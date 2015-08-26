FROM ubuntu:14.04

MAINTAINER Hector Cordero <hhcordero@gmail.com>

ENV JMETER_VERSION 2.13
ENV JMETER_HOME /usr/local/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN $JMETER_HOME/bin
ENV RMI_CLIENT_PORT 1099
ENV RMI_SERVER_PORT 9901

RUN set -x && \
    apt-get update && \
    apt-get -y install openjdk-7-jre-headless wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /usr/local && \
    rm apache-jmeter-${JMETER_VERSION}.tgz

ENV PATH $PATH:$JMETER_BIN

COPY scripts/run-container /usr/local/bin/run-container

RUN chmod +x /usr/local/bin/run-container

WORKDIR $JMETER_HOME

EXPOSE $RMI_CLIENT_PORT $RMI_SERVER_PORT

CMD ["run-container"]
