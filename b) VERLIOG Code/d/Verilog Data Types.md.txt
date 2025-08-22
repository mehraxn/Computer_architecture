# Verilog Data Types

In Verilog, variables are divided into two broad categories:

1. **Net Data Types (Connections)**
2. **Variable Data Types (Storage)**

These categories determine how signals behave in simulation and synthesis.

---

## 1. Net Data Types

* Nets represent **physical connections (wires)** between hardware elements.
* They **do not store values**; instead, they show the value being driven by something else (continuous assignment, gate/module output).
* If nothing drives a net, its value is `z` (high impedance).

### Common Net Types

* **`wire`**

  * Most commonly used net type.
  * Must be driven by a continuous assignment (`assign`) or by a module/gate output.
  * Example:

    ```verilog
    wire [7:0] bus;
    assign bus = a & b;
    ```

* **Others** (`tri`, `wand`, `wor`, etc.)

  * Special-purpose nets for multiple drivers or wired logic.
  * Less common in modern design.

---

## 2. Variable (Storage) Data Types

* Variables can **store values** until explicitly changed.
* They are updated inside **procedural blocks** (`always`, `initial`).

### Common Variable Types

* **`reg`**

  * Procedural storage element.
  * Retains its value until reassigned.
  * Can be 1-bit or multi-bit (`reg [15:0] data;`).
  * Used inside `always` or `initial` blocks.
  * Example:

    ```verilog
    reg flag;
    always @(posedge clk) begin
      flag <= ~flag;
    end
    ```

* **`integer` / `time` / `real`**

  * Used for simulation, testbenches, or counters.
  * Not synthesizable in hardware (except `integer` in limited cases).

---

## 3. Input/Output Declarations

These are **ports** of a module. By default, they are **nets** unless specified otherwise.

* **`input`**

  * Represents a signal coming **into** the module.
  * By default, it is of type `wire`.
  * Example:

    ```verilog
    input clk;
    input [7:0] data_in;
    ```

* **`output`**

  * Represents a signal driven **out** of the module.
  * By default, it is of type `wire`.
  * If you want to assign values in an `always` block, declare it as `reg`.
  * Example:

    ```verilog
    output reg ready;
    ```

* **`inout`**

  * Bidirectional port.
  * Typically declared as `wire`.
  * Example:

    ```verilog
    inout [7:0] data_bus;
    ```

---

## Summary Table

| Category     | Type                      | Stores Value?             | Typical Use                        |
| ------------ | ------------------------- | ------------------------- | ---------------------------------- |
| **Net**      | `wire`                    | ❌ No                      | Connections, continuous assigns    |
| **Net**      | `tri`                     | ❌ No                      | Multi-driver buses                 |
| **Variable** | `reg`                     | ✅ Yes                     | Flip-flops, procedural assignments |
| **Variable** | `integer`, `real`, `time` | ✅ Yes (simulation)        | Testbenches, counters              |
| **Port**     | `input`                   | Depends (wire by default) | External signals into module       |
| **Port**     | `output`                  | Depends (`wire` or `reg`) | External signals out of module     |
| **Port**     | `inout`                   | Depends (`wire` usually)  | Bidirectional buses                |

---

## Best Practices

* Use **`wire`** for connections and continuous logic.
* Use **`reg`** for storage inside `always` blocks.
* Use **`[N-1:0]` ranges** consistently (e.g., `[15:0]`) to avoid index reversal.
* In SystemVerilog, you can use **`logic`** instead of mixing `reg` and `wire`.
