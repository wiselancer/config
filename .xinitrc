xscreensaver -no-splash &
exec urxvtd -q -f &
ck-launch-session blueman-applet &

DEFAULT_SESSION=awesome

case $1 in
awesome)
	exec awesome
	;;

kde)
	exec startkde
	;;
xfce4)
	exec startxfce4
	;;
icewm)
	icewmbg &
	icewmtray &
	exec icewm
	;;
wmaker)
	exec wmaker
	;;
blackbox)
	exec blackbox
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
