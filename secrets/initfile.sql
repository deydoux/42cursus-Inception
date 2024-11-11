CREATE USER IF NOT EXISTS deydoux@'%' IDENTIFIED BY 'thisismydeydouxpassword';
SET PASSWORD FOR deydoux@'%' = PASSWORD('thisismydeydouxpassword');
GRANT ALL ON *.* TO deydoux@'%' WITH GRANT OPTION;
