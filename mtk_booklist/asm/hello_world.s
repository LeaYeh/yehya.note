.section .data
# 已經初始化的資料(有初始值的變數)

# The directive isn't an ARM instruction, but a instruction to assembler
some_string:
.ascii "put this string data into a block in memory"

.section .bss
# 未初始化的資料

.section .text
# 標註為程式碼區塊

.globl _start
# 指名 _start 為程式的進入點
# linking 時會自動找到這個標籤作為進入點

_start:
# 程式碼由此開始



## How to compile?
# $ as xxx.s -o xxx.o
# $ ld xxx.o -o xxx


## Others
# 立即定址( immediate operands) 使用 $ 符號作為前綴
# 暫存器名稱一律使用 % 作為前綴
