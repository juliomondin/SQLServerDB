-- This script sets up the database to be used in the developers environment (Docker Desktop)
-- Other database environment settings that need to align with scripts
EXEC sys.sp_cdc_enable_db


ALTER DATABASE [CustomerManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [CustomerManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
