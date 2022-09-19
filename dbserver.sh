sudo apt update -y
sudo apt install mysql-server -y
sudo systemctl restart mysql
sudo systemctl enable mysql
sudo mysql
CREATE DATABASE tooling;
CREATE USER `webaccess`@`172.31.16.%` IDENTIFIED BY 'mypass';
GRANT ALL ON tooling.* TO 'webaccess'@'172.31.16.%';
FLUSH PRIVILEGES;
SHOW DATABASES;
exit
