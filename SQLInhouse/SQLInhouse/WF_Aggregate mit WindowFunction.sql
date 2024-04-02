-------------------------------------------------------------------------------------
--Gibt es Produkte , die im aktuellen Monat (1998 Monat) 3 	hätten nachbestellt werden sollen 
--noch nicht geliefert und auf Lager sind weniger als Reorderlevel
-------------------------------------------------------------------------------------
select 	  year(orderdate), month(orderdate),p.productname, 
			Menge=sum(od.quantity) 	,p.unitsinstock, p.reorderlevel
from 
	orders o 
	inner join  [order details]   od on o.orderid = od.orderid
	inner join products p on od.productid = p.productid		
	where datediff(dd,requireddate, shippeddate) > 0	
group by 	  year(orderdate) ,month(orderdate)  , p.productname,p.unitsinstock, p.reorderlevel
order by 1 desc, 2 desc


-------------------------------------------------------------------------------------
--Welche Produkte wurden am meisten pro Quartal und Jahr am besten verkauft
-------------------------------------------------------------------------------------
with cte as
(
select productname, year(orderdate)	as jahr ,datepart(qq,orderdate)as Quartal,  sum(od.quantity)  as Menge	,
		 rank() over (partition by  year(orderdate), datepart(qq,orderdate) order by  sum(od.quantity) desc)  as RANG

from 
	orders o 
	inner join  [order details]   od on o.orderid = od.orderid
	inner join products p on od.productid = p.productid		
group by 
		   productname	  ,year(orderdate)	 ,datepart(qq,orderdate)
 )
 select *	from cte  where RANG between 1 and 3


 -------------------------------------------------------------------------------------
--all time Top verkaufte produkte		 --kommt am häufgisten unter den TOP 3 vor
-------------------------------------------------------------------------------------
 with cte as
(
select productname, year(orderdate)	as jahr ,datepart(qq,orderdate)as Quartal,  sum(od.quantity)  as Menge	,
		 rank() over (partition by  year(orderdate), datepart(qq,orderdate) order by  sum(od.quantity) desc)  as RANG

from 
	orders o 
	inner join  [order details]   od on o.orderid = od.orderid
	inner join products p on od.productid = p.productid		
group by 
		   productname	  ,year(orderdate)	 ,datepart(qq,orderdate)
 )
select Productname, count(*) from cte 
where Rang in (1,2,3)
group by productname  order by 2 desc


 -------------------------------------------------------------------------------------
 --Pro Angestellte Veränderung der Lieferkosten gegenüber Vorjahr und  
  -------------------------------------------------------------------------------------

select EmployeeID, YEAR(orderdate),
		sum(freight) as aktFracht,
		LAG(sum(Freight),1,0) over (partition by employeeid 
									order by year(orderdate)) 
									as VorJahr
from orders 
group by EmployeeID, YEAR(OrderDate)
order by 1

---Übersicht nach Jahr

select AngID, [1996], [1997], [1998]
from 
(
	select EmployeeID as AngID, YEAR(orderdate) as Jahr,
		sum(freight) as aktFracht 
		--,LAG(sum(Freight),1,0) over (partition by employeeid 
		--							order by year(orderdate)) 
		--							as VorJahr	,

		--  sum(freight) - LAG(sum(Freight),1,0) over (partition by employeeid 
		--							order by year(orderdate))	as DiffzumVorjahr
from orders 
group by EmployeeID, YEAR(OrderDate)
)	as Source
PIVOT
( 
sum(aktFracht)
for Jahr in ( [1996], [1997], [1998])
) as PT

--Übersicht nach Diff zum Vorjahr

--mit #t
drop table #t
select EmployeeID as AngID, YEAR(orderdate) as Jahr,
		sum(freight) as aktFracht 
		,LAG(sum(Freight),1,0) over (partition by employeeid 
									order by year(orderdate)) 
									as VorJahr	,

		  sum(freight) - LAG(sum(Freight),1,0) over (partition by employeeid 
									order by year(orderdate))	as DiffzumVorjahr
into #t
from orders 
group by EmployeeID, YEAR(OrderDate)


select LAG(freight,1) over (order by freight), freight from orders





CREATE TABLE T (a INT, b INT, c INT);   
GO  
INSERT INTO T VALUES (1, 1, -3), (2, 2, 4), (3, 1, NULL), (4, 3, 1), (5, 2, NULL), (6, 1, 5);   
select * from t

  
SELECT b, c,   
    LAG(2*c, b*(SELECT MIN(b) FROM T), -c/2.0) OVER (ORDER BY a) AS i  
FROM T;

SELECT b, c,   
    LEAD(2*c, b*(SELECT MIN(b) FROM T), -c/2.0) OVER (ORDER BY a) AS i  
FROM T;



select AngID, [1996], [1997], [1998]
from 
(
	select AngId, Jahr, DiffzumVorjahr from #t

)	as Source
PIVOT
( 
 sum(DiffzumVorjahr) 
for Jahr in ( [1996], [1997], [1998])	 
) as PT
 
 ---mit #t


