-- employee table analysis:-

select * from employees;

#how many employees are there?
select count(distinct(employeeNumber)) from employees;
-- there are 23 employees

#is there any employee with duplicate employee id?
select * from (
	select employeeNumber ,
    row_number() over(partition by lastName,firstName,extension,email,officeCode,reportsTo,jobTitle) as row_num
    from employees) emp
where row_num>1;

#is there any duplicate email address?
with ranked as (
	select firstName,employeeNumber ,email,
    row_number() over(partition by email order by employeeNumber) as row_num
    from employees) 
select * from ranked r1
join ranked r2 
on r1.email=r2.email
and r1.row_num=1
and r2.row_num=2;
-- there are 2 employees with same email address

#who is the manager of which employee?
select e.firstName,m.firstName from employees e
left join employees m
on e.reportsTo=m.employeeNumber;

#how many employees are there in each job title?
select jobTitle,count(jobTitle) as count from employees
group by jobTitle
order by count desc;

#how many employees are in each office?
select officeCode,count(officeCode) as count from employees
group by officeCode
order by count desc;