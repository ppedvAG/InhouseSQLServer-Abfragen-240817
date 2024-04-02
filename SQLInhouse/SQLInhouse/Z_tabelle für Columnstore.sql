USE [Northwind]
GO
insert into ku2
SELECT [CustomerID]
      ,[CompanyName]
      ,[ContactName]
      ,[ContactTitle]
      ,[City]
      ,[Country]
      ,[EmployeeID]
      ,[OrderDate]
      ,[Freight]
      ,[ShipCity]
      ,[ShipCountry]
      ,[LastName]
      ,[FirstName]
      ,[OrderID]
      ,[ProductID]
      ,[UnitPrice]
      ,[Quantity]
      ,[ProductName]
      ,[UnitsInStock]
  
  FROM [dbo].[ku2]

GO


