#!/bin/bash

#Initial variables with default values
backup=""

# Parse options
options=$(getopt -o b: --long backup: -n 'script.sh' -- "$@")

if [ $? -ne 0 ]; then
    echo "Failed to parse options." >&2
    exit 1
fi

eval set -- "$options"

# Process options
while true; do
  case "$1" in
    -b | --backup ) # backup name
      backup="$2"
      shift 2
      ;;
    -- )
      shift
      break
      ;;
    * )
      break
      ;;
  esac
done

# Check if required options are provided
if [ -z "$backup" ]; then
  echo "ERROR: Backup name is required."
  exit 1
fi

echo "INFO: Getting filenames for backup: $backup."

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $MSSQL_SA_PASSWORD -Q "RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/$backup.bak'" -s "|" -W