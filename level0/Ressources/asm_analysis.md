# Main
```
Dump of assembler code for function main:
   0x08048ec0 <+0>:     push   ebp
   0x08048ec1 <+1>:     mov    ebp,esp
   0x08048ec3 <+3>:     and    esp,0xfffffff0
   0x08048ec6 <+6>:     sub    esp,0x20
   0x08048ec9 <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+12>:    add    eax,0x4
   0x08048ecf <+15>:    mov    eax,DWORD PTR [eax]
   0x08048ed1 <+17>:    mov    DWORD PTR [esp],eax
   0x08048ed4 <+20>:    call   0x8049710 <atoi>
   0x08048ed9 <+25>:    cmp    eax,0x1a7
   0x08048ede <+30>:    jne    0x8048f58 <main+152>
   0x08048ee0 <+32>:    mov    DWORD PTR [esp],0x80c5348
   0x08048ee7 <+39>:    call   0x8050bf0 <strdup>
   0x08048eec <+44>:    mov    DWORD PTR [esp+0x10],eax
   0x08048ef0 <+48>:    mov    DWORD PTR [esp+0x14],0x0
   0x08048ef8 <+56>:    call   0x8054680 <getegid>
   0x08048efd <+61>:    mov    DWORD PTR [esp+0x1c],eax
   0x08048f01 <+65>:    call   0x8054670 <geteuid>
   0x08048f06 <+70>:    mov    DWORD PTR [esp+0x18],eax
   0x08048f0a <+74>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f0e <+78>:    mov    DWORD PTR [esp+0x8],eax
   0x08048f12 <+82>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f16 <+86>:    mov    DWORD PTR [esp+0x4],eax
   0x08048f1a <+90>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f1e <+94>:    mov    DWORD PTR [esp],eax
   0x08048f21 <+97>:    call   0x8054700 <setresgid>
   0x08048f26 <+102>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f2a <+106>:   mov    DWORD PTR [esp+0x8],eax
   0x08048f2e <+110>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f32 <+114>:   mov    DWORD PTR [esp+0x4],eax
   0x08048f36 <+118>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f3a <+122>:   mov    DWORD PTR [esp],eax
   0x08048f3d <+125>:   call   0x8054690 <setresuid>
   0x08048f42 <+130>:   lea    eax,[esp+0x10]
   0x08048f46 <+134>:   mov    DWORD PTR [esp+0x4],eax
   0x08048f4a <+138>:   mov    DWORD PTR [esp],0x80c5348
   0x08048f51 <+145>:   call   0x8054640 <execv>
   0x08048f56 <+150>:   jmp    0x8048f80 <main+192>
   0x08048f58 <+152>:   mov    eax,ds:0x80ee170
   0x08048f5d <+157>:   mov    edx,eax
   0x08048f5f <+159>:   mov    eax,0x80c5350
   0x08048f64 <+164>:   mov    DWORD PTR [esp+0xc],edx
   0x08048f68 <+168>:   mov    DWORD PTR [esp+0x8],0x5
   0x08048f70 <+176>:   mov    DWORD PTR [esp+0x4],0x1
   0x08048f78 <+184>:   mov    DWORD PTR [esp],eax
   0x08048f7b <+187>:   call   0x804a230 <fwrite>
   0x08048f80 <+192>:   mov    eax,0x0
   0x08048f85 <+197>:   leave
   0x08048f86 <+198>:   ret
End of assembler dump.
```
## Explanations
```
   0x08048ec0 <+0>:     push   ebp
   0x08048ec1 <+1>:     mov    ebp,esp
```
<+0> : Push `ebp` to save the beginning of the previous function's stackframe.
<+1> : Stores the contents of ESP (Stack Pointer), where the address of the top of the stack is contained, in EBP.
```
   0x08048ec3 <+3>:     and    esp,0xfffffff0
   0x08048ec6 <+6>:     sub    esp,0x20
```
<+3> : [Stack align](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/alignment.md) on 16 bytes unnecessary, because there are no SIMD instructions  
<+6> : 32 bytes are allocated to the main function for its local variables.
```
   0x08048ec9 <+9>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+12>:    add    eax,0x4
   0x08048ecf <+15>:    mov    eax,DWORD PTR [eax]
```
<+9> - <+15> : Store directly the value of `argv + 1` (argv[1]) in `eax`, so `eax` is now a pointer.  
*More details at [ASM x86: main args](https://github.com/maxisimo/42-RainFall/blob/main/doc/asm_x86/main_args.md)*
```
   0x08048ed1 <+17>:    mov    DWORD PTR [esp],eax
   0x08048ed4 <+20>:    call   0x8049710 <atoi>
   0x08048ed9 <+25>:    cmp    eax,0x1a7
   0x08048ede <+30>:    jne    0x8048f58 <main+152>
```
<+17> : Store `eax` (argv[1]) at the address of `esp` (the top of the stack).  
<+20> : Call to `atoi()` which will take as argument the value stored at the address of `esp` (atoi(argv[1])).  
<+25> : Then compare the value of the `atoi()` return to `0x1a7` (423).  
<+30> : JNE comparaison. If the `atoi()` return is not equal to `0x1a7`, jump to the address `0x8048f58` (main+152), otherwise continue.  
At this moment, the stack should look like :  
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
                :                 :        |
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |  32 bytes allocated
                :                 :        |
                :                 :        |
                +-----------------+        |
                :     argv[1]     :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```
Ok, let's back to our code.  
```
   0x08048ee0 <+32>:    mov    DWORD PTR [esp],0x80c5348
   0x08048ee7 <+39>:    call   0x8050bf0 <strdup>
   0x08048eec <+44>:    mov    DWORD PTR [esp+0x10],eax
```
<+32> : Store `0x80c5348` (the address of the string "/bin/sh") in the address of `esp`.  
<+39> : Call to `strdup()` which will take as argument the value stored at the address of `esp` (a pointer to the string "/bin/sh").  
<+44> : Store the return function at address `esp+16`.
```
   0x08048ef0 <+48>:    mov    DWORD PTR [esp+0x14],0x0
   0x08048ef8 <+56>:    call   0x8054680 <getegid>
   0x08048efd <+61>:    mov    DWORD PTR [esp+0x1c],eax
   0x08048f01 <+65>:    call   0x8054670 <geteuid>
   0x08048f06 <+70>:    mov    DWORD PTR [esp+0x18],eax
```
<+48> : This will be the NULL pointer to close the pointer tab which will be use as second argument for the `execv()` function.  
<+56> - <+70> : Calls to `getegid()` then `geteuid()`. Store their return value respectively to addresses `esp+0x1c` and `esp+0x18`.  
```
   0x08048f0a <+74>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f0e <+78>:    mov    DWORD PTR [esp+0x8],eax
   0x08048f12 <+82>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f16 <+86>:    mov    DWORD PTR [esp+0x4],eax
   0x08048f1a <+90>:    mov    eax,DWORD PTR [esp+0x1c]
   0x08048f1e <+94>:    mov    DWORD PTR [esp],eax
   0x08048f21 <+97>:    call   0x8054700 <setresgid>
```
<+74> - <+94> : Set arguments for `setresgid()` function.  
<+97> : Call to `setresgid()` function with values at addresses `esp`, `esp+4` and `esp+8` as arguments (setresgid(gid, gid, gid)).  
```
   0x08048f26 <+102>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f2a <+106>:   mov    DWORD PTR [esp+0x8],eax
   0x08048f2e <+110>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f32 <+114>:   mov    DWORD PTR [esp+0x4],eax
   0x08048f36 <+118>:   mov    eax,DWORD PTR [esp+0x18]
   0x08048f3a <+122>:   mov    DWORD PTR [esp],eax
   0x08048f3d <+125>:   call   0x8054690 <setresuid>
```
At this moment, the stack should look like :  
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+
                :                 :
                :   extra space   :
                :   (alignment)   :
                :                 :
                +-----------------+    ----+
                :       gid*      :        |
 ESP+0x1c =>    +-----------------+        |
                :       uid*      :        |
 ESP+0x18 =>    +-----------------+        |
                : strdup() return :        |
 ESP+0x10 =>    +-----------------+        |
                         .                 |
                         .                 |  32 bytes allocated
                         .                 |
                +-----------------+        |
                :       uid*      :        |
  ESP+0x8 =>    +-----------------+        |
                :       uid*      :        |
  ESP+0x4 =>    +-----------------+        |
                :       uid*      :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*gid : getegid() return
*uid : geteuid() return
```
<+102> - <+122> : Set arguments for `setresuid()` function.  
<+97> : Call to `setresuid()` function with values at addresses `esp`, `esp+4` and `esp+8` as arguments (setresuid(uid, uid, uid)).  
```
   0x08048f42 <+130>:   lea    eax,[esp+0x10]
   0x08048f46 <+134>:   mov    DWORD PTR [esp+0x4],eax
   0x08048f4a <+138>:   mov    DWORD PTR [esp],0x80c5348
   0x08048f51 <+145>:   call   0x8054640 <execv>
```
<+130> : `eax` points to `esp+0x10`.  
<+134> - <+138> : Set arguments for `execv()` function.  
<+145> : Call to `execv()` function with values at addresses `esp` and `esp+4` as arguments (execv("/bin/sh", [`esp+0x10`, `esp+0x14`])).  
```
   0x08048f56 <+150>:   jmp    0x8048f80 <main+192>
```
<+150> : Inconditionnal jump to the address `0x8048f80` (main+192).  
```
   0x08048f58 <+152>:   mov    eax,ds:0x80ee170
   0x08048f5d <+157>:   mov    edx,eax
   0x08048f5f <+159>:   mov    eax,0x80c5350
   0x08048f64 <+164>:   mov    DWORD PTR [esp+0xc],edx
   0x08048f68 <+168>:   mov    DWORD PTR [esp+0x8],0x5
   0x08048f70 <+176>:   mov    DWORD PTR [esp+0x4],0x1
   0x08048f78 <+184>:   mov    DWORD PTR [esp],eax
   0x08048f7b <+187>:   call   0x804a230 <fwrite>
```
At this moment, the stack should look like :  
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+
                :                 :
                :   extra space   :
                :   (alignment)   :
                :                 :
                +-----------------+    ----+
                :       gid*      :        |
 ESP+0x1c =>    +-----------------+        |
                :       uid*      :        |
 ESP+0x18 =>    +-----------------+        |
                : strdup() return :        |
 ESP+0x10 =>    +-----------------+        |
                         .                 |
                         .                 |
                         .                 |  32 bytes allocated
                +-----------------+        |
                :      stderr     :        |
  ESP+0xc =>    +-----------------+        |
                :        5        :        |
  ESP+0x8 =>    +-----------------+        |
                :        1        :        |
  ESP+0x4 =>    +-----------------+        |
                :     "No !\n"    :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*gid : getegid() return
*uid : geteuid() return
```
<+152> : Remember, this is the address pointed by the `JNE` instruction at line <+30>. 'ds:[0x80ee170]' notation means that we reach the *offset* from address in 'DS' (data segment register), so the instruction moves double word (32-bit value) from address 'ds:[0x80ee170]' to register `eax` (eax = stderr).  
<+157> : Save the value of `eax` ind `edx`.  
<+159> : Then store the value at `0x80c5350` in `eax` (eax = "No !\n").  
<+164> - <+184> : Set arguments for `fwrite()` function.  
<+187> : Call to `fwrite()` function with values at addresses from `esp` to `esp+12` as arguments (fwrite(`esp`, `esp+4`, `esp+8`, `esp+12`)).
```
   0x08048f80 <+192>:   mov    eax,0x0
   0x08048f85 <+197>:   leave
   0x08048f86 <+198>:   ret
```
<+192> - <+198> : These three lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function by doing an equivalent of `return(0)` in C.
