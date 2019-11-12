FROM qooba/raspberrypi:base
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && apt update && apt -yq install python-pil python-opencv 
RUN pip install flask meinheld gunicorn==19.9.0

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py
RUN rm /usr/bin/qemu-arm-static
COPY ./app /app
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/start.sh"]
