use16
org 0x7C00

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov ax, 0x0013
    int 0x10

    mov ax, 0xA000
    mov es, ax

    xor di, di
    mov cx, 320*200
    mov al, 14
    rep stosb

    mov cx, 40
    xor bx, bx

draw_triangle:
    mov di, bx
    shl di, 8
    mov dx, bx
    shl dx, 6
    add di, dx
    mov si, bx

draw_line:
    mov byte [es:di], 4
    inc di
    dec si
    jns draw_line

    inc bx
    loop draw_triangle

    mov si, text
    mov ah, 0x0E
    mov al, 0

    mov bh, 0
    mov bl, 4

    mov dh, 23
    mov dl, 15
    mov ah, 2
    int 10h

print_text:
    lodsb
    or al, al
    jz $

    mov ah, 0x0E
    int 10h
    jmp print_text

text db 'Materenko S.V. NMT-333901', 0

times 510-($-$$) db 0
dw 0xAA55