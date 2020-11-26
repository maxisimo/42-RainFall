# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x080482f8  _init
0x08048340  printf@plt
0x08048350  fgets@plt
0x08048360  system@plt
0x08048370  __gmon_start__@plt
0x08048380  __libc_start_main@plt
0x08048390  _start
0x080483c0  __do_global_dtors_aux
0x08048420  frame_dummy
0x08048444  p
0x08048457  n
0x080484a7  main
0x080484c0  __libc_csu_init
0x08048530  __libc_csu_fini
0x08048532  __i686.get_pc_thunk.bx
0x08048540  __do_global_ctors_aux
0x0804856c  _fini
```

# Main
```
Dump of assembler code for function main:
   0x080484a7 <+0>:     push   ebp
   0x080484a8 <+1>:     mov    ebp,esp
   0x080484aa <+3>:     and    esp,0xfffffff0
   0x080484ad <+6>:     call   0x8048457 <n>
   0x080484b2 <+11>:    leave
   0x080484b3 <+12>:    ret    
End of assembler dump.
```
## Explanations
Very similar to the previous level, so I won't dwell on the explanations.  
<+0> - <+12> : Call `n()` at `0x8048457` then quit the `main()` function.  

# N
```
Dump of assembler code for function n:
   0x08048457 <+0>:     push   ebp
   0x08048458 <+1>:     mov    ebp,esp
   0x0804845a <+3>:     sub    esp,0x218
   0x08048460 <+9>:     mov    eax,ds:0x8049804
   0x08048465 <+14>:    mov    DWORD PTR [esp+0x8],eax
   0x08048469 <+18>:    mov    DWORD PTR [esp+0x4],0x200
   0x08048471 <+26>:    lea    eax,[ebp-0x208]
   0x08048477 <+32>:    mov    DWORD PTR [esp],eax
   0x0804847a <+35>:    call   0x8048350 <fgets@plt>
   0x0804847f <+40>:    lea    eax,[ebp-0x208]
   0x08048485 <+46>:    mov    DWORD PTR [esp],eax
   0x08048488 <+49>:    call   0x8048444 <p>
   0x0804848d <+54>:    mov    eax,ds:0x8049810
   0x08048492 <+59>:    cmp    eax,0x1025544
   0x08048497 <+64>:    jne    0x80484a5 <n+78>
   0x08048499 <+66>:    mov    DWORD PTR [esp],0x8048590
   0x080484a0 <+73>:    call   0x8048360 <system@plt>
   0x080484a5 <+78>:    leave
   0x080484a6 <+79>:    ret
End of assembler dump.
```
## Explanations
Again, very similar to the previous level until *n+49.
```
   0x0804847f <+40>:    lea    eax,[ebp-0x208]
   0x08048485 <+46>:    mov    DWORD PTR [esp],eax
   0x08048488 <+49>:    call   0x8048444 <p>
```
<+40> - <+46> : Load the effective address `ebp-0x208` in `eax`, so `eax` is now pointing on `ebp-0x208`.  Then mov it into `esp`.  
<+49> : Call to `p()` function with value at address of `esp` as argument (p(buffer)).  
```
   0x0804848d <+54>:    mov    eax,ds:0x8049810
   0x08048492 <+59>:    cmp    eax,0x1025544
   0x08048497 <+64>:    jne    0x80484a5 <n+78>
```
<+54> - <+64> : JNE comparaison. If the value of the global variable ("m") stored at address `0x8049810` is not equal to 0x1025544 (16930116), jump to the address `0x80484a5` (n+78), otherwise continue.
```
   0x08048499 <+66>:    mov    DWORD PTR [esp],0x8048590
   0x080484a0 <+73>:    call   0x8048360 <system@plt>
```
<+66> : Set argument for `system()` function.  
<+73> : Call to `system()` function with value at address of `esp` as argument (system("/bin/sh")).  
```
   0x080484a5 <+78>:    leave
   0x080484a6 <+79>:    ret
```
<+78> - <+79> : These two lines allow us to find the state of the registers before executing the function. In others terms we quit the `main()` function.  
Before `leave` and `ret` instructions, the stack should look like (if we passed condition) :
```
                   High addresses

                |     OLD_EBP     |
                +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |     main
  EBP+0x8 =>    +-----------------+        |  stackframe
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
                :       uni*      :        |     n stackframe
                :                 :        |  536 bytes allocated
                :                 :        |
                +-----------------+        |
                :      stdin      :        |
  ESP+0xc =>    +-----------------+        |
                :       0xc       :        |
  ESP+0x8 =>    +-----------------+        |
                :      0x200      :        |
  ESP+0x4 =>    +-----------------+        |
                :    "/bin/sh"    :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*buffer : the pointer used for fget() and p() points here
*uni : uninitialized
```

# P
```
Dump of assembler code for function p:
   0x08048444 <+0>:     push   ebp
   0x08048445 <+1>:     mov    ebp,esp
   0x08048447 <+3>:     sub    esp,0x18
   0x0804844a <+6>:     mov    eax,DWORD PTR [ebp+0x8]
   0x0804844d <+9>:     mov    DWORD PTR [esp],eax
   0x08048450 <+12>:    call   0x8048340 <printf@plt>
   0x08048455 <+17>:    leave
   0x08048456 <+18>:    ret
End of assembler dump.
```
<+0> - <+18> : Similar to main with the differences that the function allocates 24 bytes for its local variables. And call `printf()` function with the value at address `esp` as argument (printf(str)) before leave and ret.  
Before `leave` and `ret` instructions, the stack should look like :
```
                   High addresses

                |     OLD_EBP     |
                +-----------------+    ----+
                :                 :        |
                :   extra space   :        |
                :   (alignment)   :        |
                :                 :        |     main
    EBP+? =>    +-----------------+        |  stackframe
                :    MAIN_EIP     :        |
    EBP+? =>    +-----------------+        |
                :    MAIN_EBP     :        |
    EBP+? =>    +-----------------+    ----+
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |
                :                 :        |
    EBP+? =>    +-----------------+        |
                :     buffer*     :        |
                +-----------------+        |
                :                 :        |
                :                 :        |
                :       uni*      :        |     n stackframe
                :                 :        |  536 bytes allocated
                :                 :        |
                +-----------------+        |
                :      stdin      :        |
 EBP+0x10 =>    +-----------------+        |
                :      0x200      :        |
  EBP+0xc =>    +-----------------+        |
                :      EBP+?      :   <----|-------- buffer
  EBP+0x8 =>    +-----------------+        |
                :      N_EIP      :        |
  EBP+0x4 =>    +-----------------+        |
                :      N_EBP      :        |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |  p stackframe, 24 bytes allocated
                :                 :        |
  ESP+0x4 =>    +-----------------+        |
                :      EBP+?      :   <----|-------- buffer
      ESP =>    +-----------------+    ----+
                   Low addresses

*EBP+? : I didn't want to count but we can find it
*buffer : the pointer used for fget() and p() points here
*uni : uninitialized
```
