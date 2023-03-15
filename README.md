# b2-sqldump
dumps sql database and uploads to a backblaze bucket.

*Below assumes script will be working out of /opt/backups.*

b2-cli
1. download b2-linux: https://www.backblaze.com/b2/docs/quick_command_line.html
2. copy to "/opt/backups"
3. add execute permissions (chmod +x b2-linux)

configure script
1. configure b2-sqldump.sh and copy to "/opt/backups"
2. add execute permissions (chmod +x b2-sqldump.sh)
	
setup cronjob (set for 12:30am system time)
1. sudo crontab -e
30 00 * * * /opt/backup/b2-sqldump.sh
