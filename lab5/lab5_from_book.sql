/**
  1 Найти среднее количество покупок на чек для каждого покупателя
 */
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


/**
  2 Найти для каждого продукта и каждого покупателя соотношение
  количества фактов покупки данного товара данным покупателем
  к общему количеству фактов покупки товаров данным покупателем
 */
with OneProduct (CustomerID, ProductID, ProductCount) as
         (select CustomerID, ProductID, count(1) as ProductCount
          from Sales.SalesOrderDetail as sod
                   join Sales.SalesOrderHeader as soh on sod.SalesOrderID = soh.SalesOrderID
          group by CustomerID, ProductID),
     AllProducts (CustomerID, TotalCount) as
         (select CustomerID, count(1) as TotalCount
          from Sales.SalesOrderHeader as soh
          group by CustomerID)

select OneProduct.CustomerID,
       ProductID,
       cast(ProductCount as decimal) / cast(TotalCount as decimal) as ratio
from OneProduct
         join AllProducts on OneProduct.CustomerID = AllProducts.CustomerID
order by 1, 2


/**
  3 Вывести на экран следующую информацию:
  Название продукта,
  Общее количество фактов покупки этого продукта,
  Общее количество покупателей этого продукта
*/
with ProductSales as
         (select p.Name, count(*) as TotalSales, count(distinct soh.CustomerID) as TotalCustomers
          from Production.Product p
                   join Sales.SalesOrderDetail sod on p.ProductID = sod.ProductID
                   join Sales.SalesOrderHeader soh on sod.SalesOrderID = soh.SalesOrderID
          group by p.Name)

select Name, TotalSales, TotalCustomers
from ProductSales
order by TotalSales desc


/**
  4 Вывести для каждого покупателя информацию
  о максимальной и минимальной стоимости одной покупки, чеке, в виде таблицы:
  номер покупателя, максимальная сумма, минимальная сумма.
 */
with CustomerOrders as
         (select soh.CustomerID, min(soh.TotalDue) as MinTotalDue, max(soh.TotalDue) as MaxTotalDue
          from Sales.SalesOrderHeader as soh
          group by soh.CustomerID)

select co.CustomerID, co.MaxTotalDue, co.MinTotalDue
from CustomerOrders as co
order by CustomerID


/**
  5 Найти номера покупателей, у которых не было
  нет ни одной пары чеков с одинаковым количеством наименований товаров.
 */

-- Тут исключались покупатели, у которых в разных заказах были совпадаюшие наименования продуктов
with Orders(CustomerID, ProductName, SalesOrderID) as
         (select soh.CustomerID, p.Name as ProductName, soh.SalesOrderID
          from Sales.SalesOrderHeader soh
                   join Sales.SalesOrderDetail sod on soh.SalesOrderId = sod.SalesOrderId
                   join Production.Product p on p.ProductID = sod.ProductID)

select distinct o.CustomerID
from Orders as o
where o.CustomerID not in
      (select distinct o1.CustomerID
       from Orders o1
                join Orders o2 on o1.CustomerID = o2.CustomerID
           and o1.SalesOrderID <> o2.SalesOrderID
           and o1.ProductName = o2.ProductName)

/*select so.CustomerID, sod.ProductID, so.SalesOrderID
FROM Sales.SalesOrderHeader so
         JOIN Sales.SalesOrderDetail sod ON so.SalesOrderID = sod.SalesOrderID
GROUP BY so.CustomerID, sod.ProductID, so.SalesOrderID
order by 1;*/

-- тут исключались покупатели, у которых допустим есть два заказа,
-- и в каждом заказе по 5 рандомных продуктов (и там и там их по 5)
with Orders(CustomerID, SalesOrderID, ProductsCount) as
         (select soh.CustomerID, soh.SalesOrderID, count(sod.SalesOrderDetailID) as ProductsCount
          from Sales.SalesOrderHeader soh
                   join Sales.SalesOrderDetail sod on soh.SalesOrderId = sod.SalesOrderId
                   join Production.Product p on p.ProductID = sod.ProductID
          group by soh.CustomerID, soh.SalesOrderID)

select distinct o.CustomerID
from Orders as o
where o.CustomerID not in
      (select distinct o1.CustomerID
       from Orders o1
       group by o1.CustomerID, o1.ProductsCount
       having count(*) > 1)


/**
  6 Найти номера покупателей, у которых все купленные ими товары были куплены
  как минимум дважды, т.е. на два разных чека.
 */
with Orders(CustomerID, ProductID, SalesOrderID) as
         (select soh.CustomerID, sod.ProductID, soh.SalesOrderID
          from Sales.SalesOrderHeader soh
                   join Sales.SalesOrderDetail sod on soh.SalesOrderId = sod.SalesOrderId)

select distinct o.CustomerID
from Orders as o
group by o.CustomerID, o.ProductID
having count(*) >= 2

