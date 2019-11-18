#! /usr/bin/env sh

gst-launch-1.0 -v v4l2src device=/dev/video0 ! image/jpeg,width=600,height=450,type=video,framerate=15/1  ! gdppay ! tcpserversink host=0.0.0.0 port=5000

