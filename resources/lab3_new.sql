/* task1 */
select p.Name, pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
             on p.ProductSubcategoryID = psc.ProductCategoryID
         join Production.ProductCategory as pc
             on psc.ProductCategoryID = pc.ProductCategoryID
where p.Color = 'Red' and p.StandardCost >= 100

/* task2_1 */
select psc1.Name
from Production.ProductSubcategory as psc1
         join Production.ProductSubcategory as psc2
              on psc1.ProductSubcategoryID != psc2.ProductSubcategoryID and psc1.Name = psc2.Name

/* task2_2 */
select psc.Name
from Production.ProductSubcategory as psc
group by psc.Name
having count(*) > 1

/* task2_3 */
select psc1.Name
from Production.ProductSubcategory as psc1, Production.ProductSubcategory as psc2
where psc1.ProductSubcategoryID != psc2.ProductSubcategoryID and psc1.Name = psc2.Name

/* task3_1 */
select pc.Name as Category, count(*) as CountOfProducts
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name

/* task4_1 */ /* -------------- */
select distinct psc.Name as SubCategory, count(*) as CountOfProducts
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductCategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by psc.Name

/* task4_2 */ /* -------------- */
select distinct psc.Name as SubCategory, count(*) as CountOfProducts
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductCategoryID
group by psc.Name

/* task7 from book */
select v.CreditRating, count(distinct pv.ProductID)
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
group by CreditRating

/* task5 */ /* непонятно - с наименьшим или наибольшим кол-вом товаро */
select top 3 psc.Name, count(*)
from Production.Product as p
         join  Production.ProductSubcategory as psc
               on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by psc.Name
order by count(*)

-- task6
select psc.Name, max(p.StandardCost) as MaxCost
from Production.Product as p
         join Production.ProductSubcategory as psc
              on psc.ProductSubcategoryID = p.ProductSubcategoryID
where p.Color in ('Red')
group by psc.Name

-- task7_1
select v.Name, count(*) as CountOfProducts
from Purchasing.Vendor as v
         join Purchasing.ProductVendor as pv
              on v.BusinessEntityID = pv.BusinessEntityID
         join Production.Product as p
              on p.ProductID = pv.ProductID
group by v.Name

-- task7_2
select v.Name, count(*) as CountOfProducts
from Purchasing.Vendor as v
         join Purchasing.ProductVendor as pv
              on v.BusinessEntityID = pv.BusinessEntityID
group by v.Name

-- task8_1
select p.Name as ProductName, count(*) as CountOfVendors
from Production.Product as p
         join Purchasing.ProductVendor as pv
              on p.ProductID = pv.ProductID
group by p.Name
having count(*) > 1
order by count(*)

-- task8_2 - по идее тут лишний join, который ни на что не влияет, но мб он нужен для правильности (???)
select product.Name, COUNT(vendor.Name) as CountOfVendors
from Production.Product as product
         join Purchasing.ProductVendor as pvendor
              on pvendor.ProductID = product.ProductID
         join Purchasing.Vendor as vendor
              on vendor.BusinessEntityID = pvendor.BusinessEntityID
group by product.Name
having count(vendor.Name) > 1
order by count(*)

-- task9
select top 1 p.Name, count(*) as Count
from Production.Product as p
         join Purchasing.ProductVendor as pv
              on p.ProductID = pv.ProductID
group by p.Name
order by count(*) desc

-- task10_1 - если по количеству покупок
select top 1 pc.Name
from Sales.SalesOrderDetail as sod
         join Production.Product as p
              on sod.ProductID = p.ProductID
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by count(*) desc

-- task10_2 - если имеющий самое большое количество предложений
select top 1 pc.Name
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
         join Purchasing.ProductVendor as pv
              on p.ProductID = pv.ProductID
group by pc.Name
order by count(*) desc

-- task11
select pc.Name, count(distinct p.ProductSubcategoryID) as CountOfSubCat, count(p.ProductID) as CountOfProducts
from Production.Product as p
         join Production.ProductSubcategory as psc
              on p.ProductSubcategoryID = psc.ProductSubcategoryID
         join Production.ProductCategory as pc
              on psc.ProductCategoryID = pc.ProductCategoryID
group by pc.Name

-- task12
select v.CreditRating, count(*)
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
group by v.CreditRating
order by v.CreditRating

SELECT TOP 3 PC.ProductCategoryID
FROM [Production].[Product] AS P INNER JOIN
     [Production].[ProductSubcategory] AS PSC
     ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
                                 INNER JOIN [Production].[ProductCategory] AS PC
                                            ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.ProductCategoryID
ORDER BY COUNT(*) DESC
SELECT top 3 psc.name, count(*)
FROM [Production].[Product] AS p INner JOIN
     [Production].[ProductSubcategory] AS psc
     ON p.ProductSubcategoryID=psc.ProductSubcategoryID
WHERE p.ProductSubcategoryID is NOT null
GROUP BY p.ProductSubcategoryID, psc.Name
ORDER BY count(*) desc





