## ARM System Developer's Guide ##

**RISC**  
> *prons:*  
> 1. 指令長度固定，方便CPU解碼，簡化解碼器設計。
> 2. 盡量在CPU的暫存器裡操作，避免額外的讀取與載入時間。
> 3. 由於指令長度固定，更能受益於執行 pipeline 後所帶來的效能提升。
> 4. 處理器簡化，電晶體數量少，易於提升運作時脈。耗電量較低。


Thumb
========================================

Thumb
------------------------------

ARM 有兩套指令集，  
一套是 ARM，  
另一套是 Thumb。  

**Thumb 的目地是要增加 code 的密度，**  
Thumb instruction set 實作的是 ARM instruction set 的子集，  
指令用了 16 bits，  
藉由限制一些能力來換取空間。  

(本來可以放 32 條 32 bits 的 ARM 指令換成放 Thumb 就可以放 64 條)  

Thumb 沒有 coprocessor 指令、Semaphore 指令、CPSR 和 SPSR 相關的指令、乘加指令、64 位元乘法指令，  
指令的第二個 operand 受到限制，  
只有 branch 指令可以跳 address，  
採用的是 relative jump，  
可以跳到的範圍有限制。  

Thumb 和 ARM 在組語上是相同的，  
但是 compile 後會產生初步同的資料，  
所以「Thumb 是一套 16 bits 的指令集，為 ARM 指令集的子集，可以在 32 bits 的 ARM 指令集找到對應」，  
Thumb mode 和 ARM mode 兩個不能同時運作，  
選好後處理器就會依照指定的模式運作，  
如果是 Thumb mode 的話會進行解壓縮，  
轉換成 ARM 指令來執行。


Thumb2
------------------------------

Thumb2 在原本單純的 16 bits Thumb 指令集加入了一些 32 bits 的指令，
也加入了 IT (If Then) 指令 (對於 ARM 指令集來說，IT 指令不會產生任何 code)。
