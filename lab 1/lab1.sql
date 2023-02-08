/* task1 */
select p.Name, p.Color, p.Size
from Production.Product as p

/* task2 */
select p.Name, p.Color, p.Size
from Production.Product as p
where p.StandardCost > 100

/* task3 */
select p.Name, p.Color, p.Size
from Production.Product as p
where p.StandardCost < 100 and p.Color = 'Black'

/* task4 */
select p.Name, p.Color, p.Size
from Production.Product as p
where p.StandardCost < 100 and p.Color = 'Black'
order by p.StandardCost

/* task5 */
select top 3 p.Name, p.Size
from Production.Product as p
where p.Color = 'Black'
order by p.StandardCost desc

/* task6 */
select top 3 p.Name, p.Color
from Production.Product as p
where p.Color is not NULL and p.Size is not NULL

/* task7 */
select distinct p.Color
from Production.Product as p
where p.StandardCost between 10 and 50

/* task8 */
select p.Color
from Production.Product as p
where p.Name like 'L_N%'

/* task9_1 */
select p.Name
from Production.Product as p
where p.Name like '[DM]___%'

/* task9_2 */
select p.Name
from Production.Product as p
where p.Name like '[DM]%' and len(p.Name) > 3

/* task10_1 */
select p.Name
from Production.Product as p
where DATEPART(year, p.SellStartDate) <= 2012

/* task10_2 */
select p.Name
from Production.Product as p
where p.SellStartDate < '2013-01-01'

/* task11 */
select sc.Name
from Production.ProductSubcategory sc

/* task12 */
select c.Name
from Production.ProductCategory c

/* task13 */
select p.FirstName
from Person.Person p
where p.Title = 'Mr.'

/* task14 */
select p.FirstName
from Person.Person p
where p.Title is NULL
