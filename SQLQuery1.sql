--Задание
/*1. С помощью операторов CUBE и ROLLUP написать
два запроса, которые будут отображать информацию
о среднем количестве продажи книг магазинами Ве-
ликобритании и Канады в промежутке 01/01/2008 по
01/09/2008.*/ 
select c.NameCountry, s.DateOfSale, avg(s.Quantity) as 'Avg Quantity sold books'
from Sales s, Shops sh, Country c
where s.ID_SHOP = sh.ID_SHOP
and
sh.ID_COUNTRY = c.ID_COUNTRY
and
s.DateOfSale between '2018-07-01' and '2018-08-23'
and
c.ID_COUNTRY = 1
or
c.ID_COUNTRY = 5
and
s.DateOfSale between '2018-07-01' and '2018-08-23'
group by 
rollup(NameCountry, DateOfSale)
go

-------------------------------------------------------------------------------

select c.NameCountry, sh.NameShop, avg(s.ID_SALE) as 'Avg Quantity sales'
from Country c, Shops sh, Sales s
where s.ID_SHOP = sh.ID_SHOP
and
sh.ID_COUNTRY = c.ID_COUNTRY
group by
cube (c.NameCountry, sh.NameShop)
go

--------------------------------------------------------------------------

select a.FirstName +' '+ a.LastName as 'First Last name', Year(b.DateOfPublish) as 'Year of Publish', max(b.QuantityBooks) as 'max Quantity Books'
from Books b, Authors a
where 
b.ID_AUTHOR = a.ID_AUTHOR
group by grouping sets (a.FirstName +' '+ a.LastName, Year(b.DateOfPublish))
go

--------------------------------------------------------------------------

select 'Min price sales',
[us books], [deutch books], [суничка], [you], [great reading], [big great reading], [Rembooks], [Venumber]
from (select sh.NameShop, s.Price as 'Min price sales'
from Shops sh, Sales s
where s.ID_SHOP = sh.ID_SHOP
and
s.DateOfSale < '2018-08-28') as SourceTable
pivot
(min ([Min price sales]) for NameShop in ([us books], [deutch books], [суничка], [you], [great reading], [big great reading], [Rembooks], [Venumber]))
as PivoteTable
go