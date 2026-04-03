# AES-128 Hardware Accelerator (Encryption Core)

A high-performance, synthesizable Verilog implementation of the **AES-128 Encryption Algorithm**. This core utilizes an iterative architecture to balance hardware area and throughput.

## 🚀 Key Features
* **Architecture:** Iterative 128-bit Row-Major data path.
* **Latency:** Completes a full encryption in exactly **11 clock cycles**.
* **Key Expansion:** Real-time, "On-the-fly" Round Key generation (reduces register overhead).
* **Control Logic:** Robust Finite State Machine (FSM) with `start` and `done` handshaking.

---

## 🛠️ Hardware Modules
The design is modularized for reusability and clarity:

| Module | Description |
| :--- | :--- |
| `aes_top` | Top-level wrapper & FSM Controller. |
| `aes_round` | Standard round logic (SubBytes, ShiftRows, MixColumns, AddRoundKey). |
| `key_expansion` | Generates 11 unique round keys from the original 128-bit key. |
| `subBytes` | Non-linear substitution using 16 parallel S-Boxes. |
| `mixColumns` | Galois Field $GF(2^8)$ matrix multiplication for diffusion. |
| `rcon_lut` | Round Constant lookup table for Key Schedule symmetry breaking. |

---

## 📈 Performance & Verification
The core has been verified using a Master Testbench against standard test vectors.

### Timing Diagram
1. **IDLE:** System waits for `start = 1`.
2. **START:** Initial Key XOR (Round 0) occurs in 1 cycle.
3. **ROUNDS 1-9:** Iterative processing through `aes_round`.
4. **FINAL:** Round 10 executes (skipping MixColumns) and asserts `done = 1`.

---

## 📂 Project Structure
```text
├── aes_top.v             // Top-level Wrapper & FSM Controller
├── aes_round.v           // Standard Round Logic (Rounds 1-9)
├── keyExpansion.v        // 128-bit Key Schedule Manager
├── addRoundKey.v         // 128-bit XOR with Round Key
├── mixColumns.v          // Galois Field Matrix Multiplication
├── shiftRows.v           // Row-Major Byte Permutation
├── subBytes.v            // 16-way Parallel S-Box Substitution
├── sbox.v                // Core S-Box Lookup Table
├── rcon_lut.v            // Round Constant Lookup Table
├── rotWord.v             // 32-bit Word Rotation (G-Function)
├── subWord.v             // S-Box Word Substitution (G-Function)
│
├── aes_master_test.v     // Full System Integration Test
├── aes_round_test.v      // Round Unit Test
├── keyExpansion_test.v   // Key Schedule Unit Test
├── addRoundKey_test.v    // AddRoundKey Unit Test
├── mixColumns_test.v     // MixColumns Unit Test
├── shiftRows_test.v      // ShiftRows Unit Test
└── subBytes_test.v       // SubBytes Unit Test

```

## 📝 Usage
1. Load all .v files from the rtl/ directory into your simulator (ISE, Vivado, or ModelSim).
2. Set aes_master_tb.v as the top-level module for simulation.
3. Run the simulation to observe the done flag and the final ciphertext output.
