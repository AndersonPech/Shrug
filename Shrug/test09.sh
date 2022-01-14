#!/bin/sh

#Testing shrug-rm with shrug-status 

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
x=`./shrug-status | egrep ^b`
if [ "$x" != "b - file changed, changes staged for commit" ]
then
    echo failed
    rm -r .shrug
    rm a b
    exit 
fi 

./shrug-rm --cached b 
x=`./shrug-status | egrep ^b`

if [ "$x" != "b - untracked" ]
then
    echo failed
    rm -r .shrug
    rm a b
    exit 
fi 

touch c 
./shrug-add c 
./shrug-rm a 

x=`./shrug-status | egrep ^a`

if [ "$x" != "a - deleted" ]
then
    echo failed
    rm -r .shrug
    rm a b c 
    exit 
fi 

x=`./shrug-status | egrep ^c`

if [ "$x" != "c - added to index" ]
then
    echo failed
    rm -r .shrug
    rm a b c 
    exit 
fi 

echo passed
rm -r .shrug 
rm b c  
exit 0