--Sql Retail Sales Analysis P1

Create database Sql_project_p1;

--Create Table
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
            )
use Sql_project_p1;

Select * from Retail_sales_analysis;

--DATA CLEANING

ALTER TABLE Retail_Sales_Analysis
DROP COLUMN Column13;

select count (*) from Retail_sales_analysis;

update Retail_sales_analysis
set cogs = ROUND(cogs,2);

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

-- DATA EXPLORATION

--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALES FROM Retail_sales_analysis;

--HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id) as Total_Unique_customers from Retail_sales_analysis;

--NAME OF THE UNIQUE CATEGORIES WE HAVE?
SELECT distinct(category) from Retail_sales_analysis;

--DATA ANALYSIS & BUSSINESS KEY PROBLEMS

--1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

SELECT * FROM Retail_sales_analysis
WHERE sale_date = '2022-11-05';

--2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

SELECT * FROM Retail_sales_analysis
WHERE
        category ='Clothing' 
        and
		MONTH(Sale_date) = 11
		and
		YEAR(sale_date) = 2022
		and 
		quantity > 3;

--3. **Write a SQL query to calculate the total sales (total_sale)  and total orders for each category.**

select category, 
       sum(total_sale) as total_sales ,
	   count(*) As total_orders from Retail_sales_analysis
group by category;

--4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

select round(AVG(age),2) as avg_age from Retail_sales_analysis
where category ='Beauty';

--5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

select * from Retail_sales_analysis
where total_sale >1000;

--6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

select category,count(*)as Total_transactions, gender  from Retail_sales_analysis
group by gender,category
order by category;

--7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
 
select MONTH(sale_date)As Month,
        YEAR(sale_date)As year,
		AVG(total_sale)As Avg_sale
from 
Retail_sales_analysis
group by YEAR(sale_date),MONTH(sale_date)
order by YEAR(sale_date),AVG(total_sale) desc;

--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

select top 5
       customer_id ,
       count(customer_id) as Total_customers,
	    Sum(total_sale) as total_sale 
from Retail_sales_analysis
group by customer_id
order by total_sale desc;

--9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

SELECT category,count(distinct customer_id) as unique_customers
FROM Retail_sales_analysis
group by category;

--10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

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

--END of PROJECT



