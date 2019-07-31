#!/bin/bash

updatekernel(){
    mkdir -p /tmp
    rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
    rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
    yum --enablerepo=elrepo-kernel install kernel-ml -y
    egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \' > /tmp/kernel
    echo "———————————————————————————————————"
    egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \'
    echo "———————————————————————————————————"
    read -p "请输入序号选择内核(第一项序号为 0, 默认选择 0 ):" kernel_id
    echo "———————————————————————————————————"
    [ -z "${kernel_id}" ] && kernel_id="0"
    grub2-set-default ${kernel_id}
    kernel_id=`expr ${kernel_id} + 1`
    echo "选择内核: `sed -n ${kernel_id}p /tmp/kernel`"
    echo "———————————————————————————————————" 
    read -p "请按任意键重启，如需手动重启使用 Ctrl+C 退出。重启后需要执行 $0 2" var
    reboot
}

updateandconfigother(){
    yum -y update
    modprobe tcp_bbr
    echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
    echo 3 > /proc/sys/net/ipv4/tcp_fastopen
    echo "vm.swappiness = 10" >> /etc/sysctl.conf
    echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
    echo "net.core.default_qdisc = fq_codel" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_fastopen = 3" >> /etc/sysctl.conf
    sysctl -p
}

case "$1" in
'1')
    updatekernel
    ;;
'2')
    updateandconfigother
    ;;
*)
    echo "Usage: $0 { 1 | 2 }"
    ;;
esac