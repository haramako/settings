# The following lines were added by compinstall
zstyle :compinstall filename '/home/makoto/.zshrc'

autoload colors
colors

autoload -U compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
bindkey -e

#setopt hist_ignore_dups # 履歴の重複を避ける
setopt share_history    # コマンド履歴を共有
setopt auto_pushd       # cd - の補完
setopt correct
setopt list_packed
setopt nolistbeep

zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'so=35' 'ex=32' 'bd=40;33' 'cd=40:33'

alias cp='cp -i'
alias mv='mv -i'
alias e='emacs -nw'
alias p='pwd'
alias mk='make -e'
alias be='bundle exec'

if [ `uname` = 'Darwin' ]; then
    alias ls='ls -G'
    alias ll='ls -Gl'
    alias la='ls -Gla'
else
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.i386.rpm=01;31:*.src.rpm=01;30:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:'
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -la'
fi

export LC_TIME=C
export PATH=~/bin:~/.setting/bin:~/node_modules/.bin:$PATH
export RUBYLIB=.:~/lib/ruby
export EDITOR=emacs
export PGUSER='postgres'
export GAUCHE_LOAD_PATH=.:~/.setting/share/gauche:~/.setting/share/slib

ulimit -c 1000000 # limit for core file


# load setting for local
[ -f ~/.zshrc-local.sh ] && source ~/.zshrc-local.sh

export HOST_COLOR=$fg[cyan]

# プロンプトの色を変える
PROMPT2="%{${fg[cyan]}%}%_%{${fg[green]%}%}\$%{${reset_color}%} "
case ${UID} in
    0)
        # rootなら赤に
	PROMPT="%{${fg[yellow]}%}${HOST}%{${fg[green]%}%}%%%{${reset_color}%} "
	;;
    *)
        # それ以外は白
	PROMPT="${HOST_COLOR}${HOST}%{${fg[green]%}%}\$%{${reset_color}%} "
	;;
esac
# リモートアクセスの場合 @ をつける
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[red]}%}@%{${reset_color}%}${PROMPT}"

source ~/.setting/share/zsh/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
# ターミナルタイトルの設定
case "${TERM}" in
kterm*|xterm*)
    precmd() {
	if [[ -v WSLENV ]]; then
	    # Skip git prompt when WSL.
	    RPROMPT="%{${fg[gray]}%}   [%/]%{${reset_color}%}"
	else
	    RPROMPT="%{${fg[gray]}%}   [%/($(__git_ps1 "%s"))]%{${reset_color}%}"
	fi
		
	if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ]; then
	    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	else
	    echo -ne "\033]0;`basename ${PWD}`\007"
	fi
    }
    ;;
esac

export LANG=ja_JP.utf-8

# Setup pyenv
export PATH="/usr/local/heroku/bin:$PATH"
if which pyenv >/dev/null ; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Setup rbenv
if which rbenv >/dev/null ; then
    eval "$(rbenv init -)"
fi
