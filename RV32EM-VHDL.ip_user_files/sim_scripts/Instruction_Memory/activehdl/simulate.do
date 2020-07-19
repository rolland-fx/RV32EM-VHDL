onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Instruction_Memory -L xil_defaultlib -L secureip -O5 xil_defaultlib.Instruction_Memory

do {wave.do}

view wave
view structure

do {Instruction_Memory.udo}

run -all

endsim

quit -force
