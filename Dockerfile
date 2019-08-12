FROM alpine:latest
MAINTAINER Spencer Julian <hellothere@spencerjulian.com>

RUN apk update \
 && apk upgrade \
 && apk add --update curl wget bash ruby ruby-bundler python3 python3-dev py3-pip dumb-init musl linux-headers build-base libffi-dev openssl-dev ruby-rdoc ruby-irb\
 && rm -rf /var/cache/apk/* \
 && gem install foreman \
 && mkdir /geemusic

COPY requirements.txt /tmp
RUN pip3 install -U 'pip<10' && pip3 install -r /tmp/requirements.txt 

COPY . /geemusic
WORKDIR /geemusic

EXPOSE 5000

# Make sure to run with the GOOGLE_EMAIL, GOOGLE_PASSWORD, and APP_URL environment vars!
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["foreman", "start"]
