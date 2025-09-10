-- payments table analysis:-

select * from payments;

#is there any duplicate checkNumber?
select checkNumber, count(checkNumber) as count 
from payments
group by checkNumber
having count>1;

#is there any wrong payment amount?
select * from payments
where amount<0;
-- there is no payment with negative value