--Snapshotidolation
--DS werden beim �ndern versioniert... (kommen in Tempdb)
--


--Schreiben hindert Lesen nicht mehr
--Lesen hindert auch Schreiben nicht mehr
--Versionen kommen in Tempdb!!-- evtl zuviel !!


--wird standard f�r jeden Client

USE [master]
GO
ALTER DATABASE [Northwind] SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO

--PS Ohne Zeilenversionierung wird immer READ Commited gemacht..
--Lesen nach �ndern

