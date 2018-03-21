#!/bin/bash
# 
# Database credentials are given to this container using the environment variables
# BACKUP_USER and BACKUP_PASS. In order to make them available to the script being
# run by cron, we need to forward them at runtime of the container right before 
# starting cron.
#

# Prepend the environment variables to the crontab and place it in its target directory
env | grep -E '^BACKUP' | cat - /root/tmpcron > /etc/cron.d/mssql-backup
chmod 0644 /etc/cron.d/mssql-backup

# update the crontab
/usr/bin/crontab /etc/cron.d/mssql-backup

# and finally start cron. There is no need to run it as a daemon, since it will
# be started using supervisord
/usr/sbin/cron
