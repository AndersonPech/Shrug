#!/bin/sh

#Testing the shrug-init and shrug-add scripts

red=`tput setaf 1`
green=`tput setaf 2`
#Testing shrug-add with no .shrug
./shrug-add  2&> /tmp/testadd$$
add=`cat /tmp/testadd$$`
echo $add
if [ "$add" != "shrug-add: error: no .shrug directory containing shrug repository exists" ]
then
    echo "${red}failed"
    exit 1
fi


#Testing shrug-init 
./shrug-init 2&> /tmp/testinit$$
init=`cat /tmp/testinit$$`
if [ "$init" != "Initialized empty shrug repository in .shrug" ]
then
    echo "${red}failed"
    exit 1
fi

touch a b 
./shrug-add a b > /dev/null

#Checking if shrug-add actually adds files
if [ ! -e .shrug/index/a ] || [ ! -e .shrug/index/b ]
then
    echo "${red}failed"
    exit 1
fi

#Cleaning
rm -r .shrug 

echo "${green}passed"
exit 0






 