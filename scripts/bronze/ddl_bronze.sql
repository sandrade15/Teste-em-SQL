/*isso aqui vai criar as tables no bronze e vai dropar elasa se ja existirem
tambem: vai mudar a procedure bronze.load_bronze*/

EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
	
	DECLARE @start_time DATETIME, @end_time DATETIME;

	BEGIN TRY

		TRUNCATE TABLE bronze.crm_cust_info;


		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		TRUNCATE TABLE bronze.crm_prd_info;



		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);



		TRUNCATE TABLE bronze.crm_sales_details;


		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);


		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);


		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Downloads Vivaldi\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);

		SET @end_time = GETDATE();
		PRINT 'duracao: ' +CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ ' segundos';




	END TRY
	BEGIN CATCH
		PRINT 'ERRO BRONZE' + ERROR_MESSAGE();
		PRINT 'ERRO BRONZE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERRO BRONZE' + CAST (ERROR_STATE() AS NVARCHAR);


	END CATCH

END
