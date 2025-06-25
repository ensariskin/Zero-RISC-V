# RISC-V RV32I Pipelined Processor

An educational 32-bit RISC-V processor implementation targeting the RV32I instruction set architecture. This project explores a 5-stage pipelined design with hazard detection, data forwarding, and verification components.

[![SystemVerilog](https://img.shields.io/badge/SystemVerilog-IEEE%201800-blue.svg)](https://en.wikipedia.org/wiki/SystemVerilog)
[![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-green.svg)](https://riscv.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 🏗️ Architecture Overview

This RISC-V processor implements a classic 5-stage pipeline architecture:

1. **Instruction Fetch (IF)** - Program counter management and instruction memory interface
2. **Instruction Decode (ID)** - Instruction decoding, register file access, and control signal generation
3. **Execute (EX)** - ALU operations, branch condition evaluation, and address calculation
4. **Memory Access (MEM)** - Data memory interface and load/store operations
5. **Write Back (WB)** - Register file write-back and result selection

### Key Features

- 🎯 **RV32I ISA Implementation** - Working towards complete base integer instruction support
- ⚙️ **5-Stage Pipeline** - Classic pipeline design with hazard handling mechanisms
- 🔄 **Data Forwarding** - Implementation of data hazard resolution techniques
- 🔀 **Branch Prediction** - Basic branch prediction components
- 🛡️ **Hazard Detection** - Pipeline hazard detection and management
- 🧩 **Modular Design** - Organized SystemVerilog modules for clarity
- 🧪 **Test Infrastructure** - Test suite for verification and validation

## 📁 Project Structure

```
RV32I/
├── digital/                    # Core processor implementation
│   ├── modules/               # SystemVerilog modules organized by functionality
│   │   ├── common/           # Reusable building blocks (mux, adders, etc.)
│   │   ├── fetch_stage/      # IF stage: PC control, branch predictor
│   │   ├── decode_stage/     # ID stage: decoder, register file
│   │   ├── execute/          # EX stage: ALU, branch controller
│   │   ├── mem/              # MEM stage: memory interface
│   │   ├── write_back/       # WB stage: writeback logic
│   │   ├── pipeline_register/ # Pipeline registers (IF/ID, ID/EX, etc.)
│   │   ├── hazard/           # Hazard detection and data forwarding
│   │   └── digital_top/      # Top-level processor integration
│   ├── sim/                  # Simulation environment and scripts
│   └── testbench/            # Comprehensive test suite
│       ├── tests/            # SystemVerilog testbenches
│       └── hex/              # Test programs in hexadecimal format
├── doc/                      # Documentation and design notes
│   ├── changelogs/          # Development history and changes
│   ├── Processor_Datasheet.pdf # Complete technical specification
│   └── Schematic.pdf        # Processor block diagrams
└── README.md                # This file
```

## 🚀 Quick Start

### Prerequisites

- **SystemVerilog Simulator**: ModelSim, VCS, or similar tools
- **Design Vision Tools (DVT)**: Recommended for SystemVerilog development
- **Git**: For version control

### Clone and Setup

```bash
git clone <repository-url>
cd RV32I
```

### Running Simulations

1. **Navigate to simulation directory:**
   ```bash
   cd digital/sim
   ```

2. **Run the processor simulation:**
   ```bash
   # Using the provided simulation environment
   source dsim.env
   ```

3. **View waveforms:**
   ```bash
   # Waveforms are generated in digital/sim/waves/waves.vcd
   ```

### Test Programs

The project includes test programs in `digital/testbench/hex/` for various scenarios:

- `init_ins.hex` - Basic instruction testing
- `init_ins_branches.hex` - Branch instruction validation
- `init_ins_jump.hex` - Jump instruction testing
- `init_ins_load_use_hazard.hex` - Load-use hazard scenarios
- `init_ins_jalr.hex` - JALR instruction testing
- Additional specialized test cases for development

## 🔧 Module Overview

### Core Modules

| Module | Location | Description |
|--------|----------|-------------|
| `rv32i_core` | `digital/modules/digital_top/` | Top-level processor integration |
| `fetch_stage` | `digital/modules/fetch_stage/` | Instruction fetch and PC management |
| `decode_stage` | `digital/modules/decode_stage/` | Instruction decode and register file |
| `execute_stage` | `digital/modules/execute/` | ALU and execution logic |
| `mem_stage` | `digital/modules/mem/` | Memory access stage |
| `write_back_stage` | `digital/modules/write_back/` | Register writeback stage |

### Support Modules

| Module | Location | Description |
|--------|----------|-------------|
| `rv32i_decoder` | `digital/modules/decode_stage/` | RV32I instruction decoder |
| `register_file` | `digital/modules/decode_stage/` | 32-register register file |
| `ALU` | `digital/modules/execute/` | Arithmetic Logic Unit |
| `Data_Forward` | `digital/modules/hazard/` | Data forwarding unit |
| `hazard_detection_unit` | `digital/modules/hazard/` | Pipeline hazard detection |

## 📊 Instruction Implementation Status

### RV32I Base Integer Instruction Set

| Category | Instructions | Implementation Status |
|----------|--------------|----------------------|
| **Arithmetic** | ADD, ADDI, SUB | 🟢 Implemented |
| **Logical** | AND, ANDI, OR, ORI, XOR, XORI | 🟢 Implemented |
| **Shift** | SLL, SLLI, SRL, SRLI, SRA, SRAI | 🟢 Implemented |
| **Compare** | SLT, SLTI, SLTU, SLTIU | 🟢 Implemented |
| **Branch** | BEQ, BNE, BLT, BGE, BLTU, BGEU | 🟢 Implemented |
| **Jump** | JAL, JALR | 🟢 Implemented |
| **Load** | LB, LH, LW, LBU, LHU | 🟢 Implemented |
| **Store** | SB, SH, SW | 🟢 Implemented |
| **Upper** | LUI, AUIPC | 🟢 Implemented |

*Note: Implementation status reflects current development progress and may require additional testing and validation.*

## 🧪 Testing and Verification

### Test Suite Components

- **Pipeline Testing** - Verification of pipeline functionality
- **Hazard Testing** - Testing of data hazards, control hazards, and structural hazards
- **Instruction Testing** - Individual instruction validation
- **Integration Testing** - System-level integration verification
- **Edge Case Testing** - Boundary conditions and error scenarios

### Running Tests

```bash
cd digital/testbench
# Individual module tests available in tests/ directory
# Test programs in hex/ directory for instruction memory loading
```

*Note: Test coverage and validation are ongoing development efforts.*

## 📈 Design Characteristics

- **Pipeline Depth**: 5 stages
- **Target Clock Frequency**: Design-dependent (not yet characterized)
- **Expected CPI**: Approaching 1.0 (with effective hazard handling)
- **Memory Interface**: Configurable width and timing
- **Hazard Handling**: Designed for 1-cycle stall on load-use hazards

*Note: Performance metrics are theoretical and require further characterization through synthesis and testing.*

## 🔄 Recent Development

See `doc/changelogs/` for detailed development history. Recent work includes:

- 🔧 Improved JALR instruction handling in decoder
- 🔧 Enhanced memory width selection for load/store operations
- 🔧 Refined control signal consistency
- 🔧 Updated file format standardization

## 📚 Documentation

- **[Processor Datasheet](doc/Processor_Datasheet.pdf)** - Complete technical specification
- **[Schematic Diagrams](doc/Schematic.pdf)** - Visual processor architecture
- **[Design Notes](doc/)** - Additional design documentation and notes
- **[Module READMEs](digital/)** - Individual module documentation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow SystemVerilog coding standards and best practices
- Include testbenches for new modules when possible
- Update documentation for significant changes
- Conduct thorough testing before major commits

## 📄 License

This project is available under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- RISC-V Foundation for the open instruction set architecture specification
- SystemVerilog and digital design community for resources and best practices
- Academic references and industry publications on processor design

## 📞 Contact

For questions, suggestions, or contributions, please open an issue on GitHub or contact the project maintainer.

---

**Note**: This processor is primarily designed for educational and research purposes. Additional verification, optimization, and validation would be needed for any production or commercial use.
