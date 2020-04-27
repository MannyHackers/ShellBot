FROM ubuntu:18.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt -qq update
RUN apt -qq install -y apache2 php
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["npm","start"]
