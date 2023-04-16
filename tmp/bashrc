# .bashrc

# ----------------------------------------------------------------------

# Source global definitions
if [ -f /etc/bashrc ]
then
    . /etc/bashrc
fi

# ----------------------------------------------------------------------

if [ -f /etc/bash_completion ]
then
    . /etc/bash_completion
fi

# ----------------------------------------------------------------------

export BIN_HOME=${HOME}/Bin
export CONFIG_HOME=${HOME}/Config

# ----------------------------------------------------------------------

export OS_NAME=`lsb_release -i | cut -f 2 -d ':' | tr -d '\t'`
export OS_RELEASE_NAME=`lsb_release -c | cut -f 2 -d ':' | tr -d '\t'`
export OS_VERSION=`lsb_release -r | cut -f 2 -d ':' | tr -d '\t'`

export BIN_DIR=${HOME}/Bin
export HOST_DIR=${BIN_DIR}/Host
export DOMAIN_DIR=${BIN_DIR}/Domain
export OS_DIR=${BIN_DIR}/OperatingSystem

export HOSTNAME_DIR=${HOST_DIR}/`hostname`
export DOMAINNAME_DIR=${DOMAIN_DIR}/`domainname`
export OS_NAME_DIR=${OS_DIR}/${OS_NAME}
export OS_RELEASE_NAME_DIR=${OS_NAME_DIR}/${OS_RELEASE_NAME}
export OS_RELEASE_DIR=${OS_RELEASE_NAME_DIR}/${OS_VERSION}

# ----------------------------------------------------------------------

export ROOT_PATH=${HOSTNAME_DIR}:${MISC_HOST_DIR}:${DOMAINNAME_DIR}:${RELEASE_DIR}:${OS_RELEASE_NAME_DIR}:${OS_NAME_DIR}:${OS_DIR}:${BIN_DIR}

# ----------------------------------------------------------------------

export GOPATH=${HOME}/gopath

export PATH=${GOPATH}:${GOPATH}/bin:${BIN_HOME}:${ROOT_PATH}:${PATH}

# ----------------------------------------------------------------------

for aDir in `echo ${ROOT_PATH} | tr -s ':' ' '`
do
	. ${aDir}/.bashrc 2>/dev/null
	. ${aDir}/bashrc  2>/dev/null
done

# ----------------------------------------------------------------------

__compute_git_info() {
    local GIT_INFO="`git remote 2> /dev/null` `git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/'`"

    if [ "${GIT_INFO}" != " " ]
    then
        echo " ${GIT_INFO}"
    fi
}

__prompt_command() {
    local STATUS="$?"
    local GIT_INFO=`__compute_git_info`

    PS1="\n\[\033[0;37m\][\[\033[1;34m\]\u\[\033[0;31m\]@\h\[\033[0;32m\]${GIT_INFO}\[\033[0;37m\]] \`pwd\`>\[\033[0m\] "
}

# ------------------------------------------------------------

export PROMPT_COMMAND=__prompt_command

export TERM=xterm-color

# ----------------------------------------------------------------------

alias ll='ls -l'
alias vi='vim -p'
alias vim='vim -p'

# ----------------------------------------------------------------------