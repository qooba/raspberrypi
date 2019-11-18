FROM raspbian/stretch
COPY qemu-arm-static /usr/bin
WORKDIR /
RUN apt update && apt install -y --fix-missing make g++
RUN apt update && apt install -y --fix-missing python-pip
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt -yq install python-pil python-opencv gstreamer1.0-tools gstreamer1.0-plugins-good 
RUN apt -yq install gstreamer1.0-plugins-bad

CMD [ "bash" ]
