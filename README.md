# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Sql_project_p1`.
- **Table Creation**: A table named `retail_sales_analysis` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
Create database Sql_project_p1;

Drop Table IF EXISTS Retail_sales_analysis

Create Table Retail_sales_analysis
           (
             transactions_id INT PRIMARY KEY,	
			 sale_date	Date,
			 sale_time	Time,
			 customer_id INT,	
			 gender	Varchar(15),
			 age INT,
			 category Varchar(15),	
			 quantity INT,	
			 price_per_unit	FLOAT,
			 cogs	FLOAT,
			 total_sale FLOAT
            );
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count (*) from Retail_sales_analysis;

update Retail_sales_analysis
set cogs = ROUND(cogs,2);

SELECT COUNT(DISTINCT customer_id) FROM Retail_sales_analysis;
SELECT DISTINCT category FROM Retail_sales_analysis;

Select * from Retail_sales_analysis
where transactions_id is NULL
      or
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
	  quantity IS NULL
	  OR
	  price_per_unit IS NULL
	  OR 
	  cogs IS NULL
	  OR 
	  total_sale IS NULL;

DELETE FROM Retail_sales_analysis
where transactions_id is NULL
      or
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
	  quantity IS NULL
	  OR
	  price_per_unit IS NULL
	  OR 
	  cogs IS NULL
	  OR 
	  total_sale IS NULL;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM Retail_sales_analysis
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM Retail_sales_analysis
WHERE
        category ='Clothing' 
        and
		MONTH(Sale_date) = 11
		and
		YEAR(sale_date) = 2022
		and 
		quantity > 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, 
       sum(total_sale) as total_sales ,
	   count(*) As total_orders from Retail_sales_analysis
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(AVG(age),2) as avg_age
from Retail_sales_analysis
where category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from Retail_sales_analysis
where total_sale >1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category,
       count(*)as Total_transactions,
       gender  
from Retail_sales_analysis
group by 
      gender,category
order by 
      category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select MONTH(sale_date)As Month,
        YEAR(sale_date)As year,
		AVG(total_sale)As Avg_sale
from 
Retail_sales_analysis
group by YEAR(sale_date),MONTH(sale_date)
order by YEAR(sale_date),AVG(total_sale) desc;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select top 5
       customer_id ,
       count(customer_id) as Total_customers,
	    Sum(total_sale) as total_sale 
from Retail_sales_analysis
group by customer_id
order by total_sale desc;
``` 

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category,count(distinct customer_id) as unique_customers
FROM Retail_sales_analysis
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with Hourly_sale 
as
(
SELECT *,
    CASE
	 WHEN DATEPART(HOUR,sale_time) < 12 THEN 'Morning'
	 WHEN DATEPART(HOUR,sale_time) between  12 and  17 THEN 'Afternoon'
	 ELSE 'Evening'
    END as Shift	
from Retail_sales_analysis
)
select Shift, Count(shift) as orders_shift_wise from Hourly_sale
group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


Thank you for your support, and I look forward to connecting with you!
