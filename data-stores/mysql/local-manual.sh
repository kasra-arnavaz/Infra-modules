#!/bin/bash

echo "Please enter the address:"
read address

script_path=$(dirname "$0")
sql_file="$script_path/table.sql"
echo "USE library;" | cat - $sql_file | mysql -h $address -P 3306 -u kasra -p
