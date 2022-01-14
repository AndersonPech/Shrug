#!/bin/sh

#Further testing on rm


touch a b c 
./shrug-init >/dev/null
echo hello>a
./shrug-add a b c >/dev/null
./shrug-commit -m "1" >/dev/null
echo world>b
./shrug-add b > /dev/null
./shrug-commit -m "2" > /dev/null

./shrug-rm b 

if [ -e b ] || [ -e .shrug/index/b ]
then
    echo failed
    rm -r .shrug 
    rm a c 
    exit
fi

echo world> c 
./shrug-add c 
x=`./shrug-rm c`

if [ "$x" != "shrug-rm: error: 'c' has changes staged in the index" ]
then
    echo failed 
    rm -r .shrug 
    rm a c 
    exit
fi 

./shrug-rm --force --cached c >/dev/null

if [ -e .shrug/index/c ]
then
    echo failed 
    rm -r .shrug 
    rm a c 
    exit
fi 

echo passed
rm -r .shrug
rm a 
exit
