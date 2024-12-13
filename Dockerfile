FROM alpine:latest

RUN apk add --no-cache bash openssh-client findutils

COPY scripts/*.sh /

# WORKDIR /github/workspace

ENTRYPOINT ["/entrypoint.sh"]
