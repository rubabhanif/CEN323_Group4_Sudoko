# CEN323_Group4_Sudoko
Course: CEN 323 Computer Organization & Assembly Language (COAL)

Instructor: Adnan Jelani

University: Bahria University, Department of Computer Science

Group Number: 04


# Project Description

This is a fully interactive Sudoku game built entirely in 8086 Assembly Language and runs in the emu8086 emulator. The player selects a difficulty level from the main menu — Easy, Medium, or Hard — and is presented with a 9x9 Sudoku grid to solve. The game validates every move in real time, checking for conflicts across the row, column, and 3x3 box. Pre-filled cells are protected and cannot be overwritten. When all 81 cells are correctly filled, a congratulations message is displayed. Each difficulty has 5 unique puzzle boards that cycle automatically after each game.

# Features

Three difficulty levels : Easy, Medium, Hard

Five unique boards per difficulty (15 boards total)

Real-time row, column, and 3x3 box conflict detection

Fixed cell protection (pre-filled cells cannot be changed)

Win detection with congratulations screen

Clean grid display with box separators using BIOS interrupts

ESC or entering 0 at row prompt returns to main menu

# How to Run

Open emu8086

Click File → Open and select sudoku.asm

Click Emulate to assemble the code

Click Run to start the game


# How to Play

At the main menu press 1 for Easy, 2 for Medium, 3 for Hard, 4 to Exit

Enter a row number (1–9), press 0 to go back to menu

Enter a column number (1–9)

Enter a digit (1–9) to place in that cell

The game will show an error if the move is invalid and let you try again

Fill all blank cells (shown as dots) correctly to win


# Team Contributions

# Member Name Registration Number Modules Owned: 

Rubab Hanif 01-135232-082 Game Engine and Validation: play_game, load_board, init_fixed, validate_place, check_row, check_col, check_box, check_win, show_win, all board and solution arrays in .data 

Areeza Maryam 01-135232-013 UI and Input Handling: draw_board, update_cell, draw_prompts, clear_status, get_move, clear_screen, set_cursor, print_str, get_key, echo_char, print_main_menu, draw_title_row, all display strings in .data


# Files in This Repository
Sudoku.asm , READme.md

# Assembly Concepts Used

This project covers all lab topics from CEN 323 including data movement, arithmetic, logical and shift operations, branching, LOOP instruction, stack operations, procedures, array operations, DOS interrupts (INT 21h), BIOS video interrupts (INT 10h), memory segmentation, and comparison with flags.


#Academic Integrity

This project was developed independently by the group members listed above as part of the CEN 323 semester project at Bahria University. AI assistance was used for  report writing / debugging help and is disclosed in the project report as required.
