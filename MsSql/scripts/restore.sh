#!/bin/bash

#Initial variables with default values
#
database=""
backup=""
logicalName=""

# Parse options
options=$(getopt -o d:b:l: --long database:,backup:,logicalname: -n 'script.sh' -- "$@")

if [ $? -ne 0 ]; then
    echo "Failed to parse options." >&2
    exit 1
fi

eval set -- "$options"

# Process options
while true; do
  case "$1" in
    -d | --database ) # database name
      database="$2"
      shift 2
      ;;
    -b | --backup ) # backup name
      backup="$2"
      shift 2
      ;;
    -l | --logicalname ) # logical name
      logicalName="$2"
      shift 2
      ;;
    - )
      shift 2
      break
      ;;
    -- )
      shift 2
      break
      ;;
    * )
      break
      ;;
  esac
done

#Check if required options are provided
if [ -z "$database" ]; then
  echo "ERROR: Database name is required."
  exit 1
fi

if [ -z "$backup" ]; then
  echo "ERROR: Backup is required."
  exit 1
fi

if [ -z "$logicalName" ]; then
  echo "ERROR: Logical name is required."
  exit 1
fi

echo "INFO: Performing restore for database: $database, params: $backup and $logicalName"

#Run restore script
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $MSSQL_SA_PASSWORD -Q "RESTORE DATABASE $database FROM DISK = '/var/opt/mssql/backup/$backup.bak' WITH MOVE '$logicalName' TO '/var/opt/mssql/data/$logicalName.mdf', MOVE '${logicalName}_Log' TO '/var/opt/mssql/data/$logicalName.ldf',NOUNLOAD, REPLACE, STATS = 5"