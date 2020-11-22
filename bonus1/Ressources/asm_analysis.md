# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x080482d4  _init
0x08048320  memcpy@plt
0x08048330  __gmon_start__@plt
0x08048340  __libc_start_main@plt
0x08048350  execl@plt
0x08048360  atoi@plt
0x08048370  _start
0x080483a0  __do_global_dtors_aux
0x08048400  frame_dummy
0x08048424  main
0x080484b0  __libc_csu_init
0x08048520  __libc_csu_fini
0x08048522  __i686.get_pc_thunk.bx
0x08048530  __do_global_ctors_aux
0x0804855c  _fini
```

# main
```
(gdb) set disassembly-flavor intel
(gdb) disass main
Dump of assembler code for function main:
   0x08048424 <+0>:     push   ebp
   0x08048425 <+1>:     mov    ebp,esp
   0x08048427 <+3>:     and    esp,0xfffffff0
   0x0804842a <+6>:     sub    esp,0x40
   0x0804842d <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048430 <+12>:    add    eax,0x4
   0x08048433 <+15>:    mov    eax,DWORD PTR [eax]
   0x08048435 <+17>:    mov    DWORD PTR [esp],eax
   0x08048438 <+20>:    call   0x8048360 <atoi@plt>
   0x0804843d <+25>:    mov    DWORD PTR [esp+0x3c],eax
   0x08048441 <+29>:    cmp    DWORD PTR [esp+0x3c],0x9
   0x08048446 <+34>:    jle    0x804844f <main+43>
   0x08048448 <+36>:    mov    eax,0x1
   0x0804844d <+41>:    jmp    0x80484a3 <main+127>
   0x0804844f <+43>:    mov    eax,DWORD PTR [esp+0x3c]
   0x08048453 <+47>:    lea    ecx,[eax*4+0x0]
   0x0804845a <+54>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804845d <+57>:    add    eax,0x8
   0x08048460 <+60>:    mov    eax,DWORD PTR [eax]
   0x08048462 <+62>:    mov    edx,eax
   0x08048464 <+64>:    lea    eax,[esp+0x14]
   0x08048468 <+68>:    mov    DWORD PTR [esp+0x8],ecx
   0x0804846c <+72>:    mov    DWORD PTR [esp+0x4],edx
   0x08048470 <+76>:    mov    DWORD PTR [esp],eax
   0x08048473 <+79>:    call   0x8048320 <memcpy@plt>
   0x08048478 <+84>:    cmp    DWORD PTR [esp+0x3c],0x574f4c46
   0x08048480 <+92>:    jne    0x804849e <main+122>
   0x08048482 <+94>:    mov    DWORD PTR [esp+0x8],0x0
   0x0804848a <+102>:   mov    DWORD PTR [esp+0x4],0x8048580
   0x08048492 <+110>:   mov    DWORD PTR [esp],0x8048583
   0x08048499 <+117>:   call   0x8048350 <execl@plt>
   0x0804849e <+122>:   mov    eax,0x0
   0x080484a3 <+127>:   leave
   0x080484a4 <+128>:   ret
End of assembler dump.
```
## Explanations
```
   0x08048424 <+0>:     push   ebp
   0x08048425 <+1>:     mov    ebp,esp
   0x08048427 <+3>:     and    esp,0xfffffff0
   0x0804842a <+6>:     sub    esp,0x40
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.  
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.  
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions.  
<+6> : 64 bytes are allocated to the main function for its local variables.
```
   0x0804842d <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048430 <+12>:    add    eax,0x4
   0x08048433 <+15>:    mov    eax,DWORD PTR [eax]
   0x08048435 <+17>:    mov    DWORD PTR [esp],eax
   0x08048438 <+20>:    call   0x8048360 <atoi@plt>
   0x0804843d <+25>:    mov    DWORD PTR [esp+0x3c],eax
```
<+9> - <+15> : Store directly the value of `argv[1]` in `eax`, so `eax` is now a pointer.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*  
<+17> - <+25> : Call to `atoi()` on `argv[1]` then store the function return at `esp+3c`.
```
   0x08048441 <+29>:    cmp    DWORD PTR [esp+0x3c],0x9
   0x08048446 <+34>:    jle    0x804844f <main+43>
   0x08048448 <+36>:    mov    eax,0x1
   0x0804844d <+41>:    jmp    0x80484a3 <main+127>
```
<+29> - <+41> : If the `atoi()` return is less than or equal to 0x9 jump to main+43 (we continue), otherwise set `eax` to 1 and jump to main+127 (`leave` then `ret`).
```
   0x0804844f <+43>:    mov    eax,DWORD PTR [esp+0x3c]
   0x08048453 <+47>:    lea    ecx,[eax*4+0x0]
   0x0804845a <+54>:    mov    eax,DWORD PTR [ebp+0xc]
   0x0804845d <+57>:    add    eax,0x8
   0x08048460 <+60>:    mov    eax,DWORD PTR [eax]
   0x08048462 <+62>:    mov    edx,eax
   0x08048464 <+64>:    lea    eax,[esp+0x14]
   0x08048468 <+68>:    mov    DWORD PTR [esp+0x8],ecx
   0x0804846c <+72>:    mov    DWORD PTR [esp+0x4],edx
   0x08048470 <+76>:    mov    DWORD PTR [esp],eax
   0x08048473 <+79>:    call   0x8048320 <memcpy@plt>
```
<+43> - <+47> : Multiply the `atoi()` result and store it in `ecx`.  
<+54> - <+62> : Store directly the value of `argv[2]` in `eax`, then in `edx`.  
<+64> : `eax` is now pointing on `esp+0x14`.  
<+68> - <+79> : Call to `memcpy()` with values at addresses `esp`, `esp+4` and `esp+8` as arguments (memcpy(str, argv[2], atoi(argv[1]) * 4)).
```
   0x08048478 <+84>:    cmp    DWORD PTR [esp+0x3c],0x574f4c46
   0x08048480 <+92>:    jne    0x804849e <main+122>
   0x08048482 <+94>:    mov    DWORD PTR [esp+0x8],0x0
   0x0804848a <+102>:   mov    DWORD PTR [esp+0x4],0x8048580
   0x08048492 <+110>:   mov    DWORD PTR [esp],0x8048583
   0x08048499 <+117>:   call   0x8048350 <execl@plt>
   0x0804849e <+122>:   mov    eax,0x0
   0x080484a3 <+127>:   leave
   0x080484a4 <+128>:   ret
```
<+84> - <+92> : If `atoi()` return is not equal to `0x574f4c46`, jump to main+122 (return (0)). Otherwise continue.  
<+94> - <+117> : Call to `execl()` with values at addresses `esp`, `esp+4` and `esp+8` as arguments (execl("/bin/sh", "sh", 0)).  
<+122> - <+128> : return 0
