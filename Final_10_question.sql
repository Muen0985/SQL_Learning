use employees;

# question 1

select e.gender,d.dept_name,round(avg(s.salary),2)as avg_salary
from employees e
join salaries s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
group by d.dept_name,e.gender
order by de.dept_no;

# question 2
-- select min(dept_no) from dept_emp;
-- select max(dept_no) from dept_emp;

select distinct dept_no from dept_emp
order by dept_no;

# question 3

SELECT 
    e.emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN e.emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    e.emp_no <= 10040;
    
-- Here are some scenarios where correlation might not be necessary:
-- Scalar Subqueries,Unrelated Subqueries,IN / NOT IN Subqueries

# question 4

select * from employees
where year(hire_date) = 2000;

# question 5

select * from titles
where title like('%engineer');

select * from titles
where title like('%senior engineer%');


# question 6

drop procedure if exists find_employee_de;

select e.emp_no,d.dept_no,d.dept_name
from employees e  
join dept_emp de on e.emp_no=de.emp_no
join departments d on d.dept_no=de.dept_no
order by e.emp_no;

delimiter $$
create procedure find_employee_de (in p_emp_no integer)
begin
select e.emp_no,d.dept_no,d.dept_name
from employees e  
join dept_emp de on e.emp_no=de.emp_no
join departments d on d.dept_no=de.dept_no
where p_emp_no=e.emp_no 
and de.from_date= 
(select max(from_date)
from dept_emp
where emp_no=p_emp_no); -- Without the condition emp_no = p_emp_no, the subquery might return 
end $$                  -- the maximum from_date across all employees in the dept_emp table  
delimiter ;

call find_employee_de(10010);

# question 7

select count(*) from salaries
where datediff(to_date,from_date)>365 and salary>=100000;

# question 8

DROP TRIGGER IF EXISTS before_insert_employee;

DELIMITER $$
create trigger before_insert_employee
before insert on employees
for each row
begin
declare today_date date;
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') INTO today_date;

IF NEW.hire_date > today_date
then SET NEW.hire_date = today_date;
END IF;
END$$
DELIMITER ;

INSERT employees VALUES('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');
SELECT * FROM employees
order by emp_no desc;

-- delete from employees
-- where emp_no=999904;

# question 9

drop function if exists f_largest_salary;

DELIMITER $$
CREATE FUNCTION f_largest_salary (p_emp_no integer) returns decimal(10,2)
deterministic 
begin
declare v_max_salary decimal;
select max(salary) into v_max_salary
from employees e
join salaries s on e.emp_no=s.emp_no 
where e.emp_no=p_emp_no;

return v_max_salary;
end $$
DELIMITER ;

SELECT f_largest_salary(11356);

# question 10

drop function if exists f_rank_salary;

DELIMITER $$
create function f_rank_salary (p_emp_no integer, rank_char varchar(20)) returns decimal(10,2)
deterministic
begin
DECLARE v_salary decimal;

select
case
when rank_char='max' then max(salary)
when rank_char='min' then min(salary)
else max(salary)-min(salary)
end as temp_salary
into v_salary
from employees e
join salaries s on e.emp_no=s.emp_no 
where e.emp_no=p_emp_no;

return v_salary;
end $$
DELIMITER ;

select f_rank_salary(11356, 'min');
select f_rank_salary(11356, 'max');
select f_rank_salary(11356, 'maxxx');





