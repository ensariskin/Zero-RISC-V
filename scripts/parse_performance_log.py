import re
import csv
import os
import argparse
import sys

def parse_log_to_csv(log_file_path, output_csv_path):
    if not os.path.exists(log_file_path):
        print(f"Hata: Log dosyasi bulunamadi: {log_file_path}")
        print("Lutfen simulasyonu calistirdiginizdan ve dosya yolunun dogru oldugundan emin olun.")
        return

    print(f"Log dosyasi okunuyor: {log_file_path}")
    
    with open(log_file_path, 'r') as f:
        content = f.read()

    # Regex pattern to find Cycle and Instruction Mix data
    # We use re.DOTALL to allow . to match newlines
    pattern = r"CYCLE (\d+) REPORT.*?Instruction Mix Analysis.*?Commits:\s+(\d+).*?Branches:\s+(\d+).*?Mispredicts:\s+(\d+).*?Load/Stores:\s+(\d+)"
    
    matches = re.finditer(pattern, content, re.DOTALL)
    
    data_rows = []
    
    for match in matches:
        cycle = int(match.group(1))
        commits = int(match.group(2))
        branches = int(match.group(3))
        mispreds = int(match.group(4))
        ls = int(match.group(5))
        
        # Misprediction orani ve Branch orani gibi turetilmis veriler de ekleyelim
        mispred_rate = (mispreds / branches * 100.0) if branches > 0 else 0.0
        
        data_rows.append({
            'Cycle': cycle,
            'Commits': commits,
            'Branches': branches,
            'Mispredicts': mispreds,
            'Load_Stores': ls,
            'Mispred_Rate_Percent': f"{mispred_rate:.2f}"
        })

    if not data_rows:
        print("Log dosyasinda uygun formatta veri bulunamadi.")
        return

    print(f"Toplam {len(data_rows)} veri noktasi bulundu.")
    
    # CSV dosyasina yaz
    fieldnames = ['Cycle', 'Commits', 'Branches', 'Mispredicts', 'Load_Stores', 'Mispred_Rate_Percent']
    
    try:
        with open(output_csv_path, 'w', newline='') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            
            writer.writeheader()
            for row in data_rows:
                writer.writerow(row)
                
        print(f"Basarili! Veriler suraya yazildi: {os.path.abspath(output_csv_path)}")
        print("Bu dosyayi Excel ile acabilirsiniz.")
        
    except Exception as e:
        print(f"Dosya yazma hatasi: {e}")

if __name__ == "__main__":
    # Varsayilan yollar
    default_log_path = os.path.join('digital', 'sim', 'run', 'performance_analysis.log')
    
    # Eger script scripts klasorunden calistiriliyorsa bir ust dizine cikip bak
    if not os.path.exists(default_log_path):
        alt_path = os.path.join('..', 'digital', 'sim', 'run', 'performance_analysis.log')
        if os.path.exists(alt_path):
            default_log_path = alt_path
        elif os.path.exists('performance_analysis.log'):
            default_log_path = 'performance_analysis.log'

    parser = argparse.ArgumentParser(description='Performance Analysis Log Parser')
    parser.add_argument('--log', type=str, default=default_log_path, help='Giris log dosyasi yolu')
    parser.add_argument('--out', type=str, default='performance_stats.csv', help='Cikis CSV dosyasi adi')
    
    args = parser.parse_args()
    
    parse_log_to_csv(args.log, args.out)
