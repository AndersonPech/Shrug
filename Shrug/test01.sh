#!/bin/sh


#Testing the shrug-commit scripts

red=`tput setaf 1`
green=`tput setaf 2`

touch a b 
./shrug-init
./shrug-add a b > /dev/null

#Checking if shrug-add actually adds files
if [ ! -e .shrug/index/a ] || [ ! -e .shrug/index/b ]
then
    echo "${red}failed"
    exit 1
fi

./shrug-commit -m "Test" > /dev/null 

if [ ! -e .shrug/repository/a ] || [ ! -e .shrug/repository/b ]
then
    echo "${red}failed"
    exit 1
fi


#Cleaning
rm -r .shrug 

echo "${green}passed"
exit 0


