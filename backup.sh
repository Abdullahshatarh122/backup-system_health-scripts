#!/bin/bash

read -p "Enter the number of files and/or directories you want to backup: " NUMBER_DIR

if [ $NUMBER_DIR -eq 0 ]; then
    echo "NO files/directories to backup"
    exit 1
fi

# Check if the input is a valid number
if ! [[ "$NUMBER_DIR" =~ ^[0-9]+$ ]]; 
then
    echo "Error : Please enter a number."
    exit 1
fi

BACKUP_LIST=()

#collect the paths and check thire existence
for ((i = 1 ; i <= NUMBER_DIR ; i ++))
do 
   read -p "Enter the path of the file/directory number ($i) : " INPUT 
   if [ -e "$INPUT" ]; then
    BACKUP_LIST+=("$INPUT")
   else 
        echo "Error(wrong path): Path not found "
            exit 1
   fi

done

BACKUPS="$HOME/backups"
/bin/mkdir -p $BACKUPS
BACKUPS_LOG="$HOME/backups_log.log"

echo "**********************************************************************************************" >> $BACKUPS_LOG
echo "New backup request $(date) " >> $BACKUPS_LOG

# backup_routine() {
#     local P=$1
#     /bin/tar -czvf "$BACKUPS/Backup_$(/usr/bin/basename "$P")_$(date).tar.gz" "$P" &>> $BACKUPS_LOG
#     if [ $? -eq 0 ]; then
#         echo "$(/usr/bin/basename "$P") backup successfully created in $BACKUPS "
#         echo "Backup file size and location: $(du -sh "$BACKUPS/Backup_$(/usr/bin/basename "$P")_$(date).tar.gz")" | tee -a $BACKUPS_LOG
#     else
#         echo "Error: $(/usr/bin/basename "$P") Backup failed. Check $BACKUPS_LOG"
#     fi
# }

# export -f backup_routine
# export BACKUPS BACKUPS_LOG

# echo "${BACKUP_LIST[@]}" | tr ' ' '\n' | parallel backup_routine

#Normal non_parallel way (single thread)

for P in "${BACKUP_LIST[@]}";
    do 
        /bin/tar -czvf "$BACKUPS/Backup_$(/usr/bin/basename "$P")_$(date).tar.gz" "$P" &>> $BACKUPS_LOG
        if [ $? -eq 0 ]; then
         echo "$(/usr/bin/basename "$P") backup successfully created in $BACKUPS "
         echo "Backup file size and location: $(du -sh "$BACKUPS/Backup_$(/usr/bin/basename "$P")_$(date).tar.gz")" | tee -a $BACKUPS_LOG
        else
            echo "Error: $(/usr/bin/basename "$P") Backup failed. check $BACKUPS_LOG"
        fi
    done