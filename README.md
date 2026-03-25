# x86-64 アセンブリ言語のサンプルコード

## 必要なパッケージのインストール
```bash
sudo apt install nasm binutils gcc
```

## 実行方法
```bash
nasm -f elf64 main.asm
ld main.o -o main.exe
# gcc main.o -o main.exe
./main.exe
```

## レジスタの役割

| レジスタ | 役割イメージ     |
| ---- | ---------- |
| rax  | 計算の中心（戻り値） |
| rbx  | 保存用        |
| rcx  | カウンタ（ループ）  |
| rdx  | 補助計算       |
| rsi  | データ元       |
| rdi  | データ先       |
| rbp  | スタック基準     |
| rsp  | スタックトップ    |
