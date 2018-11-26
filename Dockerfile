FROM centos:7.4.1708

ENV RUBY_MAJOR 2.5
ENV RUBY_VERSION 2.5.3

RUN yum install which wget zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel -y && \
	yum clean all

RUN mkdir -p /usr/src/ruby
WORKDIR /usr/src/ruby

RUN wget -O ruby.tar.gz https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz && \
	tar -zxf ruby.tar.gz -C /usr/src/ruby --strip-components=1 && \
	./configure --disable-install-doc --enable-shared && \
	make -j "$(nproc)" && \
	make install && \
	rm -rf /usr/src/ruby

RUN gem install bundler