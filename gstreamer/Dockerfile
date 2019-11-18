FROM raspbian/stretch
COPY qemu-arm-static /usr/bin
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt install --fix-missing -yq make g++ python-pip python-pil python-opencv gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-plugins-bad && rm /usr/bin/qemu-arm-static
WORKDIR /
COPY start.sh .
EXPOSE 5000
CMD [ "/start.sh" ]
