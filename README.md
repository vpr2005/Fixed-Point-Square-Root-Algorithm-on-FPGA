# Fixed-Point Square Root (Q8.8) - Digit-by-Digit Non-Restoring

This project implements a digit-by-digit non-restoring square root for 16-bit Q8.8 fixed-point inputs.

Contents:
- rtl/fixed_sqrt.v : Sequential Verilog implementation (one iteration per clock)
- tb/tb_fixed_sqrt.sv : SystemVerilog testbench that runs 100 random tests and checks <1% error
- Makefile : simple simulation recipe for Icarus

How to run:
  1. `iverilog -g2012 -o sim tb/tb_fixed_sqrt.sv rtl/fixed_sqrt.v`
  2. `vvp sim`

