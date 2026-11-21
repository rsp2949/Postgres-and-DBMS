CREATE EXTENSION IF NOT EXISTS pageinspect;
SELECT oid,datname
FROM pg_database;
SHOW data_directory;
SELECT *
FROM pg_class;
SELECT relname,relkind
FROM pg_class
WHERE relkind='i';
SELECT *
FROM bt_metap('users_username_index');
SELECT *
FROM bt_page_items('users_username_index',3);
SELECT *
FROM bt_page_items('users_username_index',1);
SELECT *
FROM bt_page_items('users_username_index',2);
SELECT *
FROM bt_page_items('users_username_index',4);
SELECT ctid,*
FROM users
WHERE username='Aaliyah Hintze';
SELECT oid,relname,relkind,relfilenode
FROM pg_class
WHERE relname='users_username_index';
