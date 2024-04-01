#!/bin/bash

#Initi variables with default values. These values can be set using -d and -f respectively
#Note they are required
database=""
filename=""

# Parse options
while getopts ":d:f:" opt; do
  case ${opt} in
    d ) # Database name
      database="$OPTARG"
      ;;
    f ) # Filename
      filename="$OPTARG"
      ;;
    \? ) echo "Invalid option: $OPTARG" 1>&2
      exit 1
      ;;
    : ) echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Check if required options are provided
if [ -z "$database" ]; then
  echo "ERROR: Database name is required."
  exit 1
fi

if [ -z "$filename" ]; then
  echo "ERROR: Filename is required."
  exit 1
fi

# Perform backup using provided options
echo "INFO: Performing backup for database: $database to file: $filename"


#Run backup
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "1AW9YzvtFC7z" -Q "BACKUP DATABASE $database TO DISK = '/var/opt/mssql/backup/$filename.bak'"