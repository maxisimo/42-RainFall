# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048358  _init
0x080483a0  printf@plt
0x080483b0  fflush@plt
0x080483c0  gets@plt
0x080483d0  _exit@plt
0x080483e0  strdup@plt
0x080483f0  puts@plt
0x08048400  __gmon_start__@plt
0x08048410  __libc_start_main@plt
0x08048420  _start
0x08048450  __do_global_dtors_aux
0x080484b0  frame_dummy
0x080484d4  p
0x0804853f  main
0x08048550  __libc_csu_init
0x080485c0  __libc_csu_fini
0x080485c2  __i686.get_pc_thunk.bx
0x080485d0  __do_global_ctors_aux
0x080485fc  _fini
```

# Main
```
Dump of assembler code for function main:
   0x0804853f <+0>:     push   ebp
   0x08048540 <+1>:     mov    ebp,esp
   0x08048542 <+3>:     and    esp,0xfffffff0
   0x08048545 <+6>:     call   0x80484d4 <p>
   0x0804854a <+11>:    leave
   0x0804854b <+12>:    ret
End of assembler dump.
```
## Explanations
```
   0x0804853f <+0>:     push   ebp
   0x08048540 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x08048542 <+3>:     and    esp,0xfffffff0
   0x08048545 <+6>:     call   0x80484d4 <p>
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : Call to `p()` function, we'll see what the stack should look like at the beginning of `p()` explanations.  
```
   0x0804854a <+11>:    leave
   0x0804854b <+12>:    ret
```
<+11> - <+12> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function. Of course we'll execute these instructions once we leaved the `p()` function.  

# P
```
Dump of assembler code for function p:
   0x080484d4 <+0>:     push   ebp
   0x080484d5 <+1>:     mov    ebp,esp
   0x080484d7 <+3>:     sub    esp,0x68
   0x080484da <+6>:     mov    eax,ds:0x8049860
   0x080484df <+11>:    mov    DWORD PTR [esp],eax
   0x080484e2 <+14>:    call   0x80483b0 <fflush@plt>
   0x080484e7 <+19>:    lea    eax,[ebp-0x4c]
   0x080484ea <+22>:    mov    DWORD PTR [esp],eax
   0x080484ed <+25>:    call   0x80483c0 <gets@plt>
   0x080484f2 <+30>:    mov    eax,DWORD PTR [ebp+0x4]
   0x080484f5 <+33>:    mov    DWORD PTR [ebp-0xc],eax
   0x080484f8 <+36>:    mov    eax,DWORD PTR [ebp-0xc]
   0x080484fb <+39>:    and    eax,0xb0000000
   0x08048500 <+44>:    cmp    eax,0xb0000000
   0x08048505 <+49>:    jne    0x8048527 <p+83>
   0x08048507 <+51>:    mov    eax,0x8048620
   0x0804850c <+56>:    mov    edx,DWORD PTR [ebp-0xc]
   0x0804850f <+59>:    mov    DWORD PTR [esp+0x4],edx
   0x08048513 <+63>:    mov    DWORD PTR [esp],eax
   0x08048516 <+66>:    call   0x80483a0 <printf@plt>
   0x0804851b <+71>:    mov    DWORD PTR [esp],0x1
   0x08048522 <+78>:    call   0x80483d0 <_exit@plt>
   0x08048527 <+83>:    lea    eax,[ebp-0x4c]
   0x0804852a <+86>:    mov    DWORD PTR [esp],eax
   0x0804852d <+89>:    call   0x80483f0 <puts@plt>
   0x08048532 <+94>:    lea    eax,[ebp-0x4c]
   0x08048535 <+97>:    mov    DWORD PTR [esp],eax
   0x08048538 <+100>:   call   0x80483e0 <strdup@plt>
   0x0804853d <+105>:   leave
   0x0804853e <+106>:   ret
End of assembler dump.
```
## Explanations
```
   0x080484d4 <+0>:     push   ebp
   0x080484d5 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x080484d7 <+3>:     sub    esp,0x68
```
<+3> : 104 bytes are allocated to the main function for its local variables.  
At this moment, the stack should look like :  
```
                   High addresses

                |     OLD_EBP     |
                +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |  main stackframe
  EBP+0x8 =>    +-----------------+        |
                :    MAIN_EIP     :        |
  EBP+0x4 =>    +-----------------+        |
                :    MAIN_EBP     :        |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :                 :        |
                :                 :        |
                :                 :        |
                :       uni*      :        |  p stackframe
                :                 :        |  104 bytes allocated
                :                 :        |
                :                 :        |
                :                 :        |
                :                 :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```
Ok, let's back to our code.  
```
   0x080484da <+6>:     mov    eax,ds:0x8049860
   0x080484df <+11>:    mov    DWORD PTR [esp],eax
   0x080484e2 <+14>:    call   0x80483b0 <fflush@plt>
```
<+6> : 'ds:[0x8049860]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x8049860]' to register `eax` (eax = stdout).  
<+11> : Set arguments for `fflush()` function.  
<+14> : Call to `fflush()` function with value at the address of `esp` as argument (fflush(stdout)).
```
   0x080484e7 <+19>:    lea    eax,[ebp-0x4c]
   0x080484ea <+22>:    mov    DWORD PTR [esp],eax
   0x080484ed <+25>:    call   0x80483c0 <gets@plt>
```
<+19> : Load the effective address `ebp-0x4c` in `eax`, so `eax` is now pointing on `ebp-0x4c` (perfect, gets() function need a pointer as argument).  
<+22> : Set argument for `gets()` function.  
<+25> : Call to `gets()` function with value at the address of `esp` as argument (gets(`eax`)).  
```
   0x080484f2 <+30>:    mov    eax,DWORD PTR [ebp+0x4]
   0x080484f5 <+33>:    mov    DWORD PTR [ebp-0xc],eax
   0x080484f8 <+36>:    mov    eax,DWORD PTR [ebp-0xc]
   0x080484fb <+39>:    and    eax,0xb0000000
   0x08048500 <+44>:    cmp    eax,0xb0000000
   0x08048505 <+49>:    jne    0x8048527 <p+83>
```
<+30> - <+36> : Store the return address of the current function in `eax` and also save it at address `ebp-0xc`.  
<+39> - <+44> : Execute a logical AND on `eax` then compare it to "0xb0000000". This check is made to be sure we don't overwrite the return address to an address on the stack.  
<+49> : JNE comparaison. If the `cmp` instruction return true, jump to the address `0x8048527` (p+83), otherwise continue.
```
   0x08048507 <+51>:    mov    eax,0x8048620
   0x0804850c <+56>:    mov    edx,DWORD PTR [ebp-0xc]
   0x0804850f <+59>:    mov    DWORD PTR [esp+0x4],edx
   0x08048513 <+63>:    mov    DWORD PTR [esp],eax
   0x08048516 <+66>:    call   0x80483a0 <printf@plt>
```
<+51> : Store the value at `0x8048620` in `eax` (eax = "%p\n").  
<+56> : Store in `edx` the value at `ebp-0xc` (edx = return_address).  
<+59> - <+63> : Set argument for `printf()` function.  
<+66> : Call to `printf()` function with values at addresses `esp` and `esp+4` as arguments (printf("%p\n", return_address)).
```
   0x0804851b <+71>:    mov    DWORD PTR [esp],0x1
   0x08048522 <+78>:    call   0x80483d0 <_exit@plt>
```
<+71> : Set argument for `exit()` function.  
<+66> : Call to `exit()` function with value at address of `esp` as argument (exit(1)).
```
   0x08048527 <+83>:    lea    eax,[ebp-0x4c]
   0x0804852a <+86>:    mov    DWORD PTR [esp],eax
   0x0804852d <+89>:    call   0x80483f0 <puts@plt>
```
<+83> : Load the effective address `ebp-0x4c` in `eax`, so `eax` is now pointing on `ebp-0x4c` (perfect, puts() function need a pointer as argument).  
<+86> : Set argument for `puts()` function.  
<+89> : Call to `puts()` function with value at the address of `esp` as argument (puts(`ebp-0x4c`)).  
```
   0x08048532 <+94>:    lea    eax,[ebp-0x4c]
   0x08048535 <+97>:    mov    DWORD PTR [esp],eax
   0x08048538 <+100>:   call   0x80483e0 <strdup@plt>
```
<+94> : Load the effective address `ebp-0x4c` in `eax`, so `eax` is now pointing on `ebp-0x4c` (perfect, strdup() function need a pointer as argument).  
<+97> : Set argument for `strdup()` function.  
<+100> : Call to `strdup()` function with value at the address of `esp` as argument (strdup(`eax`)).  
```
   0x0804853d <+105>:   leave
   0x0804853e <+106>:   ret
```
<+105> - <+106> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `p()` function.  
