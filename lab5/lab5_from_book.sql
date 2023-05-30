-- 1 Найти среднее количество покупок на чек для каждого покупателя
with OrderCount (CustomerID, SalesOrderID, ProductCount) as
         (select CustomerID, sod.SalesOrderID, count(ProductID) as PoductCount
          from Sales.SalesOrderDetail as sod
                   join Sales.SalesOrderHeader as soh
                        on sod.SalesOrderID = soh.SalesOrderID
          group by CustomerID, SOD.SalesOrderID)

select CustomerID, avg(ProductCount) as Avg
from OrderCount
group by CustomerID
order by CustomerID

-- 2 Найти для каждого продукта и каждого покупателя соотношение
-- количества фактов покупки данного товара данным покупателем
-- к общему количеству фактов покупки товаров данным покупателем

with OneProduct(CustomerID, ProductID, ProductCount) as
         (select CustomerID, ProductID, count(1) as ProductCount
          from Sales.SalesOrderDetail as sod
                   join Sales.SalesOrderHeader as soh
                        on sod.SalesOrderID = soh.SalesOrderID
          group by CustomerID, ProductID),

     AllProducts (CustomerID, TotalCount) as
         (select CustomerID, count(1) as TotalCount
          from Sales.SalesOrderHeader as soh
          group by CustomerID)

select OneProduct.CustomerID, ProductID, cast(ProductCount as decimal) / cast(TotalCount as decimal) as ratio
from OneProduct
         JOIN AllProducts
              ON OneProduct.CustomerID = AllProducts.CustomerID
ORDER BY 1, 2
