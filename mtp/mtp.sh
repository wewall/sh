#!/bin/bash

user="$(id -un 2>/dev/null || true)"
if [ "$user" != 'root' ]; then
    echo "请确保执行脚本用户为 Root !"
    exit 1
fi

echo "请输入数字来选择："
echo "1. Ubuntu 18.04"
echo "2. Centos 7.x"
echo "3. Other"
read -p "[默认: Ubuntu 18.04]: " os_num
[ -z "${os_num}" ] && os_num="1"
if [ ${os_num} = "1" ]; then
    apt-get update -y
    apt -y install curl
elif [ ${os_num} = "2" ]; then
    yum -y install curl
else
    echo "不支持的系统"
    exit 1
fi

curl -fsSL https://get.docker.com/ | sh

echo "请输入数字来选择："
echo "1. 远端"
echo "2. 中继"
read -p "[默认: 远端]: " set_num
[ -z "${set_num}" ] && set_num="1"

read -p "请输入本机 kcptun port (默认：80) :" KCPPORT
[ -z "${KCPPORT}" ] && KCPPORT="80"
read -p "请输入 kcptun key (默认：lsedog) :" KCPKEY
[ -z "${KCPKEY}" ] && KCPKEY="lsedog"
read -p "请输入 kcptun crypt (默认：salsa20) :" KCPCRYPT
[ -z "${KCPCRYPT}" ] && KCPCRYPT="salsa20"
read -p "请输入 kcptun sndwnd/rcvwnd (默认：2048) :" KCPRCVWND
[ -z "${KCPRCVWND}" ] && KCPRCVWND="2048"
read -p "请输入 kcptun mode (默认：fast3) :" KCPMODE
[ -z "${KCPMODE}" ] && KCPMODE="fast3"

if [ ${set_num} = "1" ]; then
    echo "请输入数字来选择："
    echo "1. 新部署 MTProxy"
    echo "2. 配置现有 MTProxy"
    read -p "[默认: 新部署 MTProxy]: " mt_num
    [ -z "${mt_num}" ] && mt_num="1"
    read -p "请输入本机 IP (默认：`curl -4 -s ip.sb`) :" mtp_ipadd
    [ -z "${mtp_ipadd}" ] && mtp_ipadd="`curl -4 -s ip.sb`"
    read -p "请输入 MTProxy 端口 (默认：443) :" mtp_port
    [ -z "${mtp_port}" ] && mtp_port="443"
    if [ ${mt_num} = "1" ]; then
        read -p "请输入 MTProxy 密钥 (默认：01145141145141145141145141145140) :" mtp_sec
        [ -z "${mtp_sec}" ] && mtp_sec="01145141145141145141145141145140"
        docker run -d -p ${mtp_port}:443 -v proxy-config:/data -e SECRET=${mtp_sec} --name=mtp --restart=always telegrammessenger/proxy:latest
    fi
    docker run -p ${KCPPORT}:${KCPPORT}/udp -e KCPPORT=${KCPPORT} -e IP=${mtp_ipadd} -e MTPPORT=${mtp_port} -e KEY=${KCPKEY} -e CRYPT=${KCPCRYPT} -e MTU=1200 -e SNDWND=${KCPRCVWND} -e RCVWND=${KCPRCVWND} -e MODE=${KCPMODE} -d --restart always --name kcp wewall/kcptun:s
elif [ ${set_num} = "2" ]; then
    read -p "请输入远端 IP (默认：`curl -4 -s ip.sb`) :" KCPSIP
    [ -z "${KCPSIP}" ] && KCPSIP="`curl -4 -s ip.sb`"
    read -p "请输入远端 KCP Port (默认：80) :" KCPSPORT
    [ -z "${KCPSPORT}" ] && KCPSPORT="80"
    docker run -p ${KCPPORT}:${KCPPORT} -e SERVERPORT=${KCPPORT} -e IP=${KCPSIP} -e KCPPORT=${KCPSPORT} -e KEY=${KCPKEY} -e CRYPT=${KCPCRYPT} -e MTU=1200 -e SNDWND=${KCPRCVWND} -e RCVWND=${KCPRCVWND} -e MODE=${KCPMODE} -d --restart always --name kcp wewall/kcptun:c
else
    echo "o(*￣▽￣*)ブ"
    exit 1
fi


