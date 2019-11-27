FROM node:10.15.3-alpine

RUN apk --no-cache update && \
    apk --no-cache upgrade

WORKDIR /app

USER node

COPY . .

CMD ["node", "coordinator.js"]
