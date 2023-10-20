use employees;
select * from dept_manager;

/* use subqueries------------*/

SELECT count(distinct emp_no) FROM employees;

# 只選出在員工工作表裡，是dept_manager的人

SELECT 
    e.emp_no, e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
/*-------------------------------------*/		
        
SELECT 
    *
FROM
    dept_manager dm
WHERE
    dm.emp_no IN (SELECT 
            e.emp_no
        FROM
            employees e
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');

/*------------------------------------------------*/
select e.emp_no,e.first_name,e.last_name
from employees e 
where exists(
select * from dept_manager dm
where dm.emp_no = e.emp_no )
order by emp_no;  # order by is better used at outter query


select * from employees e
where exists(
select * from titles t
where t.emp_no = e.emp_no and title = 'Assistant Engineer');


/* practice subqueries-------------------*/

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_Id,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS manager_Id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_Id,
            MIN(de.dept_no) AS dept_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS manager_Id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;

/* practice subqueries-----------------------*/

drop table if exists emp_manager;
CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

SELECT * FROM emp_manager;



