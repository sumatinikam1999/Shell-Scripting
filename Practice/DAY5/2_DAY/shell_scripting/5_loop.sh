#!/bin/bash
for i in $@
do
if [ $((i % 2 )) -ne 0 ]
then
echo "$i odd number"
fi
done