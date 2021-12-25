mov BL, 5A ; move the value 'Z' into the BL register

resetVDU:
   mov AL, C0 ; move address to the start of VDU
   cmp BL, 5A ; Compare value in BL to 'Z'
   jnz loop ; If value != 'Z' skip the next line
   mov AL, E9 ; move starting address into the AL register 

loop:
   mov [AL], BL ; move the alpha char into memory
   dec BL ; decrement the alpha char .ie 'Z' » 'Y'
   inc AL ; increment the address location .ie D3 » D4
   jz resetVDU ; jump back to original starting address if memory about to be overwritten
   cmp BL, 40 ; check to see if the alpha char 'A' has been reached
   jnz loop ; jump back if the 'A' condition has not been meet

end