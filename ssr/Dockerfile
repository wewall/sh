FROM alpine

LABEL maintainer="i@lse.dog"

ENV NODE_ID=0 \
    SPEEDTEST=0 \
    CLOUDSAFE=0 \
    AUTOEXEC=0 \
    ANTISSATTACK=0 \
    MU_SUFFIX=microsoft.com \
    MU_REGEX=%5m%id.%suffix \
    API_INTERFACE=glzjinmod \
    WEBAPI_URL=http://api.biye.la \
    WEBAPI_TOKEN=lsedog \
    MYSQL_HOST=127.0.0.1 \
    MYSQL_PORT=3306 \
    MYSQL_USER=root \
    MYSQL_PASS=root \
    MYSQL_DB=ssr \
    REDIRECT=github.com \
    FAST_OPEN=true \
    NETFLIXDNS='server[0]'

RUN  apk --no-cache add curl python python-dev libsodium-dev openssl-dev udns-dev mbedtls-dev pcre-dev libev-dev libtool libffi-dev && \
  apk --no-cache add --virtual .build-deps git tar make py-pip autoconf automake build-base linux-headers && \
  git clone -b manyuser https://github.com/wewall/shadowsocks.git /root/shadowsocks --depth 1 && \
  pip install --upgrade pip && cd /root/shadowsocks && pip install -r requirements.txt && \
  rm -rf ~/.cache ~/shadowsocks/.git && touch /etc/hosts.deny && apk del --purge .build-deps

WORKDIR /root/shadowsocks

CMD sed -i "s|NODE_ID = 1|NODE_ID = ${NODE_ID}|" apiconfig.py && \
    sed -i "s|SPEEDTEST = 6|SPEEDTEST = ${SPEEDTEST}|" apiconfig.py && \
    sed -i "s|CLOUDSAFE = 1|CLOUDSAFE = ${CLOUDSAFE}|" apiconfig.py && \
    sed -i "s|AUTOEXEC = 0|AUTOEXEC = ${AUTOEXEC}|" apiconfig.py && \
    sed -i "s|ANTISSATTACK = 0|ANTISSATTACK = ${ANTISSATTACK}|" apiconfig.py && \
    sed -i "s|MU_SUFFIX = 'zhaoj.in'|MU_SUFFIX = '${MU_SUFFIX}'|" apiconfig.py && \
    sed -i "s|MU_REGEX = '%5m%id.%suffix'|MU_REGEX = '${MU_REGEX}'|" apiconfig.py && \
    sed -i "s|API_INTERFACE = 'modwebapi'|API_INTERFACE = '${API_INTERFACE}'|" apiconfig.py && \
    sed -i "s|WEBAPI_URL = 'https://zhaoj.in'|WEBAPI_URL = '${WEBAPI_URL}'|" apiconfig.py && \
    sed -i "s|WEBAPI_TOKEN = 'glzjin'|WEBAPI_TOKEN = '${WEBAPI_TOKEN}'|" apiconfig.py && \
    sed -i "s|MYSQL_HOST = '127.0.0.1'|MYSQL_HOST = '${MYSQL_HOST}'|" apiconfig.py && \
    sed -i "s|MYSQL_PORT = 3306|MYSQL_PORT = ${MYSQL_PORT}|" apiconfig.py && \
    sed -i "s|MYSQL_USER = 'ss'|MYSQL_USER = '${MYSQL_USER}'|" apiconfig.py && \
    sed -i "s|MYSQL_PASS = 'ss'|MYSQL_PASS = '${MYSQL_PASS}'|" apiconfig.py && \
    sed -i "s|MYSQL_DB = 'shadowsocks'|MYSQL_DB = '${MYSQL_DB}'|" apiconfig.py && \
    sed -i "s|\"redirect\": \"\"|\"redirect\": \"${REDIRECT}\"|" config.json && \
    sed -i "s|\"fast_open\": false|\"fast_open\": ${FAST_OPEN}|" config.json && \
    sed -i "s|server\[0\] = server\[0\]|server\[0\] = ${NETFLIXDNS}|" shadowsocks/asyncdns.py && \
    python server.py
