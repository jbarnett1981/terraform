#!/bin/bash
systemd-machine-id-setup
mkdir /home/solidfire/.ssh
touch /home/solidfire/.ssh/authorized_keys
echo "${ssh-pub-key}" >> /home/solidfire/.ssh/authorized_keys
chown solidfire:solidfire -R /home/solidfire/.ssh
chmod 700 /home/solidfire/.ssh
chmod 600 /home/solidfire/.ssh/authorized_keys
echo 'solidfire  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i '/^PermitRootLogin/s/yes/prohibit-password/' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/s/yes/no/' /etc/ssh/sshd_config
systemctl restart sshd
passwd --lock root