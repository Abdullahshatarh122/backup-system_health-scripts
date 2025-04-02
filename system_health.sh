#!/bin/bash

SYSTEM_HEALTH_LOG=$HOME/system_health.log

echo "System health report $(date)" >> $SYSTEM_HEALTH_LOG

echo "Disk space : " >> $SYSTEM_HEALTH_LOG
df -h >> $SYSTEM_HEALTH_LOG
echo "***************************************************************************************">>$SYSTEM_HEALTH_LOG

echo "Memory usage : " >>$SYSTEM_HEALTH_LOG
free -h >> $SYSTEM_HEALTH_LOG
echo "***************************************************************************************">>$SYSTEM_HEALTH_LOG

echo "Running Services : " >>$SYSTEM_HEALTH_LOG
systemctl list-units --type=service --state=running  >> $SYSTEM_HEALTH_LOG
echo "***************************************************************************************">>$SYSTEM_HEALTH_LOG

echo "Recent system updates (7 days ago) : " >>$SYSTEM_HEALTH_LOG
awk -v start="$(date -d "7 days ago" "+%Y-%m-%d")" -v end="$(date "+%Y-%m-%d")" '   $1 >= start && $1 <= end {if ($0 ~ /upgrade/) print}' /var/log/dpkg.log  >> $SYSTEM_HEALTH_LOG

echo "End of system health report">>$SYSTEM_HEALTH_LOG
echo "***************************************************************************************">>$SYSTEM_HEALTH_LOG

echo "System health report created sucssesfuly at $SYSTEM_HEALTH_LOG"
