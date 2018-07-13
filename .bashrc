#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias dotgit='git --git-dir=/home/jumper/.dotfiles/ --work-tree=/home/jumper/'

PS1='\[\e[35m\][\[\e[34m\]\u\[\e[32m\]@\[\e[33m\]\h \[\e[31m\]\W\[\e[35m\]]\[\e[1;97m\]\$\[\e[0m\] '

# vim
set -o vi
export VISUAL='vim -p'
export EDITOR="$VISUAL"
alias vi="$EDITOR"
alias vim="$EDITOR"
export PAGER='vimpager'
alias less="$PAGER"
alias zless="$PAGER"

# usb scripts
alias usbmount='~/.config/i3/scripts/usb_mount.sh'
alias usbumount='~/.config/i3/scripts/usb_umount.sh'
alias usbbackup='~/.config/i3/scripts/usb_backup.sh'

# for gpg-agent from manpage
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi


# mail
export MAIL="$HOME/.mail/"
