USE northwind;
GO

Begin transaction
SELECT customerid, city, country    FROM customers AS a  
WHERE customerid not in     (SELECT customerid from orders)


DECLARE complex_cursor CURSOR FOR
    SELECT customerid
    FROM customers AS a
    WHERE customerid not in 
         (SELECT customerid from orders)--ohne Angabe der Spalte können alle Spalten geupodatet werden FOR UPDATE OF city ;

OPEN complex_cursor;
FETCH FROM complex_cursor;
FETCH NEXT from complex_cursor-- bis zum Ende
FETCH FIRST FROM complex_cursor --kein zurück bei vorwärtscursor
UPDATE customers SET CITY = city+ 'x', country =country+'X' WHERE CURRENT OF complex_cursor;

CLOSE complex_cursor;
DEALLOCATE complex_cursor;

 SELECT customerid, city, country    FROM customers AS a    WHERE customerid not in          (SELECT customerid from orders)
rollback
GO