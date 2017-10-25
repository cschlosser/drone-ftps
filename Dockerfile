FROM alpine

RUN apk --no-cache add \
        libressl \
        lftp

ADD upload.sh /bin/
RUN chmod +x /bin/upload.sh

ENTRYPOINT /bin/upload.sh
