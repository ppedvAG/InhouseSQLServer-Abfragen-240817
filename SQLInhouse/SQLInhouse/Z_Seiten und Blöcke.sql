--Seiten und Blöcke

--Seiten und Blöcke

/*
1  Seiten = 8192bytes
max 8072 bytes Datenvolumen
1 DS mit fixen Längen max 8060byts und muss in Seite passen
max 700 DS pro Seite

8 zusammenhängende Seiten = Block

Seite = Page 
Block = Extent

SQL kann mur mit einem Thread eine Seite lesen. 
Zwei Zugriffe ergeben einen Latch oder auch Spinocks
Latch = supended, Spinlocks sind aktiv

dbcc showcontig('Tabelle')

*/

use northwind;
GO


create table t1 (id int identity, spx char(4100));
GO


insert into t1 
select 'XY'
GO 20000
--Zeit Messen


dbcc shwocontig('')



select * from sys.dm_db_index_physical_stats(db_id(), object_id(''), NULL, NULL, 'detailed')
GO



use northwind;
GO


create table t1 (id int identity, spx char(4100));
GO


insert into t1 
select 'XY'
GO 20000
--Zeit Messen

--veraltet
dbcc showcontig('')


--besser
select * from sys.dm_db_index_physical_stats(db_id(), object_id(''), NULL, NULL, 'detailed')
GO



--Warum hat die Tabelle t1 160MB , bei ca 80MB Daten
--Warum liest man aus der Tabelle KU 57000, wenn der dbcc nur 41000 Seiten angibt