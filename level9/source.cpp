#include <unistd.h>
#include <cstring>

class N {
public:
	int nb;
	int (N::*func)(N &);
	char annotation[100];

	N(int val) : nb(val)
	{
		this->func = &N::operator+;
	}
	int operator+(N &right)
	{
		return this->nb + right.nb;
	}
	int operator-(N &right)
	{
		return this->nb - right.nb;
	}
	void setAnnotation(char *str)
	{
		memcpy(this->annotation, str, strlen(str));
	}
};

int		main(int ac, char **av)
{
	if (ac < 1)
		_exit(1);

	N *a = new N(5);
	N *b = new N(6);

	a->setAnnotation(av[1]);
	return (b->*(b->func))(*a);
}