# Fixed-Point Square Root on FPGA (Q8.8)

Digit-by-digit (non-restoring) square root implementation in Verilog targeting Q8.8 fixed-point format.

**Tools:** Verilog, Xilinx Vivado, ModelSim

## Features
- Q8.8 fixed-point support
- Non-restoring square root algorithm
- <1% error verified in simulation
- FPGA-ready low-latency design

## File structure
- `src/sqrt_nonrestoring.v` – Main Verilog module
- `tb/tb_sqrt_nonrestoring.v` – Testbench
- `sim/modelsim.do` – ModelSim compile/run script
- `synth/vivado_constraints.xdc` – Example constraints

## Usage
Simulate:
```bash
vsim -do sim/modelsim.do
```

Synthesize in Vivado:
- Create new project
- Add `src/sqrt_nonrestoring.v`
- Apply constraints from `synth/vivado_constraints.xdc`
