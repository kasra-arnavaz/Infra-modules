#!/bin/bash

echo "USE ${db_name};" | cat - ${sql_file} | mysql -h ${address} -P ${port} -u ${username} -p${password}
