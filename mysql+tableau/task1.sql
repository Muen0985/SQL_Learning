use employees_mod;

select * from t_dept_emp
where year(from_date)>=1990;

select year(de.from_date)as calender_year,e.gender,count(de.emp_no)as num_of_employees
from t_dept_emp de
join t_employees e on de.emp_no=e.emp_no
group by calender_year,e.gender
having calender_year>=1990
order by calender_year;

# we use HAVING because that way we can use the alias calendar_year directly
# whereas with WHERE we would not be able to do so