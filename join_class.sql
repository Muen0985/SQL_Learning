use employees;
select * from dept_manager_dup order by dept_no;
select * from departments_dup order by dept_no;

/*-------------Inner Join------------------------*/

SELECT 
    e.emp_no, first_name, last_name, dept_no, hire_date
FROM
    employees e
        JOIN
    dept_manager_dup d ON e.emp_no = d.emp_no
ORDER BY emp_no;

/*-------------essentail tasks------------------------*/

insert into dept_manager_dup
values('110228','d003','1992-03-21','9999-01-01');

insert into departments_dup
values('d009','Customer Service');

delete from dept_manager_dup
where emp_no = '110228';

delete from departments_dup
where dept_no = 'd009';

/*-------------Left Join------------------------*/ 

SELECT 
    e.emp_no, first_name, last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dept_no DESC , emp_no;

/*------------Join practice------------------------*/

SELECT 
    first_name, last_name, hire_date, title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no;

/*------------Cross Join practice------------------------*/

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no != dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

/*------------------------------------*/
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

/*------------------------------------*/
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_no;

/*------------Join aggregate practice------------------------*/
SELECT 
    e.gender, AVG(s.salary) AS avg_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;

/*------------Join multi-table practice------------------------*/

SELECT 
    e.first_name,e.last_name,e.hire_date,m.from_date,d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;
/*------------------------------------*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    t.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager m ON t.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

/*------------Tips and Tricks for Joins------------------------*/

SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;
/*---------------------------------------------*/

select e.gender,count(e.emp_no) as number_of_manager
from employees e
join dept_manager d on e.emp_no=d.emp_no
group by e.gender;

/*------------Union practice------------------------*/

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees e
WHERE
    last_name = 'Denis' 
UNION SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;


SELECT * FROM
    (SELECT
        e.emp_no,
		e.first_name,
		e.last_name,
		NULL AS dept_no,
		NULL AS from_date
    FROM
        employees e
    WHERE last_name = 'Denis' 
    
    UNION SELECT
    
        NULL AS emp_no,
		NULL AS first_name,
		NULL AS last_name,
		dm.dept_no,
		dm.from_date
    FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;
    