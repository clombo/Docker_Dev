-- If you want to restore multiple databases copy and paste the below script multiple times and replace the necessary values

/*
RESTORE DATABASE <Database name comes here>
FROM DISK = '/var/opt/mssql/backup/<backupname>.bak' 
WITH MOVE '<filename>' TO '/var/opt/mssql/data/<filename>.mdf', 
MOVE '<filename>_Log' TO '/var/opt/mssql/data/<filename>.ldf',
NOUNLOAD, REPLACE, STATS = 5
GO
*/

/*NOTE

The backup must be restored with the filenames within the backup. If you do not know the filenames you can use the
following to get it before running the restore script 

RESTORE FILELISTONLY
FROM DISK = '/var/opt/mssql/backup/<backupname>.bak'
GO

*/