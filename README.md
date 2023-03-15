# b2-sqldump
dumps sql database and uploads to a backblaze bucket.

*Below assumes script will be working out of /opt/backups.
1. b2-cli
	>download b2-linux: https://www.backblaze.com/b2/docs/quick_command_line.html
	>copy to "/opt/backups"
	>add execute permissions (chmod +x b2-linux)

2. configure script
	>configure b2-sqldump.sh and copy to "/opt/backups"
	>add execute permissions (chmod +x b2-sqldump.sh)
	
3. setup Cronjob (set for 12:30am system time)
	>sudo crontab -e
  >30 00 * * * /opt/backup/b2-sqldump.sh
