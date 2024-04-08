--Probleme bei Seiten..

--schlechter Füllgrad
--große Tabellen --> hohe IO --hoher RAM - Verbrauch


--kein IX--> TABLE SCAN

set statistics io, time on--

select * from ku where id = 100 --61058--von HDD in RAM


--Feststellen des Füllgrads der Seiten
dbcc showcontig('KU')
--- Gescannte Seiten.............................: 48028
--- Mittlere Seitendichte (voll).....................: 97.86%

--> Wie kommt es dazu, dass mehr Seiten gelesen werden als lt dbcc vorhanden

--> forward record counts
--> Das Hinzufügen von Spalten wird beim Heap dadurch gelöst, dass im "Anhang" weitere Seiten 
-- angelegt werden mit den neuen Spaltendaten..
-- Dadurch ist ein beachtlicher Mehraufwand vorhanden (zusätzliches Lesen, Limits der Seiten)
-- Beheben durch Clustered IX -- wird dann immer NULL sein
-- Wird der CL IX dann wieder gelöscht wird der Wert 0 erscheinen und kann durch hinzufügen wieder 
-- fwrec haben



--DMV
select * from sys.dm_os_
select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL,NULL,'detailed')

--forward record count!! muss NULL oder 0 sein
--wie krieg ich es weg?
--Gr IX = Tabelle , aber immer sortiert


Brent Ozar...  sp_blitzindex

---48274


--Was wäre, wenn die Seiten einen Füllgrad von 60% hätten
--kommt öfter bei sehr breiten Tabellen vor..

--Tabellen splitten Kunde + Kundensonstiges
--Datentypen statt datetime (ms) date

--alles ändert die APP...

--kompression--man kommt idr auf 40 bis 60%

--Seiten kommen 1:1 in RAM auch komprimiert
--wird bezahlt mit CPU


--Weniger IO ---------------------> weniger RAM --------------------> weniger CPU






