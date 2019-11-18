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
