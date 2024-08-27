alias p="sudo pacman"
alias pacsu="sudo pacman -Syu"
alias y="yaourt"
alias aptana="/home/sam/aptana/AptanaStudio"
alias fl="sudo fdisk -l"
alias v="vim"
alias gv= "gvim"
alias s="sudo"
alias sv="sudo vim"
alias sgv= "sudo gvim"
alias l="ls -lha --color"
alias e="less"
alias pg="pgrep -fl"
alias cl="clyde"
alias sc="sudo clyde"
alias gs="git status"
alias ga="git add ."
alias g="git"
alias gl="git log"

gm() {
    git commit -am "$1"
}

c() {
    cd $1
    ls -lh --color
}

gr() {
    grep -ir $1 *
}

bindkey -e


PATH=$PATH:/home/sam/bin/:/opt/android-sdk/tools:/opt/java/jre/bin/


export EDITOR="/usr/bin/vim"
export NOSE_WITH_CHERRYPYLIVESERVER=1

# zgitinit and prompt_wunjo_setup must be somewhere in your $fpath, see README for more.
setopt promptsubst

PS1="$(print '%{\e[1;32m%}[%T] %{\e[1;34m%}%n@%m%{\e[0m%}'):$(print '%{\e[0;34m%}%~%{\e[0m%}')$ "

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=15
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/sam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
# End of lines configured by zsh-newuser-install
