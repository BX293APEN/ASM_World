; ニーモニック・レジスタ名は大文字小文字を区別しない

section .data
    hexchars db '0123456789ABCDEF'
    newline db 0x0A

section .bss
    hexbuf resb 16

section .text
global _start

print:

    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
;   mov rsi, buf    ; バッファ
;   mov rdx, len    ; 長さ

    syscall

    ret

hexstr:
    ; 入力:  RAX = 値
    ; 出力:  RDI = hexbuf
    ; 破壊:  RBX, RCX, RDX

    push rbx
    mov rbx, rax
    mov rcx, 16
    lea rdi, [hexbuf]

.loop:
    dec rcx
    mov rdx, rbx
    and rdx, 0xF
    mov dl, [hexchars + rdx]
    mov [rdi + rcx], dl
    shr rbx, 4
    test rcx, rcx
    jnz .loop

    pop rbx
    ret

printhex:
    ; 入力: RAX = 表示したい値

    call hexstr

    ; hexbufを表示
    mov rsi, rdi    ; hexstrが返したアドレス
    mov rdx, 16
    call print

    ret

_start:
    mov rax, 0x1234ABCD5678EF00 ; 表示したい値
    call printhex

    ; 改行
    mov rsi, newline
    mov rdx, 1
    call print

    ; exit(0)
    mov rax, 60
    xor rdi, rdi
    syscall

