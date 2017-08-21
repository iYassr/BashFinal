#!/bin/bash
#Yasser ALdosari
#this script works on Ubuntu.
#this function is to display the passwd file in a human readable way
dispPasswd(){
#space 
echo -e "\n" 

#using while to display it line by line, and cut to split it into pieces
file="/etc/passwd"
while read -r line
do
    cline="$line"
    user=$(echo $cline | cut -d':' -f1)
    uid=$(echo $cline | cut -d':' -f3)
    gid=$(echo $cline | cut -d':' -f4)
    homdir=$(echo $cline | cut -d':' -f6)
    shell=$(echo $cline | cut -d':' -f7)
    echo -e User:$user ID:$uid GroupID:$gid Home Directiory:$homedir CurrentShell:$shell


done < "$file"
}

#function to get a list of all processess, log it into /var/log/getproc.txt and give the option to kill it

getProcAll(){

echo -e "\n" 
#used wc -l to display how many lines
	echo logging all of your processes to /var/log/getproc.txt
	a=$(ps -ef | wc -l)
	echo You have $a running process > /var/log/getproc.txt
	ps -ef >> /var/log/getproc.txt
	echo $(ps -ef)
	ps -ef
	read -p "Enter the { name OR the number } of the process you want to kill " pn
#to verify the input whether int to string, to decide which command to use
	if [ $pn -eq $pn ] 2>\dev\null; then
		kill $pn
	else
		$(pkill $pn)
	fi
}

checkOS(){
	#grip the op system information and use if to verify
	kali=$(  uname -a | grep kali | wc -l) 
	fedora=$( uname -a | grep fedora | wc -l )
	ubuntu=$( uname -a | grep ubuntu | wc -l )
	cent=$( uname -a | grep cent | wc -l )
	echo -e "\n" 
	if [ $kali == 1 ]; then 
		echo You are using Kali! 
	elif [ $fedora == 1 ]; then 
	       echo You are using Fedora
        elif [ $ubuntu == 1 ]; then 
 		echo You are using Ubuntu
	fi		
#if you dont see 64 bit, Your OP System arch. is 32 
	op=$( uname -a | grep 64 | wc -l) 
	if [ $op -ge 1 ]; then
		echo and running 64bit OP System
	else 
		echo and running 32bit OP System
	fi

}



main(){

echo Welcome man YASSER script
#verify if running as sudo or not
if [ $(id -u) -ne 0 ]; then 
   echo please run as root to utilize this AWESOME script
else 
   echo You are using root, good
fi
while [[ true ]]; do
	# man page of the script
	echo Enter 1 to display the passwd file in a human readable way
	echo Enter 2 to display and log the list of procesesses, and kill some of them
	echo Enter 3 to display what distribution you are using and the CPU architicture
	echo Enter 4 to quit the program
	echo you can use the first argument to select the number directly


	# the first arguement can be used to pass input into the switch
	if [ $# -eq 0 ]; then
		read -p "enter the script you want to run.. " num
	else 
	 	num=$1
	fi 

	#to choose what function to call
	case $num in
	1) dispPasswd $@
	;; 
	2) getProcAll
	;;
	3) checkOS
	;;
	4) break
	;;
	esac
done 
}

main $@