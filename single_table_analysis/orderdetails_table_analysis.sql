-- orderdetails table analysis:-

select * from orderdetails;

#what are the number of total orders?
select count(distinct(orderNumber)) from orderdetails;
-- there are 326 total orders

#how many uniqe prducts have been ordered?
select count(distinct(productCode)) from orderdetails;
-- 109 uniqe products have been ordered

#which product is ordered the most?
select productCode, count(productCode) as count from orderdetails
group by productCode
order by count desc
limit 1;
-- S18_3232 is ordered the most

#what is the average product quantity of most ordered product?
select avg(quantityOrdered) from orderdetails
where productCode =(
	select productCode as count from orderdetails
	group by productCode
	order by count desc
limit 1);
-- ~35 is the average product quantity in each invoice for most ordered product

#what is the highest bill amount?
select orderNumber,sum(quantityOrdered*priceEach) as total_bill from orderdetails
group by orderNumber
order by total_bill desc
limit 1;
-- ~67393 is the highest billing amont of order number 10165

#what is the highest number of products ordered in a single invoice?
select orderNumber,max(orderLIneNumber) as max_items from orderdetails
group by orderNumber
order by max_items desc
limit 1;
-- 18 products have orderd in a single invoice, which is the highest number

#what is the top 10 high valued invoices?
select orderNumber,sum(quantityOrdered*priceEach) as total_bill from orderdetails
group by orderNumber
order by total_bill desc
limit 10;

#what is the highest valued product?
select productCode, priceEach from orderdetails
order by priceEach desc
limit 1;
-- S10_1949 is the highest valued product

#are product price fixed?
select productCode,priceEach from orderdetails
group by productCode,priceEach
order by productCode;
-- product price varies with order to order most of the times

