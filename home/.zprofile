###############
## .zprofile ##
###############
#
# From Stack Overflow (https://unix.stackexchange.com/questions/
# 71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout):
#
# .zprofile is basically the same as .zlogin except that it's sourced 
# directly before .zshrc is sourced instead of directly after it. According 
# to the zsh documentation, ".zprofile is meant as an alternative to 
# `.zlogin' for ksh fans; the two are not intended to be used together, 
# although this could certainly be done if desired."

## Start the WM or Xserver at login
# 
# If the $DISPLAY string has zero length and we are trying to log in on
# tty1, export some variables to adjust the keyboard settings and load
# the display brouhaha
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    export XKB_DEFAULT_LAYOUT=us
    export XKB_DEFAULT_OPTIONS=caps:super
    exec sway
    #export XDG_SESSION_TYPE=wayland dbus-run-session startplasmacompositor
    #exec startx
fi

