create database if not exists Sales;

use Sales;

CREATE TABLE sales (
    purchase_num INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

SELECT * FROM sales

/* drop table sales */


