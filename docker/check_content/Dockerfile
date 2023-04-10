FROM alpine:latest

RUN apk add --no-cache bash #íntall bash

ENTRYPOINT ["bash", "-c", "cat \"$@\"", "--"]
#sets the entrypoint to a Bash command that prints the contents of the file passed in as an argument

CMD ["/etc/hosts"]
#print the content in /etc/hosts by default
