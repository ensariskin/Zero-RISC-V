import csv
import math
import sys
import os

def mean(data):
    return sum(data) / len(data)

def correlation(x, y):
    n = len(x)
    if n != len(y):
        raise ValueError("Lists must have the same length")
    
    mu_x = mean(x)
    mu_y = mean(y)
    
    numerator = sum((xi - mu_x) * (yi - mu_y) for xi, yi in zip(x, y))
    
    sum_sq_diff_x = sum((xi - mu_x) ** 2 for xi in x)
    sum_sq_diff_y = sum((yi - mu_y) ** 2 for yi in y)
    
    denominator = math.sqrt(sum_sq_diff_x * sum_sq_diff_y)
    
    if denominator == 0:
        return 0
    
    return numerator / denominator

def partial_correlation(r_xy, r_xz, r_yz):
    """
    Calculates partial correlation r_xy.z (correlation of x and y, controlling for z)
    Formula: (r_xy - r_xz * r_yz) / sqrt((1 - r_xz^2) * (1 - r_yz^2))
    """
    numerator = r_xy - (r_xz * r_yz)
    denominator = math.sqrt((1 - r_xz**2) * (1 - r_yz**2))
    if denominator == 0: return 0
    return numerator / denominator

def analyze_csv(file_path):
    cycles = []
    commits = []
    branches = []
    mispredicts = []
    load_stores = []
    mispred_rates = []

    try:
        with open(file_path, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                cycles.append(float(row['Cycle']))
                commits.append(float(row['Commits']))
                branches.append(float(row['Branches']))
                mispredicts.append(float(row['Mispredicts']))
                load_stores.append(float(row['Load_Stores']))
                mispred_rates.append(float(row['Mispred_Rate_Percent']))
    except FileNotFoundError:
        print(f"Error: File {file_path} not found.")
        return

    print(f"Analiz edilen veri noktasi sayisi: {len(commits)}")
    print("-" * 60)
    print(f"{'Metrik':<25} | {'Korelasyon (Commits ile)':<25}")
    print("-" * 60)

    # Calculate correlations with Commits
    corr_branches = correlation(branches, commits)
    corr_mispredicts = correlation(mispredicts, commits)
    corr_ls = correlation(load_stores, commits)
    corr_mispred_rate = correlation(mispred_rates, commits)

    print(f"{'Branches':<25} | {corr_branches:.4f}")
    print(f"{'Mispredicts':<25} | {corr_mispredicts:.4f}")
    print(f"{'Load/Stores':<25} | {corr_ls:.4f}")
    print(f"{'Mispred_Rate_Percent':<25} | {corr_mispred_rate:.4f}")
    print("-" * 60)

    # Partial Correlation Analysis
    # r_commits_ls_given_mispred: Correlation of Commits and LS, controlling for Mispredicts
    # x = Commits, y = LS, z = Mispredicts
    r_xy = corr_ls
    r_xz = corr_mispredicts
    r_yz = correlation(load_stores, mispredicts) # Correlation between LS and Mispredicts
    
    partial_corr_ls = partial_correlation(r_xy, r_xz, r_yz)

    print("\nKismi Korelasyon Analizi (Partial Correlation):")
    print("Bu analiz, bir faktorun etkisini sabit tutarak digerinin saf etkisini gosterir.")
    print("-" * 60)
    print(f"LS ve Mispredicts arasindaki iliski (r): {r_yz:.4f}")
    print(f"Load/Store Etkisi (Mispredicts sabit tutuldugunda): {partial_corr_ls:.4f}")
    print("-" * 60)

    print("\nDetayli Analiz ve Yorumlar:")
    
    # Interpretations
    print(f"1. Branch Etkisi (r={corr_branches:.2f}):")
    if abs(corr_branches) > 0.7:
        print("   - Branch sayisi ile performans arasinda GUCLU bir iliski var.")
        if corr_branches > 0:
            print("   - Branch yogunlugu arttikca islemci daha fazla commit yapiyor. Bu, branch prediction'in iyi calistigini veya branchlerin kisa donguler oldugunu gosterebilir.")
        else:
            print("   - Branch yogunlugu arttikca performans dusuyor. Branchler pipeline'i yavaslatiyor.")
    else:
        print("   - Branch sayisinin performansa dogrudan etkisi orta seviyede veya diger faktorlere bagli.")

    print(f"\n2. Misprediction Etkisi (r={corr_mispred_rate:.2f}):")
    if corr_mispred_rate < -0.5:
        print("   - Yanlis tahmin orani arttikca performans (Commit) CIDDI SEKILDE DUSUYOR.")
        print("   - Bu beklenen bir durumdur. Misprediction penalty (ceza) suresi performansi dogrudan etkiliyor.")
    elif corr_mispred_rate > 0:
        print("   - Ilginc bir sekilde pozitif veya notr bir iliski var. Bu, misprediction olsa bile islemcinin baska instructionlari commit edebildigini gosterebilir.")
    else:
        print("   - Misprediction orani performansi negatif etkiliyor ancak tek belirleyici faktor degil.")

    print(f"\n3. Load/Store Etkisi (r={corr_ls:.2f}):")
    if corr_ls > 0.5:
         print("   - Load/Store islemleri arttikca performans artiyor. Bellek erisimleri hizli gerceklesiyor.")
    elif corr_ls < -0.5:
         print("   - Load/Store islemleri arttikca performans DUSUYOR.")
         print("   - Bu durum, bellek (LSU) darboğazi veya cache miss'lerin etkili oldugunu gosterir.")
    else:
         print("   - Load/Store yogunlugunun performansa etkisi degisken.")

    print(f"\n4. Load/Store Etkisi (Mispredicts'ten arindirilmis) (r_partial={partial_corr_ls:.2f}):")
    if partial_corr_ls < 0:
        print("   - Misprediction etkisi kaldirildiginda, Load/Store islemlerinin performansi NEGATIF etkiledigi goruluyor.")
        print("   - Bu, bellek islemlerinin aslinda bir darboğaz olusturdugunu, ancak dusuk misprediction donemlerinde maskelendigini gosterir.")
    elif partial_corr_ls > 0:
        print("   - Misprediction etkisi kaldirildiginda bile Load/Store islemleri performansla pozitif iliskili.")
        print("   - Bu, bellek sisteminin (LSU/Cache) oldukca verimli calistigini gosterir.")
    else:
        print("   - Load/Store islemlerinin performansa belirgin bir bagimsiz etkisi yok.")

if __name__ == "__main__":
    # Use the path provided in the prompt context if available, otherwise default
    csv_path = r"d:\Ensar\Tez\RV32I\digital\sim\run\module_test\top_level\test19_3pipe\performance_stats.csv"
    
    if len(sys.argv) > 1:
        csv_path = sys.argv[1]
        
    analyze_csv(csv_path)
