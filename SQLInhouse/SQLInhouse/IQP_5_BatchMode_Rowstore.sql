-- ******************************************************** --
-- Batch mode on rowstore


-- ******************************************************** --

USE [master];
GO

ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 120;
GO

USE [WideWorldImportersDW];
GO

-- Row mode due to hint
set statistics io, time on
SELECT [Tax Rate],
	[Lineage Key],
	[Salesperson Key],
	SUM([Quantity]) AS SUM_QTY,
	SUM([Unit Price]) AS SUM_BASE_PRICE,
	COUNT(*) AS COUNT_ORDER
FROM [Fact].[OrderHistoryExtended]
WHERE [Order Date Key] <= DATEADD(dd, -73, '13.11.2015')
GROUP BY [Tax Rate],
	[Lineage Key],
	[Salesperson Key]
ORDER BY [Tax Rate],
	[Lineage Key],
	[Salesperson Key]
OPTION (RECOMPILE, USE HINT('DISALLOW_BATCH_MODE'));

-- Batch mode on rowstore eligible
SELECT [Tax Rate],
	[Lineage Key],
	[Salesperson Key],
	SUM([Quantity]) AS SUM_QTY,
	SUM([Unit Price]) AS SUM_BASE_PRICE,
	COUNT(*) AS COUNT_ORDER
FROM [Fact].[OrderHistoryExtended]
WHERE [Order Date Key] <= DATEADD(dd, -73, '13.11.2015')
GROUP BY [Tax Rate],
	[Lineage Key],
	[Salesperson Key]
ORDER BY [Tax Rate],
	[Lineage Key],
	[Salesperson Key]
OPTION (RECOMPILE);