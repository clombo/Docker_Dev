# Intellisync MongoDB container for local development

This compose file creates a mongodb container that also restores a db backup for local development purposes

## Note

**This should not be used in any production or development server environment and is only for local development**

**If the backup you are restoring comes from production make sure to update the connection strings in the connection collection to point to development**

## Running the container

The following steps assumes you have already installed docker.

1. Copy your .gz backup to the db_dump folder and name it "dump"
2. cd From your terminal into the file containing the compose file
3. Run `docker-compose up -d`