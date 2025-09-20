# Updated file list that replaces the old buffer with the new one
echo "+incdir+../testbench/include" > superscalar_new.f
echo "-F ../modules/digital_top/digital_top.f" >> superscalar_new.f
echo "-F ../modules/superscalar_spesific_modules/superscalar_core.f" >> superscalar_new.f

# Replace the old buffer in the file list
echo "# Use new synthesizable instruction buffer" >> superscalar_new.f
echo "../modules/superscalar_spesific_modules/fetch_stage/instruction_buffer_new.sv" >> superscalar_new.f

echo "-F ../testbench/tb_modules_superscalar.f" >> superscalar_new.f

echo "+define+SIM_MODE" >> superscalar_new.f
echo "+define+SUPERSCALAR_MODE" >> superscalar_new.f

echo "+hex_file=../hex/init.hex" >> superscalar_new.f
echo "+region0_base=80000000" >> superscalar_new.f
echo "+region1_base=80001000" >> superscalar_new.f