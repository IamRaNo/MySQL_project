-- orders table analysis:-

select * from orders;

#how many orders?
select count(distinct(orderNumber)) from orders;
-- There are 326 orders

#months sorted by most orders?
select month(orderDate) as months, count(orderNumber) total_orders from orders
group by month(orderDate)
order by months;

#status of orders?
select status,count(status) as count from orders
group by status
order by count desc;

#which customer have the most invoices?
select  customerNumber,count(customerNumber) as count from orders
group by customerNumber
order by count desc;
-- customer number 141 have the most invoices

#is there any pattern in shipping?
select month(shippedDate) as months, count(orderNumber) total_orders from orders
group by month(shippedDate)
having months is not null
order by months;

#what is the average duration of shipping from ordering?
select avg(shippedDate - orderDate) from orders;
-- on average it takes 10 days to ship from ordering

#are there any late deliveries?
alter table orders
add column deliveryStatus varchar(15);

update orders
set deliveryStatus = case 
when shippedDate>requiredDate then 'Late'
else 'On Time'
end;

#how many late and on time orders are there?
select deliveryStatus, count(deliveryStatus) from orders
group by deliveryStatus;
-- there is only 1 late delivery

alter table orders drop column deliveryStatus;

#is order increasing over the time?
select date_format(orderDate, "%y-%m") as period,count(orderNumber) as count
from orders
group by period
order by period;

#is shipping time decreasing over the time?
select date_format(orderDate, "%Y-%m") as period,avg(datediff(shippedDate,orderDate)) as date_difference
from orders
group by period
order by period;
