-- Offices table analysis:-

select * from offices;

#fix phone number
update offices
set phone = regexp_replace(phone, '[^0-9]', '');

#check state values
select distinct(state) from offices;

#check country values
select distinct(country) from offices;