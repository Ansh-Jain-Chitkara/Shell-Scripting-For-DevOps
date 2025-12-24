#!/bin/bash

<< comment
Ansh has build knowledge with conditionals in shells scripting
comment

function is_loyal() {
read -p "$1 is passionate about devOps(Yes/No): " check
read -p "$1 interest in DevOps in %: " cal

if [[ $check == "yes" ]];
then
     echo "$1 is passionate"

elif [[ $cal -ge 100 ]];
then 
     echo "$1 is passionate for sure"

else
     echo "$1 is partially passionate"
fi
}

is_loyal "Ansh"
