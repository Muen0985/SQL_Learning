use employees;

select count(from_date) from salaries;
select count(distinct from_date) from salaries;
select count(*) from salaries;
# returns the number of all rows and null values included

select count(distinct dept_no) from departments;
/*----------------------------------------------*/

select sum(salary) from salaries
where from_date > '1997-01-01';   #日期要記得加上單引號
/*----------------------------------------------*/

select min(salary) from salaries;
select max(salary) from salaries;
/*----------------------------------------------*/

select avg(salary) from salaries;
select avg(salary) from salaries
where from_date > '1997-01-01';
/*----------------------------------------------*/

select round(avg(salary),2) from salaries;
select round(avg(salary),2) from salaries
where from_date >'1998-06-01';
/*----------------------------------------------*/

select * from departments_dup;

# 很多人都使用coalesce來作條件，比使用ifnull來的多。
# COALESCE COALESCE(dept_manager,dept_name,'null') as dept_manage
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no DESC;


SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_name, dept_no) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

