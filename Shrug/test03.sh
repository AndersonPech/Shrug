#!/bin/sh

#Test log

./shrug-init >/dev/null
touch a b 
echo hello>a
./shrug-add a >/dev/null
./shrug-commit -m 'test 1' >/dev/null
./shrug-log 1&>/tmp/test 
x=`cat /tmp/test`

if [ "$x" != "0 test 1" ]
then
    rm -r .shrug
    echo failed
    exit 1
fi

echo world>b
./shrug-add b >/dev/null
./shrug-commit -m 'test 2' >/dev/null
./shrug-log 1&>/tmp/test2
x=`cat /tmp/test2 | head -1`


if [ "$x" != "1 test 2" ]
then
    rm -r .shrug
    echo failed her
    exit 1
fi

rm -r .shrug
rm a
rm b 

echo passed
exit 0