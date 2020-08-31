FROM alpine:latest

ENV HUGO_VERSION 0.74.3
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

RUN apk --no-cache add git curl

RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz > hugo.tar.gz
RUN gzip -dc hugo.tar.gz | tar -xof -
RUN mv hugo /usr/local/bin
RUN rm -f hugo.tar.gz

ADD . /pxbackup
WORKDIR /pxbackup
ENTRYPOINT ["/usr/local/bin/hugo"]
