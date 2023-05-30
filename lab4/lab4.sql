-- 1 Найти название самого продаваемого продукта
select p.Name
from Production.Product as p
where p.ProductID =
      (select top 1 sod.ProductID
       from Sales.SalesOrderDetail as sod
       group by sod.ProductID
       order by count(*) desc)

-- 2 Найти покупателя, совершившего покупку на самую большую сумм,
-- считая сумму покупки исходя из цены товара без скидки (UnitPrice)
select soh.CustomerID, sod.OrderQty * sod.UnitPrice AS 'Total Cost'
from Sales.SalesOrderHeader as soh
         join Sales.SalesOrderDetail as sod
              on soh.SalesOrderID = sod.SalesOrderID
where sod.OrderQty * sod.UnitPrice =
      (select max(sod.OrderQty * sod.UnitPrice)
       from Sales.SalesOrderHeader AS soh
                join Sales.SalesOrderDetail AS sod
                     on soh.SalesOrderID = sod.SalesOrderID)

-- 3 Найти такие продукты, которые покупал только один покупатель
select P.Name
from Sales.SalesOrderHeader as soh
join Sales.SalesOrderDetail as sod
on soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product as P
ON P.ProductID = sod.ProductID
GROUP BY P.Name
HAVING count(soh.CustomerID) = 1


SELECT
    ProductID
FROM
    Sales.SalesOrderDetail
WHERE
        ProductID IN
        (
            SELECT
                SOD.ProductID
            FROM
                Sales.SalesOrderDetail AS SOD
                    JOIN
                Sales.SalesOrderHeader AS SOH
                ON
                        SOD.SalesOrderID = SOH.SalesOrderID
            GROUP BY
                SOD.ProductID
            HAVING
                    COUNT(DISTINCT SOH.CustomerID) = 1
        )
