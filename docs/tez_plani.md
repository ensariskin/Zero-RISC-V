# RISC-V Superscalar İşlemci Tez Planı

## Tez Bilgileri

| Özellik | Değer |
|---------|-------|
| **Tez Türü** | Yüksek Lisans Tezi |
| **Başlık (TR)** | Süperölçekli İşlemcilere İsteğe Bağlı Yedeklilik Tekniğinin Uygulanması |
| **Başlık (EN)** | Applying On-Demand Redundancy Technique to Superscalar Processors |
| **Referans Sistemi** | Numaralı `[1], [2-3], [1,4,7]` |
| **Hedeflenen Bölüm Sayısı** | 6 Ana Bölüm + Kaynaklar + Ekler |

---

## Kapsam Notları

| Konu | Durum |
|------|-------|
| **TMR (Triple Modular Redundancy)** | ✅ Hemen hemen her modülde uygulandı |
| **ECC (Error Correction Codes)** | ⚠️ Büyük memory yapılarında ECC varsayıldı, implementasyon **KAPSAM DIŞI** |
| **Sentez** | ✅ TSMC 16nm LVT, 1GHz başarıyla sentezlendi |
| **Sonuç verileri** | Simülasyon/test sonuçları kullanılacak |

---

## Pipeline Aşamaları (6-Stage)

```
┌─────────┐   ┌─────────────────┐   ┌──────────────┐   ┌─────────┐   ┌────────┐   ┌───────────┐
│  FETCH  │ → │ DECODE & RENAME │ → │ DATA CONTROL │ → │ EXECUTE │ → │ MEMORY │ → │ WRITEBACK │
└─────────┘   └─────────────────┘   └──────────────┘   └─────────┘   └────────┘   └───────────┘
     │                 │                    │               │            │              │
  multi_fetch    rv32i_decoder         reorder_buffer    ALU/Shifter    LSQ         ROB→PRF
  branch_pred       RAT               reservation_st     Branch_Ctrl              commit logic
  instr_buffer     BRAT                   PRF
```

| Aşama | Modüller | Görevi |
|-------|----------|--------|
| **Fetch** | `multi_fetch`, `jump_controller_super`, `instruction_buffer` | Instruction fetch, branch prediction |
| **Decode & Rename** | `rv32i_decoder`, `register_alias_table`, `brat_circular_buffer` | Decode, register renaming |
| **Data Control** | `reorder_buffer`, `reservation_station`, `multi_port_register_file` | OoO scheduling, operand management |
| **Execute** | `function_unit_alu_shifter`, `Branch_Controller` | ALU/Shifter/Branch execution |
| **Memory** | `lsq_simple_top` | Load/Store queue, memory access |
| **Writeback** | ROB commit logic → PRF | In-order commit, register update |

---

## Bölüm Zorunluluk Durumu

### ✅ ZORUNLU BÖLÜMLER (İTÜ Kılavuzuna Göre)

| Sıra | Bölüm | Açıklama | Kılavuz Referansı |
|------|-------|----------|-------------------|
| 1 | Dış Kapak | Şablon formatında | Bölüm 2.8.1.1 |
| 2 | İç Kapak (TR + EN) | Her iki dilde | Bölüm 2.8.1.2 |
| 3 | Onay Sayfası | Jüri imzaları | Bölüm 2.9 |
| 4 | Önsöz | Max 2 sayfa, teşekkür | Bölüm 3.2 |
| 5 | İçindekiler | Otomatik oluşturulur | Bölüm 3.3 |
| 6 | Kısaltmalar* | Varsa zorunlu | Bölüm 3.4 |
| 7 | Semboller* | Varsa zorunlu | Bölüm 3.4 |
| 8 | Çizelge Listesi* | Varsa zorunlu | Bölüm 3.4 |
| 9 | Şekil Listesi* | Varsa zorunlu | Bölüm 3.4 |
| 10 | Türkçe Özet | 300+ kelime, 1-3 sayfa | Bölüm 3.5 |
| 11 | İngilizce Genişletilmiş Özet | 3-5 sayfa | Bölüm 3.5 |
| 12 | **GİRİŞ** | Ana metin başlangıcı | Bölüm 3.6 |
| 13 | **Diğer Bölümler** | Ana içerik | Bölüm 3.6 |
| 14 | **SONUÇLAR VE ÖNERİLER** | Son ana bölüm | Bölüm 3.6 |
| 15 | KAYNAKLAR | Numarasız başlık | Bölüm 3.7 |
| 16 | Özgeçmiş | Son sayfa | Bölüm 3.10 |

> *Listeler: Tezde ilgili öğe varsa (şekil, çizelge, sembol, kısaltma) liste zorunludur.

### ⚪ İSTEĞE BAĞLI BÖLÜMLER

| Bölüm | Açıklama | Durumumuz |
|-------|----------|-----------|
| İthaf Sayfası | "Aileme..." gibi | Tercih senin |
| Ekler | Ek A, Ek B... | ✅ Ekleyeceğiz (blok diyagramlar, dalga formları) |

---

## Genel Yapı Özeti

```
📁 TEZ YAPISI
│
├── 📄 Dış Kapak                          [ZORUNLU]
├── 📄 İç Kapak (TR)                      [ZORUNLU]
├── 📄 İç Kapak (EN)                      [ZORUNLU]
├── 📄 Onay Sayfası                       [ZORUNLU]
├── 📄 İthaf Sayfası                      [İSTEĞE BAĞLI]
├── 📄 Önsöz                              [ZORUNLU]
├── 📄 İçindekiler                        [ZORUNLU]
├── 📄 Kısaltmalar                        [ZORUNLU - varsa]
├── 📄 Semboller                          [ZORUNLU - varsa]
├── 📄 Çizelge Listesi                    [ZORUNLU - varsa]
├── 📄 Şekil Listesi                      [ZORUNLU - varsa]
├── 📄 Özet (Türkçe)                      [ZORUNLU]
├── 📄 Summary (İngilizce Genişletilmiş)  [ZORUNLU]
│
├── 📁 1. GİRİŞ                           [ZORUNLU]
├── 📁 2. TEMEL KAVRAMLAR VE LİTERATÜR    [TERCİH - önerilen]
├── 📁 3. SÜPERÖLÇEKLI İŞLEMCİ MİMARİSİ   [TERCİH - ana bölüm]
├── 📁 4. İSTEĞE BAĞLI YEDEKLİLİK TEKNİĞİ [TERCİH - ana bölüm]
├── 📁 5. DOĞRULAMA VE SONUÇLAR           [TERCİH - önerilen]
├── 📁 6. SONUÇLAR VE ÖNERİLER            [ZORUNLU]
│
├── 📄 KAYNAKLAR                          [ZORUNLU]
├── 📁 EKLER                              [İSTEĞE BAĞLI - ekleyeceğiz]
└── 📄 Özgeçmiş                           [ZORUNLU]
```

---

## Detaylı Bölüm Planı

### BÖLÜM 1: GİRİŞ [ZORUNLU]
**Tahmini Sayfa: 3-5 sayfa**

| Alt Başlık | İçerik |
|------------|--------|
| 1.1 Tezin Amacı | Superscalar işlemcilere on-demand redundancy uygulamanın motivasyonu, neden RISC-V seçildiği |
| 1.2 Tezin Kapsamı | Çalışmanın sınırları: 3-way superscalar, RV32I ISA, TMR (ECC varsayımlı, implementasyon kapsam dışı) |
| 1.3 Literatür Araştırması | Kısa özet - detay Bölüm 2'de |
| 1.4 Tezin Organizasyonu | Bölümlerin kısa tanıtımı |

---

### BÖLÜM 2: TEMEL KAVRAMLAR VE LİTERATÜR [TERCİH]
**Tahmini Sayfa: 12-18 sayfa**

#### 2.1 RISC-V Mimarisi
| Alt Başlık | İçerik | Önerilen Kaynaklar |
|------------|--------|-------------------|
| 2.1.1 RISC-V tarihçesi ve felsefesi | Açık kaynak ISA konsepti | [1] RISC-V Foundation Specification |
| 2.1.2 RV32I taban komut seti | R, I, S, B, U, J formatları, 40 komut | [2] Waterman & Asanović, 2019 |
| 2.1.3 Ayrıcalık seviyeleri | Machine mode odaklı | [1] |

#### 2.2 Pipeline Kavramları
| Alt Başlık | İçerik | Önerilen Kaynaklar |
|------------|--------|-------------------|
| 2.2.1 Klasik 5-aşamalı pipeline | IF, ID, EX, MEM, WB | [3] Patterson & Hennessy |
| 2.2.2 Pipeline tehlikeleri | Data, Control, Structural | [3] |
| 2.2.3 Tehlike çözüm teknikleri | Forwarding, stalling, branch prediction | [3] |

#### 2.3 Süperölçekli İşlemci Kavramları
| Alt Başlık | İçerik | Önerilen Kaynaklar |
|------------|--------|-------------------|
| 2.3.1 ILP ve superscalar yaklaşım | Instruction Level Parallelism | [4] Shen & Lipasti |
| 2.3.2 Out-of-order execution | Dinamik zamanlama, Tomasulo | [5] Tomasulo, 1967 |
| 2.3.3 Register renaming | WAW, WAR eliminasyonu | [6] Keller, 1975 |
| 2.3.4 Spekülatif yürütme | Branch speculation | [7] Smith, 1981 |

#### 2.4 Hata Toleransı Kavramları
| Alt Başlık | İçerik | Önerilen Kaynaklar |
|------------|--------|-------------------|
| 2.4.1 Soft error ve radiation etkileri | SEU, SET kavramları | [8] Baumann, 2005 |
| 2.4.2 Yedeklilik teknikleri | DMR, TMR, NMR | [9] Lyons & Vanderkulk, 1962 |
| 2.4.3 Error Correction Codes (ECC) | SECDED, Hamming | [10] Hamming, 1950 |
| 2.4.4 On-demand redundancy | Dinamik güvenlik | [11] Related academic works |

#### 2.5 İlgili Çalışmalar
| Alt Başlık | İçerik | Önerilen Kaynaklar |
|------------|--------|-------------------|
| 2.5.1 RISC-V superscalar implementasyonlar | BOOM, RSD, NaxRiscv | [12-15] |
| 2.5.2 Fault-tolerant işlemci tasarımları | DCLS, TMR tabanlı | [16-18] |
| 2.5.3 Hibrit güvenlik yaklaşımları | On-demand yöntemler | [19-21] |

---

### BÖLÜM 3: SÜPERÖLÇEKLI İŞLEMCİ MİMARİSİ [TERCİH - Ana Bölüm]
**Tahmini Sayfa: 40-55 sayfa**

#### 3.1 Genel Bakış
| Alt Başlık | İçerik |
|------------|--------|
| 3.1.1 Tasarım hedefleri | 3-way superscalar, RV32I, out-of-order |
| 3.1.2 Pipeline genel yapısı | 6 aşama: Fetch → Decode & Rename → Data Control → Execute → Memory → Writeback |
| 3.1.3 Blok diyagramı | Top-level `rv32i_superscalar_core` şeması |
| 3.1.4 Veri akışı | Instruction flow, data flow, control flow |

---

#### 3.2 Fetch Aşaması
**Modüller:** `fetch_buffer_top`, `multi_fetch`, `jump_controller_super`, `instruction_buffer_new`

| Alt Başlık | İçerik | İlgili Kaynaklar |
|------------|--------|-----------------|
| **3.2.1 Multi-Fetch birimi** | | |
| 3.2.1.1 Paralel instruction fetch | 5 instruction paralel fetch | |
| 3.2.1.2 Early stage immediate decoder | Branch target hesaplama | |
| 3.2.1.3 PC hesaplama | Sequential/Branch PC seçimi | |
| **3.2.2 Branch tahmin sistemi** | | [22] McFarling, 1993 |
| 3.2.2.1 Tournament predictor | GShare + Bimodal + Chooser | [22] |
| 3.2.2.2 GShare predictor | Global history, XOR indexing | [23] Yeh & Patt, 1991 |
| 3.2.2.3 Bimodal predictor | 2-bit saturating counter | [24] Smith, 1981 |
| 3.2.2.4 JALR predictor | Return Address Stack (RAS) | [25] |
| **3.2.3 Instruction buffer** | | |
| 3.2.3.1 Circular buffer yapısı | FIFO decoupling | |
| 3.2.3.2 Backpressure mekanizması | Fetch-Decode stall yönetimi | |

---

#### 3.3 Decode & Rename Aşaması
**Modüller:** `issue_stage`, `rv32i_decoder`, `register_alias_table`, `brat_circular_buffer`

| Alt Başlık | İçerik | İlgili Kaynaklar |
|------------|--------|-----------------|
| **3.3.1 Instruction decoding** | | |
| 3.3.1.1 Paralel decoder yapısı | 3 instruction paralel decode | |
| 3.3.1.2 Control signal üretimi | ALU op, memory op, branch op | |
| **3.3.2 Register renaming** | | [6] Keller, 1975 |
| 3.3.2.1 Register Alias Table (RAT) | Architectural → Physical mapping | [26] |
| 3.3.2.2 Free list yönetimi | Physical register allocation | |
| 3.3.2.3 WAW/WAR eliminasyonu | Renaming ile false dependency çözümü | |
| **3.3.3 Branch speculation desteği (BRAT)** | | |
| 3.3.3.1 RAT snapshot mekanizması | Branch için checkpoint | [27] |
| 3.3.3.2 Misprediction recovery | Snapshot restore işlemi | |
| 3.3.3.3 Multiple speculation desteği | Birden fazla branch in-flight | |

---

#### 3.4 Data Control Aşaması
**Modüller:** `dispatch_stage`, `reorder_buffer`, `reservation_station`, `multi_port_register_file`

| Alt Başlık | İçerik | İlgili Kaynaklar |
|------------|--------|-----------------|
| **3.4.1 Reorder Buffer (ROB)** | | [28] Johnson, 1991 |
| 3.4.1.1 ROB yapısı ve alanları | Instruction ID, destination, completed flag | |
| 3.4.1.2 In-order retirement mantığı | Sequential commit hazırlığı | |
| 3.4.1.3 Exception/misprediction handling | Flush ve recovery | |
| **3.4.2 Reservation Station (RS)** | | [5] Tomasulo, 1967 |
| 3.4.2.1 RS yapısı | Operand ready tracking | |
| 3.4.2.2 Operand forwarding (CDB) | Common Data Bus broadcast | |
| 3.4.2.3 Issue policy | Age-based / ready-first selection | |
| 3.4.2.4 RS Validator | Entry validation logic | |
| **3.4.3 Physical Register File (PRF)** | | |
| 3.4.3.1 Multi-port yapısı | 6 read port, 3 write port | |
| 3.4.3.2 Read-during-write davranışı | Bypass logic | |

---

#### 3.5 Execute Aşaması
**Modüller:** `superscalar_execute_stage`, `function_unit_alu_shifter`, `Branch_Controller`

| Alt Başlık | İçerik |
|------------|--------|
| **3.5.1 ALU ve Shifter birimi** | |
| 3.5.1.1 Arithmetic unit | ADD, SUB, SLT, SLTU |
| 3.5.1.2 Logical unit | AND, OR, XOR |
| 3.5.1.3 Barrel shifter | SLL, SRL, SRA |
| **3.5.2 Branch resolution** | |
| 3.5.2.1 Branch outcome hesaplama | Taken/not-taken determination |
| 3.5.2.2 Misprediction detection | Prediction vs actual comparison |
| 3.5.2.3 Recovery signal generation | Flush trigger |
| **3.5.3 Execution parallelism** | |
| 3.5.3.1 3-way parallel execution | 3 functional unit koordinasyonu |
| 3.5.3.2 Result broadcast | CDB üzerinden broadcast |

---

#### 3.6 Memory Aşaması
**Modüller:** `lsq_simple_top`, `lsq_package`

| Alt Başlık | İçerik | İlgili Kaynaklar |
|------------|--------|-----------------|
| **3.6.1 Load/Store Queue (LSQ) yapısı** | | [29] |
| 3.6.1.1 LSQ entry formatı | Address, data, valid flags | |
| 3.6.1.2 Load/Store ordering | Memory ordering kuralları | |
| **3.6.2 Memory disambiguation** | | [30] |
| 3.6.2.1 Store-to-load forwarding | Daha önce store edilmiş veriyi okuma | |
| 3.6.2.2 Address comparison logic | Conflict detection | |
| **3.6.3 Speculative memory işlemleri** | | |
| 3.6.3.1 Eager flush mekanizması | Misprediction sonrası temizleme | |
| 3.6.3.2 Priority encoder kullanımı | İlk invalid entry bulma | |

---

#### 3.7 Writeback Aşaması
**Modüller:** ROB commit logic → PRF

| Alt Başlık | İçerik |
|------------|--------|
| **3.7.1 In-order commit** | |
| 3.7.1.1 ROB head değerlendirmesi | Tamamlanmış instruction kontrolü |
| 3.7.1.2 Architectural state update | Mapping güncelleme |
| **3.7.2 Physical register file güncelleme** | |
| 3.7.2.1 Commit write mantığı | PRF'ye final değer yazımı |
| 3.7.2.2 Free list güncelleme | Eski physical register'ları serbest bırakma |
| **3.7.3 Exception handling** | |
| 3.7.3.1 Precise exception desteği | In-order commit sayesinde |
| 3.7.3.2 Pipeline flush | Exception sonrası temizlik |

---

### BÖLÜM 4: İSTEĞE BAĞLI YEDEKLİLİK TEKNİĞİ [TERCİH - Ana Bölüm]
**Tahmini Sayfa: 15-25 sayfa**

| Alt Başlık | İçerik | İlgili Kaynaklar |
|------------|--------|-----------------|
| **4.1 On-Demand Redundancy Konsepti** | | |
| 4.1.1 Motivasyon | Normal mod vs güvenli mod dinamik geçişi | |
| 4.1.2 Tasarım hedefleri | Performans/güvenlik trade-off | |
| 4.1.3 `secure_mode` sinyali | Runtime yapılandırma mekanizması | |
| **4.2 Triple Modular Redundancy (TMR) Uygulaması** | | [9, 31] |
| 4.2.1 TMR temel prensibi | 3x replikasyon + voting | [9] |
| 4.2.2 TMR Voter modülü (`tmr_voter`) | Majority voting implementasyonu | |
| 4.2.3 TMR uygulanan modüller | Hemen hemen tüm pipeline modülleri | |
| 4.2.4 Area/resource analizi | TMR overhead değerlendirmesi | [32] |
| **4.3 Error Correction Codes (ECC) Varsayımı** | | [10, 33] |
| 4.3.1 ECC temel prensibi | SECDED kavramı | [10] |
| 4.3.2 ECC varsayılan yapılar | Büyük memory blokları (ROB, RS, LSQ, PRF) | |
| 4.3.3 Implementasyon notu | **ECC implementasyonu bu tez kapsamı dışında** | |
| **4.4 Mod Geçişi ve Kontrolü** | | |
| 4.4.1 Normal moddan güvenli moda geçiş | Transition protocol | |
| 4.4.2 Pipeline state yönetimi | State consistency | |
| 4.4.3 Performance impact beklentisi | Latency overhead tahmini | |

---

### BÖLÜM 5: DOĞRULAMA VE SONUÇLAR [TERCİH]
**Tahmini Sayfa: 15-20 sayfa**

| Alt Başlık | İçerik |
|------------|--------|
| **5.1 Doğrulama Metodolojisi** | |
| 5.1.1 Simülasyon ortamı | Kullanılan araçlar (DVT, Questa/ModelSim vb.) |
| 5.1.2 Test vektörleri | RISC-V compliance tests, custom tests |
| 5.1.3 Functional verification | Instruction-level, pipeline-level doğrulama |
| **5.2 Test Sonuçları** | |
| 5.2.1 Fonksiyonel doğruluk | Test geçme oranları |
| 5.2.2 Branch prediction accuracy | 2-bit counter başarı oranı |
| 5.2.3 Normal mod vs Güvenli mod | Karşılaştırmalı analiz |
| **5.3 Sentez Sonuçları** | |
| 5.3.1 Teknoloji ve araçlar | TSMC 16nm, LVT hücreleri |
| 5.3.2 Frekans ve zamanlama | 1GHz hedef frekans başarısı |
| 5.3.3 Kritik yol analizi | BRAT → LSQ yolu, darboğaz analizi |
| 5.3.4 Alan kullanımı | Hücre sayısı, modül bazlı dağılım |
| 5.3.5 Güç tüketimi | (varsa) Statik/dinamik güç |
| **5.4 Karşılaştırmalı Değerlendirme** | |
| 5.4.1 Literatürdeki tasarımlarla karşılaştırma | BOOM, RSD vb. ile karşılaştırma |
| 5.4.2 TMR overhead analizi | Normal vs Güvenli mod kaynak kullanımı |
| **5.5 Tartışma** | |
| 5.5.1 Sonuçların değerlendirilmesi | Test ve sentez sonuçlarının yorumu |
| 5.5.2 Kısıtlamalar | Place & Route yapılmadı, post-synthesis timing |

---

### BÖLÜM 6: SONUÇLAR VE ÖNERİLER [ZORUNLU]
**Tahmini Sayfa: 3-5 sayfa**

| Alt Başlık | İçerik |
|------------|--------|
| 6.1 Sonuçların Değerlendirilmesi | Tezin ana bulgularının özeti |
| 6.2 Katkılar | 3-way superscalar + on-demand TMR kombinasyonu |
| 6.3 Kısıtlamalar | ECC implementasyonu yok, P&R yapılmadı |
| 6.4 Gelecek Çalışmalar | ECC implementasyonu, M/F extension, cache, FPGA sentezi |

---

## Önerilen Kaynaklar Listesi

### Temel Spesifikasyonlar
| No | Kaynak |
|----|--------|
| [1] | **RISC-V Foundation**, "The RISC-V Instruction Set Manual, Volume I: User-Level ISA," Version 2.2, 2019. |
| [2] | **A. Waterman and K. Asanović**, "The RISC-V Instruction Set Manual, Volume II: Privileged Architecture," Version 1.12, 2021. |

### Bilgisayar Mimarisi Temelleri
| No | Kaynak |
|----|--------|
| [3] | **D. A. Patterson and J. L. Hennessy**, *Computer Organization and Design: The Hardware/Software Interface*, 5th ed., Morgan Kaufmann, 2014. |
| [4] | **J. P. Shen and M. H. Lipasti**, *Modern Processor Design: Fundamentals of Superscalar Processors*, McGraw-Hill, 2005. |
| [5] | **R. M. Tomasulo**, "An Efficient Algorithm for Exploiting Multiple Arithmetic Units," *IBM Journal of Research and Development*, vol. 11, no. 1, pp. 25-33, 1967. |
| [6] | **R. M. Keller**, "Look-Ahead Processors," *ACM Computing Surveys*, vol. 7, no. 4, pp. 177-195, 1975. |
| [7] | **J. E. Smith**, "A Study of Branch Prediction Strategies," *Proc. 8th Annual Symposium on Computer Architecture*, pp. 135-148, 1981. |

### Hata Toleransı
| No | Kaynak |
|----|--------|
| [8] | **R. C. Baumann**, "Radiation-Induced Soft Errors in Advanced Semiconductor Technologies," *IEEE Transactions on Device and Materials Reliability*, vol. 5, no. 3, pp. 305-316, 2005. |
| [9] | **R. E. Lyons and W. Vanderkulk**, "The Use of Triple-Modular Redundancy to Improve Computer Reliability," *IBM Journal of Research and Development*, vol. 6, no. 2, pp. 200-209, 1962. |
| [10] | **R. W. Hamming**, "Error Detecting and Error Correcting Codes," *Bell System Technical Journal*, vol. 29, no. 2, pp. 147-160, 1950. |

### RISC-V Superscalar Implementasyonlar
| No | Kaynak |
|----|--------|
| [12] | **C. Celio, D. A. Patterson, and K. Asanović**, "The Berkeley Out-of-Order Machine (BOOM): An Industry-Competitive, Synthesizable, Parameterized RISC-V Processor," *Technical Report UCB/EECS-2015-167*, UC Berkeley, 2015. |
| [13] | **S. Suzuki et al.**, "RSD: An Open Source FPGA-Optimized Out-of-Order RISC-V Soft Processor," *Proc. IEEE International Symposium on Performance Analysis of Systems and Software (ISPASS)*, 2023. |
| [14] | **Various**, "Design and verification of a RISC-V superscalar CPU," *Politecnico di Milano Thesis*, 2022. |

### Branch Prediction
| No | Kaynak |
|----|--------|
| [22] | **S. McFarling**, "Combining Branch Predictors," *Technical Report TN-36*, Western Research Laboratory, Digital Equipment Corporation, 1993. |
| [23] | **T.-Y. Yeh and Y. N. Patt**, "Two-Level Adaptive Training Branch Prediction," *Proc. 24th Annual International Symposium on Microarchitecture*, pp. 51-61, 1991. |
| [24] | **J. E. Smith**, "A Study of Branch Prediction Strategies," *Proc. 8th Annual Symposium on Computer Architecture*, 1981. |

### Out-of-Order Execution
| No | Kaynak |
|----|--------|
| [28] | **M. Johnson**, *Superscalar Microprocessor Design*, Prentice Hall, 1991. |

### TMR ve RISC-V
| No | Kaynak |
|----|--------|
| [31] | **H. Quinn et al.**, "Using Benchmarks for Radiation Testing of Microprocessors and FPGAs," *IEEE Transactions on Nuclear Science*, 2015. |
| [32] | **N. Rezzak et al.**, "TMR RISC-V Soft Processors Reliability Improvement," *IEEE International Symposium on Defect and Fault Tolerance in VLSI and Nanotechnology Systems*, 2022. |

---

## Tahmini Toplam Sayfa

| Bölüm | Sayfa | Zorunluluk |
|-------|-------|------------|
| Ön sayfalar (önsöz, içindekiler, listeler) | ~8-10 | ZORUNLU |
| Özet + Summary | ~6-8 | ZORUNLU |
| Bölüm 1: Giriş | ~3-5 | ZORUNLU |
| Bölüm 2: Temel Kavramlar | ~12-18 | TERCİH |
| Bölüm 3: Superscalar Mimari | ~40-55 | TERCİH |
| Bölüm 4: On-Demand Redundancy | ~15-25 | TERCİH |
| Bölüm 5: Doğrulama ve Sonuçlar | ~10-15 | TERCİH |
| Bölüm 6: Sonuçlar ve Öneriler | ~3-5 | ZORUNLU |
| Kaynaklar | ~5-8 | ZORUNLU |
| Ekler | ~10-20 | İSTEĞE BAĞLI |
| Özgeçmiş | ~1-2 | ZORUNLU |
| **TOPLAM** | **~115-170 sayfa** | |

---

## Sonraki Adımlar

1. [x] Tez planını oluşturmak
2. [x] Pipeline yapısını güncellemek (6-stage)
3. [x] Stage isimlerini güncellemek (Decode & Rename, Data Control)
4. [x] TMR/ECC durumunu netleştirmek
5. [x] Temel kaynakları eklemek
6. [ ] Planı onaylamak
7. [ ] LaTeX dosya yapısını teze göre düzenlemek
8. [ ] Bölüm 1'den başlayarak yazmaya başlamak
