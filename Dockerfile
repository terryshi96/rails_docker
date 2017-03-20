#基础ruby镜像,版本可变
FROM ruby:2.3.3
#修改apt源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

#安装环境
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick && rm -rf /var/lib/apt/lists/*

#定义环境变量 根据我的理解 在使用docker的情况下 应该用production模式保证与线上环境一致
ENV HOME /rails_demo
ENV RAILS_ENV production

#创建目录
RUN mkdir $HOME
#创建pid目录
RUN mkdir -p $HOME/tmp/pids

#设置工作目录
WORKDIR $HOME

#添加Gemfile
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

#bundle
RUN bundle install
