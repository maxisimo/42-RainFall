We can understand the goal, need to execute the "n" function  
Get the offset (probably 72)  
The payload will be : pad of arbitrary data * 72 + "n address"  
This is a simply buffer overflow..
```
[~]$ r2 level6
 -- aaaa is experimental
[0x080483a0]> pxc
- offset -   0 1  2 3  4 5  6 7  8 9  A B  C D  E F  0123456789ABCDEF  comment
0x080483a0  31ed 5e89 e183 e4f0 5054 5268 5085 0408  1.^.....PTRhP...  ; eip  ; [13] -r-x section size 492 named .text
0x080483b0  68e0 8404 0851 5668 7c84 0408 e8cf ffff  h....QVh|.......
0x080483c0  fff4 9090 9090 9090 9090 9090 9090 9090  ................
0x080483d0  5589 e553 83ec 0480 3d2c 9804 0800 753f  U..S....=,....u?  ; sym.__do_global_dtors_aux
0x080483e0  a130 9804 08bb 2c97 0408 81eb 2897 0408  .0....,.....(...
0x080483f0  c1fb 0283 eb01 39d8 731e 8db6 0000 0000  ......9.s.......
0x08048400  83c0 01a3 3098 0408 ff14 8528 9704 08a1  ....0......(....
0x08048410  3098 0408 39d8 72e8 c605 2c98 0408 0183  0...9.r...,.....
0x08048420  c404 5b5d c38d 7426 008d bc27 0000 0000  ..[]..t&...'....
0x08048430  5589 e583 ec18 a130 9704 0885 c074 12b8  U......0.....t..  ; sym.frame_dummy
0x08048440  0000 0000 85c0 7409 c704 2430 9704 08ff  ......t...$0....
0x08048450  d0c9 c390 5589 e583 ec18 c704 24b0 8504  ....U.......$...  ; sym.n
0x08048460  08e8 0aff ffff c9c3 5589 e583 ec18 c704  ........U.......  ; sym.m
0x08048470  24d1 8504 08e8 e6fe ffff c9c3 5589 e583  $...........U...  ; sym.main
0x08048480  e4f0 83ec 20c7 0424 4000 0000 e8bf feff  .... ..$@.......
0x08048490  ff89 4424 1cc7 0424 0400 0000 e8af feff  ..D$...$........
[0x080483a0]> aaa
[x] Analyze all flags starting with sym. and entry0 (aa)
[x] Analyze function calls (aac)
[x] Analyze len bytes of instructions for references (aar)
[x] Check for vtables
[x] Type matching analysis for all functions (aaft)
[x] Propagate noreturn information
[x] Use -AA or aaaa to perform additional experimental analysis.
[0x080483a0]> s main
[0x0804847c]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x804847c */     
                                                 | #include <stdint.h>
                                                 |
    ; (fcn) main ()                              | int32_t main (char ** envp) {
                                                 |     char * src;
                                                 |     void * var_18h;
                                                 |     char * dest;
    0x0804847c push ebp                          |
    0x0804847d mov ebp, esp                      |
    0x0804847f and esp, 0xfffffff0               |
    0x08048482 sub esp, 0x20                     |
    0x08048485 mov dword [esp], 0x40             |     
    0x0804848c call 0x8048350                    |     eax = malloc (0x40);
    0x08048491 mov dword [esp + 0x1c], eax       |     *((esp + 0x1c)) = eax;
    0x08048495 mov dword [esp], 4                |
    0x0804849c call 0x8048350                    |     eax = malloc (4);
    0x080484a1 mov dword [esp + 0x18], eax       |     *((esp + 0x18)) = eax;
    0x080484a5 mov edx, 0x8048468                |     edx = m;
    0x080484aa mov eax, dword [esp + 0x18]       |     eax = *((esp + 0x18));
    0x080484ae mov dword [eax], edx              |     *(eax) = edx;
    0x080484b0 mov eax, dword [ebp + 0xc]        |     eax = *((ebp + 0xc));
    0x080484b3 add eax, 4                        |     eax += 4;
    0x080484b6 mov eax, dword [eax]              |     eax = *(eax);
    0x080484b8 mov edx, eax                      |     edx = *(eax);
    0x080484ba mov eax, dword [esp + 0x1c]       |     eax = *((esp + 0x1c));
    0x080484be mov dword [esp + 4], edx          |     *((esp + 4)) = edx;
    0x080484c2 mov dword [esp], eax              |
    0x080484c5 call 0x8048340                    |     strcpy (eax);
    0x080484ca mov eax, dword [esp + 0x18]       |     eax = *((esp + 0x18));
    0x080484ce mov eax, dword [eax]              |     eax = *(eax);
    0x080484d0 call eax                          |     void (*eax)() ();
    0x080484d2 leave                             |
    0x080484d3 ret                               |     return eax;
                                                 | }
[0x0804847c]> s sym.m
[0x08048468]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x8048468 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.m ()                             | void m (void) {
    0x08048468 push ebp                          |
    0x08048469 mov ebp, esp                      |
    0x0804846b sub esp, 0x18                     |
    0x0804846e mov dword [esp], 0x80485d1        |     
    0x08048475 call 0x8048360                    |     puts ("Nope");
    0x0804847a leave                             |
    0x0804847b ret                               |
                                                 | }
[0x08048468]> s sym.n
[0x08048454]> pdda
    ; assembly                                   | /* r2dec pseudo code output */
                                                 | /* level6 @ 0x8048454 */
                                                 | #include <stdint.h>
                                                 |  
    ; (fcn) sym.n ()                             | void n (void) {
    0x08048454 push ebp                          |
    0x08048455 mov ebp, esp                      |
    0x08048457 sub esp, 0x18                     |
    0x0804845a mov dword [esp], 0x80485b0        |
    0x08048461 call 0x8048370                    |     system ("/bin/cat /home/user/level7/.pass");
    0x08048466 leave                             |     
    0x08048467 ret                               |
                                                 | }
[0x08048454]>
```