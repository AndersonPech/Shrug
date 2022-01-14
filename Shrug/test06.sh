#!/bin/sh

#Test rm 

./shrug-init >/dev/null
touch a b 
./shrug-add a b >/dev/null
./shrug-commit -m "1" >/dev/null
./shrug-rm --cached a 

if [ -e .shrug/index/a ] || [ ! -e .shrug/index/b ]
then
    echo failed
    rm -r .shrug 
    rm a b 
    exit 1
fi 

echo passed
rm -r .shrug 
rm a b 
exit 0 
