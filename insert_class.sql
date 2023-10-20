use employees;

insert into employees
values( 999903,'1977-09-14','Johnathan','Creek','M','1999-01-01');

select * from titles
order by emp_no desc;

insert into titles (emp_no,title,from_date)
values(999903,'Senior Engineer','1997-10-01');

insert into dept_emp
values( 999903,'d005','1997-10-01','9999-01-01');

insert into departments
values('d010','Business Analysis');

select * from departments;

/*把to_date修改加上日期*/
update titles
set to_date = '9999-01-01'
where emp_no = 999903;

/*----------------------------------------------*/
/*-------modifying departments_dup table---------*/
CREATE TABLE departments_dup (
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);

insert into departments_dup
select * from departments;

select * from departments_dup;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

insert into departments_dup(dept_no)
values('d011'),('d012');

alter table departments_dup
add column dept_manager varchar(225) null after dept_name;

commit;

