#!/bin/sh

docker exec -i svilupposito_db_1 sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' < ../sql/test_tables.sql

