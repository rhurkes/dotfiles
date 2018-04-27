# Color-coded smiley based on exit code of last command
smiley () {
    if [ $? = 0 ]; then
        echo -e ${green}:\)${nc};
    else
        echo -e ${red}:\(${nc};
    fi
}

# Replaces cd command with one that calls the builtin and performs an ls
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}
