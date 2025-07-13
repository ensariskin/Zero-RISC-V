#!/usr/bin/env powershell
# Simple Test 2 Runner
# This script runs from the simple_test/test2 directory

# Example runs for simple test 2
Write-Host "Simple Test 2 - Branch Instructions" -ForegroundColor Cyan

# Run with branch hex file
..\..\sim_runner.ps1 -HexFile "..\..\..\..\testbench\hex\init_ins_branches.hex" -Cycles 8000 -TestName "simple_branch"
