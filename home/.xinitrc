xrandr --output eDP1 --primary --dpi 220
xrandr --output DP1 --auto --above eDP1
xmodmap ~/.Xmodmap
exec i3
