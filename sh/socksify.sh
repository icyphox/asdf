export SOCKS_SERVER="127.0.0.1:1"
exec socksify w3m \
	-T text/html \
	-cols $(tput cols) \
	-dump \
	-o display_image=false \
	-o display_link_number=true \
	"https://google.com"
