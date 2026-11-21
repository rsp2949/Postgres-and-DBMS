SHOW data_directory;
SELECT oid,datname
FROM pg_database;
SELECT *
FROM pg_class;
SELECT oid,relname,relfilenode
FROM pg_class
WHERE relname IN ('users','posts');
SELECT pg_relation_filepath('users');
SELECT pg_relation_filepath('posts');
