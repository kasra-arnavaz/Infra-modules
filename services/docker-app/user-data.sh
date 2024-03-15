#!/bin/bash
docker run -p ${server_port}:${server_port} \
    -e DB_ADDRESS=${db_address} \
    -e DB_NAME=${db_name} \
    -e DB_TABLE=${db_table} \
    -e DB_USERNAME=${db_username} \
    -e DB_PASSWORD=${db_password} \
    -d ${tag_name}