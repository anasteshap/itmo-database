-- 9
select v.Name
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
group by v.Name
order by count(*)


-- 9
select v.Name
from Purchasing.ProductVendor as pv
         join Purchasing.Vendor as v
              on pv.BusinessEntityID = v.BusinessEntityID
group by v.BusinessEntityID, v.Name
order by count(*)