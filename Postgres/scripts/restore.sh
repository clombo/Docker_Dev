#!/bin/bash

name=""
database=""

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
      name="$2"
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

if [ -z "$name" ]; then
  echo "ERROR: Filename is required."
  exit 1
fi


echo "INFO: Performing restore for database: $database from file: $name"

#Run restore
pg_restore -h localhost -p 5432 -U $POSTGRES_USER -d $database "/usr/local/backups/$name.backup" -v