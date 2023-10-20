use employees_mod;

select distinct year(hire_date)as y from t_employees;

select d.dept_name,e.gender,dm.emp_no,dm.from_date,dm.to_date,t.calendar_year,
case when t.calendar_year between year(dm.from_date) and year(dm.to_date) then 1 else 0 
end as active
from ( # 因為有另一個欄位需要用到這個欄位，所以用subquery來取得一個table
select year(hire_date)as calendar_year 
from t_employees
group by calendar_year) t  # 因為是table所以不用alias，直接接名稱即可
cross join
t_dept_manager dm
join
t_employees e on dm.emp_no = e.emp_no
join
t_departments d on d.dept_no = dm.dept_no
order by dm.emp_no,calendar_year;
