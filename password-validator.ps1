

#-------------------------------- Functions --------------------------------
#This function recieves a password and checks if it's a valid one ,
# and returns 1 if validation failed or 0 if validation succeeded.
function passwordValidator($password){

    $len = $password.Length

    if($len -eq 0){
        write-host("No password were given") -ForegroundColor Red
    }elseif($len -lt 10){
        write-host("The password length should be equal or greater than 10") -ForegroundColor Red
    }elseif(!($password -cmatch "[A-Z]" -and $password -cmatch "[a-z]" -and $password -match "\d")){
        write-host("The password should contain Upper Case letters, Lower Case letters and Numbers (atleast one of each)") -ForegroundColor Red
    }else{
        write-host("Validation Succeeded!, your password is strong") -ForegroundColor Green
        return 0
    }
    return 1
}

#---------------------------------------------------------------------------
#This function recieves a file/file path and reads the password from it, it returns the password.
function readPassword($path){

   $password = Get-Content $path | Select-Object -First 1
   return $password
}


#---------------------------------- Main -----------------------------------
#exit code is set with default error status
$exit_code = 1

#if the flag -f was given in the arguments
if($args[0] -eq "-f"){

    $path = $args[1]

    #if no file name/path was given along with the -f flag
    if($path.Length -eq 0){
        write-host("Option -f requires an argument.") -ForegroundColor Red
    #if the file exists - summon the functions
    }elseif(Test-Path -Path $path -PathType Leaf){
        $password = readPassword $path
        $exit_code = passwordValidator $password
    #the file doesn't exist
    }else {
        write-host("The file $path doesn't exist") -ForegroundColor Red
    }
#the flag -f wasn't given - skip the reading from file part
} else {
    $exit_code = passwordValidator $args[0]
}

exit $exit_code

