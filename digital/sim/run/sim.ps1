#!/usr/bin/env powershell
# Simple RV32I Simulation Runner
# Usage: .\sim.ps1 [test_name] [hex_file] [cycles]

param(
    [string]$TestName = "test",
    [string]$HexFile = "",
    [int]$Cycles = 10000
)

# Generate timestamp for unique files
$timestamp = Get-Date -Format "yyyy_MM_dd_HH_mm_ss"
$vcd_file = "..\waves\${TestName}_${timestamp}.vcd"

# Create waves directory if needed
if (!(Test-Path "..\waves")) { mkdir "..\waves" }

# Build command
$cmd = "dsim -timescale 1ns/1ns -top work.dv_top -L dut +acc -dump-agg -waves $vcd_file +max_cycles=$Cycles"

# Add hex file if provided
if ($HexFile -and (Test-Path $HexFile)) {
    $cmd += " +load_hex +hex_file=$HexFile"
    Write-Host "Loading: $HexFile" -ForegroundColor Green
}

# Show info
Write-Host "Test: $TestName | Cycles: $Cycles | VCD: $vcd_file" -ForegroundColor Cyan

# Run simulation
Write-Host "Running simulation..." -ForegroundColor Yellow
Invoke-Expression $cmd

# Check result
if (Test-Path $vcd_file) {
    $size = [math]::Round((Get-Item $vcd_file).Length / 1KB, 1)
    Write-Host "Success! VCD: $vcd_file (${size}KB)" -ForegroundColor Green
} else {
    Write-Host "Warning: VCD file not generated" -ForegroundColor Red
}
