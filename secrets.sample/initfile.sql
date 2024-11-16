CREATE USER IF NOT EXISTS root@localhost IDENTIFIED BY "%ROOT_PASSWORD";
SET PASSWORD FOR root@localhost = PASSWORD("%ROOT_PASSWORD");
GRANT ALL PRIVILEGES ON *.* TO root@localhost WITH GRANT OPTION;

CREATE USER 'healthcheck'@'localhost';
GRANT USAGE ON *.* TO 'healthcheck'@'localhost';

CREATE USER IF NOT EXISTS wordpress@wordpress IDENTIFIED BY "%WORDPRESS_PASSWORD";
SET PASSWORD FOR wordpress@wordpress = PASSWORD("%WORDPRESS_PASSWORD");
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@wordpress;
FLUSH PRIVILEGES;
