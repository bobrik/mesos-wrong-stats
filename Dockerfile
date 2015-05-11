FROM alpine:3.1

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
