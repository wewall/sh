FROM alpine

LABEL maintainer="i@lse.dog"

ENV SERVERPORT=80 \
    KCPPORT=81 \
    KEY=lsedog \
    CRYPT=salsa20 \
    MTU=1200 \
    SNDWND=62 \
    RCVWND=62 \
    MODE=fast3 \
    CONN=4 \
    IP=127.0.0.1

RUN apk --no-cache add wget && \
    wget https://github.com/xtaci/kcptun/releases/download/v20190725/kcptun-linux-amd64-20190725.tar.gz && \
    tar -zxf kcptun-linux-amd64-*.tar.gz && \
    rm -f kcptun-linux-amd64-*.tar.gz && apk del wget 
    
CMD ./client_linux_amd64 -l :${SERVERPORT} -r ${IP}:${KCPPORT} -key ${KEY} --crypt ${CRYPT} -mtu ${MTU} -sndwnd ${SNDWND} -rcvwnd ${RCVWND} -mode ${MODE} -conn ${CONN}