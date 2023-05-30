-- 1 Вывести названия категорий товаров, количество продуктов в которых больше 20
select pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
having count(*) > 20

-- 2 Получить названия первых двух категорий товаров
-- из упорядоченного по возрастанию количества товаров в категории списка
select top 2 pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by count(*)

-- 3 Найти названия товаров, которые были проданы хотя бы один раз
select p.Name
from Production.Product as p
         join Sales.SalesOrderDetail as sod
              on p.ProductID = sod.ProductID
group by p.Name
-- having count(*) >= 1

-- 4 Найти названия товаров, которые не были проданы ни разу - вопроооооооооос (???)
select p.Name
from Production.Product as p
         left join Sales.SalesOrderDetail as sod
                   on p.ProductID = sod.ProductID
where sod.ProductID is null
group by p.Name

-- 5 Вывести на экран список товаров, названия, упорядоченный по количеству продаж, по возрастанию
select p.Name
from Production.Product as p
         join Sales.SalesOrderDetail as sod
              on p.ProductID = sod.ProductID
group by p.Name
order by count(*)

-- 6 Вывести на экран первых три товара с наибольшим количеством продаж
select top 3 p.Name
from Production.Product as p
         join Sales.SalesOrderDetail as sod
              on p.ProductID = sod.ProductID
group by p.Name
order by count(*) desc

-- 7 Вывести на экран список категорий, названия,
-- упорядоченный по количеству продаж товаров этих категорий, по возрастанию
select pc.Name
from Sales.SalesOrderDetail as sod
         join Production.Product as p
              on p.ProductID = sod.ProductID
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by count(sod.ProductID)

SELECT PC.Name
FROM Production.Product AS P
         INNER JOIN Production.ProductSubcategory AS PSC
                    ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
         INNER JOIN Production.ProductCategory AS PC
                    ON PC.ProductCategoryID = PSC.ProductCategoryID
GROUP BY PC.Name, PC.ProductCategoryID
ORDER BY COUNT(*)

-- 8 Вывести список поставщиков, названия вендоров,
-- упорядоченный по количеству поставляемых товаров, по возрастанию
select v.Name
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
group by v.Name
order by count(*)

-- или (нахуя тут продакт нужен(?))
select v.Name
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
         join Production.Product as p
              on p.ProductID = pv.ProductID
group by v.Name
order by count(*)

-- 9 Получить названия первых двух категорий товаров
-- из упорядоченного по возрастанию количества товаров в категории списка
select top 2 pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by count(*)

-- 10 Найти сколько различных размеров товаров приходится на каждую категорию товаров
select pc.Name, count(distinct p.Size) as CountOfVariantsOfSize
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name

-- 11 Найти названия товаров, которые были куплены или три, или пять раз
select p.Name
from Production.Product as p
         join Sales.SalesOrderDetail as sod
              on p.ProductID = sod.ProductID
group by p.Name
having count(*) in (3, 5)

-- 12 Найти названия подкатегорий, которые имеют больше 5 товаров
select psc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
group by psc.Name
having count(*) > 5

-- 13 Найти названия тех категорий товаров, где количество товаров более 20
select pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on pc.ProductCategoryID = psc.ProductCategoryID
group by pc.Name
having count(*) > 20










