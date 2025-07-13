@echo off
:: Simple RV32I Simulation Runner (Batch)
:: Usage: sim.bat [test_name] [hex_file] [cycles]

set "test_name=%~1"
set "hex_file=%~2"
set "cycles=%~3"

:: Set defaults
if "%test_name%"=="" set "test_name=test"
if "%cycles%"=="" set "cycles=10000"

:: Generate timestamp
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do if not "%%I"=="" set datetime=%%I
set "timestamp=%datetime:~0,8%_%datetime:~8,6%"
set "vcd_file=..\waves\%test_name%_%timestamp%.vcd"

:: Create waves directory
if not exist "..\waves" mkdir "..\waves"

:: Build command
set "cmd=dsim -timescale 1ns/1ns -top work.dv_top -L dut +acc -dump-agg -waves %vcd_file% +max_cycles=%cycles%"

:: Add hex file if provided
if not "%hex_file%"=="" (
    if exist "%hex_file%" (
        set "cmd=%cmd% +load_hex +hex_file=%hex_file%"
        echo Loading: %hex_file%
    )
)

:: Show info
echo Test: %test_name% ^| Cycles: %cycles% ^| VCD: %vcd_file%

:: Run simulation
echo Running simulation...
%cmd%

:: Check result
if exist "%vcd_file%" (
    echo Success! VCD: %vcd_file%
) else (
    echo Warning: VCD file not generated
)

pause
