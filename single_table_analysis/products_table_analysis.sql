-- products table analysis:-

select * from products;

#how many products are there?
select count(distinct(productCode)) from products;
-- there are 110 unique products

#which product line have the most products?
select productLine, count(productLine) as count
from products
group by productLine
order by count desc;

#which are the cheapest and costliest products?
select productName, max(buyPrice) as price
from products
group by productName
order by price desc
limit 1;

select productName, min(buyPrice)
from products
group by productName
limit 1;

#which product have the cheapest and costliest msrp
select productName, max(MSRP) as price
from products
group by productName
order by price desc
limit 1;

select productName, min(MSRP)
from products
group by productName
limit 1;

#top 10 prodcuts with highest margin
select productCode,productName,(MSRP - buyPrice) as margin from products
group by productCode,productName
order by margin desc;

#top 10 products with highest margin percentage
select productCode,productName,(((MSRP - buyPrice)/buyPrice)*100) as margin from products
group by productCode,productName
order by margin desc
limit 10;

#which scale is used most?
select productScale, count(productScale) as count
from products
group by productScale
order by count desc;

#product with most in stock?
select productCode,productName,quantityInStock from products
order by quantityInStock desc;