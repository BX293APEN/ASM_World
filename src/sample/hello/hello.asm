GLOBAL          _start                                                          ; グローバルシンボルをGLOBALで宣言し、リンカに伝える

SECTION         .data
                NEWLINE         DB                  0x0A

SECTION         .bss
                STRBUF          RESB                256
                STRLEN          RESQ                1                           ; 現在の長さを保持

SECTION         .text

PRINT:
                MOV             RAX,                1                           ; SYS_WRITE
                MOV             RDI,                1                           ; STDOUT
;               MOV             RSI,                BUF                         ; バッファ
;               MOV             RDX,                LEN                         ; 長さ
                SYSCALL
                RET

CHARSTORE:  
                MOV             [RDI],              AL
                INC             RDI

                                                                                ; STRLEN = RDI - STRBUF
                MOV             RCX,                RDI
                SUB             RCX,                STRBUF
                MOV             [STRLEN],           RCX
                RET

_start:
                LEA             RDI,                [STRBUF]                    ; 書き込み開始位置

                MOV             AL,                 'H'
                CALL            CHARSTORE

                MOV             AL,                 'e'
                CALL            CHARSTORE

                MOV             AL,                 'l'
                CALL            CHARSTORE

                MOV             AL,                 'l'
                CALL            CHARSTORE

                MOV             AL,                 'o'
                CALL            CHARSTORE
                
                MOV             AL,                 ' '
                CALL            CHARSTORE

                MOV             AL,                 'W'
                CALL            CHARSTORE

                MOV             AL,                 'o'
                CALL            CHARSTORE

                MOV             AL,                 'r'
                CALL            CHARSTORE

                MOV             AL,                 'l'
                CALL            CHARSTORE

                MOV             AL,                 'd'
                CALL            CHARSTORE

                LEA             RSI,                [STRBUF]
                MOV             RDX,                [STRLEN]
                CALL            PRINT


; 改行  
                MOV             RSI,                NEWLINE
                MOV             RDX,                1
                CALL            PRINT

; 終了
                MOV             RAX,                60
                XOR             RDI,                RDI
                SYSCALL
