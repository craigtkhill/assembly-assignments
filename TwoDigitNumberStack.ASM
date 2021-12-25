call 70        ; call the subroutine (a) for the first number
call 70        ; call the subroutine (a) again for the second number
pop al         ; place one of the two digit integers into the al register
pop bl         ; place the other integer into the bl register
add al, bl     ; add the integers together
push al        ; push the resulting integer to the stack
call 90        ; call the subroutine to print the number to the VDU

;_________________SUBROUTINES___________________________________________________________

org 70          ; (a) READ TWO DIGIT NUMBER FROM KEYBOARD PUSHING NUMBER TO STACK 
pop cl          ; place the return address in the cl register
in 00           ; get first character from the keyboard and place in the al register
sub al, 30      ; convert the first character into an integer
mul al, 0a      ; multiply the first integer * 10
push al         ; push the first integer to the stack
pop bl          ; place the first integer into the bl register
in 00           ; get second character from the keyboard and place in the al register
sub al, 30      ; convert the second character into an integer
add al, bl      ; add the two integers together
push al         ; push the resulting two digit integer to the stack
push cl         ; push the return address held in the cl register to the stack
ret             ; RETURN: two digit integer is in the stack

org 90          ; (b)PRINT TWO DIGIT NUMBER TO THE VDU TAKING INPUT FROM STACK
pop cl          ; place the return address in the cl register
pop al          ; place the two digit integer in the al register
push al         ; copy the integer in the al register to the bl register
pop bl          ;
div al, 0a      ; get the the first character by dividing by 10
add al, 30      ; convert integer into ASCII
mov [c0], al    ; print the first character to the VDU
mod bl, 0a      ; get the the second character using modulo 10
add bl, 30      ; convert integer into ASCII
mov [c1], bl    ; print the second character to the VDU
push cl         ; push the return address held in the cl register to the stack
ret             ; the characters entered on the keyboard are now printed to the VDU

end             ; end the program

 