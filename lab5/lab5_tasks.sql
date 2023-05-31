/**
  Найти покупателей, у которых есть минимум три чека
  и они покупали товар минимум три раза (он присутствует в 3 чеках)

  такого нет у гугл доменте
*/
with orderInfo(CustomerID, OrderID, ProductID) as
         (select soh.CustomerID, soh.SalesOrderID, sod.ProductID
          from Sales.SalesOrderHeader as soh
                   join Sales.SalesOrderDetail as sod on sod.SalesOrderID = soh.SalesOrderID),
     ordersCountPerProduct(CustomerID, ProductID, OrdersCount) as
         (select CustomerID, ProductID, count(OrderID)
          from orderInfo
          group by CustomerID, ProductID
          having count(OrderID) > 3),
     ordersPerCustomer(CustomerID, orderCount) as
         (select CustomerID, count(distinct OrderID)
          from orderInfo
          group by CustomerID)

select distinct oi.CustomerID
from orderInfo as oi
         join ordersCountPerProduct as ocpp on oi.CustomerID = ocpp.CustomerID
         join ordersPerCustomer as opc on oi.CustomerID = opc.CustomerID
where opc.orderCount >= 3
group by oi.CustomerID
having count(ocpp.ProductID) > 0