/* task1 */
select p.Color, count(*) as Amount
from Production.Product as p
where p.Color is not null
  and p.StandardCost >= 30
group by p.Color

/* task2 */
select p.Color, min(p.ListPrice) as MinCost
from Production.Product as p
where p.Color is not null
group by p.Color
having min(p.ListPrice) > 100

/* task3 */
select ps.ProductSubcategoryID, count(*) as Amount
from Production.ProductSubcategory as ps
where ps.ProductSubcategoryID is not null /* нужно ли для интовых значений? */
group by ps.ProductSubcategoryID
order by ps.ProductSubcategoryID

/* task4 */
select sod.ProductID, count(*) as AmountOfOrderQty
from Sales.SalesOrderDetail as sod
where sod.ProductID is not null
group by sod.ProductID

/* task5 */
select sod.ProductID, count(*) as AmountOfOrderQty
from Sales.SalesOrderDetail as sod
where sod.ProductID is not null
group by sod.ProductID
having count(sod.OrderQty) > 5

/* task6 */
select soh.CustomerID, count(*)
from Sales.SalesOrderHeader as soh
group by soh.CustomerID, soh.OrderDate
having count(SalesOrderID) > 1
order by soh.CustomerID

/* task7 */
select sod.SalesOrderID, count(*)
from Sales.SalesOrderHeader as sod
group by sod.SalesOrderID
having count(*) > 3

/* task8_1 */
select sod.ProductID, count(*) as Amount
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having sum(sod.OrderQty) > 3 /* тут в сумме по всем заказам их более трех штук */
order by ProductID

/* task8_2 */
select sod.ProductID, count(*) as Amount
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(*) > 3 /* а тут именно то, что они были в трех и более заказах */
order by ProductID

/* task9 */
select sod.ProductID, count(*) as Amount
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(*) like '[35]'
/**
  ANOTHER VARIANTS:
  having count(*) = 3 or count(*) = 5
  having count(*) in (3, 5)
 */
order by ProductID

/* task10 */
select p.ProductSubcategoryID, count(*) as ProductCount
from Production.Product as p
group by p.ProductSubcategoryID
having count(*) > 10

/* task11 */
select sod.ProductID
from Sales.SalesOrderDetail as sod
where sod.OrderQty = 1
group by sod.ProductID
order by sod.ProductID

/* task12 */
select top 1 sod.SalesOrderID, count(*) as Amount /* top 1 with ties */
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID
order by count(*) desc

/* task13 ------- */
select top 1 sod.SalesOrderID, sum(sod.UnitPrice * sod.OrderQty) as OrderSum
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID
order by OrderSum desc

select sod.SalesOrderID, sod.UnitPrice, sod.OrderQty
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID, sod.UnitPrice, sod.OrderQty

SELECT TOP 1 SalesOrderID, UnitPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, UnitPrice
ORDER BY UnitPrice DESC

/* task14 */
select p.ProductSubcategoryID, count(*) as AmountOfProducts
from Production.Product as p
where p.ProductSubcategoryID is not null
  and p.Color is not null
group by p.ProductSubcategoryID

/* task15 */
select p.Color, count(*)
from Production.Product as p
where p.Color is not null
group by p.Color
order by count(*) desc

/* task16 */
select sod.ProductID, count(*)
from Sales.SalesOrderDetail as sod
where sod.OrderQty > 1
group by sod.ProductID
having count(*) > 2


select p.FirstName, p.LastName
from Person.Person as p
where p.Suffix is not null
  and p.Suffix != 'Jr.'


select sod.ProductID
from Sales.SalesOrderDetail as sod
where sod.OrderQty < 3
group by sod.ProductID
having count(*) > 3
order by sod.ProductID



