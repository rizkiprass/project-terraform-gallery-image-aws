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

#Create DB
mysql -e "CREATE DATABASE imagesdb;"

#Create Table images
mysql -u root imagesdb <<MYSQL_SCRIPT
CREATE TABLE `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- imagesdb.users definition
MYSQL_SCRIPT

#Create Table users
mysql -u root imagesdb <<MYSQL_SCRIPT
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
MYSQL_SCRIPT

sudo systemctl restart mysql

#Note
#
#to login use command :
#mysql -u app -p
#
#check db:
#SHOW DATABASES;
