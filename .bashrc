# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export PATH=/opt/puppetlabs/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH

# User specific aliases and functions
#alias vi='/usr/bin/vim'
alias vi='/bin/vim'

# git prompt support
#source /usr/share/doc/git-1.8.3.1/contrib/completion/git-completion.bash
#source /usr/share/doc/git-1.8.3.1/contrib/completion/git-prompt.sh
source /usr/share/doc/git/contrib/completion/git-completion.bash
source /usr/share/doc/git/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRYSTATE=true

# git branch coloring
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"
COLOR_MAGENTA="\033[0;38;5;013m"
COLOR_ORANGE="\033[0;38;5;214m"

function git_color {
local git_status="$(git status 2> /dev/null)"

if [[ $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_GREEN
elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
elif [[ $git_status =~ "untracked files present" ]]; then
    echo -e $COLOR_RED
elif [[ $git_status =~ "to unstage" ]]; then
    echo -e $COLOR_YELLOW
else
    echo -e $COLOR_OCHRE
fi
}

function git_branch {
local git_status="$(git status 2> /dev/null)"
local on_branch="On branch ([^${IFS}]*)"
local on_commit="HEAD detached at ([^${IFS}]*)"

if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
fi
}

# Coloring the PS1
PS1="[\u@\h: \[\e[0;96m\]\W"
PS1+="\[\$(git_color)\]"
PS1+=" \$(git_branch)"
PS1+='\[\e[0m\]]\$ '
export PS1
