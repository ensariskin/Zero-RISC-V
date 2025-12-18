# Secure Superscalar Processor Implementation Plan

Bu plan, mevcut 3-yollu superscalar RISC-V işlemcisinin, Triple Modular Redundancy (TMR) kullanılarak güvenli (secure) hale getirilmesini hedefler.

## 1. Genel Mimari Yaklaşımı ve Eleştiriler

Kullanıcının sunduğu plan genel hatlarıyla TMR prensiplerine uygundur. Özellikle "Hızlı Mod (3-way)" ve "Güvenli Mod (TMR - 1 effective instruction)" ayrımı, performans ve güvenlik dengesi açısından yerinde bir karardır.

### Kritik Kararlar ve Geri Bildirimler

1.  **Tek Instruction - Tek ROB ID Yaklaşımı (Onaylandı):**
    *   **Karar:** Güvenli modda 3 pipeline'ın aynı instruction'ı işlemesi ve bu instruction için **tek bir ROB ID** allocate edilmesi en doğru yaklaşımdır.
    *   **Neden:** Bu sayede sistem dışarıdan bakıldığında tek fakat çok güvenilir bir işlemci gibi davranır. 3 ayrı ROB ID kullanmak, commit aşamasında karmaşık senkronizasyon gerektirir ve ROB kaynaklarını verimsiz kullanır.
    *   **Gereksinim:** Execute aşamasından sonra, CDB'ye (Common Data Bus) yazmadan önce sonuçların oylanması (Voting) gerekir. Böylece ROB'a tek ve doğrulanmış bir sonuç yazılır.

2.  **BRAT ve Rollback Stratejisi (Güncellendi):**
    *   **Kullanıcı Haklı:** TMR her ne kadar tekli hataları maskelese de, çoklu hata durumlarında veya sistemin unstable olduğu durumlarda "güvenli bir duruma dönmek" (checkpoint/rollback) hayati önem taşır.
    *   **Karar:** Güvenli modda **TÜM instrucrion'lar** (sadece branchler değil) BRAT'e push'lanacak.
    *   **Mekanizma:** Her instruction dispatch aşamasında BRAT'e bir snapshot (checkpoint) bırakacak. Eğer Execute/CDB aşamasında Voter tarafından çözülemeyen bir hata (veya 2+ modülde hata) tespit edilirse, BRAT'teki son geçerli snapshot kullanılarak işlemci flush'lanacak ve o noktadan yeniden başlatılacak.

3.  **Hata Düzeltme (Healing):**
    *   Kalıcı durum tutan registerlar (PC, Pointers) için, oylama sonucu hatalı olduğu tespit edilen register'a doğru değerin geri yazılması (feedback) mekanizması eklenmelidir. Geçici durum tutanlar (Issue queue, RS payload) için bir sonraki clock'ta veri değişeceği için maskeleme yeterlidir.

4.  **RS (Reservation Station) Koruma ve İzleme (Eklendi):**
    *   **Eksiklik:** Önceki planda RS içindeki hataların düzeltilmesi detayı eksikti.
    *   **Çözüm:** 3 RS'i (RS0, RS1, RS2) dışarıdan sürekli izleyen bir **`rs_monitor`** modülü veya mantığı eklenecek.
    *   **Görev:** Bu modül 3 RS'in iç durumlarını (veya çıkışlarını) karşılaştıracak. Eğer bir RS diğer ikisinden farklı davranıyorsa (örneğin issue etmesi gerekirken etmiyorsa veya yanlış data tutuyorsa), monitor modülü o RS'e "düzeltme" sinyali (veya doğru datayı) yollayarak onu diğerleriyle senkronize edecek.

---

## 2. Implementasyon Yol Haritası (Adım Adım)

### Aşama 1: Fetch Stage (Getirme Aşaması)

En kritik aşamadır. Program akışının doğruluğu burada sağlanır.

#### Değişiklikler:
*   **`pc_ctrl_super.sv`**:
    *   **Triple PC:** `pc_current_val` yerine `pc_current_val_0`, `_1`, `_2` oluşturulacak.
    *   **Voter Logic (Oylayıcı):** Her clock cycle'da bu 3 PC değerini karşılaştıran bir kombinasyonel oylayıcı eklenecek.
        *   `vote(pc0, pc1, pc2) -> correct_pc`
        *   Eğer bir PC hatalıysa, voter çıktısı (`correct_pc`) hatalı register'a bir sonraki cycle update'inde `override` olarak geri beslenecek (Self-Correction).
    *   **Secure Mode Logic:** Güvenli modda next_pc hesaplaması üç kopya olarak yapılacak ancak hepsi aynı `correct_pc` üzerinden beslenecek.

*   **`instruction_buffer_new.sv`**:
    *   **Triple Pointers:** `head_ptr`, `tail_ptr`, `count` registerları üçlenecek (`_0`, `_1`, `_2`).
    *   **Voter Logic:** Okuma ve yazma mantığında bu üç pointer oylanarak kullanılacak. Pointer update logic'inde (next_ptr) oylama sonucu kullanılacak. Hatalı pointer varsa düzeltilecek.
    *   **Fatal Error Handling:** Eğer 3 PC birbirinden farklıysa (`fatal_error`), bu durum kurtarılamaz olarak kabul edilecek. Bu sinyal top-level'a iletilerek işlemcinin **Hard Reset** atması ve programın baştan başlaması sağlanacak.

### Aşama 2: Issue Stage (Dağıtım Aşaması)

#### Değişiklikler:
*   **`register_alias_table.sv`**:
    *   `secure_mode` input'u eklenecek.
    *   Güvenli modda, gelen tek bir instruction stream (aslında 3 kopya geliyorsa voter ile teke düşürülebilir veya 3 ayrı RAT portuna beslenebilir) işlenecek.
        *   *Strateji:* Issue stage girişinde `fetch_data_0`, `_1`, `_2` karşılaştırılır. Eğer güvenli moddaysa ve hepsi aynıysa (veya 2/3), RAT'a tek bir allocation yapılır.
        *   Fakat kullanıcının planında 3 pipeline sürülecek deniyor. Bu durumda RAT'ta da 3 kopya işlem yapmak gerekebilir ama RAT state'i (mapping table) ECC korumalı varsayıldığı için, sadece kontrol mantığı ve pointerlar korunmalı.
    *   **Address Buffers:** `free_address_buffer` ve `lsq_address_buffer` içindeki `read_ptr`, `write_ptr` üçlenecek ve oylanacak.
    *   **Circular Buffer Modifikasyonu (`circular_buffer_3port.sv`):** Bu modülün pointer logic'i TMR uyumlu hale getirilecek ya da wrapper bir modül ile sarmalanarak 3 instance oluşturulup çıktıları oylanacak. (Wrapper daha temiz olabilir).

### Aşama 3: Dispatch Stage

#### Değişiklikler:
*   **`reorder_buffer.sv`**:
    *   **Triple Pointers:** `head_ptr`, `tail_ptr` üçlenecek.
    *   **Allocation:** Güvenli modda issue'dan gelen 3 istek aslında "aynı" istektir. Normalde 3 ayrı slot doldururlar.
        *   *Tasarım Kararı:* Güvenli modda ROB'da **tek bir slot** allocate edilecek. Ancak bu slotun `tag`'i (ROB ID) 3 Reservation Station'a da gönderilecek.
        *   Böylece RS0, RS1, RS2 aynı ROB ID (örn: #5) ile çalışacak.

*   **`dispatch_stage.sv` & Yeni Modül: `rs_consistency_checker.sv`**:
    *   **RS Monitor:** 3 Reservation Station'ın durum sinyallerini (valid, busy, tag vb.) okuyan yeni bir logic eklenecek.
    *   **Hata Tespiti:** Eğer RS0, RS1, RS2 aynı instruction'ı tutuyorsa (Secure Mode), bu RS'lerin `issue_ready` veya `data_ready` sinyalleri birbiriyle tutarlı olmalı.
    *   **Düzeltme (Healing):** Eğer RS1 geride kalırsa veya yanlış sinyal üretirse, Monitor modülü RS1'e müdahale ederek (force state veya copying correct signals) onu düzeltir.
    *   **BRAT Entegrasyonu:** Güvenli modda *her* instruction için BRAT'e push sinyali üretilecek. Bu, BRAT buffer'ın çabuk dolmasına neden olabilir, bu yüzden `stall` mantığı buna göre güncellenecek (BRAT doluysa Dispatch durmalı).

### Aşama 4: Execution & Writeback

#### Değişiklikler:
*   **`execute_stage.sv`**:
    *   **Input Voter (Opsiyonel ama önerilir):** RS'den gelen veriler (`operand_a`, `operand_b`, `pc`, `controls`) ALU'ya girmeden önce oylanabilir. Ancak RS'ler zaten triple çalışıyor.
    *   **ALU Execution:** 3 ALU (FU0, FU1, FU2) aynı işlemi (Inst A) yapar.
    *   **Output Voter (KRİTİK):** 3 ALU'nun sonucu (`result`, `flags`, `branch_taken`) CDB'ye basılmadan önce bir **Voter Modülü** tarafından karşılaştırılır.
        *   Eğer `result_0 == result_1`, sonuç doğrudur.
        *   CDB Interface'ine **TEK BİR** sonuç basılır (Örn: ROB ID #5 için Data X).
        *   Böylece ROB ve Register File tek ve doğru sonucu yazar. Yanlış hesaplayan ALU'nun sonucu çöpe atılır.

## 3. Özet Değişiklik Listesi

| Modül | Değişiklik Türü | Detay |
| :--- | :--- | :--- |
| `pc_ctrl_super.sv` | **Major** | PC register üçleme, Voting Logic, Self-Correction. |
| `circular_buffer_*.sv` | **Moderate** | Pointer register üçleme, Voting Logic. |
| `instruction_buffer_new.sv` | **Moderate** | Pointer üçleme, Voting. |
| `dispatch_stage.sv` | **Logic** | Güvenli modda 3 RS'e aynı inst broadcast etme mantığı. |
| `rs_consistency_checker.sv` | **New** | 3 RS'in senkronizasyonu ve hata düzeltmesi için monitor. |
| `reorder_buffer.sv` | **Moderate** | Pointers üçleme. Single-alloc for secure mode. |
| `execute_stage.sv` | **Major** | **CDB Voter Logic** eklenmesi. 3 ALU sonucunu tek CDB sonucuna indirme. |

## 4. Doğrulama Stratejisi

1.  **Fault Injection Testbench:** Testbench içerisinde rastgele zamanlarda (random cycle) rastgele registerlara (`pc_1`, `head_ptr_2`, `alu_result_0` vb.) bit-flip (hata) enjekte eden bir `fault_injector` modülü yazılacak.
2.  **Lockstep Checker:** Güvenli modda çalışırken 3 hattın davranışının aynı olduğu (veya voter sonrası düzeldiği) cycle-cycle izlenecek.

Bu plan doğrultusunda kodlamaya başlanabilir.
