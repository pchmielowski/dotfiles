# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

PS1='\n\w \$ '
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# added by Anaconda3 4.0.0 installer
export PATH="/home/piotrek/anaconda3/bin:$PATH"

function del() {
  mv -fv -t ~/Bin "$@"
  if [ "$?" -eq "1" ]; then
    mv -fv -t ~/Bin/duplicates "$@"
  fi
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/piotrek/.sdkman"
[[ -s "/home/piotrek/.sdkman/bin/sdkman-init.sh" ]] && source "/home/piotrek/.sdkman/bin/sdkman-init.sh"
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:/usr/local/go/bin
export GOBIN=/usr/local/go/bin
export GOPATH=$HOME/go

# Colors
export GREEN=92 

#Git
function colorStatus {
  git status | GREP_COLOR=$GREEN egrep 'working directory clean|$'
}
export -f colorStatus
function rin() {
  colorStatus
  echo
  git log --oneline --decorate --all --graph | head -10
}
export -f rin
alias g=git
source /usr/share/bash-completion/completions/git
__git_complete g __git_main

alias _beer="cd ~/AndroidStudioProjects/Beer/; rin"
alias _pomodoro="cd ~/AndroidStudioProjects/Pomodoro/; rin"
function editBashRc {
  vi ~/.bashrc
  source ~/.bashrc
  (cd ~/dotfiles/ && git add .bashrc && git commit)
  echo sourced .bashrc
}

alias h_tmux="less ~/tmux-cheatsheet.markdown"

alias upgrade="sudo apt-get update -y; sudo apt-get upgrade -y"

function setResolution {
  xrandr --newmode "1680x1050_60.00" 146.25 1680 1784 1960 2240 1050 1053 1059 1089 -hsync +vsync
  xrandr --addmode VGA1 1680x1050_60.00
}

alias d='sudo docker'
