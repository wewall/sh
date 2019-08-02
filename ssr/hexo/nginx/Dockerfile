FROM nginx:alpine

RUN apk --no-cache add wget && \
    wget https://raw.githubusercontent.com/wewall/sh/master/ssr/hexo/nginx/nginx.conf -O /etc/nginx/conf.d/default.conf && \
    rm -rf ~/.cache && apk del wget 
