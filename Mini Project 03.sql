USE Classicmodels;
-- Missing Values
SELECT customerNumber,customerName,addressLine1,
    CASE
        WHEN addressLine2 IS NULL OR TRIM(addressLine2) = ''
        THEN 'Address not provided'
        ELSE addressLine2
    END AS addressLine2,
    city,
    CASE
        WHEN state IS NULL OR TRIM(state) = ''
        THEN 'State not provided'
        ELSE state
    END AS state,
    postalCode,
    country
FROM customers;

-- Name Cleanning
SELECT customerNumber,customerName,
    CONCAT(
        UPPER(LEFT(TRIM(contactFirstName), 1)),
        LOWER(SUBSTRING(TRIM(contactFirstName), 2)),
        ' ',
        UPPER(LEFT(TRIM(contactLastName), 1)),
        LOWER(SUBSTRING(TRIM(contactLastName), 2))
    ) AS cleaned_contact_name
FROM customers;

-- Email Cleaning
SELECT employeeNumber,
    CONCAT(
        UPPER(LEFT(TRIM(firstName), 1)),
        LOWER(SUBSTRING(TRIM(firstName), 2)),
        ' ',
        UPPER(LEFT(TRIM(lastName), 1)),
        LOWER(SUBSTRING(TRIM(lastName), 2))
    ) AS employee_name,
    LOWER(REPLACE(TRIM(email), ' ', '')) AS cleaned_email
FROM employees;

-- Phone Number Cleaning
SELECT officeCode,city,
    phone AS old_phone,
    REGEXP_REPLACE(
        TRIM(phone),
        '[^0-9]',
        ''
    ) AS new_phone
FROM offices;

-- Duplicate Deletion
SELECT customerNumber,paymentDate,amount,
    COUNT(*) AS occurrences
FROM payments
GROUP BY customerNumber, paymentDate, amount
HAVING COUNT(*) >= 2
ORDER BY occurrences DESC;

-- Order Analysis
SELECT orderNumber,customerNumber,orderDate,status,
    CASE
        WHEN status = 'Shipped' THEN 'Completed'
        WHEN status = 'Cancelled' THEN 'Cancelled Order'
        WHEN status = 'Disputed' THEN 'Requires Attention'
        WHEN status = 'In Process' THEN 'Being Processed'
        WHEN status = 'On Hold' THEN 'Temporarily Held'
        ELSE 'Other'
    END AS order_category
FROM orders;

-- Product Transformation
SELECT productCode,productName,productScale,
    CONVERT(
        SUBSTRING_INDEX(productScale, ':', 1) +
        0,
        UNSIGNED
    ) AS first_scale_number,
    CONVERT(
        SUBSTRING_INDEX(productScale, ':', -1),
        UNSIGNED
    ) AS second_scale_number
FROM products;

-- Data Inconsistency
SELECT c.customerNumber,c.customerName,c.creditLimit,
    COUNT(o.orderNumber) AS number_of_orders
FROM customers AS c
INNER JOIN orders AS o
    ON c.customerNumber = o.customerNumber
WHERE COALESCE(c.creditLimit, 0) <= 0
GROUP BY
    c.customerNumber,
    c.customerName,
    c.creditLimit
ORDER BY number_of_orders DESC;

-- Standardisation
UPDATE customers
SET country = REPLACE(country, 'USA', 'United States')
WHERE country = 'USA';

UPDATE customers
SET country = REPLACE(country, 'UK', 'United Kingdom')
WHERE country = 'UK';


-- Check the result
SELECT customerNumber,customerName,country
FROM customers
WHERE country IN ('United States', 'United Kingdom');