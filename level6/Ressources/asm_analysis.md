# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x080482f4  _init
0x08048340  strcpy@plt
0x08048350  malloc@plt
0x08048360  puts@plt
0x08048370  system@plt
0x08048380  __gmon_start__@plt
0x08048390  __libc_start_main@plt
0x080483a0  _start
0x080483d0  __do_global_dtors_aux
0x08048430  frame_dummy
0x08048454  n
0x08048468  m
0x0804847c  main
0x080484e0  __libc_csu_init
0x08048550  __libc_csu_fini
0x08048552  __i686.get_pc_thunk.bx
0x08048560  __do_global_ctors_aux
0x0804858c  _fini
```

# Main
```
(gdb) set disassembly-flavor intel
(gdb) disass main
Dump of assembler code for function main:
   0x0804847c <+0>:     push   ebp
   0x0804847d <+1>:     mov    ebp,esp
   0x0804847f <+3>:     and    esp,0xfffffff0
   0x08048482 <+6>:     sub    esp,0x20
   0x08048485 <+9>:     mov    DWORD PTR [esp],0x40
   0x0804848c <+16>:    call   0x8048350 <malloc@plt>
   0x08048491 <+21>:    mov    DWORD PTR [esp+0x1c],eax
   0x08048495 <+25>:    mov    DWORD PTR [esp],0x4
   0x0804849c <+32>:    call   0x8048350 <malloc@plt>
   0x080484a1 <+37>:    mov    DWORD PTR [esp+0x18],eax
   0x080484a5 <+41>:    mov    edx,0x8048468
   0x080484aa <+46>:    mov    eax,DWORD PTR [esp+0x18]
   0x080484ae <+50>:    mov    DWORD PTR [eax],edx
   0x080484b0 <+52>:    mov    eax,DWORD PTR [ebp+0xc]
   0x080484b3 <+55>:    add    eax,0x4
   0x080484b6 <+58>:    mov    eax,DWORD PTR [eax]
   0x080484b8 <+60>:    mov    edx,eax
   0x080484ba <+62>:    mov    eax,DWORD PTR [esp+0x1c]
   0x080484be <+66>:    mov    DWORD PTR [esp+0x4],edx
   0x080484c2 <+70>:    mov    DWORD PTR [esp],eax
   0x080484c5 <+73>:    call   0x8048340 <strcpy@plt>
   0x080484ca <+78>:    mov    eax,DWORD PTR [esp+0x18]
   0x080484ce <+82>:    mov    eax,DWORD PTR [eax]
   0x080484d0 <+84>:    call   eax
   0x080484d2 <+86>:    leave
   0x080484d3 <+87>:    ret
End of assembler dump.
```
## Explanations
```
   0x0804847c <+0>:     push   ebp
   0x0804847d <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x0804847f <+3>:     and    esp,0xfffffff0
   0x08048482 <+6>:     sub    esp,0x20
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : 32 bytes are allocated to the main function for its local variables.
```
   0x08048485 <+9>:     mov    DWORD PTR [esp],0x40
   0x0804848c <+16>:    call   0x8048350 <malloc@plt>
   0x08048491 <+21>:    mov    DWORD PTR [esp+0x1c],eax
   0x08048495 <+25>:    mov    DWORD PTR [esp],0x4
   0x0804849c <+32>:    call   0x8048350 <malloc@plt>
   0x080484a1 <+37>:    mov    DWORD PTR [esp+0x18],eax
```
<+9> - <+21> : Stock 0x40 at the address of `esp` (the top of the stack). Call to malloc() which will take as argument the value stored at the address of `esp`. Then save the value of the return function at the address `esp+0x1c` (the 7th line on the stack).  
<+25> - <+37> : Stock 0x4 at the address of `esp` (the top of the stack). Call to malloc() which will take as argument the value stored at the address of `esp`. Then save the value of the return function at the address `esp+0x18` (the 6th line on the stack).  
At this moment the stack will look like :  
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |
                +-----------------+        |
                :malloc(64) return:        |
 ESP+0x1c =>    +-----------------+        |
                :malloc(4) return :        |  32 bytes
 ESP+0x18 =>    +-----------------+        |  allocated
                         .                 |
                         .                 |
                         .                 |
                +-----------------+        |
                :       uni*      :        |
  ESP+0x4 =>    +-----------------+        |
                :       0x4       :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```
Lets back to our code
```
   0x080484a5 <+41>:    mov    edx,0x8048468
   0x080484aa <+46>:    mov    eax,DWORD PTR [esp+0x18]
   0x080484ae <+50>:    mov    DWORD PTR [eax],edx
```
<+41> : Store the address of the function `m()` in `edx` (edx = &m).  
<+46> : I don't know what is it for, this line is useless.  
<+50> : Store the value of `edx` in the address pointed by `eax` (*eax = &m).
```
   0x080484b0 <+52>:    mov    eax,DWORD PTR [ebp+0xc]
   0x080484b3 <+55>:    add    eax,0x4
   0x080484b6 <+58>:    mov    eax,DWORD PTR [eax]
```
<+52> - <+58> : Store directly the value of `argv[1]` in `eax`, so `eax` is now a pointer.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*
```
   0x080484b8 <+60>:    mov    edx,eax
   0x080484ba <+62>:    mov    eax,DWORD PTR [esp+0x1c]
   0x080484be <+66>:    mov    DWORD PTR [esp+0x4],edx
   0x080484c2 <+70>:    mov    DWORD PTR [esp],eax
   0x080484c5 <+73>:    call   0x8048340 <strcpy@plt>
```
<+60> : Save the value of `eax` in `edx` (edx = eax = argv[1]).  
<+62> : Store the pointer at the address `esp+0x1c` (the malloc(64) return), which points to a memory area in the heap, in `eax`.  
<+66> - <+73> : Store `edx` and `eax` respectively at the first line in the stack (`esp+4`) and at the top of the stack (`esp`) in order to be used as parameters to strcpy(). Then, of course, call strcpy() (in other therms : strcpy(`esp`, `esp+4`) => strcpy(malloc(64), argv[1])).  
This is what the stack should look like :
```
                   High addresses
                :                 :
   EBP+0x10 =>  +-----------------+
                :       argv      :
    EBP+0xc =>  +-----------------+
                :       argc      :
    EBP+0x8 =>  +-----------------+
                |     OLD_EIP     |
    EBP+0x4 =>  +-----------------+
                |     OLD_EBP     |
      EBP =>    +-----------------+
                :                 :
                :   extra space   :
                :   (alignment)   :
                :                 :
                +-----------------+    ----+
                :malloc(64) return:        |
 ESP+0x1c =>    +-----------------+        |
                :malloc(4) return :        |
 ESP+0x18 =>    +-----------------+        |
                         .                 |
                         .                 |  32 bytes allocated
                         .                 |
                +-----------------+        |
                :     argv[1]     :        |
  ESP+0x4 =>    +-----------------+        |
                :malloc(64) return:        |
      ESP =>    +-----------------+    ----+
                   Low addresses

```
```
   0x080484ca <+78>:    mov    eax,DWORD PTR [esp+0x18]
   0x080484ce <+82>:    mov    eax,DWORD PTR [eax]
   0x080484d0 <+84>:    call   eax
```
<+78> : Store the address pointed by the malloc(4) return in `eax` (eax = &adresse).  
<+82> : Store the address of `m()` function in `eax`, `eax` is now a pointer to a function (eax = *eax = &m).  
<+84> : Call `eax`, in others therms `m()`.  
These lines mean that we make an indirect call to the `m()` function via a pointer to function.
```
   0x080484d2 <+86>:    leave
   0x080484d3 <+87>:    ret
```
<+86> - <+87> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.

# M
```
Dump of assembler code for function m:
   0x08048468 <+0>:     push   ebp
   0x08048469 <+1>:     mov    ebp,esp
   0x0804846b <+3>:     sub    esp,0x18
   0x0804846e <+6>:     mov    DWORD PTR [esp],0x80485d1
   0x08048475 <+13>:    call   0x8048360 <puts@plt>
   0x0804847a <+18>:    leave
   0x0804847b <+19>:    ret
End of assembler dump.
```
## Explanations
```
   0x08048468 <+0>:     push   ebp
   0x08048469 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x0804846b <+3>:     sub    esp,0x18
```
<+3> : 32 bytes are allocated to the main function for its local variables.
```
   0x0804846e <+6>:     mov    DWORD PTR [esp],0x80485d1
   0x08048475 <+13>:    call   0x8048360 <puts@plt>
```
<+6> : Set argument for `puts()` function.  
<+13> : Call `puts()` with value at address of `esp` as argument (puts("Nope")).
```
   0x0804847a <+18>:    leave
   0x0804847b <+19>:    ret
```
<+18> - <+19> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.

# N
```
Dump of assembler code for function n:
   0x08048454 <+0>:     push   ebp
   0x08048455 <+1>:     mov    ebp,esp
   0x08048457 <+3>:     sub    esp,0x18
   0x0804845a <+6>:     mov    DWORD PTR [esp],0x80485b0
   0x08048461 <+13>:    call   0x8048370 <system@plt>
   0x08048466 <+18>:    leave
   0x08048467 <+19>:    ret
End of assembler dump.
```
## Explanations
<+0> - <+19> : Exactly the same function as `n()` excepting the call function and the value at address of `esp` (system("/bin/cat /home/user/level7/.pass")).
