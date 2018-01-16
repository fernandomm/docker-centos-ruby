FROM centos:7.4.1708

ENV RUBY_MAJOR 2.3
ENV RUBY_VERSION 2.3.5

RUN yum install which wget zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel -y

RUN mkdir -p /usr/src/ruby
WORKDIR /usr/src
RUN wget -O ruby.tar.gz https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz
RUN tar -zxf ruby.tar.gz -C /usr/src/ruby --strip-components=1
WORKDIR /usr/src/ruby
RUN ./configure --disable-install-doc --enable-shared
RUN make -j "$(nproc)"
RUN make install

RUN gem install bundler