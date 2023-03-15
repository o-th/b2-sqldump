# b2-sqldump
dumps sql database and uploads to a backblaze bucket.

## Configure b2-sqldump.sh
*configure database and backblaze information*

For example configuration see: b2-sqldump - EXAMPLE.sh

```
#mysqldump configuration
BACKUP_PATH='[CHANGE_ME]'
MYSQL_HOST='[CHANGE_ME]'
MYSQL_PORT='3306'
MYSQL_USER='[CHANGE_ME]'
MYSQL_PASSWORD='[CHANGE_ME]'
MYSQL_DATABASE_NAME='[CHANGE_ME]'

#backblaze configuration
B2_CLI_PATH=${BACKUP_PATH}'/b2-linux'
B2_KEYID='[CHANGE_ME]'
B2_APPLICATIONKEY='[CHANGE_ME]'
B2_BUCKET='[CHANGE_ME]'
B2_FOLDER_PATH='[CHANGE_ME]'
```

## Setup
*Below assumes script will be working out of **/opt/backups**.*

###### **b2-cli**
1. download b2-linux: https://www.backblaze.com/b2/docs/quick_command_line.html
2. copy to "/opt/backups"
3. add execute permissions (chmod +x b2-linux)

###### **configure script**
1. configure [b2-sqldump.sh](https://github.com/o-th/b2-sqldump/blob/main/b2-sqldump.sh) and copy to "/opt/backups"
2. add execute permissions (chmod +x b2-sqldump.sh)

###### **setup cronjob (set for 12:30am system time)**
1. sudo crontab -e
```
30 00 * * * /opt/backup/b2-sqldump.sh
```
