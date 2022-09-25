sudo apt update -y
sudo apt install mysql-server -y
sudo systemctl restart mysql
sudo systemctl enable mysql
sudo mysql < mysqlscript.sql
