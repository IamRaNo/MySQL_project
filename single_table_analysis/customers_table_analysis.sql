-- customers table analysis :-

select * from customers;

#how many unique customers are there?
select count(distinct(customerNumber))
from customers;
-- 122 customers are there

#is there any duplicate customer with different customer id?
select * from (
select customerNumber ,row_number() over(partition by customerName,
												contactLastName,contactFirstName,addressLine1,
                                                city,state,postalCode, country,salesRepEmployeeNumber) as tab
from customers ) t
where t.tab>1;
-- there is no duplicate customers with same customer id

#is there any entry with duplicate customer id?
select * from(
select customerNumber,count(customerNumber) as cust_count
from customers
group by customerNumber) as tab
where cust_count>1;
-- there is no entry with duplicate customer id

#are there any missing names?
select customerName, contactLastName,contactFirstName
from customers
where customerName is null;
-- these is no missing names

#fix the phone numbers
update customers
set phone= regexp_replace(phone, '[^0-9]', '');

#fix countries
update customers
set country=trim(country);

#are there any missing addresses?
select addressLine1 from customers
where addressLine1 is null;

#fix cities with different names?
select distinct(city) from customers
order by city;
update customers
set city=trim(city);

#can i fill any states value using city?
select * from customers;

create table city_state_map as 
select city,state from customers
where state is not null
group by city,state;

update customers c
join city_state_map m
on c.city = m.city
set c.state=m.state
where c.state is null;

drop table city_state_map;

select * from(
select city,state,row_number() over(partition by city) as row_num
from customers) t;

#no of customers with no sales employee
select count(customerName) from(
select customername from customers 
where salesRepEmployeeNumber is null) t;
-- there are 22 customers who dont have sales employee assigned yet

#which city have the most customers?
select city,count(city) as count from customers
group by city
order by count desc;
-- NYC and Madrid have most number of customers

#which state have the most customers?
select state,count(state) as count from customers
group by state
order by count desc;
-- CA have the most customers

#which country have the most customers?
select country,count(country) as count from customers
group by country
order by count desc;
-- USA have the most customers

#top 10 customers with highest credit limit?
select customerName,creditLimit from customers
order by creditLimit desc
limit 10;

#top 3 customers by credit limit from each country?
select * from (
select country,customerName,creditLimit,rank() over(partition by country order by creditLimit desc) as customer_rank
from customers
where creditLimit != 0) t
where t.customer_rank<4;

#sales employee with highest customers count?
select salesRepEmployeeNumber,count(salesRepEmployeeNumber) as count from customers
group by salesRepEmployeeNumber
order by count desc;
-- employee 1401 is handeling the most number of customers

#customers with credit limit higher than the average?
select customerName,creditLimit from customers
where creditLimit>(
select avg(creditLimit) from customers
);

#in each country, what is the distribution of cities the business is expanded?
select country,count(city) as cities_count from customers
group by country
order by cities_count desc;

#customer with same phone number?
with ranked as(
select customerNumber,customerName,phone,row_number() over(partition by phone) as row_num
from customers)
select * from ranked r1
join ranked r2 on r1.phone=r2.phone
and r1.row_num=1
and r2.row_num=2;
-- ther are 4 customers with phone number problem
