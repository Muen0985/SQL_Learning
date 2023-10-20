use employees;

select sysdate();

select * from salaries
where to_date > sysdate();

select emp_no,salary,max(from_date),to_date
from salaries
where to_date>sysdate()
group by emp_no; # this query might lead to code error 1055 (not always)

SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MAX(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date > SYSDATE()
        AND s.from_date = s1.from_date;


/*---------------practice------------------------------------*/
# 1
SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, MIN(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;
    

/*-----------------------------------------------------*/

select * from dept_emp;
select * from dept_emp where emp_no = 10010 order by from_date;
select * from dept_emp where emp_no = 10018 order by from_date;
select * from salaries where emp_no = 10010 order by from_date;

/*--------------------------------------------------------------------------------------*/


select de2.emp_no,d.dept_name,s2.salary,avg(s2.salary) over w as average_salary_per_department
from (
select de.emp_no,de.dept_no,de.from_date,de.to_date
from dept_emp de
join
(select emp_no,max(from_date)as from_date
from dept_emp
group by emp_no) de1
on de1.emp_no = de.emp_no
where de.to_date > sysdate() and de.from_date = de1.from_date) de2 # de2在這!!
join
(SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, Max(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date) s2 # s2在這!!
    on s2.emp_no = de2.emp_no      # 兩個subqueries(de2、s2)，合併join起來
join
departments d on d.dept_no = de2.dept_no
group by de2.emp_no, d.dept_name 
# this group by is not mandatory(If there are some duplicates we use the GROUP BY clause on this column. )
window w as (partition by de2.dept_no)
order by de2.emp_no;


