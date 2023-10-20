/* class s1
create database if not exists sales;

create table sale(
p_num int not null primary key auto_increment,
date_p date not null,
customer_id int,
item_code varchar(5) not null
);

select * from sales.sale;
*/


/* class s2
add foreign key--- add constraint
alter table sale
add constraint fk_CusOrder foreign key (customer_id) references 
customer (customer_id) on delete cascade;
drop foreign key--- drop foreign key
alter table sale
drop foreign key sales_ibfk_1;

add unique key--- add
alter table customer
add unique key(email);
drop unique key--- drop index **different**
alter table customer
drop index email;

add a column---add
alter table customer
add column gender enum('m','f') after lastname;
drop a column--- drop
alter table customer
drop column gender;

set column default--- alter...set
alter table customer
alter numofcomplaints set default 0;
drop column default--- drop
alter table customer
alter column numofcomplaints drop default;

modify column null---modify
alter table companies
modify column company_name company_name varchar(225) null;
change column not null--- change
alter table companies
change column company_name company_name varchar(225) not null;
*/

/* class s3 */
use employees;

select * from employees
where first_name in ('denis','Elvis'); # 不會管大小寫
select * from employees
where emp_no like '1000_';
select * from employees
where first_name not like '%Jack%';
select distinct hire_date from employees
limit 800;
select count(*) from dept_manager;
select * , count(from_date) from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date)>1;

/* insert class
insert into employees
values(999903,'1977-09-14','Johnathan','Creek','M','1999-01-01');
insert into titles(emp_no,title)
values('10983','powder');
***把to_date修改加上日期***
update titles
set to_date '9999-01-01'
where emp_no = '1000782';
insert into deparments_dup(dept_no)
values('d020'),('d090');
*/

use employees;

select * from employees e
where exists(
select * from titles t
where t.emp_no = e.emp_no
and title='Assistant Engineer');

/*----------------------------------------*/
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    

/*-------Views practice-------------------------*/

select * from dept_manager order by emp_no;

create or replace view v_average_salary_manager as
select round(avg(salary),2) from salaries s
join dept_manager dm on s.emp_no=dm.emp_no;

select round(avg(salary),2) from salaries s
join dept_manager dm on s.emp_no=dm.emp_no;

select round(avg(salary),2) from salaries s
where s.emp_no in(
select dm.emp_no from dept_manager dm
);
/*--------------------------------------*/
drop procedure if exists avg_salary;
delimiter $$
create procedure avg_salary()
begin
select avg(salary) from salaries;
end $$
delimiter ;
call avg_salary();

drop procedure if exists emp_avg_salary_out;

delimiter $$
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
select avg(s.salary) into p_avg_salary 
from employees e 
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$
delimiter ;
# 用閃電按鈕的輸出比較快
drop function if exists emp_info;

delimiter $$
create function emp_info(e_first varchar(225),e_last varchar(225)) returns decimal(10,2) deterministic
begin
declare v_max_from_date date;
declare v_salary decimal(10,2);

select max(s.from_date) into v_max_from_date
from salaries s
join employees e on s.emp_no=e.emp_no
where e.first_name=e_first and e.last_name=e_last;

select s.salary into v_salary
from salaries s
join employees e on s.emp_no=e.emp_no
where e.first_name=e_first and e.last_name=e_last and s.from_date=v_max_from_date;

return v_salary;
end $$
delimiter ;

SELECT emp_info('Aruna', 'Journel');
/*------------------------------------------------------------------------------*/

delimiter $$
create trigger check_date
before insert on employees
for each row
begin 
	if NEW.hire_date > sysdate() then
    set NEW.hire_date = date_format(sysdate(),'%y-%m-%d');
    end if;
end $$
delimiter ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

SELECT * FROM employees
ORDER BY emp_no DESC;

delete from employees
where emp_no='999904';

select e.emp_no,e.first_name,e.last_name,
case
when dm.emp_no is not null then 'manager'
else 'employee'
end as position
from employees e
left join dept_manager dm
on e.emp_no = dm.emp_no
where e.emp_no>109990;

/*------------------------------------------------------------------------------*/

select emp_no,dept_no,row_number()over(order by emp_no)as row_num
from dept_manager;
select emp_no,first_name,last_name,
row_number()over(partition by first_name order by last_name)as row_num
from employees;

select dm.emp_no,s.salary,
row_number()over()as row_num,
row_number()over(partition by dm.emp_no order by s.salary)as row_num2
from dept_manager dm
join salaries s on dm.emp_no = s.emp_no;
select emp_no,first_name,
row_number()over w as row_num
from employees
window w as (partition by first_name order by emp_no);

select t.emp_no,t.salary
from (
select emp_no,salary,row_number()over w as row_num
from salaries
window w as(partition by emp_no order by salary)
)as t
where t.row_num=1;

select t.emp_no,t.salary
from (
select emp_no,salary,row_number()over(partition by emp_no order by salary) as row_num
from salaries
)as t
where t.row_num=1;

select t.emp_no,min(salary)as min_salary
from (
select emp_no,salary
from salaries
)as t
group by emp_no;

select emp_no,salary,row_number()over(partition by emp_no order by salary desc)as rank_num
from salaries
where emp_no = 10560;

select dm.emp_no,count(s.salary)as salary_count
from dept_manager dm
join salaries s on dm.emp_no=s.emp_no
group by dm.emp_no
order by emp_no;

select emp_no,salary,rank()over(partition by emp_no order by salary desc)as rank_num
from salaries
where emp_no = 10560;

select emp_no,salary,dense_rank()over(partition by emp_no order by salary desc)as rank_num
from salaries
where emp_no = 10560;

select e.emp_no,s.salary,rank()over(partition by e.emp_no order by salary desc)as salary_rank
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 and 10600;

select e.emp_no,s.salary,e.hire_date,s.from_date,(year(s.from_date)-year(e.hire_date))as year_diff,
dense_rank()over(partition by e.emp_no order by salary desc)as salary_rank
from employees e
join salaries s on e.emp_no = s.emp_no and year(s.from_date)-year(e.hire_date) >=4 
#因為要在算salary的rank，所以需要再join salaries的時候就把不必要的紀錄移除掉
where e.emp_no between 10500 and 10600;

select emp_no,salary,lag(salary) over w as pre_salary,lead(salary) over w as next_salary,
salary-lag(salary)over w as diff_p,
lead(salary)over w -salary as diff_n
from salaries
where salary >=80000 and emp_no between 10500 and 10600
window w as(partition by emp_no order by salary);

select emp_no,salary,lag(salary) over w as pre_salary,lead(salary) over w as next_salary,
lag(salary,2) over w as pre_salary,lead(salary,2) over w as next_salary
from salaries
where salary >=80000 and emp_no between 10500 and 10600
window w as(partition by emp_no order by salary);

select emp_no,salary,min(from_date),to_date
from salaries
group by emp_no;

with cte as (select avg(salary)as avg_salary from salaries)
select
sum(case when s.salary<=c.avg_salary then 1 else 0 end)as col1,
count(s.salary)as num
from
employees e
join salaries s on e.emp_no = s.emp_no and e.gender='m'
join cte c;

select
sum(case when s.salary<=a.avg_salary then 1 else 0 end)as no_salaries_below_avg,
count(s.salary)as no_of_salary_contracts
from(
select avg(salary)as avg_salary from salaries
)as a
join
employees e
join salaries s on e.emp_no = s.emp_no and e.gender='m';

/*-------------------------------------------------------------------------------------*/
drop table if exists male_max_salary;

create temporary table male_max_salary
select s.emp_no,max(s.salary) from salaries s
join employees e
on e.emp_no = s.emp_no and e.gender='M'
group by s.emp_no;

select * from male_max_salary;

create temporary table dates2 
select
now() as current_dates,
date_sub(now(),interval 2 month) as earlier_date,
date_sub(now(),interval -2 year) as later_date;

select * from dates2;

with cte1 as(
select
now() as current_d,
date_sub(now(), interval 2 month) as earlier_date,
date_sub(now(),interval -2 year) as later_date
)select * from dates2 join cte1;

with cte2 as(
select
now() as current_d,
date_sub(now(), interval 2 month) as earlier_date,
date_sub(now(),interval -2 year) as later_date
)select * from dates2 union all select * from cte2;

drop table if exists male_max_salaries;

