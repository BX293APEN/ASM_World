GLOBAL          _start

SECTION         .data
    NEWLINE     DB          0x0A

SECTION         .bss
    STRBUF      RESB        256
    STRLEN      RESQ        1

SECTION         .text
PRINT:
    MOV         RAX,        1
    MOV         RDI,        1
    SYSCALL
    RET
CHARSTORE:
    MOV         [RDI],      AL
    INC         RDI
    MOV         RCX,        RDI
    SUB         RCX,        STRBUF
    MOV         [STRLEN],   RCX
    RET

_start:
    LEA         RDI,        [STRBUF]
    MOV         AL,         'H'
    CALL        CHARSTORE
    MOV         AL,         'e'
    CALL        CHARSTORE
    MOV         AL,         'l'
    CALL        CHARSTORE
    MOV         AL,         'l'
    CALL        CHARSTORE
    MOV         AL,         'o'
    CALL        CHARSTORE
    MOV         AL,         ' '
    CALL        CHARSTORE
    MOV         AL,         'W'
    CALL        CHARSTORE
    MOV         AL,         'o'
    CALL        CHARSTORE
    MOV         AL,         'r'
    CALL        CHARSTORE
    MOV         AL,         'l'
    CALL        CHARSTORE
    MOV         AL,         'd'
    CALL        CHARSTORE
    LEA         RSI,        [STRBUF]
    MOV         RDX,        [STRLEN]
    CALL        PRINT
    MOV         RSI,        NEWLINE
    MOV         RDX,        1
    CALL        PRINT
    MOV         RAX,        60
    XOR         RDI,        RDI
    SYSCALL
