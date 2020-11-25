#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                   scp -P 4242 path/source.c end@VM_IP:/tmp                    #
#                   scp -P 4242 path/script.sh end@VM_IP:/tmp                   #
#                                                                               #
#     pwd: 3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc source.c -o ft_bonus3

# Set SUID to give root user permissions
chmod u+s ft_bonus3

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_bonus3 ~


# Then you have to run the program and cat .pass as bonus3 by taping manually these commands

#	su bonus3
#	/home/user/end/ft_bonus3 ""
#	cat /home/user/end/.pass
