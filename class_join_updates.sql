use employees;
select * from departments_dup order by dept_no desc;

alter table departments_dup
drop column dept_manager;

alter table departments_dup
change column dept_no dept_no char(4) null;

alter table departments_dup
change column dept_name dept_name VARCHAR(40) NULL;

insert into departments_dup(dept_name)
values('Public Relations');

delete from departments_dup
where dept_no in ('d002','d012','d011','d010');
INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

delete from departments_dup
where dept_name = 'Public Relations';
/*---------------update 1----------------------------------*/

create table dept_manager_dup(
emp_no int(11) NOT NULL,
dept_no char(4) NULL,
from_date date NOT NULL,
to_date date NULL
);
insert into dept_manager_dup
select * from dept_manager;
insert into dept_manager_dup(emp_no,from_date)
values(999904, '2017-01-01'),
	  (999905, '2017-01-01'),
	  (999906, '2017-01-01'),
	  (999907, '2017-01-01');
delete from dept_manager_dup
where dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd002'; 


