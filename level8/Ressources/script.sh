#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level9@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level9@VM_IP:/tmp                 #
#                                                                               #
#     pwd: c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc source.c -o ft_level8

# Set SUID to give root user permissions
chmod u+s ft_level8

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level8 ~


# Then you have to run the program and cat .pass as level0 by taping manually these commands

#	su level8
#	// For the exemple we'll use the 2nd solution ("auth ", "service", "service", "login")
#	/home/user/level9/ft_level8
#	cat /home/user/level9/.pass
