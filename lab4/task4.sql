select p.Name
from Production.Product as p
where p.ProductID in (
    select sod.ProductID
    from Sales.SalesOrderDetail as sod
    join Sales.SalesOrderHeader as soh
    on sod.SalesOrderID = soh.SalesOrderID
    group by sod.ProductID
    having count(*) > 3 and count(distinct soh.CustomerID) > 3
    )
