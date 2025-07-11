#!/bin/bash

#This is called as array instead of giving single values, it can hold multiple values
PERSONS=("Sumati" "Bhargav" "Ram")

#inside array we always refer values with index and it starts with 0
echo "First person: ${PERSONS[0]}

#to print all persons 
echo "All persons: ${PERSONS[@]}

