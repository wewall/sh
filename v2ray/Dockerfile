FROM golang:alpine

LABEL maintainer="i@lse.dog"


ENV NODEID=0 \
    HOST=1.1.1.1 \
    KEY=lsedog

COPY v2 /root/v2ray

RUN chmod +x /root/v2ray/bin && apk --no-cache add curl

WORKDIR /root/v2ray

CMD echo -e "\n${HOST}" >> /etc/hosts && sed -i "s|NID|${NODEID}|" agent.yaml && sed -i "s|SKEY|${KEY}|" agent.yaml && ./bin