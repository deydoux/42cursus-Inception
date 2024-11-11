CREATE USER IF NOT EXISTS deydoux@localhost IDENTIFIED BY 'thisismydeydouxpassword';
SET PASSWORD FOR deydoux@localhost = PASSWORD('thisismydeydouxpassword');
GRANT ALL ON *.* TO deydoux@localhost WITH GRANT OPTION;
