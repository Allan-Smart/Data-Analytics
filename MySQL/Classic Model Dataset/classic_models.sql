/* ------------------------------- Classic Models Database -------------------------------  */

/* 1 ------------------ Select the Dataset ------------------  */
USE classicmodels;

/* 2 ------------------ Show Tables ------------------  */
SHOW TABLES;

/* 3 ------------------ Exploring the Data ------------------  */

/* Customers */
DESC customers;
SELECT * FROM customers; 							-- Select the entire table

SELECT COUNT(*) AS 'Total Rows' FROM customers; 	-- Count the number of total Customer rows

/* City */
SELECT 												-- Count the total number of customers per city
    city, 
    COUNT(*) AS 'Total Count'
FROM
    customers
GROUP BY 
	city
ORDER BY COUNT(*) DESC;

SELECT												-- Count the number where city is "Null"
	COUNT(*) AS 'City as Null'
FROM customers
WHERE city is NULL;


/* Country */
SELECT												-- Count the total number of customers per country
	country,
    COUNT(*) as 'Total Count'
FROM
	customers
GROUP BY country
ORDER BY COUNT(*) DESC;



/* Left Join: Customers and Payments */
SELECT												-- Total sales per customer
	customers.customerName AS Name,
    customers.country AS Country,
    COALESCE(SUM(payments.amount), 0) AS Amount
FROM
	customers
LEFT JOIN
	payments
		ON customers.customerNumber = payments.customerNumber
GROUP BY customers.customerName, customers.country
ORDER BY Amount DESC;

/* Customer spending and level of credit */
SELECT												-- Total credit per customer
	customers.customerName AS customers_name,
    COALESCE(SUM(payments.amount), 0) AS amount_spent,
    customers.creditLimit as credit_limit
FROM customers
LEFT JOIN
	payments
		ON customers.customerNumber = payments.customerNumber
GROUP BY customers.customerNumber, customers.creditLimit
ORDER BY amount_spent DESC;

/* Sales via seasons */
SELECT												-- Total sales per season
	CASE
		WHEN MONTH(STR_TO_DATE(paymentDate, '%Y-%m-%d')) IN (9,10,11) THEN 'Spring'
        WHEN MONTH(STR_TO_DATE(paymentDate, '%Y-%m-%d')) IN (12,1,2) THEN 'Summer'
        WHEN MONTH(STR_TO_DATE(paymentDate, '%Y-%m-%d')) IN (3,4,5) THEN 'Autumn'
        ELSE 'Winter'
	END AS Season,
    YEAR(STR_TO_DATE(paymentDate, '%Y-%m-%d')) AS SeasonYear,
    SUM(amount) AS TotalAmount
FROM payments
GROUP BY SeasonYear, Season
ORDER BY SeasonYear DESC, Season;



SELECT * FROM products;


/**************************************************
*			Employees and Offices
***************************************************/
-- Total number of employees
SELECT * FROM employees;								-- Count total employees

-- Count of each job title
SELECT													-- Count the number employees per role
	COUNT(CASE WHEN jobTitle = 'President' THEN 1 END) AS President,
    COUNT(CASE when jobTitle = 'VP Sales'  THEN 1 END) AS VP_Sales,
    COUNT(CASE WHEN jobTitle = 'VP Marketing' THEN 1 END) AS VP_Marketing,
    COUNT(CASE WHEN jobTitle = 'Sales Manager (APAC)' THEN 1 END) AS 'Sales Manager (APAC)',
    COUNT(CASE WHEN jobTitle = 'Sale Manager (EMEA)' THEN 1 END) AS 'Sale Manager (EMEA)',
    COUNT(CASE WHEN jobTitle = 'Sales Manager (NA)' THEN 1 END) AS 'Sales Manager (NA)',
    COUNT(CASE WHEN jobTitle = 'Sales Rep' THEN 1 END) AS Sales_Rep
FROM employees;

-- Number of offices per country
SELECT													-- Count the number off offices per country
	offices.country AS Country,
    COUNT(*) AS Count
FROM offices
GROUP BY Country
ORDER BY Country DESC;

-- Number of employees per country
SELECT
	COUNT(employees.employeeNumber) AS Number_of_Employees,
    offices.country AS Country
FROM
	employees
LEFT JOIN
	offices
		ON employees.officeCode = offices.officeCode
GROUP BY Country
ORDER BY Number_of_Employees DESC;

-- Total sales amount per sales rep
SELECT
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    e.jobTitle,
    COUNT(DISTINCT c.customerNumber)     AS customers,
    COALESCE(SUM(p.amount), 0)           AS totalSales
FROM employees e
LEFT JOIN customers c
    ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p
    ON p.customerNumber = c.customerNumber
GROUP BY e.employeeNumber, employeeName, e.jobTitle
ORDER BY totalSales DESC;

/**************************************************
*			Products
***************************************************/

-- Count per product category
SELECT 
	productLine 		AS Product_Catergory,
    COUNT(productLine) 	AS Count
FROM products
GROUP BY productLine
ORDER BY Count DESC;




        












