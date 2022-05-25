#!/bin/bash

password=$1
#if exit code won't change - validation failed
exit_code=1
#red color for errors
error_color="$(tput setaf 1)"
#green color for success
success_color="$(tput setaf 2)"
#holds the lengths of the given password
len="${#password}"

#check if a password was given
if test $len -eq 0; then
    echo "$error_color Validation failed, no password were given"
#check if the password length is less than 10
elif test $len -lt 10; then
    echo "$error_color Validation failed, The password length should be greater than or equal to 10"
#check if the password does not contain upper case letters, lower case letters and numbers
elif [[ !($password =~ [0-9]) || !($password =~ [[:lower:]]) || !($password =~ [[:upper:]]) ]]; then
    echo "$error_color Validation failed, The password should contain Upper Case letters, Lower Case letters and Numbers (atleast one of each)" 
#if we got here , the validation succeeded
else
    echo "$success_color Validation succeeded!, it is a strong password"
    exit_code=0
fi
    
exit $exit_code