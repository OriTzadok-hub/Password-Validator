#!/bin/bash

#red color for errors
error_color="$(tput setaf 1)"

#-------------------------------- Functions --------------------------------

#A function that gets a password and validates it
function passwordValidator(){
    
    local password=$1
    #green color for success
    local success_color="$(tput setaf 2)"
    #holds the lengths of the given password
    local len="${#password}"

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

    #if we reached here, the validation failed
    return 1
}

#A function that gets a file name/path and gets the password from it
#the function will read only the first line in the file.
function readPassword(){
    local path=$1
    while read -r line
    do
       echo "$line"
       break
    done < "$path"

}

#-------------------------------- Main --------------------------------

#if the flag -f isn't given
if [ $1 != "-f" ]; then
    pwd=$1
    passwordValidator "$pwd"
#if the flag -f was given - read the password from a file
else
    while getopts ":f:" opt; do
        case $opt in
        f)
            file_path=$OPTARG
            #if the file exists
            if [ -f $file_path ]; then
                password=$(readPassword "$file_path")
                passwordValidator "$password"
            #if the file doesn't exist
            else
                echo "$error_color The file $file_path doesn't exist"
                exit 1
            fi
        ;;
        #if the flag -f was given but without an argument
        :)
            echo "$error_color Option -$OPTARG requires an argument." >&2
            exit 1
        ;;
        esac
    done
fi
exit $?
