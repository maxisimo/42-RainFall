# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048318  _init
0x08048360  memcmp@plt
0x08048370  strcat@plt
0x08048380  getenv@plt
0x08048390  puts@plt
0x080483a0  __gmon_start__@plt
0x080483b0  __libc_start_main@plt
0x080483c0  strncpy@plt
0x080483d0  _start
0x08048400  __do_global_dtors_aux
0x08048460  frame_dummy
0x08048484  greetuser
0x08048529  main
0x08048640  __libc_csu_init
0x080486b0  __libc_csu_fini
0x080486b2  __i686.get_pc_thunk.bx
0x080486c0  __do_global_ctors_aux
0x080486ec  _fini
```

# main
```
Dump of assembler code for function main:
   0x08048529 <+0>:     push   ebp
   0x0804852a <+1>:     mov    ebp,esp
   0x0804852c <+3>:     push   edi
   0x0804852d <+4>:     push   esi
   0x0804852e <+5>:     push   ebx
   0x0804852f <+6>:     and    esp,0xfffffff0
   0x08048532 <+9>:     sub    esp,0xa0
   0x08048538 <+15>:    cmp    DWORD PTR [ebp+0x8],0x3
   0x0804853c <+19>:    je     0x8048548 <main+31>
   0x0804853e <+21>:    mov    eax,0x1
   0x08048543 <+26>:    jmp    0x8048630 <main+263>
   0x08048548 <+31>:    lea    ebx,[esp+0x50]
   0x0804854c <+35>:    mov    eax,0x0
   0x08048551 <+40>:    mov    edx,0x13
   0x08048556 <+45>:    mov    edi,ebx
   0x08048558 <+47>:    mov    ecx,edx
   0x0804855a <+49>:    rep stos DWORD PTR es:[edi],eax
   0x0804855c <+51>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804855f <+54>:    add    eax,0x4
   0x08048562 <+57>:    mov    eax,DWORD PTR [eax]
   0x08048564 <+59>:    mov    DWORD PTR [esp+0x8],0x28
   0x0804856c <+67>:    mov    DWORD PTR [esp+0x4],eax
   0x08048570 <+71>:    lea    eax,[esp+0x50]
   0x08048574 <+75>:    mov    DWORD PTR [esp],eax
   0x08048577 <+78>:    call   0x80483c0 <strncpy@plt>
   0x0804857c <+83>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804857f <+86>:    add    eax,0x8
   0x08048582 <+89>:    mov    eax,DWORD PTR [eax]
   0x08048584 <+91>:    mov    DWORD PTR [esp+0x8],0x20
   0x0804858c <+99>:    mov    DWORD PTR [esp+0x4],eax
   0x08048590 <+103>:   lea    eax,[esp+0x50]
   0x08048594 <+107>:   add    eax,0x28
   0x08048597 <+110>:   mov    DWORD PTR [esp],eax
   0x0804859a <+113>:   call   0x80483c0 <strncpy@plt>
   0x0804859f <+118>:   mov    DWORD PTR [esp],0x8048738
   0x080485a6 <+125>:   call   0x8048380 <getenv@plt>
   0x080485ab <+130>:   mov    DWORD PTR [esp+0x9c],eax
   0x080485b2 <+137>:   cmp    DWORD PTR [esp+0x9c],0x0
   0x080485ba <+145>:   je     0x8048618 <main+239>
   0x080485bc <+147>:   mov    DWORD PTR [esp+0x8],0x2
   0x080485c4 <+155>:   mov    DWORD PTR [esp+0x4],0x804873d
   0x080485cc <+163>:   mov    eax,DWORD PTR [esp+0x9c]
   0x080485d3 <+170>:   mov    DWORD PTR [esp],eax
   0x080485d6 <+173>:   call   0x8048360 <memcmp@plt>
   0x080485db <+178>:   test   eax,eax
   0x080485dd <+180>:   jne    0x80485eb <main+194>
   0x080485df <+182>:   mov    DWORD PTR ds:0x8049988,0x1
   0x080485e9 <+192>:   jmp    0x8048618 <main+239>
   0x080485eb <+194>:   mov    DWORD PTR [esp+0x8],0x2
   0x080485f3 <+202>:   mov    DWORD PTR [esp+0x4],0x8048740
   0x080485fb <+210>:   mov    eax,DWORD PTR [esp+0x9c]
   0x08048602 <+217>:   mov    DWORD PTR [esp],eax
   0x08048605 <+220>:   call   0x8048360 <memcmp@plt>
   0x0804860a <+225>:   test   eax,eax
   0x0804860c <+227>:   jne    0x8048618 <main+239>
   0x0804860e <+229>:   mov    DWORD PTR ds:0x8049988,0x2
   0x08048618 <+239>:   mov    edx,esp
   0x0804861a <+241>:   lea    ebx,[esp+0x50]
   0x0804861e <+245>:   mov    eax,0x13
   0x08048623 <+250>:   mov    edi,edx
   0x08048625 <+252>:   mov    esi,ebx
   0x08048627 <+254>:   mov    ecx,eax
   0x08048629 <+256>:   rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
   0x0804862b <+258>:   call   0x8048484 <greetuser>
   0x08048630 <+263>:   lea    esp,[ebp-0xc]
   0x08048633 <+266>:   pop    ebx
   0x08048634 <+267>:   pop    esi
   0x08048635 <+268>:   pop    edi
   0x08048636 <+269>:   pop    ebp
   0x08048637 <+270>:   ret    
End of assembler dump.
```
## Explanations
```
   0x08048529 <+0>:     push   ebp
   0x0804852a <+1>:     mov    ebp,esp
   0x0804852c <+3>:     push   edi
   0x0804852d <+4>:     push   esi
   0x0804852e <+5>:     push   ebx
   0x0804852f <+6>:     and    esp,0xfffffff0
   0x08048532 <+9>:     sub    esp,0xa0
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> - <+5> : Save some registers (as `edi` and `esi` are pushed we'll probably have loop later in the code).  
<+6> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+9> : 64 bytes are allocated to the main function for its local variables.
```
   0x08048538 <+15>:    cmp    DWORD PTR [ebp+0x8],0x3
   0x0804853c <+19>:    je     0x8048548 <main+31>
   0x0804853e <+21>:    mov    eax,0x1
   0x08048543 <+26>:    jmp    0x8048630 <main+263>
```
<+15> - <+26> : Cmp the value of argc with 0x3. If it's not equal, store 0x1 in `eax` then jump to main+263 (return (1)). Otherwise continue.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*
```
   0x08048548 <+31>:    lea    ebx,[esp+0x50]
   0x0804854c <+35>:    mov    eax,0x0
   0x08048551 <+40>:    mov    edx,0x13
   0x08048556 <+45>:    mov    edi,ebx
   0x08048558 <+47>:    mov    ecx,edx
   0x0804855a <+49>:    rep stos DWORD PTR es:[edi],eax
```
<+31> - <+49> : For `ecx` repetitions, stores the contents of `eax` into where `edi` points to, incrementing or decrementing `edi` (depending on the direction flag) by 4 bytes each time. Each iteration, `ecx` is decremented by 1, and the loop stops when it reaches zero. This is a kind of memset on the buffer start at address `esp+0x50`.  (memset(buffer, 0, 76)) //0x13 = 19; 19*4 = 76.
```
   0x0804855c <+51>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804855f <+54>:    add    eax,0x4
   0x08048562 <+57>:    mov    eax,DWORD PTR [eax]
   0x08048564 <+59>:    mov    DWORD PTR [esp+0x8],0x28
   0x0804856c <+67>:    mov    DWORD PTR [esp+0x4],eax
   0x08048570 <+71>:    lea    eax,[esp+0x50]
   0x08048574 <+75>:    mov    DWORD PTR [esp],eax
   0x08048577 <+78>:    call   0x80483c0 <strncpy@plt>
   0x0804857c <+83>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804857f <+86>:    add    eax,0x8
   0x08048582 <+89>:    mov    eax,DWORD PTR [eax]
   0x08048584 <+91>:    mov    DWORD PTR [esp+0x8],0x20
   0x0804858c <+99>:    mov    DWORD PTR [esp+0x4],eax
   0x08048590 <+103>:   lea    eax,[esp+0x50]
   0x08048594 <+107>:   add    eax,0x28
   0x08048597 <+110>:   mov    DWORD PTR [esp],eax
   0x0804859a <+113>:   call   0x80483c0 <strncpy@plt>
```
<+51> - <+76> : Call to `strncpy()` on the first 40 bytes [0:39] of our buffer.  
*strncpy(buffer, argv[1], 40)*  
<+83> - <+113> : Second call to `strncpy()` on 32 bytes [40:72] of our buffer.  
*strncpy(&buffer[40], argv[2], 32)*
```
   0x0804859f <+118>:   mov    DWORD PTR [esp],0x8048738
   0x080485a6 <+125>:   call   0x8048380 <getenv@plt>
   0x080485ab <+130>:   mov    DWORD PTR [esp+0x9c],eax
   0x080485b2 <+137>:   cmp    DWORD PTR [esp+0x9c],0x0
   0x080485ba <+145>:   je     0x8048618 <main+239>
```
<+118> - <+125> : Call to `getenv()` on "LANG".  
<+130> - <+145> : If the `getenv()` return is equal to 0, jump to main+239.
```
   0x080485bc <+147>:   mov    DWORD PTR [esp+0x8],0x2
   0x080485c4 <+155>:   mov    DWORD PTR [esp+0x4],0x804873d
   0x080485cc <+163>:   mov    eax,DWORD PTR [esp+0x9c]
   0x080485d3 <+170>:   mov    DWORD PTR [esp],eax
   0x080485d6 <+173>:   call   0x8048360 <memcmp@plt>
   0x080485db <+178>:   test   eax,eax
   0x080485dd <+180>:   jne    0x80485eb <main+194>
   0x080485df <+182>:   mov    DWORD PTR ds:0x8049988,0x1
   0x080485e9 <+192>:   jmp    0x8048618 <main+239>
```
<+147> - <+192> : First call to `memcmp()`. If the return function is equal to 0, set the global variable lang to 1 then jump to main+239. Otherwise, jump to main+194 (the other memcmp()).  
*if (memcmp(env, "fi", 2) == 0) {lang = 1;}*
```
   0x080485eb <+194>:   mov    DWORD PTR [esp+0x8],0x2
   0x080485f3 <+202>:   mov    DWORD PTR [esp+0x4],0x8048740
   0x080485fb <+210>:   mov    eax,DWORD PTR [esp+0x9c]
   0x08048602 <+217>:   mov    DWORD PTR [esp],eax
   0x08048605 <+220>:   call   0x8048360 <memcmp@plt>
   0x0804860a <+225>:   test   eax,eax
   0x0804860c <+227>:   jne    0x8048618 <main+239>
   0x0804860e <+229>:   mov    DWORD PTR ds:0x8049988,0x2
```
<+194> - <+227> : Second call to `memcmp()`. If the return function is equal to 0, set the global variable lang to 2. Otherwise, jump to main+239.  
*if (memcmp(env, "nl", 2) == 0) {lang = 2;}*
```
   0x08048618 <+239>:   mov    edx,esp
   0x0804861a <+241>:   lea    ebx,[esp+0x50]
   0x0804861e <+245>:   mov    eax,0x13
   0x08048623 <+250>:   mov    edi,edx
   0x08048625 <+252>:   mov    esi,ebx
   0x08048627 <+254>:   mov    ecx,eax
   0x08048629 <+256>:   rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi]
   0x0804862b <+258>:   call   0x8048484 <greetuser>
```
<+239> - <+256> : Move every dword of `esi` in `edi`. In other words, the buffer is copied to `esp`.  
<+258> : Then we call `greetuser()` with value at address of `esp` as argument.  
*greetuser(buffer)*
```
   0x08048630 <+263>:   lea    esp,[ebp-0xc]
   0x08048633 <+266>:   pop    ebx
   0x08048634 <+267>:   pop    esi
   0x08048635 <+268>:   pop    edi
   0x08048636 <+269>:   pop    ebp
   0x08048637 <+270>:   ret  
```
<+263> - <+270> : Retrieved old registers and quit the `main()`.  

# greetuser
```
Dump of assembler code for function greetuser:
   0x08048484 <+0>:     push   ebp
   0x08048485 <+1>:     mov    ebp,esp
   0x08048487 <+3>:     sub    esp,0x58
   0x0804848a <+6>:     mov    eax,ds:0x8049988
   0x0804848f <+11>:    cmp    eax,0x1
   0x08048492 <+14>:    je     0x80484ba <greetuser+54>
   0x08048494 <+16>:    cmp    eax,0x2
   0x08048497 <+19>:    je     0x80484e9 <greetuser+101>
   0x08048499 <+21>:    test   eax,eax
   0x0804849b <+23>:    jne    0x804850a <greetuser+134>
   0x0804849d <+25>:    mov    edx,0x8048710
   0x080484a2 <+30>:    lea    eax,[ebp-0x48]
   0x080484a5 <+33>:    mov    ecx,DWORD PTR [edx]
   0x080484a7 <+35>:    mov    DWORD PTR [eax],ecx
   0x080484a9 <+37>:    movzx  ecx,WORD PTR [edx+0x4]
   0x080484ad <+41>:    mov    WORD PTR [eax+0x4],cx
   0x080484b1 <+45>:    movzx  edx,BYTE PTR [edx+0x6]
   0x080484b5 <+49>:    mov    BYTE PTR [eax+0x6],dl
   0x080484b8 <+52>:    jmp    0x804850a <greetuser+134>
   0x080484ba <+54>:    mov    edx,0x8048717
   0x080484bf <+59>:    lea    eax,[ebp-0x48]
   0x080484c2 <+62>:    mov    ecx,DWORD PTR [edx]
   0x080484c4 <+64>:    mov    DWORD PTR [eax],ecx
   0x080484c6 <+66>:    mov    ecx,DWORD PTR [edx+0x4]
   0x080484c9 <+69>:    mov    DWORD PTR [eax+0x4],ecx
   0x080484cc <+72>:    mov    ecx,DWORD PTR [edx+0x8]
   0x080484cf <+75>:    mov    DWORD PTR [eax+0x8],ecx
   0x080484d2 <+78>:    mov    ecx,DWORD PTR [edx+0xc]
   0x080484d5 <+81>:    mov    DWORD PTR [eax+0xc],ecx
   0x080484d8 <+84>:    movzx  ecx,WORD PTR [edx+0x10]
   0x080484dc <+88>:    mov    WORD PTR [eax+0x10],cx
   0x080484e0 <+92>:    movzx  edx,BYTE PTR [edx+0x12]
   0x080484e4 <+96>:    mov    BYTE PTR [eax+0x12],dl
   0x080484e7 <+99>:    jmp    0x804850a <greetuser+134>
   0x080484e9 <+101>:   mov    edx,0x804872a
   0x080484ee <+106>:   lea    eax,[ebp-0x48]
   0x080484f1 <+109>:   mov    ecx,DWORD PTR [edx]
   0x080484f3 <+111>:   mov    DWORD PTR [eax],ecx
   0x080484f5 <+113>:   mov    ecx,DWORD PTR [edx+0x4]
   0x080484f8 <+116>:   mov    DWORD PTR [eax+0x4],ecx
   0x080484fb <+119>:   mov    ecx,DWORD PTR [edx+0x8]
   0x080484fe <+122>:   mov    DWORD PTR [eax+0x8],ecx
   0x08048501 <+125>:   movzx  edx,WORD PTR [edx+0xc]
   0x08048505 <+129>:   mov    WORD PTR [eax+0xc],dx
   0x08048509 <+133>:   nop
   0x0804850a <+134>:   lea    eax,[ebp+0x8]
   0x0804850d <+137>:   mov    DWORD PTR [esp+0x4],eax
   0x08048511 <+141>:   lea    eax,[ebp-0x48]
   0x08048514 <+144>:   mov    DWORD PTR [esp],eax
   0x08048517 <+147>:   call   0x8048370 <strcat@plt>
   0x0804851c <+152>:   lea    eax,[ebp-0x48]
   0x0804851f <+155>:   mov    DWORD PTR [esp],eax
   0x08048522 <+158>:   call   0x8048390 <puts@plt>
   0x08048527 <+163>:   leave
   0x08048528 <+164>:   ret
End of assembler dump.
```
## Explanations
```
   0x08048484 <+0>:     push   ebp
   0x08048485 <+1>:     mov    ebp,esp
   0x08048487 <+3>:     sub    esp,0x58
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> : 88 bytes are allocated to the greetuser function for its local variables.
```
   0x0804848a <+6>:     mov    eax,ds:0x8049988
   0x0804848f <+11>:    cmp    eax,0x1
   0x08048492 <+14>:    je     0x80484ba <greetuser+54>
   0x08048494 <+16>:    cmp    eax,0x2
   0x08048497 <+19>:    je     0x80484e9 <greetuser+101>
   0x08048499 <+21>:    test   eax,eax
   0x0804849b <+23>:    jne    0x804850a <greetuser+134>
```
<+6> - <+23> : First we store the value of our global variable g_lang in `eax`. Then, there is a serie of `cmp` :
- if g_lang == 1 jump to greetuser+54
- if g_lang == 2 jump to greetuser+101
- if g_lang != 0 jump to greetuser+134
```
   0x0804849d <+25>:    mov    edx,0x8048710
   0x080484a2 <+30>:    lea    eax,[ebp-0x48]
   0x080484a5 <+33>:    mov    ecx,DWORD PTR [edx]
   0x080484a7 <+35>:    mov    DWORD PTR [eax],ecx
   0x080484a9 <+37>:    movzx  ecx,WORD PTR [edx+0x4]
   0x080484ad <+41>:    mov    WORD PTR [eax+0x4],cx
   0x080484b1 <+45>:    movzx  edx,BYTE PTR [edx+0x6]
   0x080484b5 <+49>:    mov    BYTE PTR [eax+0x6],dl
   0x080484b8 <+52>:    jmp    0x804850a <greetuser+134>
```
<+25> - <+52> : Store `0x8048710` ("Hello ") on `edx` and copy it at address `ebp-0x48` (buffer) by moving byte per byte in `eax` with `ecx` as a tmp register. This is an equivalent of `strcpy()` in C.  
*strcpy(buffer, "Hello ");*
```
   0x080484ba <+54>:    mov    edx,0x8048717
   0x080484bf <+59>:    lea    eax,[ebp-0x48]
   0x080484c2 <+62>:    mov    ecx,DWORD PTR [edx]
   0x080484c4 <+64>:    mov    DWORD PTR [eax],ecx
   0x080484c6 <+66>:    mov    ecx,DWORD PTR [edx+0x4]
   0x080484c9 <+69>:    mov    DWORD PTR [eax+0x4],ecx
   0x080484cc <+72>:    mov    ecx,DWORD PTR [edx+0x8]
   0x080484cf <+75>:    mov    DWORD PTR [eax+0x8],ecx
   0x080484d2 <+78>:    mov    ecx,DWORD PTR [edx+0xc]
   0x080484d5 <+81>:    mov    DWORD PTR [eax+0xc],ecx
   0x080484d8 <+84>:    movzx  ecx,WORD PTR [edx+0x10]
   0x080484dc <+88>:    mov    WORD PTR [eax+0x10],cx
   0x080484e0 <+92>:    movzx  edx,BYTE PTR [edx+0x12]
   0x080484e4 <+96>:    mov    BYTE PTR [eax+0x12],dl
   0x080484e7 <+99>:    jmp    0x804850a <greetuser+134>
```
<+54> - <+99> : Store `0x8048717` ("Hyvää päivää ") on `edx` and copy it at address `ebp-0x48` (buffer) by moving byte per byte in `eax` with `ecx` as a tmp register. This is an equivalent of `strcpy()` in C.  
*strcpy(buffer, "Hyvää päivää ");*
```
   0x080484e9 <+101>:   mov    edx,0x804872a
   0x080484ee <+106>:   lea    eax,[ebp-0x48]
   0x080484f1 <+109>:   mov    ecx,DWORD PTR [edx]
   0x080484f3 <+111>:   mov    DWORD PTR [eax],ecx
   0x080484f5 <+113>:   mov    ecx,DWORD PTR [edx+0x4]
   0x080484f8 <+116>:   mov    DWORD PTR [eax+0x4],ecx
   0x080484fb <+119>:   mov    ecx,DWORD PTR [edx+0x8]
   0x080484fe <+122>:   mov    DWORD PTR [eax+0x8],ecx
   0x08048501 <+125>:   movzx  edx,WORD PTR [edx+0xc]
   0x08048505 <+129>:   mov    WORD PTR [eax+0xc],dx
```
<+101> - <+129> : Store `0x804872a` ("Goedemiddag! ") on `edx` and copy it at address `ebp-0x48` (buffer) by moving byte per byte in `eax` with `ecx` as a tmp register. This is an equivalent of `strcpy()` in C.  
*strcpy(buffer, "Goedemiddag! ");*
```
   0x08048509 <+133>:   nop
   0x0804850a <+134>:   lea    eax,[ebp+0x8]
   0x0804850d <+137>:   mov    DWORD PTR [esp+0x4],eax
   0x08048511 <+141>:   lea    eax,[ebp-0x48]
   0x08048514 <+144>:   mov    DWORD PTR [esp],eax
   0x08048517 <+147>:   call   0x8048370 <strcat@plt>
```
<+133> : Performs no operation. This instruction is a one-byte instruction that takes up space in the instruction stream but does not affect the machine context, except the EIP register.  
<+134> - <+147> : Call to `strcat()` with value at addresses `esp` and `esp+4` as arguments.  
*strcat(buffer, user); with 'user' the arg of the greetuser function*
```
   0x0804851c <+152>:   lea    eax,[ebp-0x48]
   0x0804851f <+155>:   mov    DWORD PTR [esp],eax
   0x08048522 <+158>:   call   0x8048390 <puts@plt>
```
<+152> - <+158> : Call to `puts()` with value at the address of `esp` as argument.  
*puts(buffer);*
```
   0x08048527 <+163>:   leave
   0x08048528 <+164>:   ret
```
<+163> - <+164> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `greetuser()` function.
