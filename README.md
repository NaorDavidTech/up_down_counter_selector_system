2

# 🔁 Up/Down Counter Selector System (Verilog)

This project implements a **multi-counter system** in Verilog HDL, featuring four up/down counters of varying bit-widths.  
Each counter can count up, count down, and output its 2’s complement when triggered. A 2-bit selector chooses the active counter, and the system routes its output through a multiplexer.

---

## 📁 Files Included

- `up_down_counter.v` – Verilog module: up/down counter with 2’s complement logic  
- `up_down_counter_selector_system.v` – Main system integrating 4 counters  
- `up_down_counter_selector_system_tb.v` – Testbench for functional verification  
- `rtl_diagram.pdf` – RTL schematic of the system  
- `appendix.pdf` – Includes truth tables, architecture diagram, timing waveforms, and test explanation  

---

## ⚙️ Features

- **Inputs**:  
  - `clk`, `rst_n` – Clock and asynchronous reset  
  - `up_down` – 1: Count up | 0: Count down  
  - `comp` – 1: Output 2’s complement of current value  
  - `sel[1:0]` – Selects active counter (0–3)

- **Output**:  
  - `yout[7:0]` – Output of selected counter (zero-padded)

- **Counter Widths**:  
  - `sel = 00`: 5-bit  
  - `sel = 01`: 6-bit  
  - `sel = 10`: 7-bit  
  - `sel = 11`: 8-bit  

- Only one counter is enabled at a time  
- Output width normalized to 8 bits using padding  

---

## 🧪 Simulation

Simulated using ModelSim:
- Validates counting direction  
- Verifies counter selection via `sel` input   
- Demonstrates zero-padding and mux routing  

---



