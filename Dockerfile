FROM ubuntu:16.04
MAINTAINER nathaniel.wilson@portworx.com

ENV HUGO_VERSION 0.42.1
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

RUN apt-get update -yq
RUN apt-get install -yq git curl

RUN curl -L https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz > hugo.tar.gz
RUN gzip -dc hugo.tar.gz | tar -xof -
RUN mv hugo /usr/local/bin
RUN rm -f hugo.tar.gz

ADD . /pxbackup
WORKDIR /pxbackup
ENTRYPOINT ["/usr/local/bin/hugo"]
