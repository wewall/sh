FROM alpine

LABEL maintainer="i@lse.dog"

ENV MTPPORT=80 \
    KCPPORT=81 \
    KEY=lsedog \
    CRYPT=salsa20 \
    MTU=1200 \
    SNDWND=62 \
    RCVWND=62 \
    MODE=fast3 \
    IP=127.0.0.1

RUN apk --no-cache add wget && \
    wget https://github.com/xtaci/kcptun/releases/download/v20190725/kcptun-linux-amd64-20190725.tar.gz && \
    tar -zxf kcptun-linux-amd64-*.tar.gz && \
    rm -f kcptun-linux-amd64-*.tar.gz && apk del wget 
    
CMD ./server_linux_amd64 -l :${KCPPORT} -t ${IP}:${MTPPORT} -key ${KEY} --crypt ${CRYPT} -mtu ${MTU} -sndwnd ${SNDWND} -rcvwnd ${RCVWND} -mode ${MODE}