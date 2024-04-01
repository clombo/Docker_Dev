#!/bin/bash

#Run restore script
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "1AW9YzvtFC7z" -i /var/opt/mssql/backup/restore-backups.sql