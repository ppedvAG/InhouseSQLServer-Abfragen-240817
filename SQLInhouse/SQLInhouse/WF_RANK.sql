--Window Function

----F() OVER(PARTITION BY Col1 ORDER BY Col2 DESC)

--ROW_NUMBER fortlaufende Zahl--
--RANK-- gleicher RANG = gleiche Zahl.. nächster Rang wird übersprungen
--DENSE_RANK Gleicher Rang = gleiche Nummmer aber keine wird übersprungen
select 
	--nach Frachtkosten sortiert eine fortlaufende nummer
	row_number() over (order by  freight), freight, orderid ,
	--fortlaufende Nummer pro Kunde sortiert nach Frachtkosten abstegend
	row_number() over (partition by customerid order by freight desc ), CustomerID,
	rank() over ( order by freight  ), Shipcountry,
	dense_rank() over ( order by freight  ),
	NTILE((Select count(*)/10 from orders)) over (order by freight)
	-- das geht leider nicht ohne group by 
	--NTILE (count(*)/10) over (order by freight)
from Orders 
order by 6
