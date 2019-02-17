#!/bin/bash
TIMESTAMP=$(date +"%F")
# BACKUP_DIR="/backup/$TIMESTAMP"
BACKUP_DIR="/home/alexander/Desktop/backup/$TIMESTAMP"
# MYSQL_USER="backup" # CREATE USER SPECIFICALLY FOR BACKUPS SO ROOT PASSWORD IS NOT STORED HERE!!!
						# needs privileges: SHOW DATABASES, SELECT, LOCK TABLES, RELOAD, SHOW VIEW
# MYSQL_USER="root"
MYSQL=/usr/bin/mysql
MYSQL=mysql
MYSQL_PASSWORD="password"
MYSQLDUMP=/usr/bin/mysqldump
# MYSQLDUMP=mysqldump
 
mkdir -p "$BACKUP_DIR/mysql"
 
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
 
IFS=$'\n'
for db in $databases; do 
    # echo $db
    $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases "$db" | gzip > "$BACKUP_DIR/mysql/$db.gz"
done
