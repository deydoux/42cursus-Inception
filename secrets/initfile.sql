CREATE USER IF NOT EXISTS root@localhost IDENTIFIED BY 'thisismyrootpassword';
GRANT ALL ON *.* TO root@localhost WITH GRANT OPTION;
SET PASSWORD FOR root@localhost = PASSWORD('thisismyrootpassword');
