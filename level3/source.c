#include <stdio.h>
#include <stdlib.h>

int		m = 0;

int		v(void)
{
	char	buffer[512];

	fgets(buffer, 512, stdin);
	printf(buffer);
	if (m == 64)
	{
		fwrite("Wait what?!\n", 12, 1, stdout);
		system("/bin/sh");
	}
	return (0);
}

int		main(void)
{
	v();
	return (0);
}