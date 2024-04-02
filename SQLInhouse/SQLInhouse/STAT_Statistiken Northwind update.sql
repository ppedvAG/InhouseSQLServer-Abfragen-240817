/*

Bis zu einem bestimmten Grenzwert
Ca 20000
(AnzahlDatenSätze / 5) + 500


Ab ca 20000 gilt die Formel
Wurzel aus (AnzahlDS*1000)
*/
--Abfrage auf Freight erzeugt Statistik...ohne IX Stichproben
select * from kundeumsatz where freight = 0.02
GO
create nonclustered index NIX_Freight on Kundeumsatz(freight)
GO


select count(*)from kundeumsatz
select sqrt(1000*1103360)
--ab --1103360--> 33216!!!! update derStats
select * from sys.stats where object_id= object_id('kundeumsatz')

select * from sys.dm_db_stats_properties(object_id('kundeumsatz'),3)
select * from sys.dm_db_stats_histogram(object_id('kundeumsatz'),3)

select * from sys.dm_db_stats_properties(object_id('kundeumsatz'),2)
select * from sys.dm_db_stats_histogram(object_id('kundeumsatz'),2)

dbcc freeproccache
set statistics io , time on
select freight from kundeumsatz where freight = 0.02 --1024 Datensätze


exec demoStats 33215


select * from ku where freight = 0.02 --1024 Datensätze


exec demoStats 20000
exec demoStatsKU 40000

drop table KU
select * into ku from kundeumsatz
where id <= 1000000

create nonclustered index NIX_Freight on KU(freight)
GO




select * from kundeumsatz where freight = 0.02 --1024 Datensätze






select * from kundeumsatz with (index([NIX_Freight]))
where freight = 0.02 



--insert von 33215 DAtensätzen plus Abfrage auf Freight

use [Northwind]
GO
UPDATE STATISTICS [dbo].[KundeUmsatz] [_WA_Sys_0000000B_22751F6C]
WITH AUTO_DROP = ON
GO


--insert von einem DS 

select * from kundeumsatz where freight = 0.02



DBCC SHOW_STATISTICS ( 'dbo.KU3' ,[_WA_Sys_00000006_2DE6D218] ) WITH STAT_HEADER ;


 SET STATISTICS TIME ON ;
UPDATE STATISTICS dbo.kundeumsatz[NIX_freight]
with sample 70 percent ;



 SELECT
s.name AS StatsName, sp.*
FROM sys.stats s
CROSS apply sys.dm_db_stats_properties(s.OBJECT_ID, s.stats_id) sp
WHERE s.name like '_WA_Sys_%'
