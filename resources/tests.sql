select count(p.ProductID), p.Class
from Production.Product as p
group by p.Class

SELECT COUNT( * )
FROM Production.Product
HAVING COUNT(*)=504;

select len(p.Name) as LenOfName, count(*) as Amount
from Production.Product as p
group by len(p.Name)
order by LenOfName

select top 3 with ties p.ProductSubcategoryID, count(*) as Amount
from Production.Product as p
where p.ProductSubcategoryID is not null
group by p.ProductSubcategoryID
order by count(*) desc

SELECT [Color], COUNT(*) AS 'Amount'
FROM [Production].[Product]
WHERE [Color] IS NOT NULL
GROUP BY [Color]
HAVING COUNT(*)>10 AND MAX([ListPrice])>3000

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY ROLLUP([Color], [Style], [Class])

SELECT [Color], [Style], [Class], COUNT(*)
FROM [Production].[Product]
GROUP BY [Color], [Style], [Class]