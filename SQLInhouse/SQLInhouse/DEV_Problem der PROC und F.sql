-------------------------------------------------------------
---LÖSUNGEN zu PROC und F()----------------------------------
-------------------------------------------------------------


--bessere Proc wenn man intern auf ander Proc verweist
create proc gpKDSuche @par
as

IF LEN(@par) > 1 exec Proc1 --SEEK
else	
exec proc3 -- SCAN




--KU2 als reiner HEAP ohne  IX

set statistics io, time on

select * from ku2 where id < 2

exec gpSuchID @par

--adhoc als Prozedur

drop proc gpSuchID

create proc gpSuchID @par int
as
select * from ku2 where id < @par
GO

exec gpSuchID 2 --IX SEEK --perfekt

dbcc freeproccache

select * from ku2 where id < 1000000 --44442

exec gpSuchID 1000000 --Proz verwendet den gleichen Plan wie beim ersten Aufruf

---über 1 MIO Seiten, obwohl Tabelle 45000 hat

--Proz sollte nicht benutzerfreundlich
--was wäre schlecht
---- je nach Par mal tab A durchgeht oder mal TAB B
--SQL Server wird bei IF im Proc den nicht aufgeruf Teil grob schätzen müssen




exec gpSuchID 2










--> Funktkionen

select * from customers where customerid like 'AL%' --wesentlich besser

select * from customers where left(customerid,2) ='AL' --top ober besch******

--F() müssen immer scannen

--tu nie im Where um eine Spalte eine F()--
--F() nehmen immer nur eine CPU her

select * from employees
--65 oder älter

--GUT
select * from employees where dateadd(year, -65, getdate()) > BirthDate

--schlecht
select * from employees where dateadd(yy, birthdate, -65)  >0


--F(Orderid) --Rsumme

--mal testweise auf NwindBig
Use NwindBig

set statistics io , time on

create function fRsumme (@oid int) returns money
as
begin
return (select sum(unitprice*quantity) from [Order Details] where orderid = @oid)
end



--nun auf Modus 2017

select orderid, dbo.fRsumme(orderid), freight from orders
	where employeeid = 3

set statistics io  ,time on
--nun auf Modus 2019
select orderid, dbo.fRsumme(orderid), freight from orders
	where employeeid = 3



	--Je nach SQL Server werden Tabellenwertfuncktionen
	--mit 1 oder 100 Zeilen egschätzt

	--erst SQL 2017 bringt hier Vorteile
set statistics io, time on

ALTER DATABASE [NwindBig] SET COMPATIBILITY_LEVEL = 110
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE ; 
Go

create function ftabvar (@oid int) returns 
		@Tab table (oid int, freight int, customerid nchar(5))
		as
	begin
			insert into @tab select orderid , freight, customerid from orders
			where orderid < @oid
		return	
	end

	select * from dbo.ftabvar(100000) where oid < 100