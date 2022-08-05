FROM alpine:edge

RUN apk --no-cache add \
        openssh \
        libressl \
        lftp \
        bash

ADD upload.sh /bin/
RUN chmod +x /bin/upload.sh && mkdir ~/.ssh && chmod 700 ~/.ssh

ENTRYPOINT /bin/upload.sh
