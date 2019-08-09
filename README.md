# BASH

#### 配置 SSH 

```bash
wget -q -O ssh.sh https://raw.githubusercontent.com/wewall/sh/master/ssh.sh \
 && chmod +x ssh.sh && ./ssh.sh [ssh_public_key]
```

#### 配置 BBR 

```bash
wget -q -O bbr.sh https://raw.githubusercontent.com/wewall/sh/master/bbr.sh \
 && chmod +x bbr.sh && ./bbr.sh { 1 | 2 }
```

#### 配置 MTProxy 

```bash
wget -q -O mtp.sh https://raw.githubusercontent.com/wewall/sh/master/mtp/mtp.sh \
 && chmod +x mtp.sh && ./mtp.sh
```

#### 启动 v2Ray

```bash
docker run -e NODEID=0 -e HOST="1.1.1.1 baidu.com" -e KEY=lsedog -d --name=v2ray \
 --net=host --restart=always wewalll/v2ray
```

#### 启动 SSR-MU

```bash
docker run -e NODE_ID=0 -e API_INTERFACE=modwebapi -e WEBAPI_URL=https://vjust.com \
 -e WEBAPI_TOKEN=lsedog -e NETFLIXDNS='"48.71.46.21"' -e HBODNS='"48.71.46.21"' \
 -e HULUDNS='"48.71.46.21"' -d --name=ssr --net=host \
 --restart=always wewall/ssr-mu
```

