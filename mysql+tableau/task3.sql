use employees_mod;

select year(s.from_date)as y from t_salaries s; 

select e.gender,d.dept_name,round(avg(s.salary),2)as avg_salary
,year(s.from_date)as calendar_year 
#you can use CROSS JOIN the result set will be the same.(but not neccessary)
from
t_employees e
join 
t_salaries s on e.emp_no = s.emp_no
join
t_dept_emp de on s.emp_no=de.emp_no
join
t_departments d on de.dept_no = d.dept_no
group by d.dept_no,e.gender,calendar_year
having calendar_year<=2002
order by d.dept_no;
