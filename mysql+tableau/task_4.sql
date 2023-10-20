use employees_mod;

select max(salary) from t_salaries;
select min(salary) from t_salaries;

drop procedure if exists filter_salary;

delimiter $$
create procedure filter_salary(in p_min float,in p_max float)
begin
select d.dept_name,e.gender,avg(s.salary)as salary
from t_employees e
join t_salaries s on s.emp_no = e.emp_no
join t_dept_emp de on e.emp_no = de.emp_no
join t_departments d on de.dept_no = d.dept_no
where salary between p_min and p_max
group by d.dept_name,e.gender;
end $$
delimiter ;

call filter_salary(50000,90000);