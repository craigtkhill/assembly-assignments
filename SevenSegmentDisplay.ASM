mov bl, a0            ; bl holds base address for the 7 segment display translation table
mov cl, 00            ; cl to holds the units
mov dl, 00            ; dl to holds the tens
mov al, [bl]          ; right side of display set to 0
out 02
sub al, 01            ; left side of display set to 0
out 02

OUTPUT_UNITS:         ; OUTPUT_UNITS
push cl               ; move the value of the units in the cl register into the al register 
pop al                
add al, bl            ; add the base address to get the address of the display code
mov al, [al]          ; display code moved into the al register
out 02                ; display this code to the 7 segment display
in 00                 ; get input from the user
cmp al, 2b            ; compare input with '+'
jz INCREMENT          ; if the input is equal to '+' jump to the INCREMENT label
jnz DECREMENT         ; else jump to the DECREMENT label

INCREMENT:            ; INCREMENT (if '+' selected)
cmp cl, 09            ; compare the units value to 09
jz INCREMENT_TENS     ; if the units value is equal to 09 jump to the INCREMENT_TENS label
inc cl                ; else increment the units value by 01
jmp OUTPUT_UNITS      ; and jump to the OUTPUT_UNITS label

DECREMENT:            ; DECREMENT (if '+' not selected)
cmp cl, 00            ; compare the units value with 00
jz DECREMENT_TENS     ; if the units value is equal to 00 jump to the DECREMENT_TENS label
dec cl                ; else decrement the units value by 01
jmp OUTPUT_UNITS      ; and jump to the OUTPUT_UNITS label

INCREMENT_TENS:       ; INCREMENT_TENS
inc dl                ; increment dl by 01
mov cl, 00            ; reset the value of cl to 00
jmp OUTPUT_TENS       ; jump to OUTPUT_TENS label

DECREMENT_TENS:       ; DECREMENT_TENS
dec dl                ; decrement dl by 01
mov cl, 09            ; set the value of cl to 09
jmp OUTPUT_TENS       ; jump to OUTPUT_TENS label

OUTPUT_TENS:          ; OUTPUT_TENS
push dl               ; move the value of the tens in the dl register into the al register
pop al
add al, bl            ; add the base address to get the address of the display code
mov al, [al]          ; display code moved into the al register
sub al, 01            ; subtract 01 to display to the left side of the 7 segment display

                      ; CHECK TO SEE NOT GOING OUT OF BOUNDS (0-99)
mul dl, 0a            ; by multiplying dl by 10
add dl, cl            ; then adding the tens and the units together
cmp dl, ff            ; comparing the value with the hex for -1
jz ZERO               ; jumping to the ZERO label if true
cmp dl, 64            ; comparing the value with the hex for 100
jz HUNDRED            ; jumping to the HUNDRED label if true
                      ; ELSE RETURN THE VALUES TO THEIR ORIGINALS
sub dl, cl            ; subtracting the units from the tens
div dl, 0a            ; and dividing the tens by 10
out 02                ; the tens value to the display
jmp OUTPUT_UNITS      ; and jump back to OUTPUT_UNITS label

HUNDRED:              ; HUNDRED (prevent number going over 100)
mov cl, 09            
mov dl, 09
jmp OUTPUT_UNITS      ; jump back to OUTPUT_UNITS label

ZERO:                 ; ZERO prevent number going below zero
mov cl, 00            
mov dl, 00            
jmp OUTPUT_UNITS      ; jump back to OUTPUT_UNITS label

                      ; start the data table from address A0
org a0
DB fb ; Hex value needed to display 0 in 7-seg display
DB 0b ; Hex value needed to display 1 in 7-seg display
DB b7 ; Hex value needed to display 2 in 7-seg display
DB 9f ; Hex value needed to display 3 in 7-seg display
DB 4f ; Hex value needed to display 4 in 7-seg display
DB dd ; Hex value needed to display 5 in 7-seg display
DB 7d ; Hex value needed to display 6 in 7-seg display
DB 8b ; Hex value needed to display 7 in 7-seg display
DB ff ; Hex value needed to display 8 in 7-seg display
DB cf ; Hex value needed to display 9 in 7-seg display

end                   ; END THE PROGRAM

