# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# @todo #1 Switch/case
if [[ "$(uname)" == "Linux" ]]; then
  source ~/dotfiles/.linux.zshrc
elif [[ "$(uname)" == "Darwin" ]]; then
  source ~/dotfiles/.mac.zshrc
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias tree='tree -C'
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


function map() {
  while read element; do
    eval "$1" "$element"
  done
}

TRASH_DIR=~/.trash
mkdir -p $TRASH_DIR
function del() {
  mv -fv -t $TRASH_DIR "$@"
  if [ "$?" -eq "1" ]; then
    DIR=`date +%d%m%y%H%M%S`
    mkdir $TRASH_DIR/$DIR
    mv -fv -t $TRASH_DIR/$DIR "$@"
  fi
}


# Colors
export GREEN=92 

#Git
function colorStatus {
  git status | GREP_COLOR=$GREEN egrep 'working directory clean|$'
}
function rin() {
  colorStatus
  echo
  git log --oneline --decorate --all --graph | head -10
}

alias watch_repo='watch --color -t -d -n 1 git gr --color=always'

alias rin='git status; git gr'

# @todo # create editZshRc command

# @todo #1 check if works on Mac/Linux
function kill8080 {
  PID=`netstat -tulpn 2>/dev/null | grep 8080 | awk '{ print $7 }' | cut -d/ -f1`
  kill $PID
}

source dotfiles/e_scripts.zsh

alias leak_canary='~/utils/leak_canary.bash'

function check_conflicts() {
	BRANCH=$1
	git merge --no-commit --no-ff $BRANCH 
	git diff --diff-filter=U | less
}

alias cs='check_conflicts statistics'

function kill_gradle_daemon() {
  kill -9 `ps x | grep GradleDaemon | grep -v grep | cut -f1 -d' '`
}

function reset_network_card() {
	nmcli radio wifi off
	nmcli radio wifi on
}
function sr {
  xrandr --newmode "1680x1050_60.00" 146.25 1680 1784 1960 2240 1050 1053 1059 1089 -hsync +vsync
  xrandr --addmode VGA-1 1680x1050_60.00
  exit
}

# TODO: ps x | grep studio.sh | grep -v grep | cut -f1 -d' '

alias grant='adb shell pm grant io.callpage.crm android.permission.READ_PHONE_STATE'
alias revoke='adb shell pm revoke io.callpage.crm android.permission.READ_PHONE_STATE'

export PATH=~/.local/bin:$PATH
