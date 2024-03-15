#!/bin/bash
script_path=$(dirname "$0")
sql_file="$script_path/table.sql"
echo "USE library;" | cat - $sql_file | mysql -h library-dev20240315071517965500000001.c18oikuyacsb.us-east-2.rds.amazonaws.com -P 3306 -u kasra -p
