use sales;

# --------------add foreign key--------------
alter table sales
add constraint fk_cusOrder foreign key (customer_id) references customer(customer_id) on delete cascade;

# --------------drop foreign key--------------
alter table sales
drop foreign key sales_ibfk_1;

create table customer(
customer_id int auto_increment,
firstname varchar(225),
lastname varchar(225),
email varchar(225),
numofcomplaints int,
primary key(customer_id)
);

# --------------add unique key--------------
alter table customer
add unique key(email);

# --------------drop unique key--------------
alter table customer   /* use drop index to drop unique key */
drop index email;

# --------------add a new column--------------
alter table customer 
add column gender enum('M','F') after lastname;

# --------------drop a column--------------
alter table customer
drop column gender;

# --------------set a column default--------------
alter table customer
alter numofcomplaints set default 0;

insert into customer values('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);


CREATE TABLE items (
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 ,2),
    company_id VARCHAR(255),
    PRIMARY KEY (item_code)
);  

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
    PRIMARY KEY (company_id)
);

# --------------set a column to be default --------------
alter table companies
alter company_name set default 'X';

# --------------drop a column to not being default --------------
alter table companies
alter column company_name drop default;

# --------------modify a column can be null --------------
alter table companies
modify company_name varchar(225) null;

# --------------change a column can be not null --------------
alter table companies
change column company_name company_name varchar(225) not null;

insert into companies
values('01','google com',091269868);

/*
alter table companies
drop primary key ;

alter table companies
modify company_id varchar(225) auto_increment;

alter table companies
add constraint primary key (company_id);
*/

