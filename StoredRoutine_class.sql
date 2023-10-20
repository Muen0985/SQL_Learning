use employees;

DROP procedure if exists select_employees;

DELIMITER $$
CREATE procedure select_employees() 
begin
	select * from employees
    limit 250;
end $$
Delimiter ;

# need to press the refresh button to see it
/* 呼叫建立procedure的方法 */
call employees.select_employees();
/* If we have already select the database we want, use... */
call select_employees();
/* 或是按Stored Procedures下，選擇對的表按閃電符號的icon */

/* delete procedure */
drop procedure select_employees;


/*------呼叫建立procedure practice----------------------- */
delimiter $$
create procedure avg_salary()
begin
	select avg(salary) from salaries;
end $$
delimiter ;;

call employees.avg_salary;

/* With input parameter procedure */
drop procedure if exists emp_salary;
/* ---------------------------------------------- */

delimiter $$
create procedure emp_salary(in p_emp_no integer)
begin 
select
e.first_name,e.last_name,s.salary,s.from_date,s.to_date
from employees e
join salaries s on e.emp_no=s.emp_no
where e.emp_no = p_emp_no;   #要確定和資料表間的關係
end $$
delimiter ;

call employees.emp_salary(11300); /* 或是按閃電的按鈕*/

/* ------------------------------------------------------ */
/* with input and output procedure */
drop procedure if exists emp_avg_salary_out;
delimiter $$
create procedure emp_avg_salary_out(in p_emp_no integer , out p_avg_salary decimal(10,2))
begin
select  avg(s.salary)  into p_avg_salary  from
employees e
join salaries s
on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$
delimiter ;

/* 現階段暫時用旁邊的閃電呼叫 */

/* with input and output procedure practice */
drop procedure if exists emp_info;
delimiter $$
create procedure emp_info (in p_first_name varchar(255), in p_last_name varchar(255) ,out p_emp_no integer)
begin
select e.emp_no into p_emp_no from employees e
where e.first_name = p_first_name and e.last_name = p_last_name; # 設定與原始資料欄位的關係
end $$
delimiter ;


/* ------------------------------------------------------ */
# Variables
set @v_avg_salary = 0;
call emp_avg_salary_out(11300,@v_avg_salary); # 會先存放，不會直接顯示出來，要再select出結果
select @v_avg_salary;

set @v_emp_no=0;
call employees.emp_info('Aruna','Journel',@v_emp_no);
select @v_emp_no;

/* -------User-Defined functions ---------------------------------------------------- */
/* with input and output function  */
drop function if exists f_emp_avg_salary;

delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
deterministic /* or use NO SQL or READS SQL DATA */
begin
declare v_avg_salary decimal(10,2);

SELECT AVG(s.salary) INTO v_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    p_emp_no= e.emp_no;
    
return v_avg_salary;
end $$
delimiter ;

select f_emp_avg_salary(11300);


/* with input and output function practice ------------------ */

drop function if exists emp_info;
delimiter $$
create function emp_info (p_first_name varchar(225),p_last_name varchar(225)) returns decimal(10,2)
deterministic
begin
declare v_max_from_date date;
declare v_salary decimal(10,2);
SELECT 
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
SELECT 
    s.salary
INTO v_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
return v_salary;
end $$
delimiter ;

SELECT EMP_INFO('Aruna', 'Journel');

set @v_emp_no=11300;
select emp_no,first_name,last_name,f_emp_avg_salary(@v_emp_no) as avg_salary
from employees
where emp_no = @v_emp_no;

