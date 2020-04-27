FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt -qq update
RUN apt -qq install -y python3 python3-pip apache2 mysql-server php5 php-pear php5-mysql
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
