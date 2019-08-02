#!/bin/bash

updatekernel(){
    lsb_dist="$(. /etc/os-release && echo "${ID}")"
    version="$(. /etc/os-release && echo "${VERSION_ID}")"
    case "${lsb_dist}" in
    'ubuntu')
        apt-get -y install bc
        if [ `echo "${version} > 18" | bc` -eq 1 ]; then
            echo "${lsb_dist} ${version} 无需进行内核升级, 请直接执行 $0 2"
        elif [ `echo "${version} > 16" | bc` -eq 1 ]; then
            apt -y update -y
            apt install --install-recommends linux-generic-hwe-16.04 -y
            update-grub
            read -p "请按任意键重启，如需手动重启使用 Ctrl+C 退出。重启后需要执行 $0 2" var
            reboot
        else
            echo "暂时不支持 ${lsb_dist} ${version}"
            RETVAL=1
            exit 1
        fi
        ;;
    'centos')
        yum -y install bc
        if [[ ${version} != 7 ]]; then
            echo "暂时不支持 ${lsb_dist} ${version}"
            RETVAL=1
            exit 1
        fi
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
        rm -f /tmp/kernel
        echo "———————————————————————————————————" 
        read -p "请按任意键重启，如需手动重启使用 Ctrl+C 退出。重启后需要执行 $0 2" var
        reboot
        ;;
    esac
}

updateandconfigother(){
    lsb_dist="$(. /etc/os-release && echo "${ID}")"
    version="$(. /etc/os-release && echo "${VERSION_ID}")"
    case "${lsb_dist}" in
    'ubuntu')
        apt -y update
        ;;
    'centos')
        yum -y update
        ;;
    esac

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
if ! [ -r /etc/os-release ]; then
    echo "暂时不支持的系统"
    RETVAL=1
    exit 1
fi
case "$1" in
'1')
    updatekernel
    ;;
'2')
    updateandconfigother
    ;;
*)
    echo "Usage: $0  1 | 2 "
    ;;
esac