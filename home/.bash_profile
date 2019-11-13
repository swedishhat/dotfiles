#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	XKB_DEFAULT_LAYOUT=us
#	exec startx
#fi

export QSYS_ROOTDIR="/home/patrick/.cache/yay/quartus-free/pkg/quartus-free/opt/altera/19.1/quartus/sopc_builder/bin"
