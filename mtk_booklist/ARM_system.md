## ARM System Developer's Guide ##

**Harvard architecture vs. von Neumann architecture**  
> ARM9 開始使用哈佛架構
* von Neumann architecture
  * 中央處理器和儲存裝置是分開
  * 中央處理器到儲存裝置中讀取一段程式碼執行
  * 不同程式碼可以造成不同的執行結果
* Harvard architecture
  * 為馮‧紐曼架構的延伸
  * 程式和資料是由兩個獨立的空間儲存，同時也有兩個記憶體控制單元分別操作
  * 指令和資料的記憶體操作能夠同時進行

**RISC**  
> *prons:*  
> 1. 指令長度固定，方便CPU解碼，簡化解碼器設計。
> 2. 盡量在CPU的暫存器裡操作，避免額外的讀取與載入時間。
> 3. 由於指令長度固定，更能受益於執行 pipeline 後所帶來的效能提升。
> 4. 處理器簡化，電晶體數量少，易於提升運作時脈。耗電量較低。


* **Thumb**  
  * Thumb
    * ARM 有兩套指令集，  
    * 一套是 ARM，  
    * 另一套是 Thumb。  

    * **Thumb 的目地是要增加 code 的密度，**  
    * Thumb instruction set 實作的是 ARM instruction set 的子集，  
    * 指令用了 16 bits，  
    * 藉由限制一些能力來換取空間。  

    * (本來可以放 32 條 32 bits 的 ARM 指令換成放 Thumb 就可以放 64 條)  

    * Thumb 沒有 coprocessor 指令、Semaphore 指令、CPSR 和 SPSR 相關的指令、乘加指令、64 位元乘法指令，  
    * 指令的第二個 operand 受到限制，  
    * 只有 branch 指令可以跳 address，  
    * 採用的是 relative jump，  
    * 可以跳到的範圍有限制。  

    * Thumb 和 ARM 在組語上是相同的，  
    * 但是 compile 後會產生出不同的資料，  
    * 所以「Thumb 是一套 16 bits 的指令集，為 ARM 指令集的子集，可以在 32 bits 的 ARM 指令集找到對應」，  
    * Thumb mode 和 ARM mode 兩個不能同時運作，  
    * 選好後處理器就會依照指定的模式運作，  
    * 如果是 Thumb mode 的話會進行解壓縮，  
    * 轉換成 ARM 指令來執行。


  * Thumb2
    * Thumb2 在原本單純的 16 bits Thumb 指令集加入了一些 32 bits 的指令，
    * 也加入了 IT (If Then) 指令 (對於 ARM 指令集來說，IT 指令不會產生任何 code)。

=> `Cortex-M3` only support Thumb2

-----

**Register table**
> in `Cortex-M3`

* R0-R12 (general-purpose registers)
  * 絕大多數 16bit Thumb 只能使用 R0-R7
  * 32bit 的 Thumb 則可以使用所有 register
* R13 Stack Pointer(SP)
  * 有 MSP 和 PSP 兩種， 但是是 banked register
    * MSP: 用於操作 kernel 和處理 exception, interrupt
    * PSP: 於 user mode 下的 program 使用
* R14 Link Register(lr)
  * 當 call function 時， 由 R14 储存 return address
    * 為了減少 access ram 的次數（time cost太高）， 如果有很多層 call func 則將 R14 存入 stack 中
* R15 Program Counter(PC)
  * 存放處理器要存取的下一道指令位址
  * 在 ARM 中 PC 是儲存下 2 個指令的位址
  * 可以藉由修改 PC 的值技巧性的控制流程

-----

**Banked Register**  
不同的視角（mode）會看到不同組的 register -> 這樣切換 mode 會比較有效率  
e.g.  
由 user mode 切換到 FIQ mode 時， 
* user mode 的狀態會以 stack 的形式存起來（R0-R7）
* (R8-R14) 則不需要， 因為對 FIQ mode 來說那些是獨立的 register  

-----

**NVIC (Nested Vectored Interrupt Controller)**  
* 每個ISR都可以獨立做啟動與關閉
* 允許巢狀中斷，也就是中斷時，還可以被中斷
* 當例外發生時，NVIC會比較例外的優先權
  * 如果後來發生的exception優先權比較高，那就插隊先執行 -> preemption
* 可以做中斷遮罩，也就是停用某些中斷
  * PRIMASK: 可以停用所有的exception(除了最嚴重的HardFault和NMI不可以停用)
    * 關鍵任務不可以被打斷
  * BASEPRI: 停用某個優先權以下的例外

> 負責處理Interrupt Request(IRQs)和Non-Maskable Interrupt(NVI) Request
* IRQ
  * 通常是週邊或外部輸入產生的
* NMI
  * watchdog timer: 一定時間處理器沒有回應時會主動打斷處理器
  * brownout detector: 處理器電壓偵測，當處理器的電壓低於某個水平時會發出警告
  * SysTick: 處理器內部的timer，會週期性的對處理器發出中斷
> exception number 越小優先權越高  

> An implementation-defined number of interrupts, in the range 1-240 interrupts
* 通常不會使用所有 interrupt -> 較省電
  * e.g. STM32F429 中只使用了 91 個 interrupt

[info link](http://enginechang.logdown.com/posts/248297-talking-about-the-priority-from-the-arm-set-cortex-m-to-freertos)  

-----

