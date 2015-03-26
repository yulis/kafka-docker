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
  docker.io \
  ruby \
  ruby-dev \
  make \
  gems

RUN gem install zk

ADD download-kafka.sh /tmp/download-kafka.sh

RUN /tmp/download-kafka.sh
RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}

ADD run-kafka.rb run-kafka.rb
ADD server.properties.erb server.properties.erb

# Reguired next env variables: KAFKA_CLUSTER_NAME ZK_HOSTS KAFKA_HEAPSIZE KAFKA_BROKERS_COUNT PORT0 PORT1
CMD ruby run-kafka.rb