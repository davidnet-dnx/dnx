; Stage 2 Bootloader (stage2.asm)
org 0x1000         ; Stage 2 bootloader starts at 0x1000

bits 16            ; 16-bit real mode code

start:
    mov ah, 0x0E        ; BIOS teletype output function

    mov al, 0x0D       ; \r  Return to left
    int 0x10
    mov al, 0x0A       ; \n  Newline
    int 0x10

    ; Print "OK" to the screen
    mov ah, 0x0E        ; BIOS teletype output function
    mov al, 'O'         ; Load character 'O' into AL
    int 0x10            ; Call BIOS interrupt to print 'O'
    
    mov al, 'K'         ; Load character 'K' into AL
    int 0x10            ; Call BIOS interrupt to print 'K'

    ; Infinite loop (hang)
    jmp $

; Fill the remaining space to the next 512-byte boundary (optional)
times 512 - ($ - $$) db 0
