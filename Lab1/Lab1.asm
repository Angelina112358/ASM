.model small
.stack 256

.data

a db 1
b db 2
c db 3
d db 5


.code
    main:
        mov ax, @data
        mov ds, ax
        
        mov al, a
        mov ah, b
        cmp al, ah
        jge if1
        mov al, c
        mov ah, d
        cmp al, ah
        jge if1
        jl print1
    if1: 
        mov al, b
        sub al, c
        mov ah, a
        add ah, d 
        cmp al, ah
        jg print2
        mov al, c
        mov ah, d
        cmp al, ah
        jne print2
        jmp print3
    print1:
        mov al, b
        mov ah, c
        add ah, d
        imul ah 
        mov cx, ax
        mov al, a
        cbw 
        sub ax, cx
        jmp print
    print2:
        mov al, d
        mov ah, a
        not ah
        add ah, 1
        imul ah
        mov cx, ax
        mov al, b
        add al, c
        cbw 
        add cx, ax
        mov ax, cx  
        jmp print
    print3:    
        mov al, a
        add al, b
        cbw
        mov bx, ax
        mov al, c
        add al, d
        cbw 
        mov cx, ax 
        add bx, cx
        sub bx, 3
        mov ax, bx
        jmp print
    
    print:
        cmp ax, 0
        jz zero
        jnl positive
        mov dl, '-'
        push ax
        mov ah, 02h
        int 21h
        pop ax
        not ax 
        inc ax

    positive:
        cmp ax, 0
        jz zeroo
        mov dx, 0
        mov bx, 10
        div bx    
        add dl, 48
        push dx   
        call positive
        pop dx
        push ax
        mov ah, 02h
        int 21h
        pop ax
        ret

    zeroo:
        ret

    zero:
        mov dl, 30h
        mov ah, 02h
        int 21h
        ret
    exit:
        mov ax, 4c00h
        mov al, 0
        int 21h
    end     main