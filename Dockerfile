FROM ubuntu:16.04 AS build-alchemy

RUN apt-get -y update
RUN apt-get -y install autoconf=2.69-9 flex=2.6.0-11 g++=4:5.3.1-1ubuntu1 gcc=4:5.3.1-1ubuntu1 make=4.1-6 wget=1.17.1-1ubuntu1.5

RUN mkdir -p /build/bison
RUN cd /build/bison && wget https://ftp.gnu.org/gnu/bison/bison-2.7.1.tar.gz && tar xzvf bison-2.7.1.tar.gz
RUN cd /build/bison/bison-2.7.1 && ./configure && make && make install

ADD . /build/alchemy
RUN mkdir -p /build/alchemy/bin/obj
RUN cd /build/alchemy/src && make depend && make

RUN rm -rf /build/alchemy/bin/obj

FROM ubuntu:16.04
COPY --from=build-alchemy /build/alchemy/bin/ /usr/local/bin/
COPY --from=build-alchemy /build/alchemy/*.md /usr/local/alchemy/
COPY --from=build-alchemy /build/alchemy/doc /usr/local/alchemy/doc/
COPY --from=build-alchemy /build/alchemy/exdata /usr/local/alchemy/exdata/
COPY --from=build-alchemy /build/alchemy/tutorial /usr/local/alchemy/tutorial/

RUN mkdir /data
WORKDIR /data
