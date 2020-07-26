##############################################################################
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
demo_lib.add_source_files(join(src_path, "execute.vhd"))
demo_lib.add_source_files(join(src_path, "imm_gen.vhd"))

# Add here declaration of testbench needed for test
demo_lib.add_source_files(join(src_path, "ALU_control_tb.vhd"))
demo_lib.add_source_files(join(src_path, "ALU_tb.vhd"))
demo_lib.add_source_files(join(src_path, "imm_gen_tb.vhd"))


ui.set_compile_option("ghdl.flags", ["-frelaxed-rules","--no-vital-checks"])
ui.set_sim_option("ghdl.elab_flags", ["-fexplicit", "-frelaxed-rules",
                  "--no-vital-checks", "--warn-binding", "--mb-comments"])

ui.main()

