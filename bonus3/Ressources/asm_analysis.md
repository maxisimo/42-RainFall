# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x0804836c  _init
0x080483b0  strcmp@plt
0x080483c0  fclose@plt
0x080483d0  fread@plt
0x080483e0  puts@plt
0x080483f0  __gmon_start__@plt
0x08048400  __libc_start_main@plt
0x08048410  fopen@plt
0x08048420  execl@plt
0x08048430  atoi@plt
0x08048440  _start
0x08048470  __do_global_dtors_aux
0x080484d0  frame_dummy
0x080484f4  main
0x08048620  __libc_csu_init
0x08048690  __libc_csu_fini
0x08048692  __i686.get_pc_thunk.bx
0x080486a0  __do_global_ctors_aux
0x080486cc  _fini
```

# main
```
Dump of assembler code for function main:
   0x080484f4 <+0>:     push   ebp
   0x080484f5 <+1>:     mov    ebp,esp
   0x080484f7 <+3>:     push   edi
   0x080484f8 <+4>:     push   ebx
   0x080484f9 <+5>:     and    esp,0xfffffff0
   0x080484fc <+8>:     sub    esp,0xa0
   0x08048502 <+14>:    mov    edx,0x80486f0
   0x08048507 <+19>:    mov    eax,0x80486f2
   0x0804850c <+24>:    mov    DWORD PTR [esp+0x4],edx
   0x08048510 <+28>:    mov    DWORD PTR [esp],eax
   0x08048513 <+31>:    call   0x8048410 <fopen@plt>
   0x08048518 <+36>:    mov    DWORD PTR [esp+0x9c],eax
   0x0804851f <+43>:    lea    ebx,[esp+0x18]
   0x08048523 <+47>:    mov    eax,0x0
   0x08048528 <+52>:    mov    edx,0x21
   0x0804852d <+57>:    mov    edi,ebx
   0x0804852f <+59>:    mov    ecx,edx
   0x08048531 <+61>:    rep stos DWORD PTR es:[edi],eax
   0x08048533 <+63>:    cmp    DWORD PTR [esp+0x9c],0x0
   0x0804853b <+71>:    je     0x8048543 <main+79>
   0x0804853d <+73>:    cmp    DWORD PTR [ebp+0x8],0x2
   0x08048541 <+77>:    je     0x804854d <main+89>
   0x08048543 <+79>:    mov    eax,0xffffffff
   0x08048548 <+84>:    jmp    0x8048615 <main+289>
   0x0804854d <+89>:    lea    eax,[esp+0x18]
   0x08048551 <+93>:    mov    edx,DWORD PTR [esp+0x9c]
   0x08048558 <+100>:   mov    DWORD PTR [esp+0xc],edx
   0x0804855c <+104>:   mov    DWORD PTR [esp+0x8],0x42
   0x08048564 <+112>:   mov    DWORD PTR [esp+0x4],0x1
   0x0804856c <+120>:   mov    DWORD PTR [esp],eax
   0x0804856f <+123>:   call   0x80483d0 <fread@plt>
   0x08048574 <+128>:   mov    BYTE PTR [esp+0x59],0x0
   0x08048579 <+133>:   mov    eax,DWORD PTR [ebp+0xc]
   0x0804857c <+136>:   add    eax,0x4
   0x0804857f <+139>:   mov    eax,DWORD PTR [eax]
   0x08048581 <+141>:   mov    DWORD PTR [esp],eax
   0x08048584 <+144>:   call   0x8048430 <atoi@plt>
   0x08048589 <+149>:   mov    BYTE PTR [esp+eax*1+0x18],0x0
   0x0804858e <+154>:   lea    eax,[esp+0x18]
   0x08048592 <+158>:   lea    edx,[eax+0x42]
   0x08048595 <+161>:   mov    eax,DWORD PTR [esp+0x9c]
   0x0804859c <+168>:   mov    DWORD PTR [esp+0xc],eax
   0x080485a0 <+172>:   mov    DWORD PTR [esp+0x8],0x41
   0x080485a8 <+180>:   mov    DWORD PTR [esp+0x4],0x1
   0x080485b0 <+188>:   mov    DWORD PTR [esp],edx
   0x080485b3 <+191>:   call   0x80483d0 <fread@plt>
   0x080485b8 <+196>:   mov    eax,DWORD PTR [esp+0x9c]
   0x080485bf <+203>:   mov    DWORD PTR [esp],eax
   0x080485c2 <+206>:   call   0x80483c0 <fclose@plt>
   0x080485c7 <+211>:   mov    eax,DWORD PTR [ebp+0xc]
   0x080485ca <+214>:   add    eax,0x4
   0x080485cd <+217>:   mov    eax,DWORD PTR [eax]
   0x080485cf <+219>:   mov    DWORD PTR [esp+0x4],eax
   0x080485d3 <+223>:   lea    eax,[esp+0x18]
   0x080485d7 <+227>:   mov    DWORD PTR [esp],eax
   0x080485da <+230>:   call   0x80483b0 <strcmp@plt>
   0x080485df <+235>:   test   eax,eax
   0x080485e1 <+237>:   jne    0x8048601 <main+269>
   0x080485e3 <+239>:   mov    DWORD PTR [esp+0x8],0x0
   0x080485eb <+247>:   mov    DWORD PTR [esp+0x4],0x8048707
   0x080485f3 <+255>:   mov    DWORD PTR [esp],0x804870a
   0x080485fa <+262>:   call   0x8048420 <execl@plt>
   0x080485ff <+267>:   jmp    0x8048610 <main+284>
   0x08048601 <+269>:   lea    eax,[esp+0x18]
   0x08048605 <+273>:   add    eax,0x42
   0x08048608 <+276>:   mov    DWORD PTR [esp],eax
   0x0804860b <+279>:   call   0x80483e0 <puts@plt>
   0x08048610 <+284>:   mov    eax,0x0
   0x08048615 <+289>:   lea    esp,[ebp-0x8]
   0x08048618 <+292>:   pop    ebx
   0x08048619 <+293>:   pop    edi
   0x0804861a <+294>:   pop    ebp
   0x0804861b <+295>:   ret
End of assembler dump.
```
## Explanations
```
   0x080484f4 <+0>:     push   ebp
   0x080484f5 <+1>:     mov    ebp,esp
   0x080484f7 <+3>:     push   edi
   0x080484f8 <+4>:     push   ebx
   0x080484f9 <+5>:     and    esp,0xfffffff0
   0x080484fc <+8>:     sub    esp,0xa0
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> - <+4> : Save some registers.  
<+5> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+8> : 160 bytes are allocated to the main function for its local variables.
```
   0x08048502 <+14>:    mov    edx,0x80486f0
   0x08048507 <+19>:    mov    eax,0x80486f2
   0x0804850c <+24>:    mov    DWORD PTR [esp+0x4],edx
   0x08048510 <+28>:    mov    DWORD PTR [esp],eax
   0x08048513 <+31>:    call   0x8048410 <fopen@plt>
   0x08048518 <+36>:    mov    DWORD PTR [esp+0x9c],eax
```
<+14> - <+36> : Call to `fopen()` then save it return value at `esp+0x9c`.  
*fopen("/home/user/end/.pass", "r");*
```
   0x0804851f <+43>:    lea    ebx,[esp+0x18]
   0x08048523 <+47>:    mov    eax,0x0
   0x08048528 <+52>:    mov    edx,0x21
   0x0804852d <+57>:    mov    edi,ebx
   0x0804852f <+59>:    mov    ecx,edx
   0x08048531 <+61>:    rep stos DWORD PTR es:[edi],eax
```
<+43> - <+61> : For `ecx` repetitions, stores the contents of `eax` into where `edi` points to, incrementing or decrementing `edi` (depending on the direction flag) by 4 bytes each time. Each iteration, `ecx` is decremented by 1, and the loop stops when it reaches zero. This is a kind of memset on the buffer start at address `esp+0x50`.  *memset(buffer, 0, 132) //0x21 = 33; 33 * 4 = 132.*
```
   0x08048533 <+63>:    cmp    DWORD PTR [esp+0x9c],0x0
   0x0804853b <+71>:    je     0x8048543 <main+79>
   0x0804853d <+73>:    cmp    DWORD PTR [ebp+0x8],0x2
   0x08048541 <+77>:    je     0x804854d <main+89>
   0x08048543 <+79>:    mov    eax,0xffffffff
   0x08048548 <+84>:    jmp    0x8048615 <main+289>
```
<+63> - <+84> : Serie of comparaisons. If the `fopen()` return is equal to 0 or `argc` is not equal to 2, then set `eax` to -1 and jump to main+289 (return (-1)).
```
   0x0804854d <+89>:    lea    eax,[esp+0x18]
   0x08048551 <+93>:    mov    edx,DWORD PTR [esp+0x9c]
   0x08048558 <+100>:   mov    DWORD PTR [esp+0xc],edx
   0x0804855c <+104>:   mov    DWORD PTR [esp+0x8],0x42
   0x08048564 <+112>:   mov    DWORD PTR [esp+0x4],0x1
   0x0804856c <+120>:   mov    DWORD PTR [esp],eax
   0x0804856f <+123>:   call   0x80483d0 <fread@plt>
```
<+89> - <+123> : Call to `fread()` with values at addresses from `esp` to `esp+12`.  
*fread(buffer, 1, 66, f);    //with f: fopen() return*
```
   0x08048574 <+128>:   mov    BYTE PTR [esp+0x59],0x0
   0x08048579 <+133>:   mov    eax,DWORD PTR [ebp+0xc]
   0x0804857c <+136>:   add    eax,0x4
   0x0804857f <+139>:   mov    eax,DWORD PTR [eax]
   0x08048581 <+141>:   mov    DWORD PTR [esp],eax
   0x08048584 <+144>:   call   0x8048430 <atoi@plt>
```
<+128> : Set the value at `esp+89` to 0.  
*`buffer[65] = 0;*  
<+133> - <+144> : Call to `atoi()` with value at the address of `esp` as argument.  
*atoi(argv[1]);*
```
   0x08048589 <+149>:   mov    BYTE PTR [esp+eax*1+0x18],0x0
   0x0804858e <+154>:   lea    eax,[esp+0x18]
   0x08048592 <+158>:   lea    edx,[eax+0x42]
   0x08048595 <+161>:   mov    eax,DWORD PTR [esp+0x9c]
   0x0804859c <+168>:   mov    DWORD PTR [esp+0xc],eax
   0x080485a0 <+172>:   mov    DWORD PTR [esp+0x8],0x41
   0x080485a8 <+180>:   mov    DWORD PTR [esp+0x4],0x1
   0x080485b0 <+188>:   mov    DWORD PTR [esp],edx
   0x080485b3 <+191>:   call   0x80483d0 <fread@plt>
```
<+149> : Set the value at `esp+eax*1+0x18` to 0.  
*`buffer[atoi(argv[1])] = 0;*  
<+154> - <+191> : Call to `fread()` function.  
*fread(&buffer[66], 1, 65, f);*
```
   0x080485b8 <+196>:   mov    eax,DWORD PTR [esp+0x9c]
   0x080485bf <+203>:   mov    DWORD PTR [esp],eax
   0x080485c2 <+206>:   call   0x80483c0 <fclose@plt>
```
<+196> - <+206> : Call to `fclose()`.  
*fclose(f);*
```
   0x080485c7 <+211>:   mov    eax,DWORD PTR [ebp+0xc]
   0x080485ca <+214>:   add    eax,0x4
   0x080485cd <+217>:   mov    eax,DWORD PTR [eax]
   0x080485cf <+219>:   mov    DWORD PTR [esp+0x4],eax
   0x080485d3 <+223>:   lea    eax,[esp+0x18]
   0x080485d7 <+227>:   mov    DWORD PTR [esp],eax
   0x080485da <+230>:   call   0x80483b0 <strcmp@plt>
   0x080485df <+235>:   test   eax,eax
   0x080485e1 <+237>:   jne    0x8048601 <main+269>
   0x080485e3 <+239>:   mov    DWORD PTR [esp+0x8],0x0
   0x080485eb <+247>:   mov    DWORD PTR [esp+0x4],0x8048707
   0x080485f3 <+255>:   mov    DWORD PTR [esp],0x804870a
   0x080485fa <+262>:   call   0x8048420 <execl@plt>
   0x080485ff <+267>:   jmp    0x8048610 <main+284>
```
<+211> - <+267> : If the value of `strcmp()` is not equal to 0, jump to main+269. In this case we do not execute `execl()`.  
*if (strcmp(buffer, argv[1]) == 0) { execl("/bin/sh", "sh", NULL); }*
```
   0x08048601 <+269>:   lea    eax,[esp+0x18]
   0x08048605 <+273>:   add    eax,0x42
   0x08048608 <+276>:   mov    DWORD PTR [esp],eax
   0x0804860b <+279>:   call   0x80483e0 <puts@plt>
```
<+269> - <+279> : Call to `puts()` function.  
*puts(&buffer[0x42]);*
```
   0x08048610 <+284>:   mov    eax,0x0
   0x08048615 <+289>:   lea    esp,[ebp-0x8]
   0x08048618 <+292>:   pop    ebx
   0x08048619 <+293>:   pop    edi
   0x0804861a <+294>:   pop    ebp
   0x0804861b <+295>:   ret
```
<+284> - <+295> : Retrieved old registers and quit the `main()` function.
