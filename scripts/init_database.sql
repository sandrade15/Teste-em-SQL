/*esse script cria a Database e os Schemas ( bronze, gold e silver ).
ele primeiro checa se já tem a datawarehouse e, se nao tiver, cria ela.
se tiver ele dá drop na que ja existia e recria ela. depois sao feitos os schemas.*/

/*NÃO USAR ESSE SCRIPT SE A DATAWAREHOUSE JÁ EXISTIR.*/

USE master;


IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse' )
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


CREATE DATABASE DataWarehouse;
GO


USE DataWarehouse;
GO


CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
