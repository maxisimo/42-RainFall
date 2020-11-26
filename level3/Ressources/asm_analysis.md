# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048344  _init
0x08048390  printf@plt
0x080483a0  fgets@plt
0x080483b0  fwrite@plt
0x080483c0  system@plt
0x080483d0  __gmon_start__@plt
0x080483e0  __libc_start_main@plt
0x080483f0  _start
0x08048420  __do_global_dtors_aux
0x08048480  frame_dummy
0x080484a4  v
0x0804851a  main
0x08048530  __libc_csu_init
0x080485a0  __libc_csu_fini
0x080485a2  __i686.get_pc_thunk.bx
0x080485b0  __do_global_ctors_aux
0x080485dc  _fini
```

# main
```
Dump of assembler code for function main:
   0x0804851a <+0>:     push   ebp
   0x0804851b <+1>:     mov    ebp,esp
   0x0804851d <+3>:     and    esp,0xfffffff0
   0x08048520 <+6>:     call   0x80484d4 <p>
   0x08048525 <+11>:    leave
   0x08048526 <+12>:    ret
End of assembler dump.
```
## Explanations
```
   0x0804851a <+0>:     push   ebp
   0x0804851b <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x0804851d <+3>:     and    esp,0xfffffff0
   0x08048520 <+6>:     call   0x80484d4 <p>
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : Call to `p()` function, we'll see what the stack should look like at the beginning of `p()` explanations.  
```
   0x08048525 <+11>:    leave
   0x08048526 <+12>:    ret
```
<+11> - <+12> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function. Of course we'll execute these instructions once we leaved the `p()` function.  

# v
```
Dump of assembler code for function v:
   0x080484a4 <+0>:     push   ebp
   0x080484a5 <+1>:     mov    ebp,esp
   0x080484a7 <+3>:     sub    esp,0x218
   0x080484ad <+9>:     mov    eax,ds:0x8049860
   0x080484b2 <+14>:    mov    DWORD PTR [esp+0x8],eax
   0x080484b6 <+18>:    mov    DWORD PTR [esp+0x4],0x200
   0x080484be <+26>:    lea    eax,[ebp-0x208]
   0x080484c4 <+32>:    mov    DWORD PTR [esp],eax
   0x080484c7 <+35>:    call   0x80483a0 <fgets@plt>
   0x080484cc <+40>:    lea    eax,[ebp-0x208]
   0x080484d2 <+46>:    mov    DWORD PTR [esp],eax
   0x080484d5 <+49>:    call   0x8048390 <printf@plt>
   0x080484da <+54>:    mov    eax,ds:0x804988c
   0x080484df <+59>:    cmp    eax,0x40
   0x080484e2 <+62>:    jne    0x8048518 <v+116>
   0x080484e4 <+64>:    mov    eax,ds:0x8049880
   0x080484e9 <+69>:    mov    edx,eax
   0x080484eb <+71>:    mov    eax,0x8048600
   0x080484f0 <+76>:    mov    DWORD PTR [esp+0xc],edx
   0x080484f4 <+80>:    mov    DWORD PTR [esp+0x8],0xc
   0x080484fc <+88>:    mov    DWORD PTR [esp+0x4],0x1
   0x08048504 <+96>:    mov    DWORD PTR [esp],eax
   0x08048507 <+99>:    call   0x80483b0 <fwrite@plt>
   0x0804850c <+104>:   mov    DWORD PTR [esp],0x804860d
   0x08048513 <+111>:   call   0x80483c0 <system@plt>
   0x08048518 <+116>:   leave
   0x08048519 <+117>:   ret
End of assembler dump.
```
## Explanations
```
   0x080484a4 <+0>:     push   ebp
   0x080484a5 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x080484a7 <+3>:     sub    esp,0x218
```
<+3> : 536 bytes are allocated to the main function for its local variables.  
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
                :       uni*      :        |  v stackframe
                :                 :        |  536 bytes allocated
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
   0x080484ad <+9>:     mov    eax,ds:0x8049860
   0x080484b2 <+14>:    mov    DWORD PTR [esp+0x8],eax
   0x080484b6 <+18>:    mov    DWORD PTR [esp+0x4],0x200
   0x080484be <+26>:    lea    eax,[ebp-0x208]
   0x080484c4 <+32>:    mov    DWORD PTR [esp],eax
   0x080484c7 <+35>:    call   0x80483a0 <fgets@plt>
```
<+9> : 'ds:[0x8049860]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x8049860]' to register `eax` (eax = stdin).  
<+14> - <+32> : Set arguments for `fgets()` function and load the effective address `ebp-0x208` in `eax`, so `eax` is now pointing on `ebp-0x208` (perfect, fgets() function need a pointer as first argument).   
<+35> : Call to `fgets()` function with values at addresses of `esp`, `esp+4` and `esp+8` as argument (fgets(`eax`, 512, stdin)).  
```
   0x080484cc <+40>:    lea    eax,[ebp-0x208]
   0x080484d2 <+46>:    mov    DWORD PTR [esp],eax
   0x080484d5 <+49>:    call   0x8048390 <printf@plt>
```
<+40> - <+49> : print the pointer passed as first argument on `fgets()` (printf(`eax`)).
```
   0x080484da <+54>:    mov    eax,ds:0x804988c
   0x080484df <+59>:    cmp    eax,0x40
   0x080484e2 <+62>:    jne    0x8048518 <v+116>
```
<+54> - <+62> : JNE comparaison. If the value of the global variable ("m") stored at address `0x804988c` is not equal to 0x40 (64), jump to the address `0x8048518` (v+116), otherwise continue.
```
   0x080484e4 <+64>:    mov    eax,ds:0x8049880
   0x080484e9 <+69>:    mov    edx,eax
   0x080484eb <+71>:    mov    eax,0x8048600
   0x080484f0 <+76>:    mov    DWORD PTR [esp+0xc],edx
   0x080484f4 <+80>:    mov    DWORD PTR [esp+0x8],0xc
   0x080484fc <+88>:    mov    DWORD PTR [esp+0x4],0x1
   0x08048504 <+96>:    mov    DWORD PTR [esp],eax
   0x08048507 <+99>:    call   0x80483b0 <fwrite@plt>
```
<+64> : 'ds:[0x8049880]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x8049880]' to register `eax` (eax = stdout).  
<+69> : Save the value of `eax` in `edx`.  
<+71> : Then store the value at address `0x8048600` in `eax` (eax = "Wait what?!\n").  
<+76> - <+96> : Set arguments for `fwrite()` function.  
<+99> : Call to `fwrite()` function with values at addresses from `esp` to `esp+12` as arguments (fwrite(`esp`, `esp+4`, `esp+8`, `esp+12`)).
```
   0x0804850c <+104>:   mov    DWORD PTR [esp],0x804860d
   0x08048513 <+111>:   call   0x80483c0 <system@plt>
```
<+104> : Set argument for `system()` function.  
<+111> : Call to `system()` function with value at address `esp` as argument (system("/bin/sh")).  
```
   0x08048518 <+116>:   leave
   0x08048519 <+117>:   ret
```
<+116> - <+117> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.  
Before `leave` and `ret` instructions, the stack should look like :
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
                :       uni*      :        |
                :                 :        |
                :                 :        |
EBP-0x208 =>    +-----------------+        |
                :     buffer*     :        |
                +-----------------+        |
                :                 :        |
                :                 :        |
                :       uni*      :        |  v stackframe
                :                 :        |  536 bytes allocated
                :                 :        |
                +-----------------+        |
                :      stdout     :        |
  ESP+0xc =>    +-----------------+        |
                :       0xc       :        |
  ESP+0x8 =>    +-----------------+        |
                :       0x8       :        |
  ESP+0x4 =>    +-----------------+        |
                : "Wait what?!\n" :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*buffer : the pointer used for fget() and printf() points here
*uni : uninitialized
```
