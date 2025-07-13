# Hierarchical RV32I Test Structure

This directory implements a hierarchical test organization system for RV32I processor simulations.

## Directory Structure

```
/run
├── sim_runner.ps1           # Shared simulation script
├── dsim_work/              # DSim working directory  
├── dsim.log               # Main simulation logs
├── advanced_test/         # Advanced test category
│   └── test1/            # Test instance
│       ├── run_test.ps1  # Local test runner
│       ├── waves/        # Generated VCD files
│       └── core_logs/    # Test-specific logs
├── simple_test/          # Simple test category  
│   ├── test1/           # Test instance 1
│   │   ├── run_test.ps1 # Local test runner
│   │   ├── waves/       # Generated VCD files
│   │   └── core_logs/   # Test-specific logs
│   └── test2/           # Test instance 2
│       ├── run_test.ps1 # Local test runner
│       ├── waves/       # Generated VCD files
│       └── core_logs/   # Test-specific logs
└── README.md            # This file
```

## Usage

### 1. From Test Directories
Navigate to any test directory and run simulations:

```powershell
# Go to a test directory
cd simple_test\test1

# Run the local test
.\run_test.ps1

# Or call the shared runner directly
..\..\sim_runner.ps1 -HexFile "path\to\test.hex" -Cycles 10000
```

### 2. Shared Runner Parameters
The `sim_runner.ps1` script accepts:

- **HexFile**: Path to hex file (relative to test directory)
- **Cycles**: Maximum simulation cycles (default: 10000)  
- **TestName**: Override auto-detected test name

### 3. Auto-Detection
The script automatically detects:
- **Test Category**: From parent directory name (e.g., "simple_test")
- **Test Instance**: From current directory name (e.g., "test1")
- **Output Naming**: Combines category + instance + timestamp

## File Organization

### Generated Files
Each test run creates timestamped files in the local test directory:

```
test1/
├── waves/
│   └── simple_test_test1_2025_07_12_14_30_52.vcd
└── core_logs/
    └── simple_test_test1_2025_07_12_14_30_52.log
```

### File Naming Convention
`{category}_{instance}_{timestamp}.{ext}`

Examples:
- `simple_test_test1_2025_07_12_14_30_52.vcd`
- `advanced_test_test1_2025_07_12_15_45_30.log`

## Creating New Tests

### 1. Create Directory Structure
```powershell
# Create new test category
mkdir my_test_category

# Create test instances
mkdir my_test_category\test1
mkdir my_test_category\test2
```

### 2. Create Local Runner
In each test directory, create `run_test.ps1`:

```powershell
#!/usr/bin/env powershell
# My Test Description

Write-Host "My Custom Test" -ForegroundColor Cyan

# Call shared runner with your parameters
..\..\sim_runner.ps1 -HexFile "path\to\your.hex" -Cycles 5000 -TestName "my_custom_test"
```

### 3. Hex File Paths
Paths are relative to the test directory. Common patterns:

```powershell
# Testbench hex files
-HexFile "..\..\..\..\testbench\hex\init_addi.hex"

# Test program hex files  
-HexFile "..\..\..\..\testbench\test_programs\advanced_test\advanced_test.hex"

# Local hex files (if you put them in the test directory)
-HexFile ".\my_test.hex"
```

## Example Workflows

### Quick Test Run
```powershell
# Navigate to test
cd simple_test\test1

# Run default test
.\run_test.ps1

# Check results
ls waves\     # View VCD files
ls core_logs\ # View log files
```

### Custom Test Run
```powershell
# Navigate to test directory
cd advanced_test\test1

# Run with custom parameters
..\..\sim_runner.ps1 -HexFile "..\..\..\..\testbench\hex\init_ins_jump.hex" -Cycles 20000 -TestName "jump_test"
```

### Batch Testing
```powershell
# Run multiple tests in sequence
cd simple_test\test1
.\run_test.ps1

cd ..\test2  
.\run_test.ps1

cd ..\..\advanced_test\test1
.\run_test.ps1
```

## Benefits

1. **Organized**: Each test has its own directory and outputs
2. **Isolated**: No file conflicts between different tests
3. **Timestamped**: No overwritten results
4. **Scalable**: Easy to add new test categories and instances
5. **Flexible**: Shared runner works from any test directory
6. **Traceable**: Clear naming shows test origin and timing

## Tips

- Use descriptive directory names for test categories
- Keep related tests in the same category  
- Use `run_test.ps1` for documented, repeatable tests
- Use direct `sim_runner.ps1` calls for quick experiments
- Check `core_logs/` for detailed simulation output
- Archive important test results by copying entire test directories
