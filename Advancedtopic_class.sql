set @v_num=3;
select @v_num;


/*--Trigger topic--------------------------*/
use employees;
commit;

/* Trigger topic will be on the other sql script---------------- */
delimiter $$
create trigger check_valid_date
before insert on employees
for each row
begin
	IF new.hire_date > date_format(SYSDATE(), '%y-%m-%d')THEN
		SET new.hire_date = date_format(SYSDATE(), '%y-%m-%d');
	end if;
end $$
delimiter ;

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01'); 
    
SELECT * FROM employees
ORDER BY emp_no DESC;

/*-------indexes topic------------------------------*/

create index i_hire_date on employees(hire_date);
select * from employees
where hire_date > '2000-01-01';

alter table employees
drop index i_hire_date;

create index i_composite on employees(first_name,last_name);
select * from employees
where first_name='Georgi' and last_name='Facello';
alter table employees
drop index i_composite;

show index from employees from employees;

select * from salaries
where salary > 89000;
create index check_salary on salaries(salary);


/*-------Case topic------------------------------*/

select e.emp_no,e.first_name,e.last_name,
CASE
	when dm.emp_no is not null then 'Manager'
    else 'Employee'
END as position
from employees e
LEFT join dept_manager dm on e.emp_no = dm.emp_no
where e.emp_no > 109990;


SELECT dm.emp_no,e.first_name,e.last_name,max(s.salary)-min(s.salary) as salary_difference,
Case
	when max(s.salary)-min(s.salary) >30000 then 'Higher'
    else 'Lower'
end as raise_salary_30000
FROM dept_manager dm  
JOIN  employees e ON e.emp_no = dm.emp_no  
JOIN  salaries s ON s.emp_no = dm.emp_no 
group by s.emp_no ;


select e.emp_no,e.first_name,e.last_name,
CASE
	when max(de.to_date)>SYSDATE() THEN 'Is still employed'
    ELSE 'Not an employee anymore'
END AS current_employee
from employees e
join dept_emp de ON e.emp_no = de.emp_no
group by de.emp_no
limit 100;