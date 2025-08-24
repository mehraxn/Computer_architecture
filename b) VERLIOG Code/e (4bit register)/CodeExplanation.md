# README — `reg4b.v` (line‑by‑line explanation)

This file explains every line of the Verilog shown on the canvas screenshot. The module implements a 4‑bit register with a synchronous, **active‑low** reset. It exposes a tri‑stated read bus and a write bus, with a single control signal `rw` that selects **read (1)** vs **write (0)** behavior.

---

## Source for reference

```
 1  module reg4b (output [3:0] read_data,
 2                 input  [3:0] write_data,
 3                 input  clk, rst, rw);
 4  
 5    reg [3:0] storage;
 6  
 7    assign read_data = rw ? storage : 4'bz;
 8  
 9    always @(posedge clk)
10      if (!rst)
11        storage <= 0;
12      else if (!rw)
13        storage <= write_data;
14  endmodule
```

---

## Line‑by‑line breakdown

**Line 1 — `module reg4b (output [3:0] read_data,`**
Begins the definition of a module named **`reg4b`**. The first port declared is `read_data`, a **4‑bit output bus** (`[3:0]`) that will carry the register’s contents when the module is in **read** mode.

**Line 2 — `input  [3:0] write_data,`**
Declares `write_data` as a **4‑bit input bus**. These are the bits that will be **written into the register** when the module is in **write** mode.

**Line 3 — `input  clk, rst, rw);`**
Declares three **1‑bit input** signals and closes the port list:

* `clk`: clock for sequencing the register.
* `rst`: **active‑low, synchronous reset** (because it’s checked inside a clocked `always` block, not in the sensitivity list).
* `rw`: **read/write control**; by design of this module **`rw = 1` means READ**, **`rw = 0` means WRITE**.
  The closing `);` ends the module header.

**Line 4 — (blank)**
Intentional whitespace for readability; has no effect on functionality.

**Line 5 — `reg [3:0] storage;`**
Declares an internal **4‑bit register** named `storage`. In Verilog, the keyword **`reg`** indicates a signal that can be assigned in procedural blocks (e.g., inside `always`); it synthesizes to flip‑flops when driven by a clocked block.

**Line 6 — (blank)**
Spacing for readability.

**Line 7 — `assign read_data = rw ? storage : 4'bz;`**
A **continuous assignment** (combinational) driving the output bus. It uses the **ternary operator** `?:`:

* If `rw` is **1** (read mode), `read_data` is driven with the current contents of `storage`.
* If `rw` is **0** (write mode), `read_data` is driven to **high‑impedance** `Z` on **all 4 bits** (`4'bz`). This effectively **tri‑states** the output bus when not reading, allowing other devices to drive a shared bus if used at the top level.

**Line 8 — (blank)**
Spacing for readability.

**Line 9 — `always @(posedge clk)`**
Starts a **sequential block** that executes on every **rising edge** of `clk`. Everything inside models edge‑triggered flip‑flops.

**Line 10 — `if (!rst)`**
First condition inside the clocked block: when `rst` is **0**, the logical negation `!rst` is **true**, so the block performs a **synchronous active‑low reset** on this clock edge.

**Line 11 — `storage <= 0;`**
During reset, the register is **loaded with zero**. The **non‑blocking assignment** operator `<=` is used (correct for clocked logic) so all sequential updates occur simultaneously. The unsized literal `0` is automatically **zero‑extended to 4 bits** (`4'b0000`).

**Line 12 — `else if (!rw)`**
If **not resetting**, check whether we are in **write mode** (`rw == 0`). Only then does the register accept new data. If `rw == 1` (read mode), no assignment happens and the register **holds its previous value**.

**Line 13 — `storage <= write_data;`**
In **write mode**, on this rising clock edge, capture the 4‑bit `write_data` into `storage` using a non‑blocking assignment. This synthesizes to a bank of four D‑flip‑flops with a clock enable matching the write condition.

**Line 14 — `endmodule`**
Closes the module definition.

---

## Behavioral summary (what the module does)

* **Reset (`rst = 0`)** on a clock edge → `storage` becomes `0000`.
  Meanwhile, `read_data` is either `storage` (if `rw = 1`) or tri‑stated `Z` (if `rw = 0`).
* **Write mode (`rw = 0`)** on a clock edge → `storage <= write_data`. The output bus is **tri‑stated** (`Z`).
* **Read mode (`rw = 1`)** → `storage` **holds** its previous value; `read_data` is **continuously driven** with `storage` (no clock needed for the read path).

---

## Notes & gotchas

* The output is tri‑stated with `4'bz`. In typical FPGA flows, internal tri‑states get converted to multiplexers; tri‑state behavior is preserved only on **top‑level I/O pins**. Use this pattern mainly when `read_data` maps to a top‑level bus or pad.
* `rst` is **synchronous and active‑low**. If you need an **asynchronous** reset, you would add it to the sensitivity list (e.g., `@(posedge clk or negedge rst)`) and adjust the `if` accordingly.
* Non‑blocking (`<=`) is correctly used for sequential logic; avoid blocking (`=`) in clocked always blocks.

That’s every line and what each part does.
