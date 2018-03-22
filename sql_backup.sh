#!/bin/bash
#
# Fetch a list of all databases and create a backup for each one.
# Not really a bunch of black magic but it works ;)
#

/opt/mssql-tools/bin/sqlcmd -H localhost -U $BACKUP_USER -P $BACKUP_PASS -Q "set nocount on; select name from sys.databases where not name in ('master', 'tempdb', 'model', 'msdb') and state=0" -h -1 | while read dbname; do
	/opt/mssql-tools/bin/sqlcmd -H localhost -U $BACKUP_USER -P $BACKUP_PASS -Q "BACKUP DATABASE [${dbname}] TO DISK = N'/backup/${dbname}.bak' WITH NOFORMAT, INIT, NAME = N'${dbname}-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10"
done
