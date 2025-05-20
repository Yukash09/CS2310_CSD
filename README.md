# CS2310_CSD

# Verilog Tic-Tac-Toe Game

This project implements the logic for a simple 3x3 Tic-Tac-Toe game in Verilog, using modular design principles. Each square (cell) on the board is represented using flip-flop based state machines, and the system tracks player turns and winning conditions.

---
<p align="center">
  <img src="images/game_diagram.png" alt="Game Board Layout" width="300"/>
</p>

## Modules

### `TCell`
A single Tic-Tac-Toe cell.

**Inputs:**
- `clk`: Clock signal.
- `set`: Signal to attempt setting the cell.
- `reset`: Global reset signal.
- `set_symbol`: Symbol to set (`0` for player X, `1` for player O).

**Outputs:**
- `valid`: High if the cell has been set.
- `symbol`: Symbol stored in the cell.

**Behavior:**
- On reset, clears the cell.
- If `set` is high and cell is not already set (`!valid`), stores the `set_symbol` and marks cell as valid.

---

###  `rcdecode`
Row-column to index decoder.

**Inputs:**
- `row`, `col`: 2-bit values indicating row and column (1-based, from `01` to `11`).

**Output:**
- `o`: 4-bit decoded value from 0 to 8, corresponding to a unique cell in the 3x3 board.

---

###  `setter`
Generates a 9-bit signal to set the desired cell.

**Inputs:**
- `c`: Decoded cell index (0–8).
- `set`: Set enable signal.
- `gstate`: Game state (0 = ongoing, non-zero = finished).

**Output:**
- `v`: 9-bit vector where only bit `c` is high when set is active and game is not over.

---

###  `switch`
Determines current player.

**Input:**
- `valid`: 9-bit vector indicating which cells are already set.

**Output:**
- `player`: XOR of all valid bits → alternates between players (0 and 1).

---

###  `TBox`
Top-level module combining all other modules.

**Inputs:**
- `clk`, `set`, `reset`: Clock, set signal, and reset.
- `row`, `col`: 2-bit inputs representing the target cell location (1-based).

**Outputs:**
- `valid`: 9-bit output indicating filled cells.
- `symbol`: 9-bit output representing each cell's symbol.
- `game_state`: 2-bit output representing game status:
  - `00`: Game ongoing
  - `01`: Player O wins
  - `10`: Player X wins
  - `11`: Draw

**Functionality:**
- Tracks game state.
- Detects wins across rows, columns, and diagonals.
- Detects draws when all cells are filled.

---

## Program Flow

1. **Decode Input**: The `rcdecode` module converts row/col into an index.
2. **Check Validity**: The `setter` determines if a move is legal based on game state.
3. **Set Cell**: Corresponding `TCell` is updated with current player's symbol.
4. **Switch Player**: The `switch` module updates the current player.
5. **Check Game State**: `TBox` checks for wins or draw and updates `game_state`.

---
