## [Programming C (pointer)](https://embedded2015.hackpad.com/ep/pad/static/s0rlzR8wVtm) ##

pointer is a bridge between memory and object

#### [incomplete declaration (forward declaration)](http://www.umich.edu/~eecs381/handouts/IncompleteDeclarations.pdf) ####

> It tells the compiler that the named class or struct type exists, but doesn't 
say anything at all about the member functions or variables of the class or struct.  
*To hide information of implementation*

> And will be supplied with the complete declaration later in the compilation,  

> so it won't be able to compile code that refers to the members of the class or 
struct, or requires knowing the size of a class or struct object.  
  
For example,  
```c
/* in header file */

// we can define a struct (e.g. GraphicsObject) without detail information
struct GraphicsObject;

// legal, because (struct GraphicsObject *) doesn't require to know size of (struct GraphicsObject)
// only need to know size of pointer, but in same platform pointer have same size
struct GraphicsObject *initGraphics(int width, int height);

// illegal, in this sentance actually create an instance
struct GraphicsObject obj;
```
-> hide infomation of implement.


```c 
int a[] // is an incomplete type
// is incomplete array exist?
``` 

*Use an incomplete declaration in a header file whenever possible.*
> It can eliminate the need to `#include` the header file for the class or struct, 
which reduces the coupling, or dependencies

-----

#### declarator type derivation ####


> **[Practice 0]**  


-----


#### object ####
* region of data storage in the execution environment, the contents of which can 
represent values  
* a continue data can be considered as *array* or *pointer* or *function*  

`ptr = ptr + 1(unit)` **unit** equals size of object which pointer point to.  

`sizeof()` is a operator not a function  

-----

#### [Lvalue vs Rvalue](http://eli.thegreenplace.net/2011/12/15/understanding-lvalues-and-rvalues-in-c-and-c) ####

* every expression is either an lvalue or an rvalue.
  * A *lvalue* (locator value) represents an object that occupies some identifiable 
location in memory (i.e. has an address).
    * 可改就必定可寫, 對 0x67a9 強制轉型(可改), 所以可以 assign rvalue(可寫)
  * A *rvalues* are defined by exclusion.

```c
*(int32_t * const) (0x67a9) = 0xaa6;
```

-----

#### Pointers vs. Arrays ####

* array subscripting 在**編譯時期**只能作以下兩件事:
  * 得知 size
  * Obtain a pointer to element 0
* 前兩者以外的操作，都透過 pointer
  * array subscripting => syntax sugar
    * array subscripting: 提供操作多維陣列的機制， 但實際上只有一維陣列的資料存取

* in declaration
  * extern, 如 `extern char x[];` => 不能變更為 pointer 的形式
  * definition/statement, 如 `char x[10]` => 不能變更為 pointer 的形式
  * parameter of function, 如 `func(char x[])` => 可變更為 pointer 的形式 => `func(char *x)`
* in expression
  * array 與 pointer 可互換

-----

#### Pointer to void ####
> A *pointer to void* shall have the same representation and alignment requirements 
as a *pointer to a character* type.

* `* void` , `* char` 彼此可互換的表示法
* `* void` 的寬度取決於機器 （e.g. 64位元 -> pointer 的寬度為 64 bit
* `* void` 沒有 data storge -> 不是 object
* C89 前沒有 void, 如果沒有指定 return type 都會 return int(伴隨著 `0` 作為返回值)
  * 但是對於 compiler 來說檢查型態是很重要的問題
    * `void` 的存在讓語法分析器可以正確的運作
  * `void *` 的設計，導致開發者必須透過 explict (顯式) 或強制轉型，才能存取最終
的 object，否則就會丟出編譯器的錯誤訊息，從而避免危險的指標操作
    * 無法直接對 `void *` 做數值操作(compiler 不知道確切的大小)
    * 在 ARM 上需要額外的 alignment 指定大小
      * e.g. `uint32_t` `uint16_t` `uint8_t`


**const 的用途**  

|          語法          |意義                              |
|------------------------|----------------------------------|
| `const int a;`         | 常整數                           |
| `int const a;`         | 常整數                           |
| `const int * a;`       | pointer 可修改; pointee 不可修改 |
| `int const * a;`       | pointer 不可修改; pointee 可修改 |
| `int const * a const;` | pointer & pointee 都不可修改     |



