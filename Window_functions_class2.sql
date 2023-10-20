use employees;

select emp_no,salary,
row_number()over(partition by emp_no order by salary desc)as row_num
from salaries
where emp_no=10001;

# 在紀錄中擁有相同薪水的次數
select emp_no,(count(salary)-count(distinct salary))as diff
from salaries
group by emp_no
having diff>0
order by emp_no;

# rank會使相同排名後的名次往後延順位
select emp_no,salary,rank()over(partition by emp_no order by salary desc)as rank_num
from salaries
where emp_no=11839;

# dense_rank會使相同排名後的名次繼續排名(不會跳過順號)
select emp_no,salary,rank()over(partition by emp_no order by salary desc)as rank_num
from salaries
where emp_no=11839;

/*---------------------------------------------------*/

select 
	d.dept_no,  d.dept_name,
	rank() over w as department_salary_rank,
	s.salary,  s.from_date,  s.to_date,  dm.from_date,  dm.to_date
from 
dept_manager dm
join salaries s on dm.emp_no = s.emp_no
	and s.from_date between dm.from_date and dm.to_date
    and s.to_date between dm.from_date and dm.to_date
join departments d on d.dept_no = dm.dept_no
window w as (partition by dm.dept_no order by s.salary desc);

# 1
select e.emp_no,s.salary,
rank() over(partition by e.emp_no order by s.salary) as salary_rank
from employees e
join salaries s on e.emp_no = s.emp_no
where e.emp_no between 10500 and 10600;

# 2
select e.emp_no,s.salary,
dense_rank() over(partition by e.emp_no order by s.salary) as salary_rank,
e.hire_date, s.from_date,
year(s.from_date)-year(e.hire_date) as years_from_start
from employees e
join salaries s on e.emp_no = s.emp_no
and year(s.from_date)-year(e.hire_date)>=5
where e.emp_no between 10500 and 10600;


/*--------lag & lead Value window functions----------------------------*/

select 
emp_no,
salary,
lag(salary) over w as previous_salary,
lead(salary) over w as next_salary,
salary-lag(salary) over w as diff_from_prev,
lead(salary) over w - salary as diff_from_next 
#window function 一定要緊接著寫over..，所以才會把 -salary放在後面
from 
salaries
where emp_no =10001
window w as (order by salary);

# 1
select
emp_no,
salary,
lag(salary) over w as previous_salary,
lead(salary) over w as next_salary,
salary-lag(salary) over w as diff_from_prev,
lead(salary) over w -salary as diff_from_next
from 
salaries
where emp_no between 10500 and 10600
and salary > 80000
window w as (partition by emp_no order by salary);

# 2
select
emp_no,
salary,
lag(salary) over w as previous_salary,
lag(salary,2) over w as pre_previous_salary,
lead(salary) over w as next_salary,
lead(salary,2) over w as after_next_salary
from 
salaries
where emp_no between 10500 and 10600
and salary > 80000
window w as (partition by emp_no order by salary)
limit 1000;






