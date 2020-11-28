# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x0804836c  _init
0x080483b0  printf@plt
0x080483c0  fgets@plt
0x080483d0  time@plt
0x080483e0  strcpy@plt
0x080483f0  malloc@plt
0x08048400  puts@plt
0x08048410  __gmon_start__@plt
0x08048420  __libc_start_main@plt
0x08048430  fopen@plt
0x08048440  _start
0x08048470  __do_global_dtors_aux
0x080484d0  frame_dummy
0x080484f4  m
0x08048521  main
0x08048610  __libc_csu_init
0x08048680  __libc_csu_fini
0x08048682  __i686.get_pc_thunk.bx
0x08048690  __do_global_ctors_aux
0x080486bc  _fini
```

# main
```
Dump of assembler code for function main:
   0x08048521 <+0>:     push   ebp
   0x08048522 <+1>:     mov    ebp,esp
   0x08048524 <+3>:     and    esp,0xfffffff0
   0x08048527 <+6>:     sub    esp,0x20
   0x0804852a <+9>:     mov    DWORD PTR [esp],0x8
   0x08048531 <+16>:    call   0x80483f0 <malloc@plt>
   0x08048536 <+21>:    mov    DWORD PTR [esp+0x1c],eax
   0x0804853a <+25>:    mov    eax,DWORD PTR [esp+0x1c]
   0x0804853e <+29>:    mov    DWORD PTR [eax],0x1
   0x08048544 <+35>:    mov    DWORD PTR [esp],0x8
   0x0804854b <+42>:    call   0x80483f0 <malloc@plt>
   0x08048550 <+47>:    mov    edx,eax
   0x08048552 <+49>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048556 <+53>:    mov    DWORD PTR [eax+0x4],edx
   0x08048559 <+56>:    mov    DWORD PTR [esp],0x8
   0x08048560 <+63>:    call   0x80483f0 <malloc@plt>
   0x08048565 <+68>:    mov    DWORD PTR [esp+0x18],eax
   0x08048569 <+72>:    mov    eax,DWORD PTR [esp+0x18]
   0x0804856d <+76>:    mov    DWORD PTR [eax],0x2
   0x08048573 <+82>:    mov    DWORD PTR [esp],0x8
   0x0804857a <+89>:    call   0x80483f0 <malloc@plt>
   0x0804857f <+94>:    mov    edx,eax
   0x08048581 <+96>:    mov    eax,DWORD PTR [esp+0x18]
   0x08048585 <+100>:   mov    DWORD PTR [eax+0x4],edx
   0x08048588 <+103>:   mov    eax,DWORD PTR [ebp+0xc]
   0x0804858b <+106>:   add    eax,0x4
   0x0804858e <+109>:   mov    eax,DWORD PTR [eax]
   0x08048590 <+111>:   mov    edx,eax
   0x08048592 <+113>:   mov    eax,DWORD PTR [esp+0x1c]
   0x08048596 <+117>:   mov    eax,DWORD PTR [eax+0x4]
   0x08048599 <+120>:   mov    DWORD PTR [esp+0x4],edx
   0x0804859d <+124>:   mov    DWORD PTR [esp],eax
   0x080485a0 <+127>:   call   0x80483e0 <strcpy@plt>
   0x080485a5 <+132>:   mov    eax,DWORD PTR [ebp+0xc]
   0x080485a8 <+135>:   add    eax,0x8
   0x080485ab <+138>:   mov    eax,DWORD PTR [eax]
   0x080485ad <+140>:   mov    edx,eax
   0x080485af <+142>:   mov    eax,DWORD PTR [esp+0x18]
   0x080485b3 <+146>:   mov    eax,DWORD PTR [eax+0x4]
   0x080485b6 <+149>:   mov    DWORD PTR [esp+0x4],edx
   0x080485ba <+153>:   mov    DWORD PTR [esp],eax
   0x080485bd <+156>:   call   0x80483e0 <strcpy@plt>
   0x080485c2 <+161>:   mov    edx,0x80486e9
   0x080485c7 <+166>:   mov    eax,0x80486eb
   0x080485cc <+171>:   mov    DWORD PTR [esp+0x4],edx
   0x080485d0 <+175>:   mov    DWORD PTR [esp],eax
   0x080485d3 <+178>:   call   0x8048430 <fopen@plt>
   0x080485d8 <+183>:   mov    DWORD PTR [esp+0x8],eax
   0x080485dc <+187>:   mov    DWORD PTR [esp+0x4],0x44
   0x080485e4 <+195>:   mov    DWORD PTR [esp],0x8049960
   0x080485eb <+202>:   call   0x80483c0 <fgets@plt>
   0x080485f0 <+207>:   mov    DWORD PTR [esp],0x8048703
   0x080485f7 <+214>:   call   0x8048400 <puts@plt>
   0x080485fc <+219>:   mov    eax,0x0
   0x08048601 <+224>:   leave
   0x08048602 <+225>:   ret
End of assembler dump.
```
## Explanations
```
   0x08048521 <+0>:     push   ebp
   0x08048522 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x08048524 <+3>:     and    esp,0xfffffff0
   0x08048527 <+6>:     sub    esp,0x20
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : 32 bytes are allocated to the main function for its local variables.
```
   0x0804852a <+9>:     mov    DWORD PTR [esp],0x8
   0x08048531 <+16>:    call   0x80483f0 <malloc@plt>
   0x08048536 <+21>:    mov    DWORD PTR [esp+0x1c],eax
```
<+9> - <+21> : Call to `malloc()` with the value at the address of `esp` as argument (malloc(8)) then store the return value in `esp+0x1c`.
```
   0x0804853a <+25>:    mov    eax,DWORD PTR [esp+0x1c]
   0x0804853e <+29>:    mov    DWORD PTR [eax],0x1
   0x08048544 <+35>:    mov    DWORD PTR [esp],0x8
   0x0804854b <+42>:    call   0x80483f0 <malloc@plt>
   0x08048550 <+47>:    mov    edx,eax
   0x08048552 <+49>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048556 <+53>:    mov    DWORD PTR [eax+0x4],edx
```
<+25> - <+29> : Set `eax` pointing on the area of the first `malloc()`, then set the first case of the `malloc()` at 0x1 (a = malloc(8); a[0] = 0x1).  
<+35> - <+42> : Second call of `malloc(8)`.  
<+47> - <+53> : Set `eax` pointing on the area of the first `malloc()` again, then set the second case of the `malloc()` at `edx` (a = malloc(8); a[1] = malloc(8)). 
```
   0x08048559 <+56>:    mov    DWORD PTR [esp],0x8
   0x08048560 <+63>:    call   0x80483f0 <malloc@plt>
   0x08048565 <+68>:    mov    DWORD PTR [esp+0x18],eax
```
<+56> - <+68> : Call to `malloc()` with the value at the address of `esp` as argument (malloc(8)) then store the return value in `esp+0x18`.
```
   0x08048569 <+72>:    mov    eax,DWORD PTR [esp+0x18]
   0x0804856d <+76>:    mov    DWORD PTR [eax],0x2
   0x08048573 <+82>:    mov    DWORD PTR [esp],0x8
   0x0804857a <+89>:    call   0x80483f0 <malloc@plt>
   0x0804857f <+94>:    mov    edx,eax
   0x08048581 <+96>:    mov    eax,DWORD PTR [esp+0x18]
   0x08048585 <+100>:   mov    DWORD PTR [eax+0x4],edx
```
<+72> - <+76> : Set `eax` pointing on the area of the third `malloc()`, then set the first case of the `malloc()` at 0x2 (b = malloc(8); b[0] = 0x2).  
<+82> - <+89> : Fourth call of `malloc(8)`.  
<+47> - <+53> : Set `eax` pointing on the area of the third `malloc()` again, then set the second case of the `malloc()` at `edx` (b = malloc(8); b[1] = malloc(8)).  
A diagram of the stack is needed.
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |
                +-----------------+        |
                :1st malloc(8) ret:        |
 ESP+0x1c =>    +-----------------+        |  32 bytes
                :3rd malloc(8) ret:        |  allocated
 ESP+0x18 =>    +-----------------+        |
                         .                 |
                         .                 |
                         .                 |
                +-----------------+        |
                :       uni*      :        |
  ESP+0x4 =>    +-----------------+        |
                :       0x8       :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```
Lets back to our code
```
   0x08048588 <+103>:   mov    eax,DWORD PTR [ebp+0xc]
   0x0804858b <+106>:   add    eax,0x4
   0x0804858e <+109>:   mov    eax,DWORD PTR [eax]
   0x08048590 <+111>:   mov    edx,eax
```
<+103> - <+111> : Store directly the value of `argv[1]` in `eax`, so `eax` is now a pointer on the first arg of the `main()` function. Then save the value of `eax` in `edx`.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*
```
   0x08048592 <+113>:   mov    eax,DWORD PTR [esp+0x1c]
   0x08048596 <+117>:   mov    eax,DWORD PTR [eax+0x4]
   0x08048599 <+120>:   mov    DWORD PTR [esp+0x4],edx
   0x0804859d <+124>:   mov    DWORD PTR [esp],eax
   0x080485a0 <+127>:   call   0x80483e0 <strcpy@plt>
```
<+113> - <+117> : `eax` is now pointing on the second case of the area of the first `malloc()` (eax = a[1]).  
<+120> - <+124> : Set arguments for `strcpy()` function.  
<+127> : Call to `strcpy()` with values at addresses `esp` and `esp+4` as arguments (strcpy(a[1], argv[1])).
```
   0x080485a5 <+132>:   mov    eax,DWORD PTR [ebp+0xc]
   0x080485a8 <+135>:   add    eax,0x8
   0x080485ab <+138>:   mov    eax,DWORD PTR [eax]
   0x080485ad <+140>:   mov    edx,eax
```
<+132> - <+140> : Store directly the value of `argv[2]` in `eax`, so `eax` is now a pointer on the second arg of the `main()` function. Then save the value of `eax` in `edx`.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*
```
   0x080485af <+142>:   mov    eax,DWORD PTR [esp+0x18]
   0x080485b3 <+146>:   mov    eax,DWORD PTR [eax+0x4]
   0x080485b6 <+149>:   mov    DWORD PTR [esp+0x4],edx
   0x080485ba <+153>:   mov    DWORD PTR [esp],eax
   0x080485bd <+156>:   call   0x80483e0 <strcpy@plt>
```
<+142> - <+146> : `eax` is now pointing on the second case of the area of the third `malloc()` (eax = b[1]).  
<+149> - <+153> : Set arguments for `strcpy()` function.  
<+156> : Call to `strcpy()` with values at addresses `esp` and `esp+4` as arguments (strcpy(b[1], argv[2])).
```
   0x080485c2 <+161>:   mov    edx,0x80486e9
   0x080485c7 <+166>:   mov    eax,0x80486eb
   0x080485cc <+171>:   mov    DWORD PTR [esp+0x4],edx
   0x080485d0 <+175>:   mov    DWORD PTR [esp],eax
   0x080485d3 <+178>:   call   0x8048430 <fopen@plt>
```
<+161> - <+175> : Set arguments for `fopen()` function.  
<+178> : Call to `fopen()` with values at addresses `esp` and `esp+4` as arguments (fopen(`esp`, `esp+4`)).  
```
   0x080485d8 <+183>:   mov    DWORD PTR [esp+0x8],eax
   0x080485dc <+187>:   mov    DWORD PTR [esp+0x4],0x44
   0x080485e4 <+195>:   mov    DWORD PTR [esp],0x8049960
   0x080485eb <+202>:   call   0x80483c0 <fgets@plt>
```
<+183> - <+195> : Set arguments for `fgets()` function.  
<+202> : Call to `fgets()` with values at addresses `esp`, `esp+4` and `esp+8` as arguments (fgets(`esp`, `esp+4`, `esp+8`)).  
At this moment, the stack should look like :
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |
                +-----------------+        |
                :1st malloc(8) ret:        |
 ESP+0x1c =>    +-----------------+        |  32 bytes
                :3rd malloc(8) ret:        |  allocated
 ESP+0x18 =>    +-----------------+        |
                         .                 |
                         .                 |
                         .                 |
                +-----------------+        |
                :  fopen() return :        |
  ESP+0x8 =>    +-----------------+        |
                :       0x44      :        |
  ESP+0x4 =>    +-----------------+        |
                :     global c    :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

global c : is a variable stored at address 0x8049960
```
```
   0x080485f0 <+207>:   mov    DWORD PTR [esp],0x8048703
   0x080485f7 <+214>:   call   0x8048400 <puts@plt>
```
<+207> : Set argument for `puts()` function.  
<+214> : Call to `puts()` with value at the address of `esp` as argument (puts("~~")).
```
   0x080485fc <+219>:   mov    eax,0x0
   0x08048601 <+224>:   leave
   0x08048602 <+225>:   ret
```
<+219> - <+225> : These three lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function by doing an equivalent of `return(0)` in C.

# m
```
Dump of assembler code for function m:
   0x080484f4 <+0>:     push   ebp
   0x080484f5 <+1>:     mov    ebp,esp
   0x080484f7 <+3>:     sub    esp,0x18
   0x080484fa <+6>:     mov    DWORD PTR [esp],0x0
   0x08048501 <+13>:    call   0x80483d0 <time@plt>
   0x08048506 <+18>:    mov    edx,0x80486e0
   0x0804850b <+23>:    mov    DWORD PTR [esp+0x8],eax
   0x0804850f <+27>:    mov    DWORD PTR [esp+0x4],0x8049960
   0x08048517 <+35>:    mov    DWORD PTR [esp],edx
   0x0804851a <+38>:    call   0x80483b0 <printf@plt>
   0x0804851f <+43>:    leave
   0x08048520 <+44>:    ret
End of assembler dump.
```
## Explanations
```
   0x080484f4 <+0>:     push   ebp
   0x080484f5 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x080484f7 <+3>:     sub    esp,0x18
```
<+3> : 24 bytes are allocated to the main function for its local variables.
```
   0x080484fa <+6>:     mov    DWORD PTR [esp],0x0
   0x08048501 <+13>:    call   0x80483d0 <time@plt>
```
<+6> - <+13> : Call to `time()` function with value at the address of `esp` as argument (time(0)).
```
   0x08048506 <+18>:    mov    edx,0x80486e0
   0x0804850b <+23>:    mov    DWORD PTR [esp+0x8],eax
   0x0804850f <+27>:    mov    DWORD PTR [esp+0x4],0x8049960
   0x08048517 <+35>:    mov    DWORD PTR [esp],edx
   0x0804851a <+38>:    call   0x80483b0 <printf@plt>
```
<+18> : Store the address `0x80486e0` in edx (edx ~= "%s - %d\n").  
<+27> : Store the address of the glabal variable c at address `esp+4`.  
<+18> - <+38> : Call to `printf()` function with values at addresses from `esp` to `esp+8` as arguments (printf("%s - %d\n", global_c, time(0))).
```
   0x0804851f <+43>:    leave
   0x08048520 <+44>:    ret
```
<+43> - <+44> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.
