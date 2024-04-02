-- ******************************************************** --
-- Scalar UDF Inlining


-- ******************************************************** --
USE [master];
GO

ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 120;
GO

USE [WideWorldImportersDW];
GO

/*
inlining
*/
CREATE OR ALTER FUNCTION
	dbo.ufn_customer_category(@CustomerKey INT)
RETURNS CHAR(10) AS
BEGIN
	DECLARE @total_amount DECIMAL(18,2);
	DECLARE @category CHAR(10);

	SELECT @total_amount = SUM([Total Including Tax])
	FROM [Fact].[Order]
	WHERE [Customer Key] = @CustomerKey;

	IF @total_amount < 500000
		SET @category = 'REGULAR';
	ELSE IF @total_amount < 1000000
		SET @category = 'GOLD';
	ELSE
		SET @category = 'PLATINUM';

	RETURN @category;
END
GO

SELECT * FROM sys.sql_modules
WHERE object_id = OBJECT_ID('ufn_customer_category')
GO

-- Before (show actual query execution plan for legacy behavior)
set statistics io, time on

SELECT TOP 100
		[Customer Key], [Customer],
       dbo.ufn_customer_category([Customer Key]) AS [Discount Price]
FROM [Dimension].[Customer]
ORDER BY [Customer Key]
OPTION (RECOMPILE,USE HINT('DISABLE_TSQL_SCALAR_UDF_INLINING'));
GO

ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 150;
-- After (show actual query execution plan for Scalar UDF Inlining)
SELECT TOP 100
		[Customer Key], [Customer],
       dbo.ufn_customer_category([Customer Key]) AS [Discount Price]
FROM [Dimension].[Customer]
ORDER BY [Customer Key]
OPTION (RECOMPILE);

