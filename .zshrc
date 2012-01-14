# The following lines were added by compinstall
zstyle :compinstall filename '/home/makoto/.zshrc'

autoload -U compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install

#setopt hist_ignore_dups # 履歴の重複を避ける
setopt share_history    # コマンド履歴を共有
setopt auto_pushd       # cd - の補完
setopt correct
setopt list_packed
setopt nolistbeep

zstyle ':completion:*' list-colors 'di=34' 'ln=36' 'so=35' 'ex=32' 'bd=40;33' 'cd=40:33'

# export from .bashrc
alias cp='cp -i'
alias mv='mv -i'

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
alias e='emacs -nw'
alias p='pwd'
alias mk='make -e'
alias euc='LANG=ja_JP.euc-jp'
alias utf='LANG=ja_JP.utf-8'
alias en='LANG=C'
alias php='/usr/bin/php'

export LC_TIME=C
export LANG=C
export PATH=/usr/local/Cellar/ruby/1.9.3-p0/bin:/usr/local/bin:/opt/local/bin:~/bin:$PATH:
export RUBYLIB=.:~/lib/ruby
export EDITOR=emacs
ulimit -c 1000000 # limit for core file

export PGUSER='postgres'

#
autoload colors
colors

RPROMPT="%{${fg[white]}%}   [%/]%{${reset_color}%}"
case ${UID} in
	0)
		PROMPT="%{${fg[yellow]}%}${HOST}%{${fg[green]%}%}%%%{${reset_color}%} "
		PROMPT2="%{${fg[cyan]}%}%_%{${fg[green]%}%}\$%{${reset_color}%} "
		;;
	*)
	    PROMPT="%{${fg[white]}%}${HOST}%{${fg[green]%}%}\$%{${reset_color}%} "
		PROMPT2="%{${fg[cyan]}%}%_%{${fg[green]%}%}\$%{${reset_color}%} "
		[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
		PROMPT="%{${fg[red]}%}${HOST}%{${fg[green]%}%}\$%{${reset_color}%} "
		;;
esac

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi

utf
