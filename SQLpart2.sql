CREATE DATABASE kfc;

USE kfc;

CREATE TABLE customers(
c_id INT UNIQUE NOT NULL AUTO_INCREMENT,
c_name VARCHAR(100) DEFAULT "",
phone_number VARCHAR(11) NOT NULL,
over_18 BOOLEAN,
points DECIMAL(6,2),
PRIMARY KEY(c_id)
);

SHOW TABLES;

DESCRIBE customers;
DESCRIBE orders;

DROP TABLE customers;

ALTER TABLE customers ADD age INT NOT NULL; #UPDATE an exisitng table, add a new coloumn

ALTER TABLE customers DROP COLUMN over_18; #UPDATE an exisitng table, delete a coloumn

ALTER TABLE customers MODIFY c_name VARCHAR(50) DEFAULT "N/A"; #UPDATE an existing table, modify existing coloumn definition

ALTER TABLE customers RENAME TO cust;


#DML commands
#CREATE - insert into
#READ - select
#UPDATE - update
#DELETE - delete

SELECT * FROM customers;
SELECT c_id, c_name FROM customers;

#                      c1       c2             c3    c4          v1      v2            v3   v4
INSERT INTO customers(c_name, phone_number, points, age) VALUES("ash", "12341234123", 5.6, 123);
INSERT INTO customers(phone_number, c_name, points, age) VALUES("ash2", "12341234123", 5.6, 123);

INSERT INTO customers(phone_number, c_name, points,age) VALUES("ash3", "12341234123", 5.6, 123),("bob", "12341234123", 5.6, 123),("bill", "12341234123", 5.6, 123),("ed", "12341234123", 5.6, 123);



INSERT INTO customers(phone_number, over_18) VALUES("12342123",1);

UPDATE customers SET c_name="jh", phone_number="23232351444" WHERE c_id=6;

DELETE FROM customers WHERE c_id=3;

CREATE TABLE items(
item_id INT UNIQUE NOT NULL AUTO_INCREMENT,
item_name VARCHAR(20),
price DECIMAL(6,2),
PRIMARY KEY(item_id));

SELECT * FROM items;
INSERT INTO items(item_name,price) VALUES("toy",3.00),("cup",5.00),("teddy",10.00),("coke",1.50),("poster",0.50);


CREATE TABLE orders(
order_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_id INT NOT NULL,
total_price DECIMAL(6,2) DEFAULT 0.00,
PRIMARY KEY(order_id),
FOREIGN KEY (cust_id) REFERENCES customers(c_id) ON DELETE CASCADE);

SELECT * FROM orders;
INSERT INTO orders(cust_id) VALUES(2),(5),(1);
INSERT INTO orders(cust_id) VALUES(6);

DELETE FROM customers WHERE c_id=6;

UPDATE orders SET total_price=10.00 WHERE order_id=1;

DROP TABLE orders;
DROP TABLE order_items;

insert into orders(cust_id, total_price) values(7,0.00);
select * from orders;

CREATE TABLE order_items(
oi_id INT UNIQUE NOT NULL AUTO_INCREMENT,
ord_id INT NOT NULL,
i_id INT NOT NULL,
quantity INT,
PRIMARY KEY(oi_id),
FOREIGN KEY (ord_id) REFERENCES orders(order_id) ON DELETE CASCADE,
FOREIGN KEY (i_id) REFERENCES items(item_id) ON DELETE CASCADE);

INSERT INTO order_items(ord_id, i_id,quantity) VALUES(1,3,1),(2,4,5),(2,2,1);
SELECT * FROM order_items;

#READ from tables to view the records:
#- SELECT * FROM table_name;
#- SELECT col1, col2, col4 FROM table_name;
#WHERE clause
# - SELECT * FROM table_name WHERE col_name=value;
SELECT * FROM order_items WHERE ord_id=2;#filtering what you see

#OPERATORS
# = equals to...
# > - exclusive
# < - excluding
# !=
# >= - inclusive 
# <= - inclusive
SELECT * FROM items;
SELECT * FROM items WHERE price>5.00;
SELECT * FROM items WHERE price!=5.00;
SELECT * FROM items WHERE price>1.00 AND price<5.00;
SELECT * FROM items WHERE price BETWEEN 1.00 AND 5.00; #INCLUSIVE RANGE - includes the numbers stated
# search for patterns - text data
SELECT * FROM items WHERE item_name LIKE "%y"; # finds any item_name that ends with y
SELECT * FROM items WHERE item_name LIKE "c%"; #finds any item_ name that begins with c

SELECT DISTINCT ord_id from order_items;#selects unique values in the stated column of chosen table

#ORDERING DATA - any type of data
SELECT * FROM items ORDER BY item_name ASC; # item_name in ascending order
SELECT * FROM items ORDER BY item_name DESC; # item_name in descending order

#LIMITING DATA - any type of data
SELECT * FROM items LIMIT 2;# first 2 records
SELECT * FROM items ORDER BY item_id DESC LIMIT 2; #last 2 records
SELECT * FROM items ORDER BY item_name DESC LIMIT 3; #last 2 records

#AGGREGATE FUNCTIONS - when you have a range of data and want to perform an operation on them to return a single value - NUMERICAL VALUES
#Average - AVG
#Sum - SUM
#Minimum - MIN
#Maximum - MAX
#Count - COUNT

SELECT AVG(price) FROM items;
SELECT MIN(price) FROM items;
SELECT MAX(price) FROM items;
SELECT SUM(price) FROM items;
SELECT COUNT(price) FROM items;

#Nested queries - A QUERY IN A QUERY

SELECT cust_id FROM orders WHERE order_id=2; #returns 5
SELECT * FROM customers WHERE c_id=5;

SELECT * FROM customers WHERE c_id=(SELECT cust_id FROM orders WHERE order_id=2);


SELECT i_id FROM order_items WHERE oi_id=1; # returns 3
SELECT * FROM items WHERE item_id=3;

SELECT * FROM items WHERE item_id=(SELECT i_id FROM order_items WHERE oi_id=1);


SELECT item_name FROM items WHERE item_id=(SELECT i_id FROM order_items WHERE ord_id=(SELECT order_id FROM orders WHERE cust_id=(SELECT c_id FROM customers WHERE c_name="blue")));

#JOINS:
#INNER JOIN - default one, combines tables together based on data that is present in both tables
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM customers JOIN orders ON customers.c_id=orders.cust_id;
SELECT customers.c_name, customers.phone_number, orders.order_id FROM customers JOIN orders ON customers.c_id=orders.cust_id;
SELECT c.c_name, c.phone_number, o.order_id FROM customers c JOIN orders o ON c.c_id=o.cust_id;
#OUTER JOINS - 2 types, LEFT OUTER JOIN and RIGHT OUTER JOIN
#LEFT OUTER JOIN
SELECT * FROM customers c LEFT OUTER JOIN orders o ON c.c_id=o.cust_id;# customers table is looking for records to match in the orders table(displayed on the right of it), any records that don't have a match are populated with NULL
#RIGHT OUTER JOIN
SELECT * FROM orders o RIGHT OUTER JOIN customers c ON c.c_id=o.cust_id;

SELECT * FROM order_items;

SELECT c.c_name, o.order_id, oi.quantity,i.item_name, i.price FROM customers c JOIN orders o ON c.c_id=o.cust_id JOIN order_items oi ON o.order_id=oi.ord_id JOIN items i ON oi.i_id=i.item_id;
