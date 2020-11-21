# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048334  _init
0x08048380  read@plt
0x08048390  strcat@plt
0x080483a0  strcpy@plt
0x080483b0  puts@plt
0x080483c0  __gmon_start__@plt
0x080483d0  strchr@plt
0x080483e0  __libc_start_main@plt
0x080483f0  strncpy@plt
0x08048400  _start
0x08048430  __do_global_dtors_aux
0x08048490  frame_dummy
0x080484b4  p
0x0804851e  pp
0x080485a4  main
0x080485d0  __libc_csu_init
0x08048640  __libc_csu_fini
0x08048642  __i686.get_pc_thunk.bx
0x08048650  __do_global_ctors_aux
0x0804867c  _fini
```

# main
```
(gdb) set disassembly-flavor intel
(gdb) disass main
Dump of assembler code for function main:
   0x080485a4 <+0>:     push   ebp       
   0x080485a5 <+1>:     mov    ebp,esp
   0x080485a7 <+3>:     and    esp,0xfffffff0     
   0x080485aa <+6>:     sub    esp,0x40
   0x080485ad <+9>:     lea    eax,[esp+0x16]     
   0x080485b1 <+13>:    mov    DWORD PTR [esp],eax
   0x080485b4 <+16>:    call   0x804851e <pp>     
   0x080485b9 <+21>:    lea    eax,[esp+0x16]     
   0x080485bd <+25>:    mov    DWORD PTR [esp],eax
   0x080485c0 <+28>:    call   0x80483b0 <puts@plt>
   0x080485c5 <+33>:    mov    eax,0x0
   0x080485ca <+38>:    leave
   0x080485cb <+39>:    ret
End of assembler dump.
```
## Explanations
```
   0x080485a4 <+0>:     push   ebp       
   0x080485a5 <+1>:     mov    ebp,esp
   0x080485a7 <+3>:     and    esp,0xfffffff0     
   0x080485aa <+6>:     sub    esp,0x40
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : 64 bytes are allocated to the main function for its local variables.
```
   0x080485ad <+9>:     lea    eax,[esp+0x16]     
   0x080485b1 <+13>:    mov    DWORD PTR [esp],eax
   0x080485b4 <+16>:    call   0x804851e <pp>
```
<+9> - <+16> : Call the `pp()` function with a pointer on `esp+0x16` as argument (pp(buffer)).
```
   0x080485b9 <+21>:    lea    eax,[esp+0x16]     
   0x080485bd <+25>:    mov    DWORD PTR [esp],eax
   0x080485c0 <+28>:    call   0x80483b0 <puts@plt>
   0x080485c5 <+33>:    mov    eax,0x0
   0x080485ca <+38>:    leave
   0x080485cb <+39>:    ret
```
<+21> - <+28> : Call to `puts()` function with our pointer at `esp+0x16` as argument (puts(str)).  
<+33> - <+39> : return 0.

# pp
```
(gdb) set disassembly-flavor intel
(gdb) disass pp
Dump of assembler code for function pp:
   0x0804851e <+0>:     push   ebp
   0x0804851f <+1>:     mov    ebp,esp
   0x08048521 <+3>:     push   edi
   0x08048522 <+4>:     push   ebx
   0x08048523 <+5>:     sub    esp,0x50
   0x08048526 <+8>:     mov    DWORD PTR [esp+0x4],0x80486a0
   0x0804852e <+16>:    lea    eax,[ebp-0x30]
   0x08048531 <+19>:    mov    DWORD PTR [esp],eax
   0x08048534 <+22>:    call   0x80484b4 <p>
   0x08048539 <+27>:    mov    DWORD PTR [esp+0x4],0x80486a0
   0x08048541 <+35>:    lea    eax,[ebp-0x1c]
   0x08048544 <+38>:    mov    DWORD PTR [esp],eax
   0x08048547 <+41>:    call   0x80484b4 <p>
   0x0804854c <+46>:    lea    eax,[ebp-0x30]
   0x0804854f <+49>:    mov    DWORD PTR [esp+0x4],eax
   0x08048553 <+53>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048556 <+56>:    mov    DWORD PTR [esp],eax
   0x08048559 <+59>:    call   0x80483a0 <strcpy@plt>
   0x0804855e <+64>:    mov    ebx,0x80486a4
   0x08048563 <+69>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048566 <+72>:    mov    DWORD PTR [ebp-0x3c],0xffffffff
   0x0804856d <+79>:    mov    edx,eax
   0x0804856f <+81>:    mov    eax,0x0
   0x08048574 <+86>:    mov    ecx,DWORD PTR [ebp-0x3c]
   0x08048577 <+89>:    mov    edi,edx
   0x08048579 <+91>:    repnz scas al,BYTE PTR es:[edi]
   0x0804857b <+93>:    mov    eax,ecx
   0x0804857d <+95>:    not    eax
   0x0804857f <+97>:    sub    eax,0x1
   0x08048582 <+100>:   add    eax,DWORD PTR [ebp+0x8]
   0x08048585 <+103>:   movzx  edx,WORD PTR [ebx]
   0x08048588 <+106>:   mov    WORD PTR [eax],dx
   0x0804858b <+109>:   lea    eax,[ebp-0x1c]
   0x0804858e <+112>:   mov    DWORD PTR [esp+0x4],eax
   0x08048592 <+116>:   mov    eax,DWORD PTR [ebp+0x8]
   0x08048595 <+119>:   mov    DWORD PTR [esp],eax
   0x08048598 <+122>:   call   0x8048390 <strcat@plt>
   0x0804859d <+127>:   add    esp,0x50
   0x080485a0 <+130>:   pop    ebx
   0x080485a1 <+131>:   pop    edi
   0x080485a2 <+132>:   pop    ebp
   0x080485a3 <+133>:   ret
End of assembler dump.
```
## Explanations
```
   0x0804851e <+0>:     push   ebp
   0x0804851f <+1>:     mov    ebp,esp
   0x08048521 <+3>:     push   edi
   0x08048522 <+4>:     push   ebx
   0x08048523 <+5>:     sub    esp,0x50
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> - <+4> : Save old `edi` and `ebx`. We'll probably run into a loop later in the code.  
<+5> : 80 bytes are allocated to the main function for its local variables.
```
   0x08048526 <+8>:     mov    DWORD PTR [esp+0x4],0x80486a0
   0x0804852e <+16>:    lea    eax,[ebp-0x30]
   0x08048531 <+19>:    mov    DWORD PTR [esp],eax
   0x08048534 <+22>:    call   0x80484b4 <p>
   0x08048539 <+27>:    mov    DWORD PTR [esp+0x4],0x80486a0
   0x08048541 <+35>:    lea    eax,[ebp-0x1c]
   0x08048544 <+38>:    mov    DWORD PTR [esp],eax
   0x08048547 <+41>:    call   0x80484b4 <p>
```
<+8> - <+41> : Two call to `p()` function with pointer to char as first argument and string as second (a[20]; b[20]; p(a, " - "); p(b, " - ");).  
*Both of char array will have a size of 20 because 0x30 - 0x1c = 0x14 (20)*
```
   0x0804854c <+46>:    lea    eax,[ebp-0x30]
   0x0804854f <+49>:    mov    DWORD PTR [esp+0x4],eax
   0x08048553 <+53>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048556 <+56>:    mov    DWORD PTR [esp],eax
   0x08048559 <+59>:    call   0x80483a0 <strcpy@plt>
```
<+46> - <+56> : Set argument for `strcpy()` function.  
<+59> : Call to `strcpy()` with values at addresses of `esp` and `esp+4` as arguments (strcpy(buffer, a)).  
At this moment the stack should look like this :  
```
                   High addresses

                |     OLD_EBP     |
                +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |
                +-----------------+        |
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |
                :                 :        |
                +-----------------+        |   main stackframe
                :      buffer     :        |  64 bytes allocated
    EBP+? =>    +-----------------+        |
                :                 :        |
                :       uni*      :        |
                :                 :        |
                +-----------------+        |
                :      buffer     :        |
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
 EBP-0x1c =>    +-----------------+        |
                :        b        :        |
 EBP-0x30 =>    +-----------------+        |
                :        a        :        |
                +-----------------+        |    pp stackframe
                :                 :        |  80 bytes allocated
                :                 :        |
                :       uni*      :        |
                :                 :        |
                :                 :        |
  ESP+0x8 =>    +-----------------+        |
                :        a        :        |
  ESP+0x4 =>    +-----------------+        |
                :      buffer     :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*EBP+? : I didn't want to count but we can find it
*uni : uninitialized
```
Ok, we can refocus on the code
```
   0x0804855e <+64>:    mov    ebx,0x80486a4
   0x08048563 <+69>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048566 <+72>:    mov    DWORD PTR [ebp-0x3c],0xffffffff
   0x0804856d <+79>:    mov    edx,eax
   0x0804856f <+81>:    mov    eax,0x0
   0x08048574 <+86>:    mov    ecx,DWORD PTR [ebp-0x3c]
   0x08048577 <+89>:    mov    edi,edx
   0x08048579 <+91>:    repnz scas al,BYTE PTR es:[edi]
   0x0804857b <+93>:    mov    eax,ecx
   0x0804857d <+95>:    not    eax
   0x0804857f <+97>:    sub    eax,0x1
   0x08048582 <+100>:   add    eax,DWORD PTR [ebp+0x8]
   0x08048585 <+103>:   movzx  edx,WORD PTR [ebx]
   0x08048588 <+106>:   mov    WORD PTR [eax],dx
```
<+64> : Store the value at `0x80486a4` in `ebx` (ebx = 32).
```
Breakpoint 1, 0x08048563 in pp ()
(gdb) info register ebx
ebx            0x80486a4        134514340
(gdb) x/d $ebx
0x80486a4:      32
(gdb)
```
<+69> : eax = buffer.  
<+72> : Set the value at address `ebp-0x3c` to 0xffffffff (-1).  
<+79> - <+86> : Save `eax` in `edx`, set `eax` to 0x0 then store the value at address `ebp-0x3c` in `ecx` (ecx = -1).  
<+89> : Store the value at `edx` in `edi` (edi is now pointing on buffer).  
```
0x08048579 in pp ()
(gdb) info registers
eax            0x0      0
ecx            0xffffffff       -1
edx            0xbffff706       -1073744122
                   .
                   .
                   .
edi            0xbffff706       -1073744122
eip            0x8048579        0x8048579 <pp+91>
```
<+91> - <+97> : [repnz scasb](https://stackoverflow.com/questions/26783797/repnz-scas-assembly-instruction-specifics) is an equivalent of `strlen()` function in C. In our case, it is like do `strlen(buffer)`. (The sub at pp+97 is probably used to not count "\n" or "\0" at the end of the buffer).  
<+100> : eax = buffer + 1
<+103> : Store the the value pointed by `ebx` in `edx` (edx = 32) see [movzx](https://www.gladir.com/LEXIQUE/ASM/movzx.htm).  
```
   0x0804858b <+109>:   lea    eax,[ebp-0x1c]
   0x0804858e <+112>:   mov    DWORD PTR [esp+0x4],eax
   0x08048592 <+116>:   mov    eax,DWORD PTR [ebp+0x8]
   0x08048595 <+119>:   mov    DWORD PTR [esp],eax
   0x08048598 <+122>:   call   0x8048390 <strcat@plt>
```
<+109> - <+122> : Call to `strcat()` function with values at addresses of `esp` and `esp+4` as argument (strcat(buffer, b)).
```
   0x0804859d <+127>:   add    esp,0x50
   0x080485a0 <+130>:   pop    ebx
   0x080485a1 <+131>:   pop    edi
   0x080485a2 <+132>:   pop    ebp
   0x080485a3 <+133>:   ret
```
<+130> - <+132> : Retrieve old values of `ebx`, `edi` and `ebp`.  
<+127> and <+133> : Lines 127 and 133 is an equivalent of instructions `leave` and `ret`.

# p
```
(gdb) set disassembly-flavor intel
(gdb) disass p
Dump of assembler code for function p:
   0x080484b4 <+0>:     push   ebp
   0x080484b5 <+1>:     mov    ebp,esp
   0x080484b7 <+3>:     sub    esp,0x1018
   0x080484bd <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x080484c0 <+12>:    mov    DWORD PTR [esp],eax
   0x080484c3 <+15>:    call   0x80483b0 <puts@plt>
   0x080484c8 <+20>:    mov    DWORD PTR [esp+0x8],0x1000
   0x080484d0 <+28>:    lea    eax,[ebp-0x1008]
   0x080484d6 <+34>:    mov    DWORD PTR [esp+0x4],eax
   0x080484da <+38>:    mov    DWORD PTR [esp],0x0
   0x080484e1 <+45>:    call   0x8048380 <read@plt>
   0x080484e6 <+50>:    mov    DWORD PTR [esp+0x4],0xa
   0x080484ee <+58>:    lea    eax,[ebp-0x1008]
   0x080484f4 <+64>:    mov    DWORD PTR [esp],eax
   0x080484f7 <+67>:    call   0x80483d0 <strchr@plt>
   0x080484fc <+72>:    mov    BYTE PTR [eax],0x0
   0x080484ff <+75>:    lea    eax,[ebp-0x1008]
   0x08048505 <+81>:    mov    DWORD PTR [esp+0x8],0x14
   0x0804850d <+89>:    mov    DWORD PTR [esp+0x4],eax
   0x08048511 <+93>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048514 <+96>:    mov    DWORD PTR [esp],eax
   0x08048517 <+99>:    call   0x80483f0 <strncpy@plt>
   0x0804851c <+104>:   leave
   0x0804851d <+105>:   ret
End of assembler dump.
```
```
   0x080484b4 <+0>:     push   ebp
   0x080484b5 <+1>:     mov    ebp,esp
   0x080484b7 <+3>:     sub    esp,0x1018
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> : 4120 bytes are allocated to the main function for its local variables.
```
   0x080484bd <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x080484c0 <+12>:    mov    DWORD PTR [esp],eax
   0x080484c3 <+15>:    call   0x80483b0 <puts@plt>
```
<+9> - <+15> : Call to `puts()` with the second arg of `p()` (puts(" - ")).
```
   0x080484c8 <+20>:    mov    DWORD PTR [esp+0x8],0x1000
   0x080484d0 <+28>:    lea    eax,[ebp-0x1008]
   0x080484d6 <+34>:    mov    DWORD PTR [esp+0x4],eax
   0x080484da <+38>:    mov    DWORD PTR [esp],0x0
   0x080484e1 <+45>:    call   0x8048380 <read@plt>
```
<+20> - <+45> : Call to `read()` function with values at addresses of `esp`, `esp+4` and `esp+8` as arguments (read(0, buffer, 4096)).
```
   0x080484e6 <+50>:    mov    DWORD PTR [esp+0x4],0xa
   0x080484ee <+58>:    lea    eax,[ebp-0x1008]
   0x080484f4 <+64>:    mov    DWORD PTR [esp],eax
   0x080484f7 <+67>:    call   0x80483d0 <strchr@plt>
   0x080484fc <+72>:    mov    BYTE PTR [eax],0x0
```
<+50> - <+67> : Call to `strchr()` function with values at addresses of `esp` and `esp+4` as arguments (strchr(buffer, 10)).  
<+72> : Then we set the value pointed by `eax` to 0 (*strchr(buffer, 10) = 0).
```
   0x080484ff <+75>:    lea    eax,[ebp-0x1008]
   0x08048505 <+81>:    mov    DWORD PTR [esp+0x8],0x14
   0x0804850d <+89>:    mov    DWORD PTR [esp+0x4],eax
   0x08048511 <+93>:    mov    eax,DWORD PTR [ebp+0x8]
   0x08048514 <+96>:    mov    DWORD PTR [esp],eax
   0x08048517 <+99>:    call   0x80483f0 <strncpy@plt>
```
<+75> - <+99> : Call to `strncpy()` function with values at addresses of `esp`, `esp+4` and `esp+8` as arguments (strncpy(s, buffer, 20)). With s, our pointers to char in `pp()` (a[20]; b[20]) and buffer, the string initialized with a size of 0x1000 (4096) at the start of the program.
```
   0x0804851c <+104>:   leave
   0x0804851d <+105>:   ret
```
<+104> - <+105> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `p()` function.
