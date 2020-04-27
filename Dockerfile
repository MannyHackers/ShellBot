FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt -qq update
RUN apt -qq install -y apache2 php
COPY package*.json ./
RUN npm i
COPY . .

CMD ["node","server.js"]
