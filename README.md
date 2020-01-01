## Introduction

Docker images for raspberrypi 

## Qemu

To build you need to install **qemu**:
```
sudo apt-get install -y qemu binfmt-support qemu-user-static
wget http://archive.ubuntu.com/ubuntu/pool/main/b/binfmt-support/binfmt-support_2.1.8-2_amd64.deb
sudo apt install ./binfmt-support_2.1.8-2_amd64.deb
rm binfmt-support_2.1.8-2_amd64.deb
cp /usr/bin/qemu-aarch64-static ./base
```

## Installation

Install [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) with [Etcher](https://www.balena.io/etcher/)

## Enable camera

***raspi-config*** - enable camera

Add ***bcm2835-v4l2*** to ***/etc/modules*** and reboot

## Set static ip

Add to ***/etc/dhcpcd.conf***:
```
interface eth0
static ip_address=x.x.x.y/24
static routers=x.x.x.1
static domain_name_servers=8.8.8.8
```

## Install docker

```
curl -sSL get.docker.com | sh && \
sudo usermod pi -aG docker && \
newgrp docker
```

## Disable swap

```
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo update-rc.d dphys-swapfile remove && \
sudo swapoff -a
```

## Install kubernetes

Add to ***/boot/cmdline.txt***
```
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
```

Add to ***/etc/apt/sources.list.d/kubernetes.list***
```
deb http://apt.kubernetes.io/ kubernetes-xenial main
```

run
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```

```
sudo apt-get update
sudo apt-get install -qy kubeadm
```

## Run docker image on raspberry pi

run on raspberry pi:
```
docker run -it -p 5000:5000 --device /dev/video0:/dev/video0 qooba/raspberrypi:gstreamer /start.sh --framerate 30
```

run on client:
```
/usr/bin/gst-launch-1.0 -v tcpclientsrc host=192.168.x.x port=5000 ! gdpdepay ! jpegparse ! jpegdec ! videoconvert  ! autovideosink sync=false
```


raspberry
```
gst-launch-1.0 -v v4l2src device=/dev/video0 ! jpegenc ! gdppay ! tcpserversink host=0.0.0.0 port=5000
```

client:
```
/usr/bin/gst-launch-1.0 -v tcpclientsrc host=192.168.*.* port=5000 ! gdpdepay ! jpegparse ! jpegdec ! autovideosink sync=false

/usr/bin/gst-launch-1.0 -v tcpclientsrc host=192.168.*.* port=5000 ! gdpdepay ! jpegparse ! jpegdec ! videoconvert ! x264enc qp-min=18 ! avimux ! filesink location=output.avi

/usr/bin/gst-launch-1.0 -v tcpclientsrc host=192.168.0.101 port=5000 num-buffers=1 ! gdpdepay ! jpegparse ! jpegdec ! filesink location=./test.jpg

/usr/bin/gst-launch-1.0 -v tcpclientsrc host=192.168.0.101 port=5000 ! gdpdepay ! jpegparse ! jpegdec ! videoconvert ! pngenc snapshot=true ! filesink location=a.png

/usr/bin/gst-launch-1.0 -v tcpclientsrc host=qba-jetson port=5000 ! gdpdepay ! jpegparse ! jpegdec ! videoconvert ! jpegenc snapshot=true ! filesink location=1.jpg
```


with browser 

server:
```
gst-launch-1.0 -v v4l2src device=/dev/video0 ! videoconvert ! videoscale ! video/x-raw,width=320,height=240 ! clockoverlay shaded-background=true font-desc="Sans 38" ! theoraenc ! oggmux ! tcpserversink host=0.0.0.0 port=5000
```

client
```
<!DOCTYPE html>
<html>
        <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8">
                <title>gst-stream</title>
        </head>
        <body>
                <video width=320 height=240 autoplay>
                        <source src="http://localhost:8080">
                </video>
        </body>
</html>
```
