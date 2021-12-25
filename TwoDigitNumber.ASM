start:
call 80         ; call the subroutine at memory address 80 for the first number
push al         ; push the first two digit value to the stack
pop cl          ; place the two digit value in the cl register
call 80         ; call the subroutine again for the second number
push al         ; push the second two digit value to the stack
pop dl          ; place the two digit value in the dl register

in 00           ; get a operator +, - , / , * and place in the al register
cmp al, 2b      ; compare the value in al to '+'
jz addition     ; jump to addition label is the zero flag is set

cmp al, 2d      ; compare the value in al to '-'
jz subtraction  ; jump to subtraction label is the zero flag is set

cmp al, 2f      ; compare the value in al to '/'
jz division     ; jump to division label is the zero flag is set

cmp al, 2a      ; compare the value in al to '*'
jz multiplication ; jump to multiplication label is the zero flag is set

addition:
add cl, dl      ; add value in cl to dl
jmp print       

subtraction:
sub cl, dl      ; subtract dl from cl
jmp print

division:
div cl, dl      ; divide the value in cl by dl
jmp print

multiplication:
mul cl, dl      ; multiply cl by dl
jmp print

print:
push cl         ; push the final result to the stack
pop al          ; place the final result in the al register
call a0         ; call the subroutine at memory address a0 to print the num to the VDU
jmp start

org 80          ; SUBROUTINE: TO BUILD A TWO DIGIT POSITIVE INTEGER USING THE KEYBOARD
in 00           ; get first character from the keyboard and place in the al register
sub al, 30      ; convert the first character into an integer
mul al, 0a      ; first integer * 10
push al         ; push the (first integer * 10) value onto the stack
pop bl          ; pop the integer value into the bl register
in 00           ; get second character from the keyboard and place in the al register
sub al, 30      ; convert the second character into an integer
add al, bl      ; add the value in bl to al
ret             ; RETURN: two digit positive integer is in the al register

org a0          ; SUBROUTINE: TO PRINT A TWO DIGIT INTEGER TO THE VDU
push al         ; push the value of the two digit positive integer to the stack
div al, 0a      ; get the value of the first character by dividing by 10
add al, 30      ; convert integer into ASCII
mov [c0], al    ; print the first character to the VDU
pop al          ; place the original value of the two digit integer into the al register
mod al, 0a      ; get the value of the second character with modulo 10
add al, 30      ; convert integer into ASCII
mov [c1], al    ; print the second character to the VDU
ret             ; the characters entered on the keyboard are now printed to the VDU

end             ; end the program

 