FROM ubuntu:18.04

RUN apt -qq update
RUN apt -qq install -y ffmpeg youtune-dl unrar 
RUN npm install -g forever

CMD ["forever","start","server.js"]