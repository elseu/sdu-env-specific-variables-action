FROM alpine:latest

RUN apk add bash gettext --no-cache --update

COPY run.bash /run.bash
RUN chmod +x /run.bash

ENTRYPOINT [ "/run.bash" ]
