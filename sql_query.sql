-- SQL RETAIL SALES ANALYSIS
CREATE DATABASE sql_retail_project1;

--CREATE TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(25),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
)

SELECT * FROM retail_sales

-- DATA CLEANING
-- FINDING THE NULL RECORDS
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL


-- DELETING NULL ROWS
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

-- DATA EXPLORATION
-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) as total_sale FROM retail_sales;
-- 1987

--HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) as no_of_customers
FROM retail_sales;
-- 155

--WHAT ARE THE DISTINCT CATEGORIES WE HAVE?
SELECT DISTINCT category FROM retail_sales;


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS
-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05?
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?
SELECT * FROM retail_sales
WHERE 
		category = 'Clothing'
	AND quantiy >= 4
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
-- We can also use the EXTRACT method

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category?
SELECT 
	category,
	SUM(total_sale) as net_sales,
	COUNT(*) as total_order
FROM retail_sales
GROUP BY category

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category?
SELECT ROUND(AVG(age), 2) as average_age FROM retail_sales
WHERE category = 'Beauty'

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000?
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category?
SELECT 
	gender,
	category,
	COUNT(*) as total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year?
SELECT
    ROUND(CAST(AVG(total_sale) AS NUMERIC), 2) AS avg_sale_by_month,
    EXTRACT(MONTH FROM sale_date) AS month,
    EXTRACT(YEAR FROM sale_date) AS year
FROM 
    retail_sales
GROUP BY 
    EXTRACT(MONTH FROM sale_date), EXTRACT(YEAR FROM sale_date)
ORDER BY 
    year, month;

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales?
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category?
SELECT
	category,
	COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS number_of_orders
FROM 
    retail_sales
GROUP BY 
    shift
ORDER BY shift

-- END OF PROJECT

