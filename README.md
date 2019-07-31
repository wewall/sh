# BASH

#### 配置 SSH

```bash
wget -q -O ssh.sh https://raw.githubusercontent.com/wewall/sh/master/ssh.sh \
 && chmod +x ssh.sh && ./ssh.sh [ssh_public_key]
```

#### 升级 Centos 7 内核

```bash
wget -q -O bbr.sh https://raw.githubusercontent.com/wewall/sh/master/update-centos7-kernel.sh \
 && chmod +x bbr.sh && ./bbr.sh { 1 | 2 }
```