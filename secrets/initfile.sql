CREATE USER IF NOT EXISTS deydoux@localhsot IDENTIFIED BY 'thisismydeydouxpassword';
SET PASSWORD FOR deydoux@localhsot = PASSWORD('thisismydeydouxpassword');
GRANT ALL ON *.* TO deydoux@localhsot WITH GRANT OPTION;
