#!/bin/sh

#Test shrug-commit -a 

touch a 

./shrug-init >/dev/null

./shrug-add a  >/dev/null

./shrug-commit -m 'test' > /dev/null

touch e d

./shrug-commit -a -m 'test' >/dev/null 

if [ ! -e .shrug/repository/c ] || [ ! -e .shrug/repository/d ] || [ ! -e .shrug/repository/a ]
then
    echo failed
    rm -r .shrug
    rm e d 
    exit
fi 


rm a b c d e 
rm -r .shrug
echo passed
exit


