--Sortierbar geworden

--Optimierung durch besser Kompression ab SQL 2022
--bessere Aufräumaktionen
--kombinierbar mit in Memory Tabellen
CREATE CLUSTERED COLUMNSTORE INDEX CSIX
ON dbo.ku2 ORDER (City)
WITH (DROP_EXISTING = ON);


---Demos für Realtime Varianten

--This example creates a nonclustered columnstore index on an existing OLTP table.  
--Create the table  
CREATE TABLE t_account (  
    accountkey int PRIMARY KEY,  
    accountdescription nvarchar (50),  
    accounttype nvarchar(50),  
    unitsold int  
);  

--Create the columnstore index with a filtered condition  
CREATE NONCLUSTERED COLUMNSTORE INDEX account_NCCI   
ON t_account (accountkey, accountdescription, unitsold)   
;

--oder so : :-)
-- This example creates a memory-optimized table with a columnstore index.  
CREATE TABLE t_account (  
    accountkey int NOT NULL PRIMARY KEY NONCLUSTERED,  
    Accountdescription nvarchar (50),  
    accounttype nvarchar(50),  
    unitsold int,  
    INDEX t_account_cci CLUSTERED COLUMNSTORE  
    )  
    WITH (MEMORY_OPTIMIZED = ON );  
GO