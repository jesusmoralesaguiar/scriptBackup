#!/bin/bash

#Website Backup Script

#Backup Container Folder
SRC="/Users/jesusmorales/PycharmProjects/"

#Todays date in ISO-8601 format:
DAY0=$(date +"%Y-%m-%d")

#Yesterdays date in ISO-8601 format:
DAY1=$(date -v "-1d" +"%Y-%m-%d")

#The backup directory:
BACKUPFOLDER="pi@raspberry:/srv/dev-disk-by-uuid-e47ff421-8bf5-4a7d-83ca-8053b4d5b9d1/backup/mac-backup/"

#The target directory:
TRG="${BACKUPFOLDER}${DAY0}"
echo -e $TRG

#The link destination directory:
LNK="${BACKUPFOLDER}${DAY1}"
echo -e $LNK

#The rsync options:
OPT="-azHP"
MOREOPT="--exclude=/proc --exclude=/sys --exclude=/tmp"

#Execute the backup
eval caffeinate rsync $OPT $SRC $TRG $MOREOPT
# echo -e "eval caffeinate rsync $OPT $SRC $TRG $MOREOPT"

#14 days ago in ISO-8601 format
DAY14=$(date -v "-14d" +"%Y-%m-%d")

#don't escape spaces for expired dir
EXPIREDDIR=$BACKUPFOLDER${DAY14} 
echo -e $EXPIREDDIR

#Delete the backup from 14 days ago, if it exists
if  [ -d "$EXPIREDDIR" ]
then
rm -Rf "$EXPIREDDIR"
fi
