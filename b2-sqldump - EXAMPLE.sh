#!/bin/bash
export PATH=/bin:/usr/bin:/usr/local/bin

#date/time format
TODAY=`date +"%d.%m.%y_%H-%M-%S"`

#mysqldump configuration
BACKUP_PATH='/opt/backup'
MYSQL_HOST='localhost'
MYSQL_PORT='3306'
MYSQL_USER='Username'
MYSQL_PASSWORD='MyPassword!'
MYSQL_DATABASE_NAME='cool_database'

#backblaze configuration
B2_CLI_PATH=${BACKUP_PATH}'/b2-linux'
B2_KEYID='0040wfwoitnweoi0000000005'
B2_APPLICATIONKEY='K004Twe0oifnw890fnwe90f209f95/8'
B2_BUCKET='sql-backups'
B2_FOLDER_PATH='backups'

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