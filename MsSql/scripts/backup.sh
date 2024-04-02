#!/bin/bash

#Initial variables with default values. These values can be set using -d and -f respectively
#Note they are required
database=""
filename=""

# Parse options
options=$(getopt -o d:f: --long database:,filename: -n 'script.sh' -- "$@")

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
    -f | --filename ) # file name
      filename="$2"
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

# Check if required options are provided
if [ -z "$database" ]; then
  echo "ERROR: Database name is required."
  exit 1
fi

if [ -z "$filename" ]; then
  echo "ERROR: Filename is required."
  exit 1
fi


echo "INFO: Performing backup for database: $database to file: $filename"

#Run backup
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $MSSQL_SA_PASSWORD -Q "BACKUP DATABASE $database TO DISK = '/var/opt/mssql/backup/$filename.bak'"