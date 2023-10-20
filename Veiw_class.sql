use employees;

select * from dept_emp;


select emp_no,from_date,to_date,count(emp_no) as Num
from dept_emp
group by emp_no
having Num >1;


/* using View as  another temporary virtual table to retrieve data from base tables */
# 可以點選views的執行件來取得所建置的table
create or replace view v_dept_emp_latest_date as
select
emp_no,max(from_date),max(to_date)
from dept_emp
group by emp_no;


/* View practice ----------------------*/
create or replace view v_average_salary_managers as
select round(avg(s.salary),2)
from salaries s
join dept_manager dm
on s.emp_no = dm.emp_no;


select round(avg(s.salary),2)
from salaries s
join dept_manager dm
on s.emp_no = dm.emp_no;




