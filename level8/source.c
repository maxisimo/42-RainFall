#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char	*auth = NULL;
char	*service = NULL;

int		main(void)
{
	char	buffer[128];
	
	while (1)
	{
		printf("%p, %p\n", auth, service);
		if (fgets(buffer, 128, stdin) == 0)
			break;
		if (strncmp(buffer, "auth ", 5) == 0)
		{
			auth = malloc(4);
			auth[0] = 0;
			if (strlen(buffer + 5) <= 30)
				strcpy(auth, buffer + 5);
		}
		if (strncmp(buffer, "reset", 5) == 0)
			free(auth);
		if (strncmp(buffer, "service", 6) == 0)
			service = strdup(buffer + 7);
		if (strncmp(buffer, "login", 5) == 0)
		{
			if (auth[32] != 0)
				system("/bin/sh");
			else
				fwrite("Password:\n", 10, 1, stdout);
		}
	}
}
