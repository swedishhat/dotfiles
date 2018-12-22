#xrandr --output eDP1 --primary --dpi 220
xrandr --output eDP1 --primary --dpi 100
xrandr --output DP1 --auto --above eDP1
xmodmap ~/.Xmodmap
#~/.fehbg &
#eval 'cat ~/.fehbg'
#exec i3
exec startxfce4

