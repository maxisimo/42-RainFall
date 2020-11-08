# Alignment

For this exemple, take the level1 assembly program of the main function :
```
Dump of assembler code for function main:
   0x08048480 <+0>:     push   ebp
   0x08048481 <+1>:     mov    ebp,esp
   0x08048483 <+3>:     and    esp,0xfffffff0
   0x08048486 <+6>:     sub    esp,0x50
   0x08048489 <+9>:     lea    eax,[esp+0x10]
   0x0804848d <+13>:    mov    DWORD PTR [esp],eax
   0x08048490 <+16>:    call   0x8048340 <gets@plt>
   0x08048495 <+21>:    leave
   0x08048496 <+22>:    ret
End of assembler dump.
```
For one of the lines we can see :  
`   0x08048483 <+3>:     and    esp,0xfffffff0`  
This line aligning the stack with the next lowest 16-byte boundary for SIMD instructions.  
Assume the stack looks like this on entry to _main :  
```
                |    existing     |
                |  stack content  |
       ESP  =>  +-----------------+
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
                |    existing     |
                |  stack content  |
                +-----------------+
		:     OLD_EBP     :
  EBP & ESP =>  +-----------------+
```
<+3> : Stack align on 16 bytes. In this particular example, it has the effect of reserving an additional 12 bytes.
```
                |    existing     |
                |  stack content  |
                +-----------------+
		:     OLD_EBP     :
       EBP  =>  +-----------------+
	        :                 :
	        :   extra space   :
	        :                 :
       ESP  =>  +-----------------+
```
The point of this is that there are some "SIMD" (Single Instruction, Multiple Data) instructions (also known in x86-land as "SSE" for "Streaming SIMD Extensions") which can perform parallel operations on multiple words in memory, but require those multiple words to be a block starting at an address which is a multiple of 16 bytes.  
In general, the compiler can't assume that particular offsets from `esp` will result in a suitable address (because the state of `esp` on entry to the function depends on the calling code). But, by deliberately aligning the stack pointer in this way, the compiler knows that adding any multiple of 16 bytes to the stack pointer will result in a 16-byte aligned address, which is safe for use with these SIMD instructions.  
In this exemple there are no SIMD instructions, so the alignment is useless.  
*List of SSE instructions* : [SSE Instructions](https://docs.oracle.com/cd/E26502_01/html/E28388/eojde.html)
