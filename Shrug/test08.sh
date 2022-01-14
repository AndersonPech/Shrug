#!/bin/sh

#Test shrug-status 
touch a b 
./shrug-init >/dev/null 
./shrug-add a b >/dev/null 
./shrug-commit -m 'test' >/dev/null

x=`./shrug-status | egrep ^a`
echo $x

if [ "$x" != "a - same as repo" ]
then
    echo failed
    rm -r .shrug
    rm a b
    exit 
fi 

echo hello>b 
./shrug-add b >/dev/null 
x=`.shrug-status | egrep ^b`
if [ "$x" != "b - file changed, changes staged for commit" ]
then
    echo failed
    rm -r .shrug
    rm a b
    exit 
fi 

echo passed
rm -r .shrug 
rm a b 
exit 0


