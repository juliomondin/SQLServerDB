-- This script sets up the database to be used in the developers environment (Docker Desktop)
-- In order to align service users with the user that will match with permissions in the deployment environment
-- thus testing merissions script, as well as user access will then be possible
IF NOT EXISTS(SELECT name FROM sys.database_principals WHERE name = 'CustomerManagementDbUser')
BEGIN
    CREATE LOGIN [CustomerManagementDbUser] WITH PASSWORD = N'Test12345%', DEFAULT_DATABASE=[CustomerManagement]
END
CREATE USER CustomerManagementDbUser FROM LOGIN CustomerManagementDbUser WITH DEFAULT_SCHEMA=[dbo]
