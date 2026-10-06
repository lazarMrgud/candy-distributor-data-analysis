# Candy Distributor Sales Analysis

## Project Overview

This project analyzes sales data from a candy distribution company.

The goal of the project is to explore and validate the dataset, analyze sales and profitability, identify key products, customers, and regions, and present the results through an interactive Power BI dashboard.

## Tools Used

- Python
- Pandas
- MySQL
- SQL
- Power BI

## Project Workflow

### 1. Data Exploration and Validation

The dataset was first explored in Python using Pandas.

The main steps included:
- Checking the dataset structure, columns, and data types
- Checking for duplicate records
- Reviewing categorical values such as country and shipping mode
- Converting order and shipping dates to datetime format
- Validating financial data by checking whether Sales - Cost = Gross Profit
- Investigating unusual values in the shipping dates

During the validation process, an anomaly was identified in the shipping dates. 
The calculated shipping times were approximately 2,000 days, which indicated a problem in the source data. 
Because the correct shipping dates could not be verified, shipping-time analysis was excluded from the final analysis.

### 2. MySQL Database

After validating the dataset, the sales data was imported into a MySQL database.

Database:
`candy_project`

Main table:
`candy_sales`

The final table contains 10,194 sales records.

### 3. SQL Analysis

SQL was used to analyze sales performance and answer key business questions.

The analysis included:
- Total sales and gross profit
- Sales performance by year
- Monthly sales trends
- Sales and profit by division
- Sales and profit by region
- Top products by sales
- Top products by gross profit
- Profit margin by product and division
- Top customers by spending and number of orders
- Average Order Value (AOV)
- Top states and cities by sales and profit
- Shipping mode usage
- Top products within each division using window functions

SQL techniques used in the project include:
- GROUP BY
- Aggregate functions
- CASE statements
- Common Table Expressions (CTEs)
- ROW_NUMBER()
- Date functions
- Ranking and Top-N analysis

### 4. Power BI Dashboard

An interactive Power BI dashboard was created to present the main findings.

The dashboard includes KPI cards for:
- Total Sales
- Total Gross Profit
- Total Orders
- Total Customers
- Average Order Value

The dashboard also includes visual analysis of:
- Sales trends over time
- Gross profit by division
- Sales by region
- Top 10 products by sales
- Sales and profitability performance

Interactive slicers allow the dashboard to be filtered by selected business dimensions.

## Project Structure

- `distribution.ipynb` - Python data exploration and validation
- `candy_sales_analysis.sql` - SQL analysis
- `Candy_Sales.csv` - Source sales dataset
- `Candy_Distributor_Sales_Analysis.pbix` - Power BI dashboard

## Key Skills Demonstrated

Python | Pandas | Data Cleaning | Data Validation | MySQL | SQL | CTEs | Window Functions | Power BI | Data Visualization | Business Analysis
