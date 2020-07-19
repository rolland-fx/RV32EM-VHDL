vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib -64 -93 \
"../../../../RV32EM-VHDL.srcs/sources_1/ip/Instruction_Memory/Instruction_Memory_sim_netlist.vhdl" \


