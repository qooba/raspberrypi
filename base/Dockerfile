FROM raspbian/stretch
COPY qemu-arm-static /usr/bin
WORKDIR /
RUN apt update && apt install -y --fix-missing make g++
RUN apt update && apt install -y --fix-missing python-pip
CMD [ "bash" ]
