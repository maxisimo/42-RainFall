# Getting command line parameters

In assembly x86, there is a specific way to retrieve `argc` `argv` of the main().  
For this exemple, we will use a program in asm that take two parameters and use `atoi()` on both of them.  
```
Dump of assembler code for function main:
   0x08048ec0 <+0>:     push   ebp
   0x08048ec1 <+1>:     mov    ebp,esp
   0x08048ec6 <+3>:     sub    esp,0x20
   0x08048ec9 <+6>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+9>:     add    eax,0x4
   0x08048ecf <+12>:    mov    eax,DWORD PTR [eax]
   0x08048ed1 <+14>:    mov    DWORD PTR [esp],eax
   0x08048ed4 <+17>:    call   0x8049710 <atoi>
   0x08048ec9 <+20>:    mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+23>:    add    eax,0x8
   0x08048ecf <+26>:    mov    eax,DWORD PTR [eax]
   0x08048ed1 <+28>:    mov    DWORD PTR [esp],eax
   0x08048ed4 <+31>:    call   0x8049710 <atoi>
   0x08048f85 <+36>:    leave
   0x08048f86 <+37>:    ret
End of assembler dump.
```
Ok, this program is useless but it does not matter. We just want, on this exemple, to retrieve `argv[1]` and `argv[2]` for the two calls of `atoi()`.  
Lets focus on these lines :
```
   0x08048ec9 <+6>:     mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+9>:     add    eax,0x4
   0x08048ecf <+12>:    mov    eax,DWORD PTR [eax]
```
<+6> : Store all parameters of the main function (all argv) in `eax`.  
<+9> : At this moment we add `0x4` to `eax` to reach `argv + 1` (argv[1]). Here is how it work  
```
argc = [ebp+0x8]  
argv = [ebp+0xc + 4 * ARG_NUMBER]
```
<+12> : We saw with the 2 lines of code before, that `eax` is now pointing to the memory area of `argv + 1` on the stack. Then with the code at this line we store directly the value of `argv[1]` in `eax`, so `eax` is now a pointer.  
A sketch of the stack is probably required :
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
                :                 :
                :                 :
                :   32 allocated  :
                :   bytes (0x20)  :
                :                 :
                :                 :
                :                 :
      ESP =>    + - - - - - - - - +
                   Low addresses
```
Good, we retrieved the first parameter. As we said upper, this will be exactly the same thing for the second parmeter with one exception :
```
   0x08048ec9 <+20>:    mov    eax,DWORD PTR [ebp+0xc]
   0x08048ecc <+23>:    add    eax,0x8
   0x08048ecf <+26>:    mov    eax,DWORD PTR [eax]
```
<+23> : We add `0x8` to `eax` to reach `argv + 2` (argv[2]) ! 
