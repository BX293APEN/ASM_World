; ニーモニック・レジスタ名は大文字小文字を区別しない
GLOBAL          _start                                                          ; グローバルシンボルをGLOBALで宣言し、リンカに伝える

SECTION         .data
                HEXCHARS        DB                  '0123456789ABCDEF'
                NEWLINE         DB                  0x0A

SECTION         .bss
                HEXBUF          RESB                16
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

HEXSTR: 
                                                                                ; 入力:  RAX = 値
                                                                                ; 出力:  RDI = HEXBUF
                                                                                ; 破壊:  RBX, RCX, RDX

                PUSH            RBX
                MOV             RBX,                RAX
                MOV             RCX,                16
                LEA             RDI,                [HEXBUF]

.LOOP:  
                DEC             RCX
                MOV             RDX,                RBX
                AND             RDX,                0xF
                MOV             DL,                 [HEXCHARS + RDX]
                MOV             [RDI + RCX],        DL
                SHR             RBX,                4
                TEST            RCX,                RCX
                JNZ             .LOOP

                POP             RBX
                RET


; 入力: RAX = 表示したい値
PRINTHEX:
                CALL            HEXSTR

                                                                                ; HEXBUFを表示
                MOV             RSI,                RDI                         ; HEXSTRが返したアドレス
                MOV             RDX,                16
                CALL            PRINT

                RET

; エントリーポイント(main関数) デフォルト : _start
; エントリーポイントの名前変更は ld コマンドの-e オプションで行う
_start:
;               MOV             RAX,                0x1234ABCD5678EF00          ; 表示したい値
;               CALL            PRINTHEX


; 改行
;               MOV             RSI,                NEWLINE
;               MOV             RDX,                1
;               CALL            PRINT

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

