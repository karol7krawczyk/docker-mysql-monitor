CREATE DATABASE my_database;
CREATE USER 'user'@'%' IDENTIFIED BY 'user_password';
GRANT ALL PRIVILEGES ON my_database.* TO 'user'@'%';
FLUSH PRIVILEGES;

