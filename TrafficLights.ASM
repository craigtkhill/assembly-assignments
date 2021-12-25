in 00 ; get input from the keyboard and place in the al register
sub al, 30 ; convert the keyboard value into an integer
mov [30], al ; move the integer value into the memory address 30 
mov bl, [30] ; move the value in memory address 30 into the bl register

start:
mov al, ff ; turn all the colours on at the same time, (Code is FF)
out 01 

mov al, 27 ; turn on both green coloured lights only, (Code is 27)
out 01 

mov al, 90 ; turn on both red coloured lights only, (Code is 90)
out 01

dec bl ; subtract 1 from the bl register
cmp bl, 0 ; compare the bl register to zero
jnz start ; if bl != zero jump back to the start

end ; else end the program

 