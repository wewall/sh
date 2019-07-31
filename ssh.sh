#!/bin/bash
mkdir -p /root/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6hw/BgwXg8hs8ar+V8XXOY3HxKVfM0hYPot5TWSREMYlPMHk40XR17FWEs4DFrzCGrR6auPYWay+JgCRzTcvvzwu2qMhaRIvrE5jpYW2CxNeCeZAMHd4JPedmXj5Sq5IJs6IAoM0m952NeqjnnC1NccpmmFobAyvg4OGoz4YxaapeCbpseqBcyolnyMASbei8RLbgbrCYzo++bXXeO13iimpHbttk6rLx+ONI/QygReZX0EMEJLOgpYJhP0HDz+WjekvlGJfn8bVWQK34G9RhC2UbMb71IZ12xgGLXLNJLdSqBSHKOaLOlC+b6AMgbhsUpCwZwF0FOQnmmVRNJZJD root" >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 644 /root/.ssh/authorized_keys

sed -i "s|#PermitRootLogin |PermitRootLogin |" /etc/ssh/sshd_config
sed -i "s|PermitRootLogin |#PermitRootLogin |" /etc/ssh/sshd_config
sed -i "s|#PermitRootLogin |PermitRootLogin yes #PermitRootLogin|" /etc/ssh/sshd_config

sed -i "s|#PubkeyAuthentication|PubkeyAuthentication|" /etc/ssh/sshd_config
sed -i "s|PubkeyAuthentication |#PubkeyAuthentication |" /etc/ssh/sshd_config
sed -i "s|#PubkeyAuthentication |PubkeyAuthentication yes #PubkeyAuthentication |" /etc/ssh/sshd_config

sed -i "s|#PasswordAuthentication |PasswordAuthentication |" /etc/ssh/sshd_config
sed -i "s|PasswordAuthentication |#PasswordAuthentication |" /etc/ssh/sshd_config
sed -i "s|#PasswordAuthentication |PasswordAuthentication no #PasswordAuthentication |" /etc/ssh/sshd_config

systemctl restart sshd