/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

-- EXCEUTE THIS SP : exec bronze.load_bronze
--create stroe procedure
create or alter procedure bronze.load_bronze as
begin
	DECLARE @start_time DATETIME,@end_time DATETIME, @batch_start_time DATETIME,@batch_end_time Datetime;
	Begin try
		set @batch_start_time = getdate();
		print '==========================================';
		print 'LOADING BRONZE LAYER';
		PRINT '==========================================';

		PRINT '------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '------------------------------------------';

		-- data insert in BRONZE.CRM_CUST_INFO

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.CRM_CUST_INFO';
		truncate table BRONZE.CRM_CUST_INFO;

		PRINT '>> INSERTING DATA INTO:BRONZE.CRM_CUST_INFO';
		BULK INSERT BRONZE.CRM_CUST_INFO
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		-- data insert in [bronze].[crm_prd_info]
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.crm_prd_info';
		truncate table [bronze].[crm_prd_info];

		PRINT '>> INSERTING DATA INTO:BRONZE.crm_prd_info';
		BULK INSERT [bronze].[crm_prd_info]
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		-- data insert in crm_sales_details

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.crm_sales_details';
		truncate table [bronze].[crm_sales_details];

		PRINT '>> INSERTING DATA INTO:BRONZE.crm_sales_details';
		BULK INSERT [bronze].[crm_sales_details]
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		PRINT '------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '------------------------------------------';

		-- data insert in erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.erp_cust_az12';
		truncate table [bronze].[erp_cust_az12];

		PRINT '>> INSERTING DATA INTO:BRONZE.erp_cust_az12';
		BULK INSERT [bronze].[erp_cust_az12]
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		--data insert in erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.erp_loc_a101';
		truncate table [bronze].[erp_loc_a101];

		PRINT '>> INSERTING DATA INTO:BRONZE.erp_loc_a101';
		BULK INSERT [bronze].[erp_loc_a101]
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		-- data insert in erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE:BRONZE.erp_px_cat_g1v2';
		truncate table [bronze].[erp_px_cat_g1v2];

		PRINT '>> INSERTING DATA INTO:BRONZE.erp_px_cat_g1v2';
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 'C:\Users\bhakt\OneDrive\Desktop\2026-INTERVIEW PREP\3 - Study 2026\SQL\SQL Projects - mine\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' SECONDS';
		PRINT '>> --------------';

		set @batch_end_time = GETDATE();
		print '========================================';
		PRINT 'LOADING BRONZE LAYER IS COMPLETED';
		PRINT ' - TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) as nvarchar) + ' seconds';
		print '========================================';

	end try 
	begin catch
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZELAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_MESSAGE() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	end catch
end

