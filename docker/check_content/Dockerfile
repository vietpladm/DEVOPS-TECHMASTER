FROM alpine:latest

COPY script.sh / 

RUN chmod +x /script.sh

RUN apk add --no-cache bash

ENTRYPOINT ["/bin/bash", "/script.sh"]

CMD ["/etc/hosts"]
