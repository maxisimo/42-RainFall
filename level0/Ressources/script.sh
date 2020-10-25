#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level1@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level1@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc source.c -o ft_level0

# Set SUID to give root user permissions
chmod u+s ft_level0

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level0 ~


# Then you have to run the program and cat .pass as level0 by taping manually these commands

# ----------------------------------- #
#              su level0              #
#   /home/user/level1/ft_level0 423   #
#     cat /home/user/level1/.pass     #
# ----------------------------------- #
