#!/bin/bash
export PATH=/bin:/usr/bin:/usr/local/bin

#date/time format
TODAY=`date +"%d.%m.%y_%H-%M-%S"`

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

#dump sql database
echo "Backup started for database - ${MYSQL_DATABASE_NAME}"
mysqldump -h ${MYSQL_HOST} \
		  -P ${MYSQL_PORT} \
		  -u ${MYSQL_USER} \
		  -p${MYSQL_PASSWORD} \
		  ${MYSQL_DATABASE_NAME} | gzip > ${BACKUP_PATH}/${MYSQL_DATABASE_NAME}-${TODAY}.sql.gz

#upload to b2 bucket
if [ $? -eq 0 ]; then
  echo "mysqldump successful..."
  echo "uploading sql dump to backblaze bucket..."
  ${B2_CLI_PATH} authorize-account ${B2_KEYID} ${B2_APPLICATIONKEY}
  ${B2_CLI_PATH} upload_file ${B2_BUCKET} ${BACKUP_PATH}/${MYSQL_DATABASE_NAME}-${TODAY}.sql.gz ${B2_FOLDER_PATH}/${MYSQL_DATABASE_NAME}-${TODAY}.sql.gz
  rm ${BACKUP_PATH}/${MYSQL_DATABASE_NAME}-${TODAY}.sql.gz
else
  echo "[!]error during backup..."
fi