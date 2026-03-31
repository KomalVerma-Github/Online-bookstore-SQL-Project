
create database online_bookstore;

use online_bookstore;

-- Create tables for store data in the database.
create table books(
book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    author VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(8,2),
    stock INT
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Insert record data in each table.
INSERT INTO books (title, author, category, price, stock) VALUES
('The Alchemist','Paulo Coelho','Fiction',350,20),
('C Programming','Dennis Ritchie','Programming',500,15),
('Database Systems','Korth','Education',750,10),
('Clean Code','Robert Martin','Programming',900,8);

INSERT INTO customers (name,email,phone,city) VALUES
('Rahul Sharma','rahul@gmail.com','9876543210','Delhi'),
('Anita Verma','anita@gmail.com','9876501234','Noida'),
('Vikas Kumar','vikas@gmail.com','9123456789','Ghaziabad');

INSERT INTO orders (customer_id,order_date,total_amount) VALUES
(1,'2024-02-10',700),
(2,'2024-02-12',500),
(3,'2024-02-15',900);

INSERT INTO order_items (order_id,book_id,quantity,price) VALUES
(1,1,2,350),
(2,2,1,500),
(3,4,1,900);

-- Below are the SQL queries used in this project to manage and retrieve data from different tables.

-- Q1: Display all books available in the bookstore.
SELECT * FROM books;

-- Q2: Display books with price less than ₹500
SELECT title, price
FROM books
WHERE price < 500;

-- Q3: Find all books in the 'Programming' category.
SELECT * FROM books
WHERE category = 'Programming';

-- Q4: Display books with low stock (less than 10).
SELECT title, stock
FROM books
WHERE stock < 10;

-- Q5: Display all customers.
SELECT * FROM customers;

-- Q6: Find customers from Delhi.
SELECT * FROM customers
WHERE city = 'Delhi';

-- Q7: Display all orders.
SELECT * FROM orders;

-- Q8: Show orders placed after a specific date.
SELECT * FROM orders
WHERE order_date > '2024-02-10';

-- Q9: Display all order items.
SELECT * FROM order_items;

-- Q10: Display order items where quantity is greater than 1.
SELECT * FROM order_items
WHERE quantity > 1;

-- Q11: Display customer names along with their order details.
SELECT customers.name, orders.order_id, orders.order_date
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id;

-- Q12: Show books ordered in each order.
SELECT orders.order_id, books.title, order_items.quantity
FROM order_items
JOIN books ON order_items.book_id = books.book_id
JOIN orders ON order_items.order_id = orders.order_id;

-- Q13: Calculate total sales of the bookstore.
SELECT SUM(total_amount) AS total_sales
FROM orders;

-- Q14: Count total number of books.
SELECT COUNT(*) AS total_books
FROM books;

-- Q15: Find average price of books.
SELECT AVG(price) AS avg_price
FROM books;

-- Q16: Find the most expensive book in the bookstore.
SELECT title, price
FROM books
ORDER BY price DESC
LIMIT 1;

-- Q17: Display names of customers who have placed orders.
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id;

-- Q18: Find total number of books sold for each book.
SELECT books.title, SUM(order_items.quantity) AS total_sold
FROM order_items
JOIN books ON order_items.book_id = books.book_id
GROUP BY books.title;

-- Q19: Calculate total amount spent by each customer.
SELECT customers.name, SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name;

-- Q20: Display books with low stock (less than 10).
SELECT title, stock
FROM books
WHERE stock < 10;

-- Q21: Update the price of a specific book.
UPDATE books
SET price = 800
WHERE book_id = 3;

-- Q22: Create View to display book summary (title, author, price).
CREATE VIEW book_summary AS
SELECT title, author, price
FROM books;

-- Q23: Display total spending of each customer.
SELECT customers.name, SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.name;

-- Q24: Count total number of orders placed by each customer.
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- Q25: Find books that are sold more than once.
SELECT book_id, SUM(quantity) AS total_sold
FROM order_items
GROUP BY book_id
HAVING total_sold > 1;

-- Q26: Display the most recent order placed.
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 1;

-- Conclusion:
-- In this project, I have created an Online Bookstore Database using MySQL.This project helped me to understand how a real database works in 
-- managing books, customers, and orders.I used different SQL queries like SELECT, INSERT, UPDATE, DELETE, JOIN, and aggregate functions to
-- perform various operations on the data.Through this project, I learned how to connect multiple tables and retrieve meaningful information.
-- Overall, this project improved my knowledge of database management systems and gave me practical experience in writing SQL queries.
