#!/bin/bash

# Turn on bash's job control
set -m

# Remove any existing healthcheck ready indicator
rm -f /var/opt/mssql-init/mssql-ready

# Start the primary process
/opt/mssql/bin/sqlservr &

# Prepare a backups directory on the data volume
mkdir -p /var/opt/mssql/backup

# Wait for sql server to become alive

echo "Waiting for SQL Server to start..."
until sqlcmd -S localhost -U sa -P $SA_PASSWORD
do
    sleep 1
done
sleep 1 # Allow sql server startup console messages to flush
echo "SQL Server has started"

FILE=/var/opt/mssql-init/databaseInit.sql
if [ -f "$FILE" ]; then
    echo "$FILE exists."
    echo "Initializing databaseInit.sql"
    sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /var/opt/mssql-init/databaseInit.sql
else 
    echo "$FILE does not exist."
fi

INSERT_FILE=/var/opt/mssql-init/insert.sql
if [ -f "$INSERT_FILE" ]; then
    echo "$INSERT_FILE exists."
    echo "Running insert.sql script"
    sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /var/opt/mssql-init/insert.sql
else 
    echo "$INSERT_FILE does not exist."
fi


# Case you want to restore .bak database inside container. COPY backup database into /var/opt/mssql-init/database
# Initialise databases
# Iterate the mssql-init/databases folder
shopt -s nullglob
cd /var/opt/mssql-init/databases
for filename in *.bak;
do
    filenameWithoutExtension="${filename%.*}"
    echo "Checking for existance of [${filenameWithoutExtension}] database..."
    if sqlcmd -S localhost -U sa -P $SA_PASSWORD -d $filenameWithoutExtension > /dev/null 2>&1;
    then
        echo "  [${filenameWithoutExtension}] database already exists"
    else
        echo "Initialising database [${filenameWithoutExtension}] by restoring .bak file to data volume..."
        sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q \
            "RESTORE DATABASE [${filenameWithoutExtension}] FROM DISK = '/var/opt/mssql-init/databases/${filename}'"
    fi
done

# Create the healthcheck ready indicator
touch /var/opt/mssql-init/mssql-ready

# Bring the primary process back into the foreground and leave it there
fg %1