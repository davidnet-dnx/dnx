org 0x7C00
bits 16

start:
    mov ah, 0x0E        ; BIOS teletype output function
    
    mov al, 'D'
    int 0x10
    mov al, 'N'
    int 0x10
    mov al, 'X'
    int 0x10

    ; Set up the segment registers (initialize DS and ES)
    xor ax, ax          ; Clear AX register
    mov ds, ax          ; Set DS to 0 (segment for data)
    mov es, ax          ; Set ES to 0 (segment for extra data)

    ; Read Stage 2 Bootloader into memory (address 0x1000)
    mov ah, 0x02        ; BIOS read sector function
    mov al, 1           ; Read 1 sector
    mov ch, 0           ; Cylinder (for LBA, this is 0)
    mov cl, 2           ; Sector 2 (LBA 1, sector numbers are 1-based)
    mov dh, 0           ; Head
    mov dl, 0x80        ; Disk number (0x80 for first hard disk)
    mov bx, 0x1000      ; Load to memory address 0x1000
    int 0x13            ; BIOS interrupt (read disk sector)

    ; Check if there was an error in reading the disk
    jc read_error       ; Jump to error handling if carry flag is set

    ; Jump to the Stage 2 Bootloader code (located at 0x1000)
    jmp 0x1000          ; Jump to the Stage 2 Bootloader

read_error:
    mov al, 'S'
    int 0x10
    mov al, '2'
    int 0x10
    mov al, '-'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'r'
    int 0x10
    jmp hlt

hlt:
    hlt
    jmp hlt
    
; Fill the remaining space to 510 bytes with 0s (boot sector requirement)
times 510 - ($ - $$) db 0

; Boot sector signature (0xAA55)
dw 0xAA55
