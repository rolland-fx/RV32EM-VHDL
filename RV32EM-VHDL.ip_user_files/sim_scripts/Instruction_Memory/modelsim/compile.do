vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../../RV32EM-VHDL.srcs/sources_1/ip/Instruction_Memory/Instruction_Memory_sim_netlist.vhdl" \


