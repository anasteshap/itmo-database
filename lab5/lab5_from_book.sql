-- 1 Найти среднее количество покупок на чек для каждого покупателя (2 способа)
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
