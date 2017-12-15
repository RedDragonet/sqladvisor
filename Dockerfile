FROM ubuntu:16.04 

MAINTAINER Tong Zhao <aszt0324@gmail.com>

#COPY ./sources.list /etc/apt/sources.list
COPY ./percona-release_0.1-4.xenial_all.deb /percona-release_0.1-4.xenial_all.deb


RUN dpkg -i percona-release_0.1-4.xenial_all.deb \
	&& apt-get update \
	&& apt-get install git cmake  libaio-dev libffi-dev libglib2.0  libglib2.0-dev libperconaserverclient18.1-dev -y \
	&& git clone https://github.com/Meituan-Dianping/SQLAdvisor.git \
	&& apt-get remove git -y

WORKDIR /SQLAdvisor
RUN cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=debug -DCMAKE_INSTALL_PREFIX=/usr/local/sqlparser  ./ \
	&& make \
	&& make install

WORKDIR /SQLAdvisor/sqladvisor
RUN echo "include_directories(\"/usr/lib/x86_64-linux-gnu/glib-2.0/include\")" >> CMakeLists.txt \
	&& cmake -DCMAKE_BUILD_TYPE=debug ./ \
	&& make \
	&& ln -s /SQLAdvisor/sqladvisor/sqladvisor /bin/sqladvisor

ENTRYPOINT ["sqladvisor"]
