use employees;

create temporary table f_hightest_salary
select s.emp_no,max(salary) as f_hightest_salary
from salaries s
join employees e on s.emp_no= e.emp_no and e.gender= 'F'
group by s.emp_no;

select * from f_hightest_salary; 
/* if restart the connection, it won't work unless
create the temporary table again*/
select * from f_hightest_salary
where emp_no<='10010'; # 可以做其他的處理

drop table if exists f_hightest_salary; # 可以drop temporary table

select * from departments; /* permenant table*/

/*-------------------------------------------------*/

create temporary table max_salary
select s.emp_no,max(s.salary) as highest_salary 
from salaries s
join employees e on s.emp_no = e.emp_no and gender='M'
group by s.emp_no;

select * from max_salary; 

/*-------------------------------------------------*/

create temporary table f_highest_salary
select s.emp_no,max(salary) as f_highest_salary
from salaries s
join employees e on s.emp_no= e.emp_no and e.gender= 'F'
group by s.emp_no
limit 10;

with cte as(
select s.emp_no,max(salary) as f_highest_salary
from salaries s
join employees e on s.emp_no= e.emp_no and e.gender= 'F'
group by s.emp_no
limit 10)
select * from f_highest_salary f1 join cte c;

with cte as(
select s.emp_no,max(salary) as f_highest_salary
from salaries s
join employees e on s.emp_no= e.emp_no and e.gender= 'F'
group by s.emp_no
limit 10)
select * from f_highest_salary union all select * from cte c;

/*---------------------------------------*/
create temporary table dates
select
now() as current_datetime,
date_sub(now(),interval 1 month) as a_month_earlier, # 雖然是以前的日期但要用正數
date_sub(now(),interval -1 year) as a_year_later;

select * from dates;
/* can't use join and union all */
select * from dates d1 join dates d2;
select * from dates d1 union all select * from dates d2;

with cte as (
select
now() as current_datetime,
date_sub(now(),interval 1 month) as a_month_earlier,
date_sub(now(),interval -1 year) as a_year_later
)
select * from dates d1 join cte c;

with cte as (
select
now() as current_datetime,
date_sub(now(),interval 1 month) as a_month_earlier,
date_sub(now(),interval -1 year) as a_year_later
)
select * from dates d1 union all select * from cte c;

drop table if exists f_highest_salary;
drop table if exists dates;

 
/*-----------practice----------------------------------------*/

create temporary table dates2
select
now() as current_datetime,
date_sub(now(),interval 2 month) as 2_month_earlier,
date_sub(now(),interval -2 year) as 2_year_later;

select * from dates2;

with cte as (
select
now() as current_datetime,
date_sub(now(),interval 2 month) as 2_month_earlier,
date_sub(now(),interval -2 year) as 2_year_later)
select * from dates2 join cte c;

with cte as (
select
now() as current_datetime,
date_sub(now(),interval 2 month) as 2_month_earlier,
date_sub(now(),interval -2 year) as 2_year_later)
select * from dates2 union all select * from cte c;

DROP TABLE IF EXISTS dates2;


