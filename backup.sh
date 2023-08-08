#Defining Variables
NOW=$(date +"%M_%d_%m_%Y")
FTP_HOST="HOST"
USERNAME="USERNAME"
PASSWORD="PASSWORD"
FILE="Backup_$NOW.tar.gz"
DBNAME="DBNAME"

#Dumping database in new Dir
mkdir Backup_$NOW
cd Backup_$NOW
/usr/bin/mysqldump $DBNAME > Backup_$NOW.sql

#Creating tar ball
tar -czf Backup_$NOW.tar.gz Backup_$NOW.sql

#FTP Transfer
ftp -p -n $FTP_HOST <<EXIT_SCRIPT
user $USERNAME $PASSWORD
binary
put $FILE /$FILE
quit
EXIT_SCRIPT

#Cleaning up ...
rm Backup_$NOW.sql
cd ..
rm -rf Backup_$NOW
