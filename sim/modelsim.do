vlib work
vlog ../src/sqrt_nonrestoring.v ../tb/tb_sqrt_nonrestoring.v
vsim tb_sqrt_nonrestoring
add wave *
run -all
