select * from departments;

commit; 

delete from departments
where dept_no ='d010';

rollback;
/*-------------------------------*/
select * from titles
order by emp_no desc;

commit;

delete from employees
where emp_no=999903;

select * from employees
where emp_no=999903;

rollback;