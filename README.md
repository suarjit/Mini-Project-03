# Mini-Project-03
# Classicmodels SQL Data Cleaning Project

## 📌 Project Overview
This project focuses on cleaning, transforming, standardizing, and analyzing data in the `Classicmodels` database using MySQL. It demonstrates essential SQL techniques for improving data quality and identifying inconsistencies in customer, employee, office, order, product, and payment data.

## 🎯 Project Objectives
- Handle missing and blank values in customer addresses.
- Clean and standardize customer and employee names.
- Remove unnecessary spaces from email addresses and convert them to lowercase.
- Clean phone numbers by removing non-numeric characters.
- Identify potential duplicate payment records.
- Categorize orders according to their status.
- Extract numerical values from product scale information.
- Identify customers with non-positive credit limits who have placed orders.
- Standardize country names for consistency.

## 🛠️ Technologies Used
- **Database:** Classicmodels
- **Language:** SQL
- **Platform:** MySQL / MySQL Workbench

## 📂 Data Cleaning Tasks

### 1. Missing Value Handling
Identifies missing or blank values in customer address fields, particularly `addressLine2` and `state`. Replaces them with descriptive labels such as `Address not provided` and `State not provided`.

### 2. Customer Name Cleaning
Cleans customer contact names by removing unnecessary spaces and standardizing capitalization. The first letter of each name is converted to uppercase, while the remaining letters are converted to lowercase.

### 3. Employee Email Cleaning
Standardizes employee names and cleans email addresses by removing leading, trailing, and internal spaces and converting all characters to lowercase.

### 4. Phone Number Cleaning
Uses `TRIM()` and `REGEXP_REPLACE()` to remove whitespace and non-numeric characters from office phone numbers. Displays both the original and cleaned phone numbers for comparison.

### 5. Duplicate Payment Identification
Groups payment records by `customerNumber`, `paymentDate`, and `amount` to identify combinations occurring more than once. Results are sorted by the number of occurrences.

**Note:** This query identifies potential duplicate records but does not delete them.

### 6. Order Status Analysis
Uses a `CASE` statement to classify orders into meaningful categories:

- `Shipped` → Completed
- `Cancelled` → Cancelled Order
- `Disputed` → Requires Attention
- `In Process` → Being Processed
- `On Hold` → Temporarily Held
- Other statuses → Other

### 7. Product Scale Transformation
Extracts the numerical values before and after the colon in the `productScale` column. Uses `SUBSTRING_INDEX()` and `CONVERT()` to transform the scale information into separate numeric columns.

### 8. Data Inconsistency Identification
Joins the `customers` and `orders` tables to identify customers whose credit limits are zero, negative, or `NULL` and who have placed orders. Counts their orders and sorts the results by order count in descending order.

### 9. Country Name Standardization
Updates country names in the `customers` table to maintain consistent naming conventions:

- `USA` → `United States`
- `UK` → `United Kingdom`

The `WHERE` conditions restrict the updates to records containing the specified country codes.

### 10. Result Verification
Retrieves customer numbers, customer names, and country names to verify the standardized values for `United States` and `United Kingdom`.

## 🧠 SQL Concepts Practiced
- `SELECT` and `WHERE`
- `CASE` statements
- `TRIM()`, `UPPER()`, and `LOWER()`
- `CONCAT()`, `LEFT()`, and `SUBSTRING()`
- `REPLACE()` and `REGEXP_REPLACE()`
- `SUBSTRING_INDEX()` and `CONVERT()`
- `COUNT()`, `GROUP BY`, and `HAVING`
- `INNER JOIN`
- `COALESCE()`
- `UPDATE` statements
- Data quality checks and standardization

## 📊 Expected Outcomes
- Improved consistency in customer and employee names.
- Cleaner email addresses and phone numbers.
- Clear identification of missing address information.
- Detection of potential duplicate payments.
- Better understanding of order status categories.
- Structured numerical product scale values.
- Identification of possible customer credit-limit inconsistencies.
- Consistent country naming in the customer database.

## ⚠️ Important Notes
- The missing-value, name-cleaning, email-cleaning, phone-cleaning, duplicate-identification, order-analysis, product-transformation, and credit-limit queries display results without directly modifying the underlying records.
- The country standardization queries modify the `customers` table permanently unless the changes are rolled back within an appropriate transaction.
- The duplicate payment query identifies repeated combinations; it does not establish that the payments are true duplicates.
- Back up your database before executing `UPDATE` statements.

## 👨‍💻 Author
**Surajit Bera**

## 📜 License
This project is intended for educational and SQL practice purposes.