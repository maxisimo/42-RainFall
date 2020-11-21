# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x080483c4  _init
0x08048410  printf@plt
0x08048420  free@plt
0x08048430  strdup@plt
0x08048440  fgets@plt
0x08048450  fwrite@plt
0x08048460  strcpy@plt
0x08048470  malloc@plt
0x08048480  system@plt
0x08048490  __gmon_start__@plt
0x080484a0  __libc_start_main@plt
0x080484b0  _start
0x080484e0  __do_global_dtors_aux
0x08048540  frame_dummy
0x08048564  main
0x08048740  __libc_csu_init
0x080487b0  __libc_csu_fini
0x080487b2  __i686.get_pc_thunk.bx
0x080487c0  __do_global_ctors_aux
0x080487ec  _fini
```

# Main
```
Dump of assembler code for function main:
   0x08048564 <+0>:     push   ebp
   0x08048565 <+1>:     mov    ebp,esp
   0x08048567 <+3>:     push   edi
   0x08048568 <+4>:     push   esi
   0x08048569 <+5>:     and    esp,0xfffffff0
   0x0804856c <+8>:     sub    esp,0xa0
   0x08048572 <+14>:    jmp    0x8048575 <main+17>
   0x08048574 <+16>:    nop
   0x08048575 <+17>:    mov    ecx,DWORD PTR ds:0x8049ab0
   0x0804857b <+23>:    mov    edx,DWORD PTR ds:0x8049aac
   0x08048581 <+29>:    mov    eax,0x8048810
   0x08048586 <+34>:    mov    DWORD PTR [esp+0x8],ecx
   0x0804858a <+38>:    mov    DWORD PTR [esp+0x4],edx
   0x0804858e <+42>:    mov    DWORD PTR [esp],eax
   0x08048591 <+45>:    call   0x8048410 <printf@plt>
   0x08048596 <+50>:    mov    eax,ds:0x8049a80
   0x0804859b <+55>:    mov    DWORD PTR [esp+0x8],eax
   0x0804859f <+59>:    mov    DWORD PTR [esp+0x4],0x80
   0x080485a7 <+67>:    lea    eax,[esp+0x20]
   0x080485ab <+71>:    mov    DWORD PTR [esp],eax
   0x080485ae <+74>:    call   0x8048440 <fgets@plt>
   0x080485b3 <+79>:    test   eax,eax
   0x080485b5 <+81>:    je     0x804872c <main+456>
   0x080485bb <+87>:    lea    eax,[esp+0x20]
   0x080485bf <+91>:    mov    edx,eax
   0x080485c1 <+93>:    mov    eax,0x8048819
   0x080485c6 <+98>:    mov    ecx,0x5
   0x080485cb <+103>:   mov    esi,edx
   0x080485cd <+105>:   mov    edi,eax
   0x080485cf <+107>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x080485d1 <+109>:   seta   dl
   0x080485d4 <+112>:   setb   al
   0x080485d7 <+115>:   mov    ecx,edx
   0x080485d9 <+117>:   sub    cl,al
   0x080485db <+119>:   mov    eax,ecx
   0x080485dd <+121>:   movsx  eax,al
   0x080485e0 <+124>:   test   eax,eax
   0x080485e2 <+126>:   jne    0x8048642 <main+222>
   0x080485e4 <+128>:   mov    DWORD PTR [esp],0x4
   0x080485eb <+135>:   call   0x8048470 <malloc@plt>
   0x080485f0 <+140>:   mov    ds:0x8049aac,eax
   0x080485f5 <+145>:   mov    eax,ds:0x8049aac
   0x080485fa <+150>:   mov    DWORD PTR [eax],0x0
   0x08048600 <+156>:   lea    eax,[esp+0x20]
   0x08048604 <+160>:   add    eax,0x5
   0x08048607 <+163>:   mov    DWORD PTR [esp+0x1c],0xffffffff
   0x0804860f <+171>:   mov    edx,eax
   0x08048611 <+173>:   mov    eax,0x0
   0x08048616 <+178>:   mov    ecx,DWORD PTR [esp+0x1c]
   0x0804861a <+182>:   mov    edi,edx
   0x0804861c <+184>:   repnz scas al,BYTE PTR es:[edi]
   0x0804861e <+186>:   mov    eax,ecx
   0x08048620 <+188>:   not    eax
   0x08048622 <+190>:   sub    eax,0x1
   0x08048625 <+193>:   cmp    eax,0x1e
   0x08048628 <+196>:   ja     0x8048642 <main+222>
   0x0804862a <+198>:   lea    eax,[esp+0x20]
   0x0804862e <+202>:   lea    edx,[eax+0x5]
   0x08048631 <+205>:   mov    eax,ds:0x8049aac
   0x08048636 <+210>:   mov    DWORD PTR [esp+0x4],edx
   0x0804863a <+214>:   mov    DWORD PTR [esp],eax
   0x0804863d <+217>:   call   0x8048460 <strcpy@plt>
   0x08048642 <+222>:   lea    eax,[esp+0x20]
   0x08048646 <+226>:   mov    edx,eax
   0x08048648 <+228>:   mov    eax,0x804881f
   0x0804864d <+233>:   mov    ecx,0x5
   0x08048652 <+238>:   mov    esi,edx
   0x08048654 <+240>:   mov    edi,eax
   0x08048656 <+242>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x08048658 <+244>:   seta   dl
   0x0804865b <+247>:   setb   al
   0x0804865e <+250>:   mov    ecx,edx
   0x08048660 <+252>:   sub    cl,al
   0x08048662 <+254>:   mov    eax,ecx
   0x08048664 <+256>:   movsx  eax,al
   0x08048667 <+259>:   test   eax,eax
   0x08048669 <+261>:   jne    0x8048678 <main+276>
   0x0804866b <+263>:   mov    eax,ds:0x8049aac
   0x08048670 <+268>:   mov    DWORD PTR [esp],eax
   0x08048673 <+271>:   call   0x8048420 <free@plt>
   0x08048678 <+276>:   lea    eax,[esp+0x20]
   0x0804867c <+280>:   mov    edx,eax
   0x0804867e <+282>:   mov    eax,0x8048825
   0x08048683 <+287>:   mov    ecx,0x6
   0x08048688 <+292>:   mov    esi,edx
   0x0804868a <+294>:   mov    edi,eax
   0x0804868c <+296>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x0804868e <+298>:   seta   dl
   0x08048691 <+301>:   setb   al
   0x08048694 <+304>:   mov    ecx,edx
   0x08048696 <+306>:   sub    cl,al
   0x08048698 <+308>:   mov    eax,ecx
   0x0804869a <+310>:   movsx  eax,al
   0x0804869d <+313>:   test   eax,eax
   0x0804869f <+315>:   jne    0x80486b5 <main+337>
   0x080486a1 <+317>:   lea    eax,[esp+0x20]
   0x080486a5 <+321>:   add    eax,0x7
   0x080486a8 <+324>:   mov    DWORD PTR [esp],eax
   0x080486ab <+327>:   call   0x8048430 <strdup@plt>
   0x080486b0 <+332>:   mov    ds:0x8049ab0,eax
   0x080486b5 <+337>:   lea    eax,[esp+0x20]
   0x080486b9 <+341>:   mov    edx,eax
   0x080486bb <+343>:   mov    eax,0x804882d
   0x080486c0 <+348>:   mov    ecx,0x5
   0x080486c5 <+353>:   mov    esi,edx
   0x080486c7 <+355>:   mov    edi,eax
   0x080486c9 <+357>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x080486cb <+359>:   seta   dl
   0x080486ce <+362>:   setb   al
   0x080486d1 <+365>:   mov    ecx,edx
   0x080486d3 <+367>:   sub    cl,al
   0x080486d5 <+369>:   mov    eax,ecx
   0x080486d7 <+371>:   movsx  eax,al
   0x080486da <+374>:   test   eax,eax
   0x080486dc <+376>:   jne    0x8048574 <main+16>
   0x080486e2 <+382>:   mov    eax,ds:0x8049aac
   0x080486e7 <+387>:   mov    eax,DWORD PTR [eax+0x20]
   0x080486ea <+390>:   test   eax,eax
   0x080486ec <+392>:   je     0x80486ff <main+411>
   0x080486ee <+394>:   mov    DWORD PTR [esp],0x8048833
   0x080486f5 <+401>:   call   0x8048480 <system@plt>
   0x080486fa <+406>:   jmp    0x8048574 <main+16>
   0x080486ff <+411>:   mov    eax,ds:0x8049aa0
   0x08048704 <+416>:   mov    edx,eax
   0x08048706 <+418>:   mov    eax,0x804883b
   0x0804870b <+423>:   mov    DWORD PTR [esp+0xc],edx
   0x0804870f <+427>:   mov    DWORD PTR [esp+0x8],0xa
   0x08048717 <+435>:   mov    DWORD PTR [esp+0x4],0x1
   0x0804871f <+443>:   mov    DWORD PTR [esp],eax
   0x08048722 <+446>:   call   0x8048450 <fwrite@plt>
   0x08048727 <+451>:   jmp    0x8048574 <main+16>
   0x0804872c <+456>:   nop
   0x0804872d <+457>:   mov    eax,0x0
   0x08048732 <+462>:   lea    esp,[ebp-0x8]
   0x08048735 <+465>:   pop    esi
   0x08048736 <+466>:   pop    edi
   0x08048737 <+467>:   pop    ebp
   0x08048738 <+468>:   ret
End of assembler dump.
```

## Explanations
```
   0x08048564 <+0>:     push   ebp
   0x08048565 <+1>:     mov    ebp,esp
   0x08048567 <+3>:     push   edi
   0x08048568 <+4>:     push   esi
   0x08048569 <+5>:     and    esp,0xfffffff0
   0x0804856c <+8>:     sub    esp,0xa0
   0x08048572 <+14>:    jmp    0x8048575 <main+17>
   0x08048574 <+16>:    nop
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> - <+4> : Save the old values of `edi` and `esi`.  
<+5> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+8> : 160 bytes are allocated to the main function for its local variables.  
<+14> : Inconditionnal jump to the address `0x8048575` (main+17).  
<+16> : Performs no operation. This instruction is a one-byte instruction that takes up space in the instruction stream but does not affect the machine context, except the EIP register. This is the start of our infinity loop (see main+451).
```
   0x08048575 <+17>:    mov    ecx,DWORD PTR ds:0x8049ab0
   0x0804857b <+23>:    mov    edx,DWORD PTR ds:0x8049aac
   0x08048581 <+29>:    mov    eax,0x8048810
   0x08048586 <+34>:    mov    DWORD PTR [esp+0x8],ecx
   0x0804858a <+38>:    mov    DWORD PTR [esp+0x4],edx
   0x0804858e <+42>:    mov    DWORD PTR [esp],eax
   0x08048591 <+45>:    call   0x8048410 <printf@plt>
```
<+17> - <+42> : Set arguments for `printf()` function. `esp = "%p, %p\n"`, `esp+4 = auth` and `esp+8 = service` where auth and service are global variables.  
<+45> : Call to `printf()` (printf(`esp`, `esp+4`, `esp+8`)).
```
   0x08048596 <+50>:    mov    eax,ds:0x8049a80
   0x0804859b <+55>:    mov    DWORD PTR [esp+0x8],eax
   0x0804859f <+59>:    mov    DWORD PTR [esp+0x4],0x80
   0x080485a7 <+67>:    lea    eax,[esp+0x20]
   0x080485ab <+71>:    mov    DWORD PTR [esp],eax
   0x080485ae <+74>:    call   0x8048440 <fgets@plt>
   0x080485b3 <+79>:    test   eax,eax
   0x080485b5 <+81>:    je     0x804872c <main+456>
```
<+50> : 'ds:[0x8049a80]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x8049a80]' to register `eax` (eax = stdin).  
<+67> : Load the effective address `esp+0x20` in `eax`, so `eax` is now pointing on `esp+0x20` (perfect, fgets() function need a pointer as argument).  
<+50> - <+71> : Set arguments for `printf()` function.  
<+74> : Call to `fgets()` function with values at addresses of `esp`, `esp+4` and `esp+8` as argument (fgets(`eax`, 128, stdin)).  
<+79> - <+81> : Then if the `fgets()` return is equal to 0, jump to `0x804872c` (main+456). Because `fgets()` return a pointer, it is like if we check the function return to NULL.  
*The instruction `test eax,eax` is equivalent to `cmp eax,0`*  
```
   0x080485bb <+87>:    lea    eax,[esp+0x20]
   0x080485bf <+91>:    mov    edx,eax
   0x080485c1 <+93>:    mov    eax,0x8048819
   0x080485c6 <+98>:    mov    ecx,0x5
   0x080485cb <+103>:   mov    esi,edx
   0x080485cd <+105>:   mov    edi,eax
   0x080485cf <+107>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x080485d1 <+109>:   seta   dl
   0x080485d4 <+112>:   setb   al
   0x080485d7 <+115>:   mov    ecx,edx
   0x080485d9 <+117>:   sub    cl,al
   0x080485db <+119>:   mov    eax,ecx
   0x080485dd <+121>:   movsx  eax,al
   0x080485e0 <+124>:   test   eax,eax
   0x080485e2 <+126>:   jne    0x8048642 <main+222>
```
*The [cmps](https://c9x.me/x86/html/file_module_x86_id_38.html) instruction compares `esi` to `edi` by substracting them (as a `sub dest, src`) and sets the status flags CF (Carry Flag) and ZF (Zero Flag) in the [EFLAGS](http://www.c-jump.com/CIS77/ASM/Instructions/I77_0070_eflags_bits.htm) register according to the results.*  
*The `repz` prefix means to increment `esi` and `edi` then repeat cmps until `ecx` or ZF flag is not equal to 0*  

<+87> - <+107> : The `repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]` instruction compare the N first byte of the two strings into ds:[esi] and es:[edi], where N is the value of `ecx`. It is similar to `strncmp()` function in C (strncmp(buffer, "auth ", 5)).  
*nb : The rest of the program depends on the values of CF and ZF, here are the different possible combinations depending on `cmps` instruction :*  
```
cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]         ZF     CF
-----------------------------------------------------------
BYTE PTR ds:[esi] = BYTE PTR es:[edi]            1       0

BYTE PTR ds:[esi] < BYTE PTR es:[edi]            0       1 

BYTE PTR ds:[esi] > BYTE PTR es:[edi]            0       0 
```
*During the rest of the code, we'll suppose that the two strings into ds:[esi] and es:[edi] was equal.*  
<+109> : Set `dl` to 1 if CF=0 and ZF=0, otherwise 0  
*`dl` is a sub register, [click here](https://www.gladir.com/CODER/ASM8086/registre.htm) if you need more informations. You may also need some documentation about [movsx](https://www.gladir.com/LEXIQUE/ASM/movsx.htm) instruction!*
```
1. edx = 0xbffff6b0 =  1011111111111111   11110110   10110000
                      |________________| |________| |________|
                          dh: 0xbfff      dh: 0xf6   dl: 0xb0
2. dl = 0b00000000
3. edx = 0xbffff600 =  1011111111111111   11110110   00000000
                      |________________| |________| |________|
                          dh: 0xbfff      dh: 0xf6   dl: 0x00
```
<+112> : Set `al` to 1 if CF=1, othewise 0
```
1. eax = 0x08048819 =  0000100000000100   10001000   00011001
                      |________________| |________| |________|
                          dh: 0x0804      dh: 0x88   dl: 0x19
2. al = 0b00000000
3. eax = 0x08048800 =  0000100000000100   10001000   00000000
                      |________________| |________| |________|
                          dh: 0x0804      dh: 0x88   dl: 0x00
```
=> `dl` or `al` will be set to 1 if "strncmp" didn't return 0 (I know it's not a real strncmp but this way is easier to understand).  
<+115> : Save the value at `edx` in `ecx` (`0xbffff600`).  
<+117> : `cl` = `cl` - `al` (this change nothing only if "strncmp" return 0).  
<+119> : Save the value at `ecx` in `eax` (`0xbffff600`).  
<+121> : Copies the contents of the 8-bit register (`al`) to the 32-bit register (`eax`) with a sign extension.
```
                            +-------------+
al:                         |  0 0000000  |   8 bits
                            +-/-----------+
                             /      |
                            /       |
                           /        |
eax:  000000000000000000000000 00000000       32 bits
          sign extension         copy
```
<+124> - <+126> : If `eax` is not equal to 0 jump at `0x8048642` (main+222).  
*With all these informations, we can deduce that we do an equivalent of `if (strncmp(buffer, "auth ", 5) != 0)` in C.
```
   0x080485e4 <+128>:   mov    DWORD PTR [esp],0x4
   0x080485eb <+135>:   call   0x8048470 <malloc@plt>
   0x080485f0 <+140>:   mov    ds:0x8049aac,eax
   0x080485f5 <+145>:   mov    eax,ds:0x8049aac
   0x080485fa <+150>:   mov    DWORD PTR [eax],0x0
   0x08048600 <+156>:   lea    eax,[esp+0x20]
   0x08048604 <+160>:   add    eax,0x5
   0x08048607 <+163>:   mov    DWORD PTR [esp+0x1c],0xffffffff
   0x0804860f <+171>:   mov    edx,eax
   0x08048611 <+173>:   mov    eax,0x0
   0x08048616 <+178>:   mov    ecx,DWORD PTR [esp+0x1c]
   0x0804861a <+182>:   mov    edi,edx
   0x0804861c <+184>:   repnz scas al,BYTE PTR es:[edi]
   0x0804861e <+186>:   mov    eax,ecx
   0x08048620 <+188>:   not    eax
   0x08048622 <+190>:   sub    eax,0x1
   0x08048625 <+193>:   cmp    eax,0x1e
   0x08048628 <+196>:   ja     0x8048642 <main+222>
   0x0804862a <+198>:   lea    eax,[esp+0x20]
   0x0804862e <+202>:   lea    edx,[eax+0x5]
   0x08048631 <+205>:   mov    eax,ds:0x8049aac
   0x08048636 <+210>:   mov    DWORD PTR [esp+0x4],edx
   0x0804863a <+214>:   mov    DWORD PTR [esp],eax
   0x0804863d <+217>:   call   0x8048460 <strcpy@plt>
```
<+128> - <+145> : Call to `malloc(4)` for the global variable `auth` (auth = malloc(4)).  
<+150> : Set the value pointed by `eax` as 0x0 (auth[0] = 0).  
<+156> : `eax` is now pointing at [esp+0x20] (eax = buffer).  
<+160> : `eax` is now pointing at [esp+0x20] + 5 (eax = buffer + 5).  
<+163> : Set the value at address `esp+0x1c` to 0xffffffff (-1).  
<+171> - <+178> : Save `eax` in `edx`, set `eax` to 0x0 then store the value at address `esp+0x1c` in `ecx` (ecx = -1).  
<+182> : Store the value at `edx` in `edi` (edi is now pointing on buffer + 5).  
```
0x0804861c in main ()
(gdb) info registers
eax            0x0      0
ecx            0xffffffff       -1
edx            0xbffff6b5       -1073744203
                   .
                   .
                   .
edi            0xbffff6b5       -1073744203
eip            0x804861c        0x804861c <main+184>
```
<+184> - <+188> : [repnz scasb](https://stackoverflow.com/questions/26783797/repnz-scas-assembly-instruction-specifics) is an equivalent of `strlen()` function in C. In our case, it is like do `strlen(buffer + 5)` in C.  
<+190> - <+196> : JA instruction. If above, jump to `0x8048642` (main+222). In pseudo C it is like if we wrote `if (strlen(buffer + 5) > 30)`.  
<+198> - <+217> : Call to `strcpy()` with values at addresses `esp` and `esp+4` as arguments (strcpy(auth, buffer + 5)).
```
   0x08048642 <+222>:   lea    eax,[esp+0x20]
   0x08048646 <+226>:   mov    edx,eax
   0x08048648 <+228>:   mov    eax,0x804881f
   0x0804864d <+233>:   mov    ecx,0x5
   0x08048652 <+238>:   mov    esi,edx
   0x08048654 <+240>:   mov    edi,eax
   0x08048656 <+242>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x08048658 <+244>:   seta   dl
   0x0804865b <+247>:   setb   al
   0x0804865e <+250>:   mov    ecx,edx
   0x08048660 <+252>:   sub    cl,al
   0x08048662 <+254>:   mov    eax,ecx
   0x08048664 <+256>:   movsx  eax,al
   0x08048667 <+259>:   test   eax,eax
   0x08048669 <+261>:   jne    0x8048678 <main+276>
```
<+222> - <+261> : Same as lines 128-217, we'll do a check on an equivalent of `strncmp()` function with `edx` as 1st arg, `eax` as 2nd and `ecx` as third.  
`if (strncmp(buffer, "reset", 5) != 0)`
```
   0x0804866b <+263>:   mov    eax,ds:0x8049aac
   0x08048670 <+268>:   mov    DWORD PTR [esp],eax
   0x08048673 <+271>:   call   0x8048420 <free@plt>
```
<+263> - <+271> : Call to `free()` function with value at the address of `esp` as argument (free(auth)).
```
   0x08048678 <+276>:   lea    eax,[esp+0x20]
   0x0804867c <+280>:   mov    edx,eax
   0x0804867e <+282>:   mov    eax,0x8048825
   0x08048683 <+287>:   mov    ecx,0x6
   0x08048688 <+292>:   mov    esi,edx
   0x0804868a <+294>:   mov    edi,eax
   0x0804868c <+296>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x0804868e <+298>:   seta   dl
   0x08048691 <+301>:   setb   al
   0x08048694 <+304>:   mov    ecx,edx
   0x08048696 <+306>:   sub    cl,al
   0x08048698 <+308>:   mov    eax,ecx
   0x0804869a <+310>:   movsx  eax,al
   0x0804869d <+313>:   test   eax,eax
   0x0804869f <+315>:   jne    0x80486b5 <main+337>
```
<+276> - <+315> : Same as lines 128-217 or 222-261, we'll do a check on an equivalent of `strncmp()` function with `edx` as 1st arg, `eax` as 2nd and `ecx` as third.  
`if (strncmp(buffer, "service", 6) != 0)`
```
   0x080486a1 <+317>:   lea    eax,[esp+0x20]
   0x080486a5 <+321>:   add    eax,0x7
   0x080486a8 <+324>:   mov    DWORD PTR [esp],eax
   0x080486ab <+327>:   call   0x8048430 <strdup@plt>
   0x080486b0 <+332>:   mov    ds:0x8049ab0,eax
```
<+317> - <+332> : Call to `strdup()` with value at the address of `esp` as arguments (strdup(buffer + 7)). Then store the value of the `strdup()` return at the global variable service `ds:0x8049ab0` (service = strdup(buffer + 7)).
```
   0x080486b5 <+337>:   lea    eax,[esp+0x20]
   0x080486b9 <+341>:   mov    edx,eax
   0x080486bb <+343>:   mov    eax,0x804882d
   0x080486c0 <+348>:   mov    ecx,0x5
   0x080486c5 <+353>:   mov    esi,edx
   0x080486c7 <+355>:   mov    edi,eax
   0x080486c9 <+357>:   repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
   0x080486cb <+359>:   seta   dl
   0x080486ce <+362>:   setb   al
   0x080486d1 <+365>:   mov    ecx,edx
   0x080486d3 <+367>:   sub    cl,al
   0x080486d5 <+369>:   mov    eax,ecx
   0x080486d7 <+371>:   movsx  eax,al
   0x080486da <+374>:   test   eax,eax
   0x080486dc <+376>:   jne    0x8048574 <main+16>
```
<+337> - <+376> : Same as lines 128-217 or 222-261 or even 276-315, we'll do a check on an equivalent of `strncmp()` function with `edx` as 1st arg, `eax` as 2nd and `ecx` as third.  
`if (strncmp(buffer, "login", 5) != 0)`
```
   0x080486e2 <+382>:   mov    eax,ds:0x8049aac
   0x080486e7 <+387>:   mov    eax,DWORD PTR [eax+0x20]
   0x080486ea <+390>:   test   eax,eax
   0x080486ec <+392>:   je     0x80486ff <main+411>
   0x080486ee <+394>:   mov    DWORD PTR [esp],0x8048833
   0x080486f5 <+401>:   call   0x8048480 <system@plt>
   0x080486fa <+406>:   jmp    0x8048574 <main+16>
```
<+382> : 'ds:[0x8049aac]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x8049aac]' to register `eax` (auth).  
<+387> : `eax` is now pointing on `auth + 32`.  
<+390> - <+392> : JE comparaison. If `eax` is equal to 0, then jump to `0x80486ff` (main+411).  
<+394> - <+406> : Call to `system()` function with the value at address of `esp` as argument (system("/bin/sh")). Then inconditionnal jump to `0x8048574` (main+16).
```
   0x080486ff <+411>:   mov    eax,ds:0x8049aa0
   0x08048704 <+416>:   mov    edx,eax
   0x08048706 <+418>:   mov    eax,0x804883b
   0x0804870b <+423>:   mov    DWORD PTR [esp+0xc],edx
   0x0804870f <+427>:   mov    DWORD PTR [esp+0x8],0xa
   0x08048717 <+435>:   mov    DWORD PTR [esp+0x4],0x1
   0x0804871f <+443>:   mov    DWORD PTR [esp],eax
   0x08048722 <+446>:   call   0x8048450 <fwrite@plt>
   0x08048727 <+451>:   jmp    0x8048574 <main+16>
```
<+411> - <+443> : Set arguments for `fwrite()` function.  
<+446> : Call to `fwrite()` with values at addresses from `esp` to `esp+12` as arguments (fwrite("Password:\n", 1, 10, stdout)).
```
   0x0804872c <+456>:   nop
   0x0804872d <+457>:   mov    eax,0x0
   0x08048732 <+462>:   lea    esp,[ebp-0x8]
   0x08048735 <+465>:   pop    esi
   0x08048736 <+466>:   pop    edi
   0x08048737 <+467>:   pop    ebp
   0x08048738 <+468>:   ret
```
<+456> : Performs no operation. This instruction is a one-byte instruction that takes up space in the instruction stream but does not affect the machine context, except the EIP register.  
<+457> : Set `eax` to 0 for the `ret` instruction (return (0)).  
<+462> - <+466> : Give back `esp` value (esp at aligned 16-bytes) then pop `esi` and `edi` to retrieve their old values.  
<+467> : Retrieve the old `ebp`.  
*Instructions `lea esp,[ebp-0x8]` and `pop ebp` combined are very similar to `leave` instruction.*  
<+468> : Retrieve the next instructions after the call of the `main()` function !
