#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

char	c[68];

void	m(void)
{
	printf("%s - %d\n", c, (int)time(0));
}

int		main(int ac, char **av)
{
	int		*a;
	int		*b;

	a = malloc(8);
	a[0] = 1;
	a[1] = (int)malloc(8);

	b = malloc(8);
	b[0] = 2;
	b[1] = (int)malloc(8);

	strcpy((char *)a[1], av[1]);
	strcpy((char *)b[1], av[2]);
	
	fgets(c, 68, fopen("/home/user/level8/.pass", "r"));

	puts("~~");

	return (0);
}
