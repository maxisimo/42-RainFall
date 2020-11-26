# Get functions infos
```
(gdb) info functions
All defined functions:

Non-debugging symbols:
0x08048334  _init
0x08048380  printf@plt
0x08048390  _exit@plt
0x080483a0  fgets@plt
0x080483b0  system@plt
0x080483c0  __gmon_start__@plt
0x080483d0  exit@plt
0x080483e0  __libc_start_main@plt
0x080483f0  _start
0x08048420  __do_global_dtors_aux
0x08048480  frame_dummy
0x080484a4  o
0x080484c2  n
0x08048504  main
0x08048520  __libc_csu_init
0x08048590  __libc_csu_fini
0x08048592  __i686.get_pc_thunk.bx
0x080485a0  __do_global_ctors_aux
0x080485cc  _fini
```

# main
```
Dump of assembler code for function main:
   0x08048504 <+0>:     push   ebp
   0x08048505 <+1>:     mov    ebp,esp
   0x08048507 <+3>:     and    esp,0xfffffff0
   0x0804850a <+6>:     call   0x80484c2 <n>
   0x0804850f <+11>:    leave
   0x08048510 <+12>:    ret   
End of assembler dump.
```
## Explanations
Very similar to the previous level, so I won't dwell on the explanations.  
<+0> - <+12> : Call `n()` at `0x80484c2` then quit the `main()` function.  

# n
```
Dump of assembler code for function n:
   0x080484c2 <+0>:     push   ebp
   0x080484c3 <+1>:     mov    ebp,esp
   0x080484c5 <+3>:     sub    esp,0x218
   0x080484cb <+9>:     mov    eax,ds:0x8049848
   0x080484d0 <+14>:    mov    DWORD PTR [esp+0x8],eax
   0x080484d4 <+18>:    mov    DWORD PTR [esp+0x4],0x200
   0x080484dc <+26>:    lea    eax,[ebp-0x208]
   0x080484e2 <+32>:    mov    DWORD PTR [esp],eax
   0x080484e5 <+35>:    call   0x80483a0 <fgets@plt>
   0x080484ea <+40>:    lea    eax,[ebp-0x208]
   0x080484f0 <+46>:    mov    DWORD PTR [esp],eax
   0x080484f3 <+49>:    call   0x8048380 <printf@plt>
   0x080484f8 <+54>:    mov    DWORD PTR [esp],0x1
   0x080484ff <+61>:    call   0x80483d0 <exit@plt>
End of assembler dump.
```
## Explanations
Again, very similar to the previous level until *n+49.
```
   0x080484ea <+40>:    lea    eax,[ebp-0x208]
   0x080484f0 <+46>:    mov    DWORD PTR [esp],eax
   0x080484f3 <+49>:    call   0x8048380 <printf@plt>
```
<+40> - <+46> : Load the effective address `ebp-0x208` in `eax`, so `eax` is now pointing on `ebp-0x208`.  Then mov it into `esp`.  
<+49> : Call to `printf()` function with value at address of `esp` as argument (p(buffer)).  
```
   0x080484f8 <+54>:    mov    DWORD PTR [esp],0x1
   0x080484ff <+61>:    call   0x80483d0 <exit@plt>
```
<+54> : Set argument for `exit()` function.  
<+61> : Call to `exit()` function with value at address of `esp` as argument (exit(1)).  
Before `leave` and `ret` instructions, the stack should look like :
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
  ESP+0xc =>    +-----------------+        |
                :      stdin      :        |
  ESP+0x8 =>    +-----------------+        |
                :      0x200      :        |
  ESP+0x4 =>    +-----------------+        |
                :       0x1       :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*buffer : the pointer used for fget() and p() points here
*uni : uninitialized
```

# o
```
Dump of assembler code for function o:
   0x080484a4 <+0>:     push   ebp
   0x080484a5 <+1>:     mov    ebp,esp
   0x080484a7 <+3>:     sub    esp,0x18
   0x080484aa <+6>:     mov    DWORD PTR [esp],0x80485f0
   0x080484b1 <+13>:    call   0x80483b0 <system@plt>
   0x080484b6 <+18>:    mov    DWORD PTR [esp],0x1
   0x080484bd <+25>:    call   0x8048390 <_exit@plt>
End of assembler dump.
```
## Explanations
<+0> - <+25> : Similar to main with the differences that the function allocates 24 bytes for its local variables. And call `system()` and `_exit()` functions (system("/bin/sh"; _exit(1)) then leave and ret.  
Before `leave` and `ret` instructions, the stack should look like :
```
                   High addresses

                |     OLD_EBP     |
      EBP =>    +-----------------+    ----+
                :                 :        |
                :                 :        |
                :       uni*      :        |
                :                 :        |  o stackframe, 24 bytes allocated
                :                 :        |
  ESP+0x4 =>    +-----------------+        |
                :       0x1       :        |
      ESP =>    +-----------------+    ----+
                   Low addresses

*uni : uninitialized
```
