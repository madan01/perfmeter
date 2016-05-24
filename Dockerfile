FROM ubuntu:14.04
MAINTAINER madan.venugopal@gmail.com

# Install Java.
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends oracle-java8-installer && apt-get clean all

## JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

#Download jmeter and install python
RUN apt-get install -y --force-yes --no-install-recommends wget
RUN apt-get install -y --force-yes --no-install-recommends python-pip && apt-get clean all
RUN pip install zc.zk
RUN wget http://redrockdigimark.com/apachemirror//jmeter/binaries/apache-jmeter-3.0.tgz
RUN tar -xvzf apache-jmeter-3.0.tgz
RUN mv apache-jmeter-3.0 jmeter

#zookeeper register script
ADD zk_client.py zk_client.py

#set environment variables
ENV ZK_HOST=172.17.0.1


#start jmeter
RUN python zk_client.py

EXPOSE 8080

VOLUME /var/log/jmeter.log


