# status based on exit code of last command
__exit_status () {
    if [ $? = 0 ]; then
        echo -e ${green}$'\u2705'${nc};
    else
        echo -e ${red}$'\u274C'${nc};
    fi
}

# gets current k8s context
__kube_ps1() {
  CONTEXT=$(kubectl config view | grep current-context | awk '{ print $NF }' | awk -F '.' '{ print $1 }')
  echo -e "[${lightblue}$(echo -e '\u2388')${nc} ${CONTEXT}]"
}

# Replaces cd command with one that calls the builtin and performs an ls
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}
