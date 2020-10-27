/*
	I made a buffer of 64 bytes because :
	- we have to remove 4 bytes for the return adress
	- we have to remove 4 bytes for the old placement of ebp (https://stackoverflow.com/questions/9849078/size-of-ebp-register-on-the-stack#:~:text=In%20x86%2D32%2C%20all%20of,4%20bytes%20on%20the%20stack.)
	- we have to remove 8 bytes for esp alignement (and    $0xfffffff0,%esp)
	80 - 16 = 64
*/
#include <stdio.h>
#include <stdlib.h>

int		run(void)
{
	fwrite("Good... Wait what?\n", 19, 1, stdout);
	return (system("/bin/sh"));
}

int		main(void)
{
	char	s[64];

	gets(s);
	return (0);
}
