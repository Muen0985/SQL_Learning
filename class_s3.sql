use employees;

select dept_no from departments;
 
select * from employees
where (first_name = 'Elvis') and (gender='F');
 
select * from employees
where (first_name = 'Kellie' or first_name = 'Aruna') and gender='F';
/*---------------------------------------------------*/

select * from employees
where first_name in ('Denis', 'Elvis');

select * from employees
where first_name not in ('John', 'Mark','Jacob');
/*---------------------------------------------------*/

select * from employees
where first_name like 'Mark%';

select * from employees
where hire_date like '2000-%-%';

select * from employees
where emp_no like '1000_';

select * from employees
where first_name not like '%Jack%';
/*---------------------------------------------------*/

select * from salaries
where salary between 60000 and 75000;

select * from employees
where emp_no not between 10004 and 10012;
/*---------------------------------------------------*/

select dept_name from departments
where dept_no is not null;

select * from employees
where gender='F' and hire_date >= '2000-01-01'; /* hire_date like '20%'; */
/*---------------------------------------------------*/

select distinct hire_date from employees limit 100;

select count(salary) from salaries
where salary >=100000;

select count(*) from dept_manager;

select * from employees
order by hire_date desc;
/*---------------------------------------------------*/

select salary,count(salary) as num_with_same from salaries
where salary > 100000
group by salary
order by salary;

select *, avg(salary) from salaries
group by emp_no
having avg(salary)>120000
order by emp_no;

select * ,count(from_date) from dept_emp
where from_date >'2000-01-01'
group by emp_no
having count(from_date)>1;

select * from dept_emp limit 100;

