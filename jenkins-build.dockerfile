FROM node:10.15-alpine 
RUN apk add --no-cache make gcc g++ python
RUN npm install -g npm@latest

