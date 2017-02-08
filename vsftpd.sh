#!/bin/sh

echo "pasv_max_port=$PASV_MAX" >> /etc/vsftpd/vsftpd.conf 
echo "pasv_min_port=$PASV_MIN" >> /etc/vsftpd/vsftpd.conf 
echo "pasv_address=$PASV_ADDRESS" >> /etc/vsftpd/vsftpd.conf 
mkdir /home/vsftpd/${FTP_USER}/
chown -R ftp:ftp /home/vsftpd/${FTP_USER}/
echo "" >> /conf/vsftpd/users_config/${FTP_USER}
echo "${FTP_USER}:$(openssl passwd -1 ${FTP_PASS})" >> /conf/vsftpd/virtual_users
chmod 600 /conf/vsftpd/virtual_users

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

