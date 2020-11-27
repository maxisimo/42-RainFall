#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef void(*func_ptr)(void);

void	n(void)
{
	system("/bin/cat /home/user/level7/.pass");
}

void	m(void)
{
	puts("Nope");
}

int		main(int ac, char **av)
{
	char		*arg;
	func_ptr	*func;

	arg = malloc(64);
	func = malloc(4);

	/*
		0x080484a5 <+41>:    mov    edx,0x8048468
		0x080484aa <+46>:    mov    eax,DWORD PTR [esp+0x18]
		0x080484ae <+50>:    mov    DWORD PTR [eax],edx
	*/
	*func = (void *)m;
	strcpy(arg, av[1]);
	/*
		0x080484ca <+78>:    mov    eax,DWORD PTR [esp+0x18]
		0x080484ce <+82>:    mov    eax,DWORD PTR [eax]
		0x080484d0 <+84>:    call   eax
	*/
	(**func)();

	return (0);
}
