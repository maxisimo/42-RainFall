#include <stdlib.h>
#include <stdio.h>
#include <string.h>

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
	char	*arg;
	void	(*func)(void);

	arg = malloc(64);
	func = malloc(4);
	func = m;
	strcpy(arg, av[1]);
	func();
}
