USE NORTHWIND;
GO
DROP TABLE IF EXISTS Kundeumsatz;
GO

SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Employees.LastName, Employees.FirstName, Orders.OrderDate, Orders.EmployeeID, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity,
                   Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock
INTO KundeUmsatz
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID
GO

insert into KundeUmsatz
select * from kundeumsatz
GO 9 --keine Varable darin möglich




alter table kundeumsatz add ID int identity
GO


create or alter  procedure demofillerKU @Anzahl as varchar(10)
as
declare @sql as nvarchar(1000)
set @sql = '
insert into KU
select top ' + @anzahl + ' [CustomerID],[CompanyName],[ContactName],[ContactTitle]
		   ,[City],[Country],[LastName]  ,[FirstName],[OrderDate]		  ,[EmployeeID]
		   ,0.02--[Freight]		
		   ,[ShipName],[ShipAddress] ,[ShipCity] 
		   ,[ShipCountry],[OrderID] ,[ProductID],[UnitPrice] 
		   ,[Quantity] ,[ProductName],[UnitsInStock]	  
	FROM [dbo].[KU]'		
exec (@sql)
GO


create or alter  procedure demofillerKundeumsatz @Anzahl as varchar(10)
as
declare @sql as nvarchar(1000)
set @sql = '
insert into Kundeumsatz
select top ' + @anzahl + ' [CustomerID],[CompanyName],[ContactName],[ContactTitle]
		   ,[City],[Country],[LastName]  ,[FirstName],[OrderDate]		  ,[EmployeeID]
		   ,0.02--[Freight]		
		   ,[ShipName],[ShipAddress] ,[ShipCity] 
		   ,[ShipCountry],[OrderID] ,[ProductID],[UnitPrice] 
		   ,[Quantity] ,[ProductName],[UnitsInStock]	  
	FROM [dbo].[Kundeumsatz]'		
exec (@sql)
GO


