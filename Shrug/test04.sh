#!/bin/sh

#Test shrug-show

./shrug-init >/dev/null
touch a b c
echo hello > b
./shrug-add a b c >/dev/null
./shrug-commit -m 'test 1' >/dev/null
x=`./shrug-show :b`
if [ "$x" != "hello" ]
then
    echo failed
    exit
fi

x=`./shrug-show 0:b`
if [ "$x" != "hello" ]
then
    rm -r .shrug
    rm a b c 
    echo failed
    exit
fi
rm -r .shrug
rm a b c 
echo passed