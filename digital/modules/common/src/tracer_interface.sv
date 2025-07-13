interface tracer_interface;
 
   logic valid;
   logic [31:0] pc;
   logic [31:0] instr;
   logic [4:0] reg_addr;
   logic [31:0] reg_data;
   logic is_load; 
   logic is_store; 
   logic is_float;
   logic [1:0] mem_size;
   logic [31:0] mem_addr;
   logic [31:0] mem_data;
   logic [31:0] fpu_flags;

   // modport for the source (producer)
   modport source (
       output valid,
       output pc,
       output instr,
       output reg_addr,
       output reg_data,
       output is_load, is_store, is_float,
       output mem_size,
       output mem_addr,
       output mem_data,
       output fpu_flags
   );

   // modport for the sink (consumer)
   modport sink (
       input valid,
       input pc,
       input instr,
       input reg_addr,
       input reg_data,
       input is_load, is_store, is_float,
       input mem_size,
       input mem_addr,
       input mem_data,
       input fpu_flags
   );
endinterface