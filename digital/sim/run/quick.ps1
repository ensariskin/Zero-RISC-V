#!/usr/bin/env powershell
# Quick Test Menu for RV32I Processor
# Usage: .\quick.ps1

Write-Host "RV32I Quick Test Menu" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan

$tests = @(
    @{Name = "Basic Test"; Hex = "..\..\testbench\hex\init.hex"; Cycles = 5000},
    @{Name = "ADDI Test"; Hex = "..\..\testbench\hex\init_addi.hex"; Cycles = 3000},
    @{Name = "Branch Test"; Hex = "..\..\testbench\hex\init_ins_branches.hex"; Cycles = 8000},
    @{Name = "Jump Test"; Hex = "..\..\testbench\hex\init_ins_jump.hex"; Cycles = 5000},
    @{Name = "Hazard Test"; Hex = "..\..\testbench\hex\init_ins_load_use_hazard.hex"; Cycles = 8000}
)

for ($i = 0; $i -lt $tests.Count; $i++) {
    Write-Host "$($i+1). $($tests[$i].Name)" -ForegroundColor Green
}
Write-Host "0. Exit" -ForegroundColor Red

$choice = Read-Host "`nSelect test (0-$($tests.Count))"

if ($choice -eq "0") {
    Write-Host "Exiting..." -ForegroundColor Yellow
    exit
}

$selected = $tests[$choice - 1]
if ($selected) {
    Write-Host "Running $($selected.Name)..." -ForegroundColor Yellow
    
    $test_name = $selected.Name.Replace(" ", "_").ToLower()
    .\sim.ps1 -TestName $test_name -HexFile $selected.Hex -Cycles $selected.Cycles
} else {
    Write-Host "Invalid selection!" -ForegroundColor Red
}
