#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char	*p(void)
{
	char	buffer[64];       // ebp-0x4c - ebp-0xc = 64
	void	*return_addr;

	fflush(stdout);
	gets(buffer);
	return_addr = __builtin_return_address (0);      // 0 for the current function
	if (((unsigned int)return_addr & 0xb0000000) == 0xb0000000)
	{
		printf("%p\n", return_addr);
		exit(1);
	}
	puts(buffer);
	return (strdup(buffer));
}

int		main(void)
{
	p();
	return (0);
}
