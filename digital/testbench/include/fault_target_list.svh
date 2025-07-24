// Fault injection target list
// Extend NUM_FAULT_TARGETS and alias statements to inject faults
// into additional design signals.

parameter int NUM_FAULT_TARGETS = 3;
logic [31:0] fi_targets[NUM_FAULT_TARGETS];

// Example target aliases
alias fi_targets[0] = dut.Ins_Fetch.current_pc;
alias fi_targets[1] = dut.data_mem_addr_o;
alias fi_targets[2] = dut.Final_Result_WB_o;
// Add more alias lines here, incrementing NUM_FAULT_TARGETS accordingly
