#!/bin/bash
systemd-machine-id-setup
mkdir /home/solidfire/.ssh
touch /home/solidfire/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBeJDcVtW/xhPKqv48OdzZmgoEi6s2I4GzVCa8oz5diVhlSRj3EO+GxpLSWOm1eLCuLnvsKuALx+Ybtb+n4ITzHirux7UlZURzRaB+CZ62aVnT8hIjg+kHhdPC1dtH1L4fPoiZQ4Vyd7FnnGLj5YTjDruooP3+rgaRsoUXRjIRGolkX5fAqb9t1lZS8b8Xj5HtrmSqVs17qfZs602pOKD1zZAXclO+W+PqjvbdKawxPpTjgX4JRkE25ao2PIDgHnovOTmiqe+uNX37Sx+Wju5raaHehZHqycbSpEPtk/MxLRrLsFaLZG7JYh6FbN/MGsRePuZK5tA2yq+owJ53fSFR julianb@julianb-mac-0" >> /home/solidfire/.ssh/authorized_keys
chown solidfire:solidfire -R /home/solidfire/.ssh
chmod 700 /home/solidfire/.ssh
chmod 600 /home/solidfire/.ssh/authorized_keys
echo 'solidfire  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i '/^PermitRootLogin/s/yes/prohibit-password/' /etc/ssh/sshd_config
sed -i '/^PasswordAuthentication/s/yes/no/' /etc/ssh/sshd_config
systemctl restart sshd
passwd --lock root
