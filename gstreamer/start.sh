#! /usr/bin/env sh

#gst-launch-1.0 -v v4l2src device=/dev/video0 ! image/jpeg,width=600,height=450,type=video,framerate=15/1  ! gdppay ! tcpserversink host=0.0.0.0 port=5000

TYPE="jpeg"
WIDTH=600
HEIGHT=450
FRAMERATE=15
PORT=5000

while true ; do
  case "$1" in
    --type) export TYPE="$2" ; shift 2 ;;
    --width) export WIDTH="$2" ; shift 2 ;;
    --height) export HEIGHT="$2" ; shift 2 ;;
    --framerate) export FRAMERATE="$2" ; shift 2 ;;
    --port) export PORT="$2" ; shift 2 ;;
    *) break ;;
  esac
done

echo $TYPE
echo $WIDTH
echo $HEIGHT
echo $FRAMERATE
echo $PORT

case "$TYPE" in
   "jpeg") gst-launch-1.0 -v v4l2src device=/dev/video0 ! image/jpeg,width=$WIDTH,height=$HEIGHT,type=video,framerate=$FRAMERATE/1  ! gdppay ! tcpserversink host=0.0.0.0 port=$PORT
   ;;
   *) echo "ERROR :( please use type jpeg" 
   ;;
esac


