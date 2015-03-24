FROM ubuntu:trusty

MAINTAINER yulis

ENV KAFKA_VERSION="0.8.2.1"
ENV SCALA_VERSION="2.10"

RUN apt-get update && apt-get install -y \
  unzip \
  openjdk-7-jdk \
  wget \
  curl \
  git \
  docker.io

ADD download-kafka.sh /tmp/download-kafka.sh

RUN /tmp/download-kafka.sh
RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

#ADD run-kafka.sh /usr/bin/run-kafka.sh
#CMD run-kafka.sh