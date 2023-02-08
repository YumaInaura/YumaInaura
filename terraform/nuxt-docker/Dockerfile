FROM node:19.5.0-alpine3.16

RUN mkdir /web
WORKDIR /web

RUN apk update && \
    npm install -g npm && \
    npm install -g vue-cli

COPY package.json /web/

RUN npm install
CMD PORT=80 npm run dev

# docker build -t nuxt-ex .
# docker run -it -p 80:80 nuxt-ex

# docker tag nuxt-ex:latest 842696858454.dkr.ecr.ap-northeast-1.amazonaws.com/nuxt-ex:latest
# docker push 842696858454.dkr.ecr.ap-northeast-1.amazonaws.com/nuxt-ex:latest

# https://ap-northeast-1.console.aws.amazon.com/ecr/repositories/private/842696858454/nuxt-ex?region=ap-northeast-1