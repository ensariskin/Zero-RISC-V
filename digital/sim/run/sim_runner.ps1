#!/usr/bin/env powershell
# Hierarchical RV32I Simulation Runner
# This script can be called from any test directory
# Usage: ..\..\sim_runner.ps1 [hex_file] [cycles] [test_name]

param(
    [string]$HexFile = "",
    [int]$Cycles = 20000,
    [string]$TestName = ""
)

# Auto-detect test info from current directory
$current_path = Get-Location
$path_parts = $current_path.Path.Split('\')
$test_category = $path_parts[-2]  # e.g., "simple_test", "advanced_test"
$test_instance = $path_parts[-1]  # e.g., "test1", "test2"

# Set test name if not provided
if (-not $TestName) {
    $TestName = "${test_category}_${test_instance}"
}

# Generate timestamp for unique files
$timestamp = Get-Date -Format "yyyy_MM_dd_HH_mm_ss"
$run_id = "${TestName}_${timestamp}"

# Create local directories for this test
$waves_dir = ".\waves"
$logs_dir = ".\core_logs"
if (!(Test-Path $waves_dir)) { mkdir $waves_dir | Out-Null }
if (!(Test-Path $logs_dir)) { mkdir $logs_dir | Out-Null }

# Define output files
$vcd_file = "${waves_dir}\${run_id}.vcd"
$log_file = "${logs_dir}\${run_id}.log"

# Find the simulation working directory (should be run/)
$sim_work_dir = ".."
while (!(Test-Path "$sim_work_dir\dsim_work") -and $sim_work_dir.Length -lt 20) {
    $sim_work_dir = "..\$sim_work_dir"
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "RV32I Hierarchical Simulation" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Category: $test_category" -ForegroundColor Yellow
Write-Host "Test Instance: $test_instance" -ForegroundColor Yellow
Write-Host "Test Name    : $TestName" -ForegroundColor Yellow
Write-Host "Run ID       : $run_id" -ForegroundColor Yellow
Write-Host "Cycles       : $Cycles" -ForegroundColor Yellow
if ($HexFile) {
    Write-Host "Hex File     : $HexFile" -ForegroundColor Yellow
}
Write-Host "VCD Output   : $vcd_file" -ForegroundColor Green
Write-Host "Log Output   : $log_file" -ForegroundColor Green
Write-Host "Work Dir     : $sim_work_dir" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan

# Build dsim command - VCD path relative to simulation work directory
# We're in run/category/instance/, DSim runs from run/, so path is category/instance/waves/file.vcd
$relative_vcd_path = $vcd_file.Replace('.\', '').Replace('\', '/')
$dsim_vcd_path = "${test_category}/${test_instance}/${relative_vcd_path}"

$cmd = "dsim -timescale 1ns/1ns -top work.dv_top -L dut +acc -dump-agg -waves $dsim_vcd_path +max_cycles=$Cycles"

# Add hex file if provided
if ($HexFile -and (Test-Path $HexFile)) {
    $cmd += " +load_hex +hex_file=$HexFile"
    Write-Host "Loading hex file: $HexFile" -ForegroundColor Green
} elseif ($HexFile) {
    Write-Host "Warning: Hex file '$HexFile' not found" -ForegroundColor Yellow
}

# Log simulation start
$log_content = @"
================================================================================
RV32I Hierarchical Simulation Log
================================================================================
Start Time    : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Test Category : $test_category
Test Instance : $test_instance
Test Name     : $TestName
Run ID        : $run_id
Cycles        : $Cycles
Hex File      : $HexFile
Command       : $cmd
VCD File      : $vcd_file
Working Dir   : $sim_work_dir
================================================================================

"@

$log_content | Out-File -FilePath $log_file -Encoding UTF8

Write-Host "Starting simulation..." -ForegroundColor Green
Write-Host "Command: $cmd" -ForegroundColor Gray
Write-Host "VCD Path for DSim: $dsim_vcd_path" -ForegroundColor Gray

# Change to simulation work directory and run
$original_location = Get-Location
try {
    Set-Location $sim_work_dir
    
    $start_time = Get-Date
    $sim_output = & cmd /c $cmd 2>&1
    $exit_code = $LASTEXITCODE
    $end_time = Get-Date
    $duration = $end_time - $start_time
    
    # Return to test directory
    Set-Location $original_location
    
    # Append output to log
    "`nSimulation Output:" | Out-File -FilePath $log_file -Append -Encoding UTF8
    "================================================================================`n" | Out-File -FilePath $log_file -Append -Encoding UTF8
    $sim_output | Out-File -FilePath $log_file -Append -Encoding UTF8
    
    # Display results
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Simulation Complete" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Duration     : $($duration.ToString('hh\:mm\:ss\.fff'))" -ForegroundColor Yellow
    Write-Host "Exit Code    : $exit_code" -ForegroundColor $(if ($exit_code -eq 0) { 'Green' } else { 'Red' })
    Write-Host "Status       : $(if ($exit_code -eq 0) { 'SUCCESS' } else { 'FAILED' })" -ForegroundColor $(if ($exit_code -eq 0) { 'Green' } else { 'Red' })
    
    if (Test-Path $vcd_file) {
        $vcd_size = (Get-Item $vcd_file).Length
        Write-Host "VCD File     : $vcd_file ($([math]::Round($vcd_size/1KB, 1)) KB)" -ForegroundColor Green
    } else {
        Write-Host "VCD File     : Not generated" -ForegroundColor Red
    }
    
    Write-Host "Log File     : $log_file" -ForegroundColor Green
    Write-Host "Test Location: $(Get-Location)" -ForegroundColor Green
    
    # Show last few lines of output if there were errors
    if ($exit_code -ne 0 -and $sim_output) {
        Write-Host "`nLast 5 lines of simulation output:" -ForegroundColor Yellow
        $sim_output | Select-Object -Last 5 | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
    }
    
} catch {
    Set-Location $original_location
    Write-Host "Error running simulation: $_" -ForegroundColor Red
    "Error: $_" | Out-File -FilePath $log_file -Append -Encoding UTF8
}

Write-Host "========================================" -ForegroundColor Cyan
