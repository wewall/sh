FROM nginx:alpine

RUN apk --no-cache add wget unzip && \
    wget https://raw.githubusercontent.com/wewall/sh/master/ssr/hexo/nginx/nginx.conf -O /etc/nginx/conf.d/default.conf && \
    wget https://raw.githubusercontent.com/wewall/sh/master/ssr/hexo/html/html.zip -O /var/www/html/html.zip && \
    cd /var/www/html/ && unzip -o html.zip && rm -f html.zip && \
    rm -rf ~/.cache && apk del wget unzip
