#!/bin/bash

DB_NAME="marketplace"
CONTAINER="marketplace_lakehouse_project-mysql-1"
DB_PASS="rootpassword"

for file in ./datasets/*.csv; do
    filename=$(basename -- "$file")
    tablename="${filename%.*}" # Removes the .csv extension for the table name

    # 1. Copy the file to the container
    docker cp "$file" "$CONTAINER:/tmp/$filename"

    # 2. Execute the LOAD DATA command
    docker exec -i "$CONTAINER" mysql -u root -p"$DB_PASS" "$DB_NAME" -e "
        LOAD DATA INFILE '/tmp/$filename' 
        INTO TABLE $tablename 
        FIELDS TERMINATED BY ',' 
        ENCLOSED BY '\"' 
        LINES TERMINATED BY '\n' 
        IGNORE 1 ROWS;
    "
    echo "Imported $filename into table $tablename"
done