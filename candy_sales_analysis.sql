USE candy_project;

SELECT COUNT(*) AS total_rows
FROM candy_sales;


-- Preview the dataset

SELECT *
FROM candy_sales
LIMIT 10;

-- Check the date range of the dataset

SELECT 
    MIN(`Order Date`) AS first_order,
    MAX(`Order Date`) AS last_order
FROM candy_sales;

-- Calculate total sales
SELECT 
    SUM(Sales) AS total_sales
FROM candy_sales;


-- Calculate total sales by year
SELECT 
    YEAR(`Order Date`) AS year,
    SUM(Sales) AS total_sales
FROM candy_sales
GROUP BY YEAR(`Order Date`)
ORDER BY year;

-- Calculate total sales by division
SELECT 
    Division,
    SUM(Sales) AS total_sales
FROM candy_sales
GROUP BY Division
ORDER BY total_sales DESC;

-- Top 10 products by total sales
SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales
FROM candy_sales
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;



-- Top 10 products by gross profit
SELECT 
    `Product Name`,
    SUM(`Gross Profit`) AS total_profit
FROM candy_sales
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;

-- Calculate profit margin by product

SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales,
    SUM(`Gross Profit`) AS total_profit,
    ROUND(SUM(`Gross Profit`) / SUM(Sales) * 100, 2) AS profit_margin
FROM candy_sales
GROUP BY `Product Name`
ORDER BY profit_margin DESC;


-- Calculate sales and gross profit by region

SELECT 
    Region,
    SUM(Sales) AS total_sales,
    SUM(`Gross Profit`) AS total_profit
FROM candy_sales
GROUP BY Region
ORDER BY total_sales DESC;


-- Analyze monthly sales trend
SELECT 
    YEAR(`Order Date`) AS year,
    MONTH(`Order Date`) AS month,
    SUM(Sales) AS total_sales
FROM candy_sales
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
ORDER BY year, month;


-- Identify the month with the highest total sales

SELECT 
    YEAR(`Order Date`) AS godina,
    MONTH(`Order Date`) AS mesec,
    SUM(Sales) AS total_sales
FROM candy_sales
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
ORDER BY total_sales DESC
LIMIT 1;



-- Top 10 states/provinces by total sales

SELECT 
    `State/Province`,
    SUM(Sales) AS total_sales,
    SUM(`Gross Profit`) AS total_profit
FROM candy_sales
GROUP BY `State/Province`
ORDER BY total_sales DESC
LIMIT 10;





-- Top 3 products by sales within each division

WITH product_sales AS (
    SELECT
        Division,
        `Product Name`,
        SUM(Sales) AS total_sales
    FROM candy_sales
    GROUP BY Division, `Product Name`
),
ranked_products AS (
    SELECT
        Division,
        `Product Name`,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY Division
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_sales
)

SELECT *
FROM ranked_products
WHERE product_rank <= 3;



-- Categorize sales into Low, Medium, and High groups

WITH sales_groups AS (
    SELECT
        Sales,
        CASE
            WHEN Sales < 50 THEN 'Low'
            WHEN Sales BETWEEN 50 AND 100 THEN 'Medium'
            ELSE 'High'
        END AS sales_category
    FROM candy_sales
)

SELECT
    sales_category,
    COUNT(*) AS number_of_sales
FROM sales_groups
GROUP BY sales_category
ORDER BY number_of_sales DESC;
-- Calculate average sales by division

SELECT
    Division,
    ROUND(AVG(Sales), 2) AS average_sales
FROM candy_sales
GROUP BY Division
ORDER BY average_sales DESC;



-- Top 10 customers by number of orders

SELECT
    `Customer ID`,
    COUNT(DISTINCT `Order ID`) AS number_of_orders
FROM candy_sales
GROUP BY `Customer ID`
ORDER BY number_of_orders DESC
LIMIT 10;
-- Identify the top 10 customers by total spending and number of orders

SELECT
    `Customer ID`,
    COUNT(DISTINCT `Order ID`) AS number_of_orders,
    ROUND(SUM(Sales), 2) AS total_spent
FROM candy_sales
GROUP BY `Customer ID`
ORDER BY total_spent DESC
LIMIT 10;

-- Calculate the average order value (AOV)

WITH order_totals AS (
    SELECT
        `Order ID`,
        SUM(Sales) AS order_value
    FROM candy_sales
    GROUP BY `Order ID`
)

SELECT
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_totals;


-- Analyze sales, gross profit, and profit margin by division
SELECT
    Division,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(`Gross Profit`), 2) AS total_profit,
    ROUND(
        SUM(`Gross Profit`) / SUM(Sales) * 100,
        2
    ) AS profit_margin_percent
FROM candy_sales
GROUP BY Division
ORDER BY profit_margin_percent DESC;

-- Identify the top 10 cities by gross profit

SELECT
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(`Gross Profit`), 2) AS total_profit
FROM candy_sales
GROUP BY City
ORDER BY total_profit DESC
LIMIT 10;


-- Analyze the number of orders by shipping mode

SELECT
    `Ship Mode`,
    COUNT(DISTINCT `Order ID`) AS number_of_orders
FROM candy_sales
GROUP BY `Ship Mode`
ORDER BY number_of_orders DESC;



-- Calculate key performance indicators (KPIs)

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(`Gross Profit`), 2) AS total_profit,
    COUNT(DISTINCT `Order ID`) AS total_orders,
    COUNT(DISTINCT `Customer ID`) AS total_customers,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT `Order ID`),
        2
    ) AS average_order_value
FROM candy_sales;