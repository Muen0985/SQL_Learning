use employees;

SELECT 
    AVG(salary) AS avg_salary
FROM
    salaries;
    
# --1
with cte as(
select avg(salary) as avg_salary from salaries)
select * from salaries s 
join cte c;

# --2
with cte as (
select avg(salary) as avg_salary from salaries)
select * from salaries s    # 因為沒有特別指定欄位且用*來表示，因此回傳全部資料表的欄位
join 
employees e on s.emp_no = e.emp_no and e.gender='F'
join 
cte c;  # 如果沒有加上on，會被視為cross join

# --3
with cte as (
select avg(salary)as avg_salary from salaries)
select
sum(case when s.salary > c.avg_salary then 1 else 0 end) as no_salary_above_avg,
count(s.salary) as total_no_salary_contracts
from
salaries s
join 
employees e on  s.emp_no = e.emp_no and e.gender = 'F'
cross join
cte c;

/*----------------------------------------------------------*/
# 1
with cte as(
select avg(salary) as avg_s from salaries)
select
sum(case when s.salary <= c.avg_s then 1 else 0 end) as not_above_avg,
count(s.salary)as total_no_salary_contracts
from
salaries s
join 
employees e on  s.emp_no = e.emp_no and e.gender = 'M'
cross join
cte c;

# 2
with cte as(
select avg(salary) as avg_s from salaries)
select
count(case when s.salary <= c.avg_s then s.salary else null end) as not_above_avg,
count(s.salary)as total_no_salary_contracts
from
salaries s
join 
employees e on  s.emp_no = e.emp_no and e.gender = 'M'
cross join
cte c;

# 3
select
count(case when s.salary <= c.avg_s then s.salary else null end) as not_above_avg,
count(s.salary)as total_no_salary_contracts
from
salaries s
join 
employees e on  s.emp_no = e.emp_no and e.gender = 'M'
join
(select avg(salary) as avg_s from salaries) c;


/*------------------------------------------------------*/

with cte1 as(
select avg(salary) as avg_salary from salaries),
cte2 as(
select s.emp_no,max(s.salary) as f_highest_salary
from salaries s
join employees e on e.emp_no = s.emp_no and e.gender ='F'
group by s.emp_no
)
select
sum(case when c2.f_highest_salary > c1.avg_salary then 1 else 0 end) as highest_above_avg,
count(e.emp_no)as total_no_female_contracts,
concat(round((sum(case when c2.f_highest_salary > c1.avg_salary then 1 else 0 end)/count(e.emp_no))*100, 2), '%') as '%percentage'
from employees e
join cte2 c2 on c2.emp_no = e.emp_no
cross join cte1 c1;

# 1
/* exercise for finding not above average salary for male, using sum or count.*/

with cte as(
select avg(salary)as avg_salary from salaries),
cte2 as(select s.emp_no,max(salary)as m_highest_salary from salaries s 
join employees e on s.emp_no = e.emp_no and e.gender='M'
group by s.emp_no)
select
sum(case when c2.m_highest_salary > c1.avg_salary then 1 else 0 end) as highest_above_avg,
count(e.emp_no)as total_no_male_contracts,
concat(round((sum(case when c2.m_highest_salary > c1.avg_salary then 1 else 0 end)/count(e.emp_no))*100, 2), '%') as '%percentage'
from employees e
join cte2 c2 on c2.emp_no = e.emp_no
cross join cte c1;

/*---------------------------------------------------------------------------------------*/

select * from employees where hire_date >'2000-01-01';

with cte_2000 as(  #第一個cte
select * from employees 
where hire_date >'2000-01-01'),
highest_contract_salary as (  #第二個cte
select e.emp_no,max(s.salary) 
from salaries s 
join cte_2000 ce #可以join前面設立好的cte
on ce.emp_no = s.emp_no group by ce.emp_no)					  
select * from highest_contract_salary;


