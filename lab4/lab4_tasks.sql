-- найти название и айдишники продуктов, у которых цвет совпадает с такими товарами,
-- цена на которые была меньше 5000
select p.Name, p.ProductID
from Production.Product as p
where p.Color in (select distinct p1.Color
                  from Production.Product as p1
                  where p1.ListPrice < 5000)

-- вывести на экран товары и ид у которых цвет совпадает с цветом самого дорогого товара
select p.Name -- id нужен?
from Production.Product as p
where p.Color in (select top 1 p1.Color
                  from Production.Product as p1
                  where p1.ListPrice = (select max(p2.ListPrice)
                                        from Production.Product as p2))

-- Вывести названия товаров, чей цвет совпадает с цветом одного из товаров,
-- чья цена меньше 4000
select p.Name
from Production.Product as p
where p.Color in (select p1.Color
                  from Production.Product as p1
                  where p1.ListPrice < 4000)

-- найти название подкатегории где содержится самый дорогой товар с красным цветом
select psc.Name
from Production.ProductSubcategory as psc
where psc.ProductSubcategoryID in (select p.ProductSubcategoryID
                                   from Production.Product as p
                                   where p.Color = 'Red'
                                     and p.ListPrice = (select max(p1.ListPrice)
                                                        from Production.Product as p1
                                                        where p1.Color = 'Red'))

-- Найти название категории с наибольшим количеством товаров (с подзапросом)
select pc.Name -- no
from Production.ProductCategory as pc
where pc.ProductCategoryID in (select psc.ProductCategoryID
                               from Production.ProductSubcategory as psc
                               where psc.ProductSubcategoryID in (select top 1 p.ProductSubcategoryID
                                                                  from Production.Product as p
                                                                  where p.ProductSubcategoryID is not null
                                                                  group by p.ProductSubcategoryID
                                                                  order by count(*) desc))

select pc.Name -- yes
from Production.ProductCategory as pc
where pc.ProductCategoryID =
      (select top 1 ps.ProductCategoryID
       from Production.ProductSubcategory as ps
                join Production.Product as p
                     on p.ProductSubcategoryID = ps.ProductSubcategoryID
       group by ps.ProductCategoryID
       order by count(*) desc)


-- Найти номер покупателя и самый дорогой купленный им товар для
-- каждого покупателя
SELECT DISTINCT soh.CustomerID,
                (SELECT TOP 1 sod.ProductId
                 FROM Sales.SalesOrderDetail sod
                 WHERE sod.UnitPrice = (SELECT MAX(d.UnitPrice)
                                        FROM Sales.SalesOrderDetail d
                                                 JOIN Sales.SalesOrderHeader h
                                                      ON d.SalesOrderID = h.SalesOrderID
                                        WHERE h.CustomerID = soh.CustomerID)) AS ExpensiveProduct
FROM Sales.SalesOrderHeader soh


-- Найти название категории самого продаваемого товара (по количеству чеков на которые он был продан)
select *
from Production.ProductCategory


-- Найти покупателей которые никогда не покупали один и тот же товар дважды
select soh.CustomerID
from Sales.SalesOrderHeader as soh
where soh.CustomerID not in (select soh1.CustomerID
                             from Sales.SalesOrderHeader as soh1
                                      join Sales.SalesOrderDetail as sod
                                           on sod.SalesOrderID = soh1.SalesOrderID
                             where soh1.CustomerID = soh.CustomerID
                             group by CustomerID, ProductID -- что тут ??
                             having count(*) >= 2)


select distinct CustomerID
from Sales.SalesOrderHeader as soh
where not exists(
        select ProductID
        from Sales.SalesOrderDetail as sod1
                 join Sales.SalesOrderHeader as soh1
                      on sod1.SalesOrderID = soh1.SalesOrderID
        where soh1.CustomerID = soh.CustomerID
        group by ProductID
        having count(*) >= 2
    )

