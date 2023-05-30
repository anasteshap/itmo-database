-- название самого дорогого товара с цветом Red
select *
from Production.Product as p
where p.Color = 'Red'
  and p.ListPrice =
      (select max(p2.ListPrice)
       from Production.Product as p2
       where p2.Color = 'Red')

-- список товаров, цвет которых может быть любой, кроме Red,
-- а цена равна цене любого товара с цветом Red
select *
from Production.Product as p
where p.Color != 'Red'
  and p.ListPrice = any
      (select p2.ListPrice
       from Production.Product as p2
       where p2.Color = 'Red')

-- список товаров, цена которых больше цены любого из товаров с цветом Red
select *
from Production.Product as p
where p.ListPrice > all
      (select p2.ListPrice
       from Production.Product as p2
       where p2.Color = 'Red')

-- название товаров, чей цвет совпадает с цветом одного из товаров,
-- чья цена больше 3000
select *
from Production.Product as p
where p.Color in
      (select p2.Color
       from Production.Product as p2
       where p2.ListPrice > 3000)

-- название категории, где содержится самый дорогой товар
select *
from Production.ProductCategory as pc
where pc.ProductCategoryID in
      (select psc.ProductCategoryID
       from Production.ProductSubcategory as psc
       where psc.ProductSubcategoryID in
             (select p.ProductSubcategoryID
              from Production.Product as p
              where p.ListPrice =
                    (select max(p2.ListPrice)
                     from Production.Product as p2)))

-- список товаров, у которых цвет совпадает с цветом самого дорогого товара,
-- и стиль совпадает со стилем самого дорого товара
select *
from Production.Product as p
where p.Color in
      (select Color
       from Production.Product
       where ListPrice =
             (select max(ListPrice)
              from Production.Product))
  and p.Style in
      (select Style
       from Production.Product
       where ListPrice =
             (select max(ListPrice)
              from Production.Product))

-- найти номер подкатегории товаров с наибольшим количеством товаров (???)
select p.ProductSubcategoryID
from Production.Product as p
group by p.ProductSubcategoryID
having count(*) =
       (select top 1 count(*) -- ProductSubcategoryID c макс кол-вом товаров
        from Production.Product
        group by ProductSubcategoryID
        order by count(*) desc)

-- список самых дорогих товаров в каждой из подкатегорий
-- коррелирующий подзапрос
select p1.ListPrice, p1.ProductSubcategoryID
from Production.Product as p1
where ListPrice =
      (select max(p2.ListPrice)
       from Production.Product as p2
       where p1.ProductSubcategoryID = p2.ProductSubcategoryID)
-- нихуя не поняла нахуя (или поняла) ааа понялааа ура))

-- название продукта и название подкатегории, к которой он относится
select p.Name,
       (select psc.Name
        from Production.ProductSubcategory as psc
        where p.ProductSubcategoryID = psc.ProductSubcategoryID) as SubCategory
from Production.Product as p


select p.Name,
       (select psc.Name
        from Production.ProductSubcategory as psc
        where p.ProductSubcategoryID = psc.ProductSubcategoryID) as SubCategory
from Production.Product as p

-- Вывести на экран такого покупателя, который каждый раз покупал только одну номенклатуру товаров,
-- не обязательно в одинаковых количествах, т.е. у него всегда был один и тот же «список покупок»

select soh1.CustomerID
from Sales.SalesOrderHeader as soh1
group by soh1.CustomerID
having count(*) > 1 and count(*) = all (
    select count(*)
    from Sales.SalesOrderHeader as soh
    join Sales.SalesOrderDetail as sod
    on soh.SalesOrderID = sod.SalesOrderID
--     where soh.CustomerID = soh1.CustomerID
    group by soh.CustomerID, sod.ProductID
    having soh.CustomerID = soh1.CustomerID
)
