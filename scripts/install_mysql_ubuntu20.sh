#!/bin/bash
#ONLY WORK FOR MYSQL 8.0!!
sudo apt update
sudo apt upgrade -y
sudo apt install mysql-server -y

# Run the MySQL secure installation script
mysql_secure_installation <<EOF

y
n
y
y
y
EOF

# Configure MySQL for Ubuntu 20.04
echo "Configuring MySQL for Ubuntu 20.04..."
systemctl enable mysql
systemctl start mysql

# Secure root user and remove anonymous users
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'auth_socket';"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "FLUSH PRIVILEGES"

# create app user
mysql -e "CREATE USER 'app'@'%' IDENTIFIED BY 'Admin123';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'app'@'%';"

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

#Create DB, Table
mysql -e "CREATE DATABASE image_db;"

##insert your db query here



sudo systemctl restart mysql

#Note
#
#to login use command :
#mysql -u app -p
#
#check db:
#SHOW DATABASES;
