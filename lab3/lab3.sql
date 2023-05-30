/* testing */
SELECT p.Name, s.Name
FROM [Production].[Product] p
         INNER JOIN [Production].[ProductSubcategory] s
                    ON p.ProductSubcategoryID = s.ProductSubcategoryID


SELECT p.Name, s.Name
FROM [Production].[Product] p
         LEFT JOIN [Production].[ProductSubcategory] s
                   ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name, p.ProductSubcategoryID, s.ProductSubcategoryID
FROM [Production].[Product] p
         RIGHT JOIN [Production].[ProductSubcategory] s
                    ON p.ProductSubcategoryID = s.ProductSubcategoryID

SELECT p.Name, s.Name, p.ProductSubcategoryID, s.ProductSubcategoryID
FROM [Production].[Product] p
         FULL OUTER JOIN [Production].[ProductSubcategory] s
                         ON p.ProductSubcategoryID = s.ProductSubcategoryID


SELECT tAvalue, tBvalue
FROM dbo.tA
         FULL JOIN dbo.tB ON
    tA.tAvalue = tB.tBvalue

SELECT tAvalue, tBvalue
FROM dbo.tA
         right JOIN dbo.tB ON
    tA.tAvalue = tB.tBvalue

SELECT tAvalue, tBvalue
FROM dbo.tA
         cross JOIN dbo.tB

SELECT p1.Name
FROM [Production].[Product] p1
         JOIN [Production].[Product] p2
              ON p1.Name = p2.Name AND p1.ProductID != p2.ProductID

/*тогда если говорить по рядам:

не нашлось совпадения из 2 таблички -> null
не нашлось совпадения из 2 таблички -> null
нашлось совпадение из 2 таблички -> значение
нашлось сопадение из 2 таблички -> значение
не нашлось совпадение из 2 таблички -> null*/

INSERT INTO dbo.tA (tAvalue)
VALUES (0)
INSERT INTO dbo.tA (tAvalue)
VALUES (1)
INSERT INTO dbo.tA (tAvalue)
VALUES (2)
INSERT INTO dbo.tA (tAvalue)
VALUES (3)
INSERT INTO dbo.tA (tAvalue)
VALUES (null)

UPDATE dbo.tB
SET priority=
IF (priority = 1, 2, 1) WHERE priority IN (1, 2)
    DELETE FROM dbo.tB WHERE tBvalue is null;

select count(distinct pv.ProductID) as CountOfProducts
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v on v.BusinessEntityID = pv.BusinessEntityID
where v.CreditRating = 1