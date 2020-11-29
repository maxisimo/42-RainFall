<a href="https://www.42.fr/">
    <p><img src="https://www.universfreebox.com/UserFiles/image/site_logo.gif" alt="42 logo" title="42" align="right" /></p>
</a>
<p align="center"><img src="https://user-images.githubusercontent.com/34480775/100523211-ffc36c80-31ae-11eb-86c1-0e2002257c1b.JPG" /></p>


<p align="center">
    <img src="https://img.shields.io/badge/Skill%201-Security-9cf">
    <img src="https://img.shields.io/badge/Skill%202-Assembly-blue">
    <img src="https://img.shields.io/badge/Objectives-reverse%20engineering-brightgreen">
</p>

<br/>
Rainfall is an iso challenge slightly more complex than Snow Crash. You will have to dive deep into reverse engineering, learn to reconstruct a code, and understand it to detect faults. Will you reach the last level?  
<br/>

## General instructions
To make this project, you will have to use a VMV(64 bits). Once you have started your machine with the ISO provided with this subject, if your configuration is right, you will get a simple prompt with an IP :  
![alt tag](https://user-images.githubusercontent.com/34480775/100551564-b728b380-3281-11eb-91e7-51a4d16dbed5.JPG)  
Then, you will be able to log-in using the following couple of login:password :  
`level00:level00`  
You really shoud use the SSH connection available on port 4242 :  
`$> ssh level0@[VM_IP] -p 4242`  
Once logged-in, you will have to find a way to read the ".pass" file with the "levelX" user account of the next level (X = numéro next level).  
This ".pass" file is located at the home root of each (level0 exclu) user.  

## Ressources
### Exploits
- [Buffer overflows](https://beta.hackndo.com/buffer-overflow/)
- [Format string attacks](https://www.exploit-db.com/docs/english/28476-linux-format-string-exploitation.pdf)
- [Return-to-libc](https://beta.hackndo.com/retour-a-la-libc/)

### Helpers
- [Pattern generator](https://wiremask.eu/tools/buffer-overflow-pattern-generator/)
- [Shellcode list](http://shell-storm.org/shellcode/)

### Learn more
- [Learn assembly basics](https://beta.hackndo.com/assembly-basics/)
- [The holy grail of assembler documentation ❤](https://www.gladir.com/CODER/ASM8086/)
- [Additional documentation on buffer overflows attacks](https://itandsecuritystuffs.wordpress.com/2014/03/18/understanding-buffer-overflows-attacks-part-1/)


## Minimal setup requirements of the VM
For this project, I used VirtualBox in order to create the VM. You will also need to download the ISO, avaible in the 42 school intranet.  
- Name : RainFall
- Type : Linux
- Version : Ubuntu (64-bit)
- RAM : 1024 MB
- CPU : 1
- Network access mode : bridge
- Port : 4242


# Rate : 125/100
