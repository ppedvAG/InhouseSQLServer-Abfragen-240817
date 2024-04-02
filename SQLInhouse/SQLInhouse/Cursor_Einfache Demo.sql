use Northwind;
GO

Declare @Firma as varchar(50)
Declare @KDID as varchar(50)

Declare demoCursor Cursor For
Select Companyname, customerid from customers where Country = 'Germany'

Open  DemoCursor
Fetch next from democursor into @Firma, @kdid

While @@Fetch_Status=0
Begin
	select @Firma, @kdid
	Fetch next from democursor into @Firma, @kdid
end


--------------FETCH

use Northwind;
GO

Declare @Firma as varchar(50)
Declare @KDID as varchar(50)

Declare demoCursor Cursor For
Select Companyname, customerid from customers where Country = 'Germany'

Open  DemoCursor
Fetch next from democursor into @Firma, @kdid

While @@Fetch_Status=0
Begin
	select @Firma, @kdid
	Fetch next from democursor into @Firma, @kdid
end

close democursor
deallocate demoCuros
