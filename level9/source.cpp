#include <unistd.h>
#include <string.h>

class N;
int		operator+(N &left, N &right);
int		operator-(N &left, N &right);

void *	vtable[2] = { (void *)operator+, (void *)operator- };

class	N
{
	public:
		int		nb;
		void	**func;
		char	annotation[100];

		N(int val) : nb(val)
		{
			this->func = (void **) vtable[0];
		}
		
		void	setAnnotation(char *str)
		{
			memcpy(this->annotation, str, strlen(str));
		}
};

int		operator+(N &left, N &right)
{
	return (left.nb + right.nb);
}

int		operator-(N &left, N &right)
{
	return (left.nb - right.nb);
}

int		main(int ac, char **av)
{
	if (ac < 1)
		_exit(1);
	
	N	*a = new N(5);
	N	*b = new N(6);

	a->setAnnotation(av[1]);
	return ( (int (*)(N &, N &)) (b->func)[0] )(*b, *a);
}