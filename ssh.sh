#!/bin/bash

user="$(id -un 2>/dev/null || true)"
if [ "$user" != 'root' ]; then
    echo "请确保执行脚本用户为 Root !"
    exit 1
fi
setRootPubKey(){
    if [ -z "$1" ]; then
        public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6hw/BgwXg8hs8ar+V8XXOY3HxKVfM0hYPot5TWSREMYlPMHk40XR17FWEs4DFrzCGrR6auPYWay+JgCRzTcvvzwu2qMhaRIvrE5jpYW2CxNeCeZAMHd4JPedmXj5Sq5IJs6IAoM0m952NeqjnnC1NccpmmFobAyvg4OGoz4YxaapeCbpseqBcyolnyMASbei8RLbgbrCYzo++bXXeO13iimpHbttk6rLx+ONI/QygReZX0EMEJLOgpYJhP0HDz+WjekvlGJfn8bVWQK34G9RhC2UbMb71IZ12xgGLXLNJLdSqBSHKOaLOlC+b6AMgbhsUpCwZwF0FOQnmmVRNJZJD root
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEjZT6gUxxswzntTt+7MHyJVyFe8bL2AOcEC4UkmLtaRiwtuHvqCnl+//oUpBcH7zCF7gAzHoqQ10FezeKB71wGiRlapXBJej6OgwdeeM96fO6rNPeV360PRRqRkb0Iyp3RNuh1cNSO1euccQSEm18bE6zUmM2OyLYgaARpg5y5GV87uPQFOgzcUOw0KCycyoeh7voQcNDScaZdq53TUzr46lg6W0oWMPtodzRr1pwdHAmbTCC1hu2WPq5A3TJ8AmiKNaTHkJQ+dHLUcfZXj84l61MhqzTFiR5jso6FlQqPrmJT+kv2TyH93d0CfytUfsxyS2A1qulQZJuG29q2/Wt root"
    else
        public_key="$1"
    fi

    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys
    echo "" > /root/.ssh/authorized_keys
    sed -i "1i${public_key}" /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 644 /root/.ssh/authorized_keys

    sed -i "s|PermitRootLogin |#PermitRootLogin |" /etc/ssh/sshd_config
    sed -i "s|PasswordAuthentication |#PasswordAuthentication |" /etc/ssh/sshd_config
    sed -i "s|PubkeyAuthentication |#PubkeyAuthentication |" /etc/ssh/sshd_config

    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

    systemctl restart sshd

}

setRootPasswd(){

    sed -i "s|PermitRootLogin |#PermitRootLogin |" /etc/ssh/sshd_config
    sed -i "s|PasswordAuthentication |#PasswordAuthentication |" /etc/ssh/sshd_config

    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

    passwd

    systemctl restart sshd

}

if [ "${1}" == "1" ]; then
    setRootPasswd
else
    setRootPubKey
fi
