# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x080482f8  _init
0x08048340  gets@plt
0x08048350  fwrite@plt
0x08048360  system@plt
0x08048370  __gmon_start__@plt
0x08048380  __libc_start_main@plt
0x08048390  _start
0x080483c0  __do_global_dtors_aux
0x08048420  frame_dummy
0x08048444  run
0x08048480  main
0x080484a0  __libc_csu_init
0x08048510  __libc_csu_fini
0x08048512  __i686.get_pc_thunk.bx
0x08048520  __do_global_ctors_aux
0x0804854c  _fini
```

# Main
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
## Explanations
```
   0x08048480 <+0>:     push   ebp
   0x08048481 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x08048483 <+3>:     and    esp,0xfffffff0
   0x08048486 <+6>:     sub    esp,0x50
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : 80 bytes are allocated to the main function for its local variables.
```
   0x08048489 <+9>:     lea    eax,[esp+0x10]
   0x0804848d <+13>:    mov    DWORD PTR [esp],eax
   0x08048490 <+16>:    call   0x8048340 <gets@plt>
```
<+9> : Load the effective address `esp+0x10` in `eax`, so `eax` is now pointing on `esp+0x10` (perfect, gets() function need a pointer as argument).  
<+13> : Set argument for `gets()` function.  
<+16> : Call to `gets()` function with value at address `esp` as argument (gets(`eax`)).  
```
   0x08048495 <+21>:    leave
   0x08048496 <+22>:    ret
```
<+21> - <+22> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.  
Before `leave` and `ret` instructions, the stack should look like :
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+
                :                 :
                :   extra space   :
                :   (alignment)   :
                :                 :
                +-----------------+    ----+
                :                 :        |
                :                 :        |
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |  80 bytes allocated
                :                 :        |
                :                 :        |
                :                 :        |
  ESP+0x4 =>    +-----------------+        |
                :    [esp+0x10]   :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```

# Run
```
Dump of assembler code for function run:
   0x08048444 <+0>:     push   ebp
   0x08048445 <+1>:     mov    ebp,esp
   0x08048447 <+3>:     sub    esp,0x18
   0x0804844a <+6>:     mov    eax,ds:0x80497c0
   0x0804844f <+11>:    mov    edx,eax
   0x08048451 <+13>:    mov    eax,0x8048570
   0x08048456 <+18>:    mov    DWORD PTR [esp+0xc],edx
   0x0804845a <+22>:    mov    DWORD PTR [esp+0x8],0x13
   0x08048462 <+30>:    mov    DWORD PTR [esp+0x4],0x1
   0x0804846a <+38>:    mov    DWORD PTR [esp],eax
   0x0804846d <+41>:    call   0x8048350 <fwrite@plt>
   0x08048472 <+46>:    mov    DWORD PTR [esp],0x8048584
   0x08048479 <+53>:    call   0x8048360 <system@plt>
   0x0804847e <+58>:    leave
   0x0804847f <+59>:    ret
End of assembler dump.
```
## Explanations
```
   0x08048444 <+0>:     push   ebp
   0x08048445 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x08048447 <+3>:     sub    esp,0x18
```
<+3> : 24 bytes are allocated to the main function for its local variables.
```
   0x0804844a <+6>:     mov    eax,ds:0x80497c0
   0x0804844f <+11>:    mov    edx,eax
   0x08048451 <+13>:    mov    eax,0x8048570
   0x08048456 <+18>:    mov    DWORD PTR [esp+0xc],edx
   0x0804845a <+22>:    mov    DWORD PTR [esp+0x8],0x13
   0x08048462 <+30>:    mov    DWORD PTR [esp+0x4],0x1
   0x0804846a <+38>:    mov    DWORD PTR [esp],eax
   0x0804846d <+41>:    call   0x8048350 <fwrite@plt>
```
<+6> : 'ds:[0x80497c0]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x80497c0]' to register `eax` (eax = stdout).  
<+11> : Save the value of `eax` in `edx`.  
<+13> : Then store the value at `0x8048570` in `eax` (eax = "Good... Wait what?\n").  
<+18> - <+38> : Set arguments for `fwrite()` function.  
<+41> : Call to `fwrite()` function with values at addresses from `esp` to `esp+12` as arguments (fwrite(`esp`, `esp+4`, `esp+8`, `esp+12`)).
```
   0x08048472 <+46>:    mov    DWORD PTR [esp],0x8048584
   0x08048479 <+53>:    call   0x8048360 <system@plt>
```
<+46> : Set argument for `system()` function.  
<+53> : Call to `system()` function with value at address `esp` as argument (system("/bin/sh")).  
```
   0x0804847e <+58>:    leave
   0x0804847f <+59>:    ret
```
<+58> - <+59> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.  
Before `leave` and `ret` instructions, the stack should look like :
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :       uni*      :        |
                :                 :        |
                +-----------------+        |
                :      stdout     :        |
  ESP+0xc =>    +-----------------+        |  24 bytes allocated
                :        19       :        |
  ESP+0x8 =>    +-----------------+        |
                :        1        :        |
  ESP+0x4 =>    +-----------------+        |
                :       cmd*      :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*cmd : "/bin/sh"
*uni : uninitialized
```
