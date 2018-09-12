FROM alpine:edge

RUN apk --no-cache add \
        libressl \
        lftp \
        bash

ADD upload.sh /bin/
RUN chmod +x /bin/upload.sh

ENTRYPOINT /bin/upload.sh
