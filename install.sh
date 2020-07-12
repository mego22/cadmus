#!/usr/bin/env bash

main () {
    printThis
    check_for_dependencies
    download_the_repo
    Install_tools
}

printThis () {

    echo "This Script will print to the terminal for review, press any key to continue"
    read -d '' -s -n1

    cd $(dirname "$0")
    pwd
    me=`basename "$0"`
    safePrint $me


    echo "Are you happy to proceed? Press y to continue"
    read -d '' -s -n1 proceedQ
    if [ "$proceedQ" != "y" ]; then
        exit 0
    fi
}

safePrint () {
    if hash highlight 2>/dev/null; then
        highlight "$@"
    else
        cat "$@"
    fi
}


check_for_dependencies () {

    echo "Press Any Key to Check for dependencies, press the c Key to Skip this"
    read -d '' -s -n1 CheckDepQ
    if [ "$CheckDepQ" == "c" ]; then
        return
    fi

    for i in ${StringArray[@]}; do
        command -v "$i" >/dev/null 2>&1 || { echo >&2 "I require $i but it's not installed.  Aborting."; exit 1; }
    done

    echo "All Dependencies Satisfied"

}

download_the_repo () {

    echo "Press y to download the repo"
    read -d '' -s -n1 downloadQ
    if [ "$downloadQ" != "y" ]; then
        return
    fi

    mkdir -p $HOME/DotFiles/
    cd $HOME/DotFiles


    if [[ -d ".git" ]]; then
        echo "Detected a Git Repo, Press y to add a submodule or any key to exit"

        read -d '' -s -n1 CheckDepQ
        if [ "$CheckDepQ" != "y" ]; then
                echo "You pressed any key"
        fi

        git submodule add https://github.com/RyanGreenup/cadmus && echo "Submodule succesfully added"

    elif [[ -f ".git" ]]; then
        echo "You have a file called .git In there, delete that first.";
    else
        git clone https://github.com/RyanGreenup/cadmus
    fi

    echo "Repository is downloaded"

}

Install_tools () {
    echo "Installing with Stow from $(pwd) to $HOME"
}

# Declare an array of string with type
declare -a StringArray=("R"
                        "highlight"
                        "node"
                        "nvim"
                        "fzf"
                        "code"
                        "sk"
                        "rg"
                        "perl"
                        "stow"
                        "python"
                        "tmsu"
                        "ranger"
                        "mdcat"
                        "xclip"
                        "sd"
                        "fd"
                        "sed"
                        "cut"
                        "grep"
                        "find"
                        "realpath"
                       )

# Iterate the string array using for loop
##

main
exit 0
