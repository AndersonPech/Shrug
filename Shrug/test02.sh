#!/bin/sh

#test errors in commit

./shrug-commit -m message1 2&> /tmp/test$$
x=`cat /tmp/test$$`

if [ "$x" != "shrug-commit: error: no .shrug directory containing shrug repository exists" ]
then
    echo "${red}failed"
    exit 1
fi

./shrug-init > /dev/null

#If no -m 
./shrug-commit message 2&> /tmp/test2$$ 
x=`cat /tmp/test2$$`

if [ "$x" != "usage: shrug-commit [-a] -m commit-message" ]
then
    rm -r .shrug 
    echo "failed"
    exit 1
fi

#If nothing in index
./shrug-commit -m message 2&> /tmp/test3$$ 
x=`cat /tmp/test3$$`
if [ "$x" != "nothing to commit" ]
then
    rm -r .shrug 
    echo "failed"
    exit 1 
fi

rm -r .shrug
echo "passed"
exit 0