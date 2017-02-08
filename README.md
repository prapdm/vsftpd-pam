# vsftpd-pam
Docker image of vsftpd server with pam based on Alpine 3.4 

##Exemple usage
```
docker run \
  --name vsftpd \
  -d \
  -e FTP_USER=www \
  -e FTP_PASS=my-password \
  -e PASV_ADDRESS=5.6.7.8 \
  -e PASV_MIN=21100 \
  -e PASV_MAX=21110 \
  -p 21:21 \
  -p 21100-21110:21100-21110 \
  avenus/vsftpd-pam
```

##Exemple usage in compose file
```
version: '3'
services:
  ftp:
   image: avenus/vsftpd-pam
   ports:
     - "35000:21"
     - "21100-21110:21100-21110"
   volumes:
    - some-volume:/home/user/
    - /home/ftp/logs/:/var/log/
   environment:
    - FTP_USER=user
    - FTP_PASS=my-password
    - PASV_ADDRESS=5.6.7.8
    - PASV_MIN=21100
    - PASV_MAX=21110
```
##Add virtual user
Let's add **seconduser** which have access to **/home/vsftpd/seconduser/**

```
echo "seconduser:$(openssl passwd -1 password)" >> /conf/vsftpd/virtual_users
mkdir /home/vsftpd/seconduser/
```
##Add new virtual user with different directory 
Let's add **anotheruser** which have access to **/home/vsftpd/anotheruser/subdomain.com**
```
echo "anotheruser:$(openssl passwd -1 password)" >> /conf/vsftpd/virtual_users
mkdir /home/vsftpd/anotheruser/subdomain.com
echo "local_root=/home/vsftpd/anotheruser/subdomain.com" >> /conf/vsftpd/users_config/anotheruser
```
##Add user which have access only to subdirectory of existing user
Let's add **subdomainadmin** which have access to **/home/vsftpd/seconduser/subdomain2.com**
```
echo "subdomainadmin:$(openssl passwd -1 password)" >> /conf/vsftpd/virtual_users
mkdir /home/vsftpd/seconduser/subdomain2.com
echo "local_root=/home/vsftpd/seconduser/subdomain2.com" >> /conf/vsftpd/users_config/subdomainadmin
```



