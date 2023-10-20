use employees;

SELECT 
    emp_no, salary,
    row_number() over(partition by emp_no order by salary desc) as row_num
FROM
    salaries
limit 100;

/*------------row_number practice----------------------------------*/
select emp_no,dept_no,row_number()over(order by emp_no) as row_num
from dept_manager;

select emp_no,first_name,last_name,
row_number()over(partition by first_name order by last_name) as row_num
from employees;

/*------------using several windows funcitons----------------------------------*/
select  dm.emp_no,salary,
		# row_number() over() as row_1,
        row_number() over(partition by emp_no) as row_2,
        row_number() over(partition by emp_no order by salary desc) as row_3
        # row_number() over(order by salary desc) as row_4
from salaries;

#1
select dm.emp_no,s.salary,
row_number() over(partition by s.salary order by s.salary desc) as salary_num,
row_number() over(partition by s.salary order by s.salary) as salary_num
from salaries s
join dept_manager dm on s.emp_no = dm.emp_no;

#2
select dm.emp_no,salary,
row_number() over() as row_num,
row_number() over(partition by emp_no order by salary desc) as salary_num
from salaries s
join dept_manager dm on s.emp_no = dm.emp_no;

/*------------using windows funcitons syntax----------------------------------*/
/* This method isn't used frequently*/
select emp_no,salary,
row_number() over(w) as row_num
from salaries
window w as(partition by emp_no order by salary desc);

select emp_no,first_name,last_name,
row_number() over(w) as row_num
from employees
window w as(partition by first_name order by emp_no);


/*------------partition by v.s group by funcitons----------------------------------*/
select a.emp_no,max(salary) as max
from(
select emp_no,salary
from salaries
)a
group by emp_no;

select emp_no,max(salary) as max
from salaries
group by emp_no;

/*-----------------------------------------------*/
select a.emp_no, min(salary) as lowest_salary
from (
select emp_no,salary,row_number() over w as row_num
from salaries
window w as (partition by emp_no order by salary))a
group by emp_no;

select a.emp_no,min(a.salary) as lowest_salary
from (
	select emp_no,salary,row_number() over(partition by emp_no order by salary) as row_num
    from salaries) a
group by emp_no;

select a.emp_no,min(a.salary) as lowest_salary
from (
select emp_no,salary
from salaries)a
group by emp_no;

select a.emp_no,a.salary as lowest_salary
from (
select emp_no,salary,row_number() over w as row_num
from salaries
window w as (partition by emp_no order by salary))a
where a.row_num =1; # can change to other ranking

/*------------partition by v.s group by funcitons----------------------------------*/

select emp_no,salary,row_number() over(order by salary) as row_num
from salaries
where emp_no=10560;

select dm.emp_no,count(salary) as num_of_salary_contracts
from dept_manager dm
join salaries s on dm.emp_no = s.emp_no
group by emp_no
order by emp_no;

select emp_no,salary,rank() over (order by salary desc) as salary_rank
from salaries
where emp_no = 10560;

select emp_no,salary,dense_rank() over (order by salary desc) as salary_rank
from salaries
where emp_no = 10560;




