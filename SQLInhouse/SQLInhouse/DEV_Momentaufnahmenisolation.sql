--Snapshotidolation
--DS werden beim Ändern versioniert... (kommen in Tempdb)
--


--Schreiben hindert Lesen nicht mehr
--Lesen hindert auch Schreiben nicht mehr
--Versionen kommen in Tempdb!!-- evtl zuviel !!


--wird standard für jeden Client

USE [master]
GO
ALTER DATABASE [Northwind] SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO

--PS Ohne Zeilenversionierung wird immer READ Commited gemacht..
--Lesen nach Ändern

