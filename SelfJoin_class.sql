use employees;

/* 概念作法 */
select e1.emp_no,e1.dept_no,e2.manager_no
from emp_manager e1
join emp_manager e2
on e1.emp_no = e2.manager_no;

/* 正確做法 1*/
select distinct e1.*
from emp_manager e1
join emp_manager e2
on e1.emp_no = e2.manager_no;

/* 正確做法 2*/
SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no
WHERE
    e2.emp_no IN (SELECT 
            manager_no
        FROM
            emp_manager)

