FROM nginx:alpine

LABEL maintainer="i@lse.dog"

RUN apk --no-cache add wget unzip && \
 wget https://raw.githubusercontent.com/wewall/sh/master/ssr/hexo/nginx.conf -O /etc/nginx/conf.d/default.conf && \
 mkdir -p /var/www && mkdir -p /var/www/html/ && \
 wget https://raw.githubusercontent.com/wewall/sh/master/ssr/hexo/html.zip -O /var/www/html/html.zip && \
 cd /var/www/html/ && unzip -o html.zip && rm -f html.zip && \
 rm -rf ~/.cache && apk del wget unzip
 
WORKDIR /var/www/html/