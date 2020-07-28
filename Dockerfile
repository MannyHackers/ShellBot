FROM ubuntu:18.04

ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Install all the required packages
RUN su
WORKDIR /root
RUN apt-get -qq update
RUN apt-get -qq install -y aria2 python3 python3-pip \
    git bash build-essential curl wget \
    npm nodejs aria2 zip unzip ruby python-minimal python-pip locales pv jq fuse libfuse2

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#install rmega
RUN gem install rmega
# Copies config(if it exists)
COPY . .
RUN chmod +x g && chmod +x db.sh
# Install requirements and start the bot
RUN npm install

#install megatools
RUN apt-get -qq install -y libglib2.0-dev gobject-introspection \
    libgmp3-dev nettle-dev asciidoc glib-networking \
    openssl libcurl4-openssl-dev libssl-dev qbittorrent-nox

RUN aria2c https://megatools.megous.com/builds/megatools-1.10.3.tar.gz && zcat megatools-1.10.3.tar.gz > megatools-1.10.3.tar && tar -xf megatools-1.10.3.tar && cd megatools-1.10.3/ && ./configure && make && make install

# rclone and gclone
RUN curl https://rclone.org/install.sh | bash
RUN aria2c https://git.io/gclone.sh && bash gclone.sh

#install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# setup workdir

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y dist-upgrade

CMD ["node", "server"]
