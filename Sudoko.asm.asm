.model small
.stack 200h

.data

msg_title      db '================================', 0dh, 0ah
               db '         SUDOKU GAME             ', 0dh, 0ah
               db '================================', 0dh, 0ah
               db '$'

msg_menu       db 0dh, 0ah
               db '  Select Difficulty:', 0dh, 0ah, 0dh, 0ah
               db '  1. Easy   ', 0dh, 0ah
               db '  2. Medium', 0dh, 0ah
               db '  3. Hard   ', 0dh, 0ah
               db '  4. Exit   ', 0dh, 0ah, 0dh, 0ah
               db '  Enter choice: $'

msg_invalid    db 0dh, 0ah
               db '  !! Invalid choice. Press 1-4 !!', 0dh, 0ah
               db '$'

msg_exit       db 0dh, 0ah
               db '  Thank you for playing SUDOKU!', 0dh, 0ah
               db '  Goodbye!', 0dh, 0ah
               db '$'

msg_easy_title db 'SUDOKU - EASY MODE   (fill the dots)  $'
msg_med_title  db 'SUDOKU - MEDIUM MODE (fill the dots)  $'
msg_hard_title db 'SUDOKU - HARD MODE   (fill the dots)  $'

msg_border     db '+-------+-------+-------+$'

msg_p_row      db '  Enter Row    (1-9, 0=Menu): $'
msg_p_col      db '  Enter Col    (1-9):         $'
msg_p_num      db '  Enter Number (1-9):         $'

msg_st_inv_row db '  !! Invalid row. Use 1-9  (0=Menu)  $'
msg_st_inv_col db '  !! Invalid col. Use 1-9            $'
msg_st_inv_num db '  !! Invalid number. Use 1-9         $'
msg_st_fixed   db '  !! Cell is fixed. Choose another   $'
msg_st_row_c   db '  !! Number already in this ROW      $'
msg_st_col_c   db '  !! Number already in this COLUMN   $'
msg_st_box_c   db '  !! Number already in this BOX      $'
msg_st_ok      db '  >> Placed! Enter next move:        $'
msg_st_esc     db '  Returning to main menu...          $'
msg_pressany   db '  Press any key to continue...       $'

msg_win        db '  *** CONGRATULATIONS - SOLVED! *** $'
msg_presskey   db '  Press any key for menu...          $'

; SPEED HACK: Using a string to clear lines instead of a loop
clear_line     db '                                                                        $'
blank_space    db '          $'

row_count      db 0
col_count      db 0

easy_idx       db 0
med_idx        db 0
hard_idx       db 0
current_mode   db 0

input_row      db 0
input_col      db 0
input_num      db 0
exit_flag      db 0

t_row0         db 0
t_col0         db 0
t_brow         db 0
t_bcol         db 0
t_scr_row      db 0
t_scr_col      db 0

; ================================================================
; EASY BOARDS  (~27 blanks)
; ================================================================

e0_board db  7,0,8, 2,9,4, 3,6,1
         db  2,0,6, 1,8,3, 5,0,7
         db  0,3,0, 0,6,5, 0,8,2
         db  4,8,0, 3,0,6, 9,2,5
         db  0,0,1, 0,2,8, 6,7,3
         db  3,6,2, 5,7,0, 8,1,0
         db  9,2,3, 0,4,1, 7,0,0
         db  0,0,5, 6,3,7, 0,0,9
         db  6,7,4, 0,5,0, 1,3,8
e0_sol   db  7,5,8, 2,9,4, 3,6,1
         db  2,4,6, 1,8,3, 5,9,7
         db  1,3,9, 7,6,5, 4,8,2
         db  4,8,7, 3,1,6, 9,2,5
         db  5,9,1, 4,2,8, 6,7,3
         db  3,6,2, 5,7,9, 8,1,4
         db  9,2,3, 8,4,1, 7,5,6
         db  8,1,5, 6,3,7, 2,4,9
         db  6,7,4, 9,5,2, 1,3,8

e1_board db  7,5,0, 2,0,4, 3,0,1
         db  0,4,6, 0,8,3, 5,9,0
         db  1,0,9, 7,6,0, 4,8,2
         db  4,0,7, 0,1,6, 9,0,5
         db  5,9,0, 4,0,8, 6,7,0
         db  0,6,2, 5,7,0, 8,0,4
         db  9,0,3, 8,0,1, 7,5,0
         db  0,1,5, 6,3,0, 2,4,0
         db  6,7,0, 0,5,2, 0,3,8
e1_sol   db  7,5,8, 2,9,4, 3,6,1
         db  2,4,6, 1,8,3, 5,9,7
         db  1,3,9, 7,6,5, 4,8,2
         db  4,8,7, 3,1,6, 9,2,5
         db  5,9,1, 4,2,8, 6,7,3
         db  3,6,2, 5,7,9, 8,1,4
         db  9,2,3, 8,4,1, 7,5,6
         db  8,1,5, 6,3,7, 2,4,9
         db  6,7,4, 9,5,2, 1,3,8

e2_board db  0,5,8, 2,9,0, 3,6,0
         db  2,4,0, 1,0,3, 0,9,7
         db  0,3,9, 0,6,5, 4,0,2
         db  4,8,7, 3,1,0, 0,2,5
         db  5,0,1, 4,2,8, 0,7,3
         db  3,6,0, 5,0,9, 8,1,4
         db  0,2,3, 8,4,0, 7,5,6
         db  8,1,0, 6,3,7, 2,0,9
         db  6,0,4, 9,5,2, 1,3,0
e2_sol   db  7,5,8, 2,9,4, 3,6,1
         db  2,4,6, 1,8,3, 5,9,7
         db  1,3,9, 7,6,5, 4,8,2
         db  4,8,7, 3,1,6, 9,2,5
         db  5,9,1, 4,2,8, 6,7,3
         db  3,6,2, 5,7,9, 8,1,4
         db  9,2,3, 8,4,1, 7,5,6
         db  8,1,5, 6,3,7, 2,4,9
         db  6,7,4, 9,5,2, 1,3,8

e3_board db  7,5,8, 0,9,4, 0,6,1
         db  2,0,6, 1,8,0, 5,9,7
         db  1,3,0, 7,0,5, 4,8,0
         db  0,8,7, 3,1,6, 9,0,5
         db  5,9,1, 0,2,0, 6,7,3
         db  3,0,2, 5,7,9, 0,1,4
         db  9,2,0, 8,4,1, 0,5,6
         db  8,1,5, 0,3,7, 2,0,9
         db  0,7,4, 9,0,2, 1,3,0
e3_sol   db  7,5,8, 2,9,4, 3,6,1
         db  2,4,6, 1,8,3, 5,9,7
         db  1,3,9, 7,6,5, 4,8,2
         db  4,8,7, 3,1,6, 9,2,5
         db  5,9,1, 4,2,8, 6,7,3
         db  3,6,2, 5,7,9, 8,1,4
         db  9,2,3, 8,4,1, 7,5,6
         db  8,1,5, 6,3,7, 2,4,9
         db  6,7,4, 9,5,2, 1,3,8

e4_board db  7,0,8, 2,9,4, 0,6,1
         db  2,4,6, 0,8,3, 5,0,7
         db  1,3,9, 7,6,5, 4,8,0
         db  4,8,0, 3,0,6, 9,2,5
         db  0,9,1, 4,2,0, 6,7,3
         db  3,6,2, 0,7,9, 8,1,0
         db  0,2,3, 8,4,1, 7,0,6
         db  8,0,5, 6,3,7, 0,4,9
         db  6,7,4, 9,0,2, 1,3,0
e4_sol   db  7,5,8, 2,9,4, 3,6,1
         db  2,4,6, 1,8,3, 5,9,7
         db  1,3,9, 7,6,5, 4,8,2
         db  4,8,7, 3,1,6, 9,2,5
         db  5,9,1, 4,2,8, 6,7,3
         db  3,6,2, 5,7,9, 8,1,4
         db  9,2,3, 8,4,1, 7,5,6
         db  8,1,5, 6,3,7, 2,4,9
         db  6,7,4, 9,5,2, 1,3,8

; ================================================================
; MEDIUM BOARDS
; ================================================================

m0_board db  5,0,0, 0,3,6, 7,4,0
         db  0,0,0, 9,0,0, 0,2,5
         db  0,8,4, 7,0,0, 9,0,0
         db  9,0,0, 0,6,7, 0,0,8
         db  0,2,1, 0,0,0, 0,0,7
         db  0,0,6, 3,1,0, 0,0,0
         db  3,6,0, 0,0,4, 0,8,0
         db  0,0,7, 6,0,0, 5,0,0
         db  0,0,0, 0,9,0, 0,7,4
m0_sol   db  5,9,2, 8,3,6, 7,4,1
         db  6,7,3, 9,4,1, 8,2,5
         db  1,8,4, 7,2,5, 9,3,6
         db  9,3,5, 2,6,7, 4,1,8
         db  8,2,1, 4,5,9, 3,6,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,9, 5,7,4, 1,8,2
         db  4,1,7, 6,8,2, 5,9,3
         db  2,5,8, 1,9,3, 6,7,4

m1_board db  5,0,0, 0,0,0, 7,4,0
         db  6,7,3, 9,4,1, 8,0,5
         db  1,8,0, 0,2,5, 9,3,6
         db  0,0,5, 0,0,0, 4,0,8
         db  8,0,1, 0,5,9, 3,0,7
         db  0,0,0, 0,1,8, 0,0,9
         db  0,6,0, 5,7,4, 0,8,0
         db  4,1,7, 0,0,2, 5,0,3
         db  0,0,0, 0,9,3, 6,7,0
m1_sol   db  5,9,2, 8,3,6, 7,4,1
         db  6,7,3, 9,4,1, 8,2,5
         db  1,8,4, 7,2,5, 9,3,6
         db  9,3,5, 2,6,7, 4,1,8
         db  8,2,1, 4,5,9, 3,6,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,9, 5,7,4, 1,8,2
         db  4,1,7, 6,8,2, 5,9,3
         db  2,5,8, 1,9,3, 6,7,4

m2_board db  0,9,2, 8,0,6, 7,4,1
         db  0,7,0, 9,0,1, 8,0,0
         db  1,0,0, 7,2,0, 9,0,6
         db  9,0,5, 2,6,0, 0,1,8
         db  8,0,1, 0,0,9, 0,6,0
         db  7,4,6, 0,1,0, 2,0,0
         db  0,6,9, 5,7,0, 0,8,0
         db  4,0,0, 6,8,0, 0,9,3
         db  0,0,8, 0,0,3, 0,0,0
m2_sol   db  5,9,2, 8,3,6, 7,4,1
         db  6,7,3, 9,4,1, 8,2,5
         db  1,8,4, 7,2,5, 9,3,6
         db  9,3,5, 2,6,7, 4,1,8
         db  8,2,1, 4,5,9, 3,6,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,9, 5,7,4, 1,8,2
         db  4,1,7, 6,8,2, 5,9,3
         db  2,5,8, 1,9,3, 6,7,4

m3_board db  5,9,2, 8,3,6, 7,0,0
         db  0,0,3, 9,4,0, 8,0,5
         db  1,8,4, 7,2,0, 9,3,0
         db  0,3,0, 2,6,7, 0,0,8
         db  8,2,0, 4,5,0, 3,0,7
         db  7,0,6, 0,0,0, 0,0,9
         db  3,6,9, 5,0,0, 1,8,2
         db  0,1,0, 6,8,0, 0,9,0
         db  0,5,0, 1,9,0, 6,0,0
m3_sol   db  5,9,2, 8,3,6, 7,4,1
         db  6,7,3, 9,4,1, 8,2,5
         db  1,8,4, 7,2,5, 9,3,6
         db  9,3,5, 2,6,7, 4,1,8
         db  8,2,1, 4,5,9, 3,6,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,9, 5,7,4, 1,8,2
         db  4,1,7, 6,8,2, 5,9,3
         db  2,5,8, 1,9,3, 6,7,4

m4_board db  5,9,0, 8,3,6, 7,0,1
         db  0,7,3, 9,0,1, 8,0,0
         db  1,8,4, 0,0,0, 9,0,6
         db  9,0,0, 0,6,7, 0,1,0
         db  8,0,1, 4,5,0, 0,0,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,0, 5,7,0, 1,0,2
         db  0,1,7, 6,0,0, 5,9,3
         db  2,5,0, 1,9,0, 6,0,4
m4_sol   db  5,9,2, 8,3,6, 7,4,1
         db  6,7,3, 9,4,1, 8,2,5
         db  1,8,4, 7,2,5, 9,3,6
         db  9,3,5, 2,6,7, 4,1,8
         db  8,2,1, 4,5,9, 3,6,7
         db  7,4,6, 3,1,8, 2,5,9
         db  3,6,9, 5,7,4, 1,8,2
         db  4,1,7, 6,8,2, 5,9,3
         db  2,5,8, 1,9,3, 6,7,4

; ================================================================
; HARD BOARDS
; ================================================================

h0_board db  0,0,0, 9,1,2, 0,0,0
         db  0,0,0, 7,0,0, 0,0,9
         db  2,4,0, 0,0,0, 6,1,0
         db  0,0,0, 0,0,0, 4,9,0
         db  0,0,6, 2,0,0, 1,0,0
         db  4,8,0, 3,0,0, 0,7,0
         db  0,3,4, 0,0,7, 0,0,0
         db  7,0,1, 0,0,0, 0,0,4
         db  0,0,0, 0,6,8, 0,0,0
h0_sol   db  6,5,7, 9,1,2, 3,4,8
         db  3,1,8, 7,4,6, 2,5,9
         db  2,4,9, 8,5,3, 6,1,7
         db  1,7,3, 6,8,5, 4,9,2
         db  5,9,6, 2,7,4, 1,8,3
         db  4,8,2, 3,9,1, 5,7,6
         db  8,3,4, 1,2,7, 9,6,5
         db  7,6,1, 5,3,9, 8,2,4
         db  9,2,5, 4,6,8, 7,3,1

h1_board db  0,0,0, 0,1,2, 3,0,0
         db  3,0,0, 7,4,0, 2,0,0
         db  0,0,9, 0,0,3, 6,1,0
         db  1,7,3, 6,0,5, 0,9,0
         db  5,0,0, 0,7,0, 1,0,0
         db  4,0,0, 3,9,1, 0,0,0
         db  0,3,4, 0,0,7, 9,0,5
         db  7,6,0, 0,0,0, 8,0,0
         db  9,2,5, 0,0,0, 7,3,0
h1_sol   db  6,5,7, 9,1,2, 3,4,8
         db  3,1,8, 7,4,6, 2,5,9
         db  2,4,9, 8,5,3, 6,1,7
         db  1,7,3, 6,8,5, 4,9,2
         db  5,9,6, 2,7,4, 1,8,3
         db  4,8,2, 3,9,1, 5,7,6
         db  8,3,4, 1,2,7, 9,6,5
         db  7,6,1, 5,3,9, 8,2,4
         db  9,2,5, 4,6,8, 7,3,1

h2_board db  6,0,7, 0,1,0, 0,4,8
         db  0,0,0, 0,0,0, 2,5,9
         db  0,0,9, 0,0,0, 6,1,0
         db  1,7,3, 6,8,0, 4,0,0
         db  0,0,0, 0,0,4, 1,0,0
         db  4,0,2, 3,9,1, 5,7,6
         db  8,0,4, 1,0,0, 9,6,0
         db  7,0,0, 5,3,0, 0,0,0
         db  9,0,0, 0,6,8, 7,0,0
h2_sol   db  6,5,7, 9,1,2, 3,4,8
         db  3,1,8, 7,4,6, 2,5,9
         db  2,4,9, 8,5,3, 6,1,7
         db  1,7,3, 6,8,5, 4,9,2
         db  5,9,6, 2,7,4, 1,8,3
         db  4,8,2, 3,9,1, 5,7,6
         db  8,3,4, 1,2,7, 9,6,5
         db  7,6,1, 5,3,9, 8,2,4
         db  9,2,5, 4,6,8, 7,3,1

h3_board db  6,0,7, 0,1,0, 3,0,0
         db  3,1,8, 0,4,6, 2,0,9
         db  2,0,9, 8,0,0, 6,0,7
         db  0,0,0, 6,8,5, 4,0,2
         db  0,9,0, 2,0,0, 0,8,0
         db  4,0,0, 0,0,1, 0,7,0
         db  0,0,0, 0,0,7, 9,6,0
         db  7,6,1, 5,0,0, 0,2,0
         db  9,0,5, 4,6,8, 0,0,1
h3_sol   db  6,5,7, 9,1,2, 3,4,8
         db  3,1,8, 7,4,6, 2,5,9
         db  2,4,9, 8,5,3, 6,1,7
         db  1,7,3, 6,8,5, 4,9,2
         db  5,9,6, 2,7,4, 1,8,3
         db  4,8,2, 3,9,1, 5,7,6
         db  8,3,4, 1,2,7, 9,6,5
         db  7,6,1, 5,3,9, 8,2,4
         db  9,2,5, 4,6,8, 7,3,1

h4_board db  6,0,7, 9,1,0, 3,4,8
         db  0,1,8, 7,4,0, 0,0,9
         db  2,4,0, 8,5,3, 6,0,7
         db  1,7,0, 0,0,5, 0,9,2
         db  0,9,6, 0,0,0, 1,8,0
         db  0,8,2, 0,0,1, 5,7,0
         db  8,3,0, 0,2,0, 0,6,0
         db  0,6,0, 5,0,0, 8,2,0
         db  0,2,0, 4,6,0, 7,0,1
h4_sol   db  6,5,7, 9,1,2, 3,4,8
         db  3,1,8, 7,4,6, 2,5,9
         db  2,4,9, 8,5,3, 6,1,7
         db  1,7,3, 6,8,5, 4,9,2
         db  5,9,6, 2,7,4, 1,8,3
         db  4,8,2, 3,9,1, 5,7,6
         db  8,3,4, 1,2,7, 9,6,5
         db  7,6,1, 5,3,9, 8,2,4
         db  9,2,5, 4,6,8, 7,3,1

active_board db 81 dup(0)
active_sol   db 81 dup(0)
fixed_cells  db 81 dup(0)

.code

main proc
    mov ax, @data
    mov ds, ax

    mov ah, 2ch
    int 21h
    mov al, dh
    mov ah, 0
    mov bl, 5
    div bl
    mov [easy_idx], ah

    mov ah, 2ch
    int 21h
    mov al, dl
    mov ah, 0
    mov bl, 5
    div bl
    mov [med_idx], ah

    mov ah, 2ch
    int 21h
    mov al, cl
    mov ah, 0
    mov bl, 5
    div bl
    mov [hard_idx], ah

menu_loop:
    call clear_screen
    call print_main_menu
    call get_key
    call echo_char

    cmp al, '1'
    je  do_easy
    cmp al, '2'
    je  do_med
    cmp al, '3'
    je  do_hard
    cmp al, '4'
    je  do_exit

    mov dx, offset msg_invalid
    call print_str
    call get_key
    jmp menu_loop

do_easy:
    mov byte ptr [current_mode], 1
    call play_game
    call adv_easy_idx
    jmp menu_loop
do_med:
    mov byte ptr [current_mode], 2
    call play_game
    call adv_med_idx
    jmp menu_loop
do_hard:
    mov byte ptr [current_mode], 3
    call play_game
    call adv_hard_idx
    jmp menu_loop
do_exit:
    mov dx, offset msg_exit
    call print_str
    mov ah, 4ch
    mov al, 0
    int 21h
main endp

adv_easy_idx proc
    mov al, [easy_idx]
    inc al
    cmp al, 5
    jl  aei_ok
    mov al, 0
aei_ok:
    mov [easy_idx], al
    ret
adv_easy_idx endp

adv_med_idx proc
    mov al, [med_idx]
    inc al
    cmp al, 5
    jl  ami_ok
    mov al, 0
ami_ok:
    mov [med_idx], al
    ret
adv_med_idx endp

adv_hard_idx proc
    mov al, [hard_idx]
    inc al
    cmp al, 5
    jl  ahi_ok
    mov al, 0
ahi_ok:
    mov [hard_idx], al
    ret
adv_hard_idx endp

play_game proc
    push ax
    push bx
    push dx

    mov byte ptr [exit_flag], 0

    call clear_board_arrays
    call load_board
    call init_fixed

    call clear_screen
    call draw_title_row
    call draw_board
    call draw_prompts

pg_loop:
    call get_move

    mov al, [exit_flag]
    cmp al, 1
    je  pg_exit

    call validate_place

    mov al, [exit_flag]
    cmp al, 1
    je  pg_exit

    call check_win
    cmp al, 1
    jne pg_loop

    call show_win
    jmp pg_done

pg_exit:
    call clear_status
    call print_status
    mov dx, offset msg_st_esc
    call print_str
    call get_key
    mov byte ptr [exit_flag], 0

pg_done:
    pop dx
    pop bx
    pop ax
    ret
play_game endp

draw_prompts proc
    push dx
    mov dh, 18
    mov dl, 0
    call set_cursor
    mov dx, offset msg_p_row
    call print_str
    mov dh, 19
    mov dl, 0
    call set_cursor
    mov dx, offset msg_p_col
    call print_str
    mov dh, 20
    mov dl, 0
    call set_cursor
    mov dx, offset msg_p_num
    call print_str
    pop dx
    ret
draw_prompts endp

; SPEED OPTIMIZATION: Using DOS string print instead of loops for clearing
clear_status proc
    push ax
    push bx
    push cx
    push dx

    mov dh, 22
    mov dl, 0
    call set_cursor
    mov dx, offset clear_line
    call print_str

    mov dh, 18
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str

    mov dh, 19
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str

    mov dh, 20
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str

    pop dx
    pop cx
    pop bx
    pop ax
    ret
clear_status endp

print_status proc
    push dx
    mov dh, 22
    mov dl, 0
    call set_cursor
    pop dx
    ret
print_status endp

clear_board_arrays proc
    push ax
    push cx
    push di
    mov di, offset active_board
    mov cx, 81
    mov al, 0
cba_1:
    mov [di], al
    inc di
    loop cba_1
    mov di, offset active_sol
    mov cx, 81
cba_2:
    mov [di], al
    inc di
    loop cba_2
    mov di, offset fixed_cells
    mov cx, 81
cba_3:
    mov [di], al
    inc di
    loop cba_3
    pop di
    pop cx
    pop ax
    ret
clear_board_arrays endp

load_board proc
    push ax
    push bx
    push cx
    push si
    push di

    mov al, [current_mode]
    cmp al, 1
    je  lb_easy
    cmp al, 2
    je  lb_med

    mov al, [hard_idx]
    cmp al, 0
    jne lb_h1
    mov si, offset h0_board
    mov di, offset h0_sol
    jmp lb_copy
lb_h1:
    cmp al, 1
    jne lb_h2
    mov si, offset h1_board
    mov di, offset h1_sol
    jmp lb_copy
lb_h2:
    cmp al, 2
    jne lb_h3
    mov si, offset h2_board
    mov di, offset h2_sol
    jmp lb_copy
lb_h3:
    cmp al, 3
    jne lb_h4
    mov si, offset h3_board
    mov di, offset h3_sol
    jmp lb_copy
lb_h4:
    mov si, offset h4_board
    mov di, offset h4_sol
    jmp lb_copy

lb_easy:
    mov al, [easy_idx]
    cmp al, 0
    jne lb_e1
    mov si, offset e0_board
    mov di, offset e0_sol
    jmp lb_copy
lb_e1:
    cmp al, 1
    jne lb_e2
    mov si, offset e1_board
    mov di, offset e1_sol
    jmp lb_copy
lb_e2:
    cmp al, 2
    jne lb_e3
    mov si, offset e2_board
    mov di, offset e2_sol
    jmp lb_copy
lb_e3:
    cmp al, 3
    jne lb_e4
    mov si, offset e3_board
    mov di, offset e3_sol
    jmp lb_copy
lb_e4:
    mov si, offset e4_board
    mov di, offset e4_sol
    jmp lb_copy

lb_med:
    mov al, [med_idx]
    cmp al, 0
    jne lb_m1
    mov si, offset m0_board
    mov di, offset m0_sol
    jmp lb_copy
lb_m1:
    cmp al, 1
    jne lb_m2
    mov si, offset m1_board
    mov di, offset m1_sol
    jmp lb_copy
lb_m2:
    cmp al, 2
    jne lb_m3
    mov si, offset m2_board
    mov di, offset m2_sol
    jmp lb_copy
lb_m3:
    cmp al, 3
    jne lb_m4
    mov si, offset m3_board
    mov di, offset m3_sol
    jmp lb_copy
lb_m4:
    mov si, offset m4_board
    mov di, offset m4_sol

lb_copy:
    push di
    mov di, offset active_board
    mov cx, 81
lb_bloop:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop lb_bloop
    pop si

    mov di, offset active_sol
    mov cx, 81
lb_sloop:
    mov al, [si]
    mov [di], al
    inc si
    inc di
    loop lb_sloop

    pop di
    pop si
    pop cx
    pop bx
    pop ax
    ret
load_board endp

init_fixed proc
    push ax
    push cx
    push si
    push di
    mov si, offset active_board
    mov di, offset fixed_cells
    mov cx, 81
if_loop:
    mov al, [si]
    cmp al, 0
    je  if_zero
    mov byte ptr [di], 1
    jmp if_next
if_zero:
    mov byte ptr [di], 0
if_next:
    inc si
    inc di
    loop if_loop
    pop di
    pop si
    pop cx
    pop ax
    ret
init_fixed endp

clear_screen proc
    push ax
    push bx
    push cx
    push dx
    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    int 10h
    mov dh, 0
    mov dl, 0
    call set_cursor
    pop dx
    pop cx
    pop bx
    pop ax
    ret
clear_screen endp

set_cursor proc
    push ax
    push bx
    mov ah, 02h
    mov bh, 0
    int 10h
    pop bx
    pop ax
    ret
set_cursor endp

print_str proc
    push ax
    mov ah, 09h
    int 21h
    pop ax
    ret
print_str endp

get_key proc
    mov ah, 08h
    int 21h
    ret
get_key endp

echo_char proc
    push ax
    push bx
    push cx
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor
    pop cx
    pop bx
    pop ax
    ret
echo_char endp

print_main_menu proc
    push dx
    mov dx, offset msg_title
    call print_str
    mov dx, offset msg_menu
    call print_str
    pop dx
    ret
print_main_menu endp

draw_title_row proc
    push ax
    push dx
    mov dh, 0
    mov dl, 0
    call set_cursor
    mov al, [current_mode]
    cmp al, 1
    jne dtr_med
    mov dx, offset msg_easy_title
    jmp dtr_print
dtr_med:
    cmp al, 2
    jne dtr_hard
    mov dx, offset msg_med_title
    jmp dtr_print
dtr_hard:
    mov dx, offset msg_hard_title
dtr_print:
    call print_str
    pop dx
    pop ax
    ret
draw_title_row endp

draw_board proc
    push ax
    push bx
    push cx
    push dx
    push si

    mov dh, 4
    mov dl, 27
    call set_cursor
    mov dx, offset msg_border
    call print_str

    mov si, offset active_board
    mov byte ptr [row_count], 0

db_row:
    mov al, [row_count]
    cmp al, 9
    jge db_done

    mov al, [row_count]
    mov ah, 0
    mov bl, 3
    div bl
    mov bh, al
    mov al, [row_count]
    add al, 5
    add al, bh
    mov dh, al
    mov dl, 27
    call set_cursor

    mov ah, 09h
    mov al, '|'
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor

    mov ah, 09h
    mov al, ' '
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor

    mov byte ptr [col_count], 0

db_col:
    mov al, [col_count]
    cmp al, 9
    jge db_col_done

    mov al, [si]
    inc si
    cmp al, 0
    jne db_digit
    mov al, '.'
    jmp db_print_cell
db_digit:
    add al, '0'
db_print_cell:
    push ax
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor
    pop ax

    mov ah, 09h
    mov al, ' '
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor

    mov al, [col_count]
    cmp al, 2
    je  db_sep
    cmp al, 5
    je  db_sep
    jmp db_no_sep
db_sep:
    mov ah, 09h
    mov al, '|'
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor

    mov ah, 09h
    mov al, ' '
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    mov ah, 03h
    mov bh, 0
    int 10h
    inc dl
    call set_cursor
db_no_sep:
    inc byte ptr [col_count]
    jmp db_col

db_col_done:
    mov ah, 09h
    mov al, '|'
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h

    mov al, [row_count]
    cmp al, 2
    je  db_mid
    cmp al, 5
    je  db_mid
    jmp db_next_row

db_mid:
    mov al, [row_count]
    mov ah, 0
    mov bl, 3
    div bl
    mov bh, al
    mov al, [row_count]
    add al, 5
    add al, bh
    inc al
    mov dh, al
    mov dl, 27
    call set_cursor
    mov dx, offset msg_border
    call print_str

db_next_row:
    inc byte ptr [row_count]
    jmp db_row

db_done:
    mov dh, 16
    mov dl, 27
    call set_cursor
    mov dx, offset msg_border
    call print_str

    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
draw_board endp

update_cell proc
    push ax
    push bx
    push cx
    push dx

    mov al, [input_row]
    dec al
    mov byte ptr [t_row0], al
    mov ah, 0
    mov bl, 3
    div bl
    mov byte ptr [t_brow], al
    mov al, [t_row0]
    add al, 5
    add al, [t_brow]
    mov byte ptr [t_scr_row], al

    mov al, [input_col]
    dec al
    mov byte ptr [t_col0], al
    mov ah, 0
    mov bl, 3
    div bl
    mov byte ptr [t_bcol], al
    mov al, [t_col0]
    shl al, 1
    mov bl, [t_bcol]
    shl bl, 1
    add al, bl
    add al, 29
    mov byte ptr [t_scr_col], al

    mov dh, [t_scr_row]
    mov dl, [t_scr_col]
    call set_cursor

    mov al, [input_num]
    add al, '0'
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
update_cell endp

check_cell_fixed proc
    push bx
    push di
    mov al, [input_row]
    dec al
    mov ah, 0
    mov bl, 9
    mul bl
    mov bx, ax
    mov al, [input_col]
    dec al
    mov ah, 0
    add bx, ax
    mov di, offset fixed_cells
    add di, bx
    mov al, [di]
    pop di
    pop bx
    ret
check_cell_fixed endp

get_move proc
    push ax
    push bx
    push cx
    push dx

    call clear_status

gm_row_again:
    mov dh, 18
    mov dl, 30
    call set_cursor
    call get_key

    cmp al, 1bh
    jne gm_row_noesc
    mov byte ptr [exit_flag], 1
    jmp gm_done
gm_row_noesc:
    push ax
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    pop ax

    sub al, '0'
    cmp al, 0
    jne gm_row_not0
    mov byte ptr [exit_flag], 1
    jmp gm_done
gm_row_not0:
    cmp al, 1
    jl  gm_row_err
    cmp al, 9
    jg  gm_row_err
    mov [input_row], al
    jmp gm_col

gm_row_err:
    call print_status
    mov dx, offset msg_st_inv_row
    call print_str
    call get_key
    mov dh, 22
    mov dl, 0
    call set_cursor
    mov dx, offset clear_line
    call print_str
    mov dh, 18
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str
    jmp gm_row_again

gm_col:
gm_col_again:
    mov dh, 19
    mov dl, 30
    call set_cursor
    call get_key

    cmp al, 1bh
    jne gm_col_noesc
    mov byte ptr [exit_flag], 1
    jmp gm_done
gm_col_noesc:
    push ax
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    pop ax

    sub al, '0'
    cmp al, 1
    jl  gm_col_err
    cmp al, 9
    jg  gm_col_err
    mov [input_col], al
    jmp gm_check_fixed

gm_col_err:
    call print_status
    mov dx, offset msg_st_inv_col
    call print_str
    call get_key
    mov dh, 22
    mov dl, 0
    call set_cursor
    mov dx, offset clear_line
    call print_str
    mov dh, 19
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str
    jmp gm_col_again

gm_check_fixed:
    call check_cell_fixed
    cmp al, 1
    jne gm_num
    call print_status
    mov dx, offset msg_st_fixed
    call print_str
    call get_key
    call clear_status
    jmp gm_row_again

gm_num:
gm_num_again:
    mov dh, 20
    mov dl, 30
    call set_cursor
    call get_key

    cmp al, 1bh
    jne gm_num_noesc
    mov byte ptr [exit_flag], 1
    jmp gm_done
gm_num_noesc:
    push ax
    mov ah, 09h
    mov bh, 0
    mov bl, 07h
    mov cx, 1
    int 10h
    pop ax

    sub al, '0'
    cmp al, 1
    jl  gm_num_err
    cmp al, 9
    jg  gm_num_err
    mov [input_num], al
    jmp gm_done

gm_num_err:
    call print_status
    mov dx, offset msg_st_inv_num
    call print_str
    call get_key
    mov dh, 22
    mov dl, 0
    call set_cursor
    mov dx, offset clear_line
    call print_str
    mov dh, 20
    mov dl, 30
    call set_cursor
    mov dx, offset blank_space
    call print_str
    jmp gm_num_again

gm_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
get_move endp

validate_place proc
    push ax
    push bx
    push dx
    push si

    mov al, [input_row]
    dec al
    mov ah, 0
    mov bl, 9
    mul bl
    mov bx, ax
    mov al, [input_col]
    dec al
    mov ah, 0
    add bx, ax

    call check_row
    cmp al, 1
    jne vp_col
    call print_status
    mov dx, offset msg_st_row_c
    call print_str
    call get_key
    call clear_status
    jmp vp_done

vp_col:
    call check_col
    cmp al, 1
    jne vp_box
    call print_status
    mov dx, offset msg_st_col_c
    call print_str
    call get_key
    call clear_status
    jmp vp_done

vp_box:
    call check_box
    cmp al, 1
    jne vp_place
    call print_status
    mov dx, offset msg_st_box_c
    call print_str
    call get_key
    call clear_status
    jmp vp_done

vp_place:
    mov si, offset active_board
    add si, bx
    mov al, [input_num]
    mov [si], al

    call update_cell

    call check_win
    cmp al, 1
    je  vp_done

    call print_status
    mov dx, offset msg_st_ok
    call print_str
    call get_key
    call clear_status

vp_done:
    pop si
    pop dx
    pop bx
    pop ax
    ret
validate_place endp

check_row proc
    push bx
    push cx
    push si
    mov al, [input_row]
    dec al
    mov ah, 0
    mov bl, 9
    mul bl
    mov si, offset active_board
    add si, ax
    mov cx, 9
    mov bl, 1
cr_loop:
    mov al, bl
    cmp al, [input_col]
    je  cr_skip
    mov al, [si]
    cmp al, [input_num]
    jne cr_skip
    mov al, 1
    jmp cr_done
cr_skip:
    inc si
    inc bl
    loop cr_loop
    mov al, 0
cr_done:
    pop si
    pop cx
    pop bx
    ret
check_row endp

check_col proc
    push bx
    push cx
    push si
    mov al, [input_col]
    dec al
    mov ah, 0
    mov si, offset active_board
    add si, ax
    mov cx, 9
    mov bl, 1
cc_loop:
    mov al, bl
    cmp al, [input_row]
    je  cc_skip
    mov al, [si]
    cmp al, [input_num]
    jne cc_skip
    mov al, 1
    jmp cc_done
cc_skip:
    add si, 9
    inc bl
    loop cc_loop
    mov al, 0
cc_done:
    pop si
    pop cx
    pop bx
    ret
check_col endp

check_box proc
    push bx
    push cx
    push dx
    push si

    mov al, [input_row]
    dec al
    mov ah, 0
    mov bl, 3
    div bl
    mov ah, 0
    mov bl, 3
    mul bl
    mov bh, al

    mov al, [input_col]
    dec al
    mov ah, 0
    mov bl, 3
    div bl
    mov ah, 0
    mov bl, 3
    mul bl
    mov bl, al

    mov dh, 0
cb_rloop:
    cmp dh, 3
    jge cb_no_conflict
    mov dl, 0
cb_cloop:
    cmp dl, 3
    jge cb_next_row
    mov al, bh
    add al, dh
    inc al
    cmp al, [input_row]
    jne cb_check
    mov al, bl
    add al, dl
    inc al
    cmp al, [input_col]
    je  cb_next_col
cb_check:
    mov al, bh
    add al, dh
    mov ah, 0
    mov cl, 9
    mul cl
    mov si, offset active_board
    add si, ax
    mov al, bl
    add al, dl
    mov ah, 0
    add si, ax
    mov al, [si]
    cmp al, [input_num]
    jne cb_next_col
    mov al, 1
    jmp cb_done
cb_next_col:
    inc dl
    jmp cb_cloop
cb_next_row:
    inc dh
    jmp cb_rloop
cb_no_conflict:
    mov al, 0
cb_done:
    pop si
    pop dx
    pop cx
    pop bx
    ret
check_box endp

check_win proc
    push cx
    push si
    mov si, offset active_board
    mov cx, 81
cw_loop:
    mov al, [si]
    cmp al, 0
    je  cw_no
    inc si
    loop cw_loop
    mov al, 1
    jmp cw_done
cw_no:
    mov al, 0
cw_done:
    pop si
    pop cx
    ret
check_win endp

show_win proc
    push dx
    call print_status
    mov dx, offset msg_win
    call print_str

    mov dh, 23
    mov dl, 0
    call set_cursor
    mov dx, offset msg_presskey
    call print_str

    call get_key
    pop dx
    ret
show_win endp

end main