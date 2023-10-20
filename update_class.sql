use employees;

select * from employees
order by emp_no desc;

update employees
set first_name ='Stella',
	last_name='Parkinson',
	birth_date='1990-12-12',
	gender='F'
where emp_no=999903;

select * from employees
where emp_no =999903;
/*----------------------------------*/
select * from departments
order by dept_no desc;

commit;

update departments
set dept_name ='business analysis'
where dept_no ='d010';

update departments
set dept_name='data engineer'
where dept_no='d010';

rollback;
/*會到最後run commit的地方，假設都沒有run commit就會回到sql的初始樣貌*/
/* 需要取消那個控制的按鈕，
才能啟用rollback和commit的功能。
(那個按鈕是limit to 1000 rows 那個下拉選單的左手邊)
*/






