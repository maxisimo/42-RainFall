#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int		main(int ac, char **av)
{
	int		nb;
	char	str[40]; //0x3c - 0x14 (address of nb - start address of str)

	nb = atoi(av[1]);
	if (!(nb <= 9))
		return (1);
	memcpy(str, av[2], nb * 4);
	if (nb == 0x574f4c46)
		execl("/bin/sh", "sh", NULL);
	return (0);
}
