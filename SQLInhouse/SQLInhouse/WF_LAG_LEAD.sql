--LEAD(Spalte, Anzahl der zu beobachtenden Zeile darunter, Wenn kein Wert dann default)
	-- sortiert nach

select *, lead(Unitprice,1,0) over (order by orderid) ,
		lead(Unitprice,2,0) over (order by orderid)
from [Order Details]


--LAG--Gegenteil von Lead.. der Wert davor
select *, LAG(unitprice,1,0) over (order by orderid) from [Order Details]

--Idee
select *, lead(Unitprice,-1,0) over (order by orderid) ,
		lead(Unitprice,2,0) over (order by orderid)
from [Order Details]



select		lastname,year(orderdate), sum(unitprice*quantity) AS UMSATZ,
			LAG(
					SUM(unitprice*quantity),1,0) 
					over (partition by lastname order by year(orderdate)) as Vorjahr,
			sum(unitprice*quantity)-LAG(
					SUM(unitprice*quantity),1,0) 
					over (partition by lastname order by year(orderdate)) as DiffzumVJ
from 
			employees e 
inner join	orders o			on e.EmployeeID=o.EmployeeID
inner join	[Order Details]od	on od.OrderID= o.OrderID
Group by 
			lastname, year(orderdate)