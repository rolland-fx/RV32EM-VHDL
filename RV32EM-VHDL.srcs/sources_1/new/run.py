#############################################################################
# TRIUMF4 Benchmarks unit test runner
# Author : Simon
# Date : 2018-12-06
# Adapted from https://github.com/VUnit/vunit/blob/master/examples/vhdl/uart/run.py
##############################################################################
from os.path import join, dirname
from vunit import VUnit

ui = VUnit.from_argv()

src_path = join(dirname(__file__), ".")
demo_lib = ui.add_library("demo_lib")

# Add here declaration of rtl needed for test
demo_lib.add_source_files(join(src_path, "part.vhd"))
demo_lib.add_source_files(join(src_path, "ALU.vhd"))
demo_lib.add_source_files(join(src_path, "ALU_control.vhd"))
demo_lib.add_source_files(join(src_path, "Branch_Compare.vhd"))
demo_lib.add_source_files(join(src_path, "control_unit.vhd"))
demo_lib.add_source_files(join(src_path, "data_memory.vhd"))
demo_lib.add_source_files(join(src_path, "execute.vhd"))
demo_lib.add_source_files(join(src_path, "Hazard_detection_unit.vhd"))
demo_lib.add_source_files(join(src_path, "imm_gen.vhd"))
demo_lib.add_source_files(join(src_path, "Instruction_decode.vhd"))
demo_lib.add_source_files(join(src_path, "Instruction_fetch.vhd"))
demo_lib.add_source_files(join(src_path, "Instruction_Memory.vhd"))
demo_lib.add_source_files(join(src_path, "memory_access.vhd"))
demo_lib.add_source_files(join(src_path, "Register_Memory.vhd"))
demo_lib.add_source_files(join(src_path, "write_back.vhd"))
demo_lib.add_source_files(join(src_path, "top.vhd"))

# Add here declaration of testbench needed for test
# demo_lib.add_source_files(join(src_path, "ALU_control_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "ALU_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "imm_gen_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "control_unit_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "execute_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "Instruction_Memory_tb.vhd"))
# demo_lib.add_source_files(join(src_path, "Register_Memory_tb.vhd"))
demo_lib.add_source_files(join(src_path, "top_tb.vhd"))

ui.set_compile_option("ghdl.flags", ["-frelaxed-rules","--no-vital-checks"])
ui.set_sim_option("ghdl.elab_flags", ["-fexplicit", "-frelaxed-rules",
                  "--no-vital-checks", "--warn-binding", "--mb-comments"])

ui.main()
