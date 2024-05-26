CREATE DATABASE IF NOT EXISTS WalmartSales; 
USE walmartsales;

select * from Sales;


Alter Table sales
modify Time time;

# Converting Date column Text into Date Data Type
ALTER TABLE sales ADD (new_col DATE);
UPDATE sales SET new_col=str_to_date(Date,'%d/%m/%Y');
ALTER TABLE Sales DROP Date;
ALTER TABLE Sales RENAME COLUMN new_col TO Date;


Desc sales;



ALTER TABLE sales ADD COLUMN Time_of_day varchar(20); 

select * from sales;


UPDATE sales
SET Time_of_day = (CASE 
	WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning" 
	WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon" 
	ELSE "Evening" 
    END);
    
SELECT 
date, 
DAYNAME(date) 
from sales;       
SELECT * FROM Sales; 

ALTER TABLE Sales ADD COLUMN day_name varchar(12);
UPDATE Sales 
SET day_name = DAYNAME(date);


SELECT 
date, 
MONTHNAME(date) 
from sales;  
ALTER TABLE Sales ADD COLUMN month_name varchar(12); 
UPDATE Sales 
SET month_name = MONTHNAME(date); 
SELECT * FROM Sales; 

    
# ***************************************** GENERIC QUESTIONS  **************************************** 

# 1. How many unique cities does the data have?     
SELECT  
DISTINCT city 
from sales;    

#2.  In which city is each branch? 
SELECT  
DISTINCT city, 
branch 
FROM sales;   


# ***************************************** Product Analysis  **************************************** 

# 1. How many unique product lines does the data have?
SELECT  
COUNT(DISTINCT Product_line) 
FROM sales; 

# 2. What is the most selling product line     
SELECT  
SUM(quantity) AS qty, 
product_line 
FROM Sales   
GROUP BY product_line 
ORDER BY qty DESC;  

# 3.  What is the total revenue by month
select sum(total) as totalRevenue,
monthname(date) as month
from sales
group by month
Order BY totalRevenue DESC;


# 4. What month had the largest COGS? 
select Sum(cogs) as largestCogs,
month_name
from sales
group by month_name
Order BY largestCogs DESC;


# 5. What product line had the largest revenue? 
SELECT 
 product_line, 
 SUM(total) as total_revenue 
FROM sales 
GROUP BY product_line 
ORDER BY total_revenue DESC; 

#6. What is the city with the largest revenue?
SELECT 
 branch, 
 city, 
 SUM(total) AS total_revenue 
FROM sales 
GROUP BY city, branch  
ORDER BY total_revenue; 

Select * from sales;

# 7. What product line had the largest TAX? 
SELECT product_line, 
AVG(Tax) as avg_tax 
FROM sales 
GROUP BY product_line 
ORDER BY avg_tax DESC; 

# 8. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average  sales 
     
SELECT 
      product_line, 
      case 
           when AVG(quantity) > (SELECT AVG(quantity) FROM Sales) then "Good" 
           else "Bad" 
      end as remark    
from Sales      
group by product_line; 


# 9. Which branch sold more products than average product sold? 

select branch, 
sum(quantity) as Qty
from sales
group by branch
having sum(quantity) > (SELECT AVG(quantity) FROM Sales);

# 10. What is the most common product line by gender 
SELECT 
 gender, 
    product_line, 
    COUNT(gender) AS total_cnt 
FROM sales 
GROUP BY gender, product_line 
ORDER BY total_cnt DESC; 


# 11. What is the average rating of each product line 
SELECT 
product_line,
 ROUND(AVG(rating), 2) as avg_rating
FROM sales 
GROUP BY product_line 
ORDER BY avg_rating DESC;




# ************************ CUSTOMER ANALYSIS ***************************************************

#1. How many unique customer types does the data have? 

SELECT 
DISTINCT customer_type Type 
FROM sales; 


# 2. How many unique payment methods does the data have? 
SELECT  
DISTINCT payment 
FROM Sales;    


# 3.  Which customer type buys the most? 
SELECT 
customer_type, 
COUNT(*) 
FROM sales 
GROUP BY customer_type;


# 4. What is the gender of most of the customers? 
 
SELECT 
 gender, 
 COUNT(*) as gender_cnt 
FROM sales 
GROUP BY gender 
ORDER BY gender_cnt DESC;


# 5.  What is the gender distribution per branch? 
SELECT 
 branch, gender,
 COUNT(gender) as gender_cnt 
FROM sales 
GROUP BY branch, gender
ORDER BY gender_cnt DESC;


# 6. Which time of the day do customers give most ratings? 

SELECT time_of_day, 
AVG(rating) AS avg_rating 
FROM sales 
GROUP BY time_of_day 
ORDER BY avg_rating DESC;


# 7. Which time of the day do customers give most ratings per branch?   
SELECT 
    time_of_day, 
    branch, 
    AVG(rating) AS avg_rating 
FROM sales 
WHERE branch IN (select branch from sales)
GROUP BY time_of_day, branch 
ORDER BY avg_rating DESC; 


# 8. Which day fo the week has the best avg ratings?
SELECT 
 day_name, 
 AVG(rating) AS avg_rating 
FROM sales 
GROUP BY day_name  
ORDER BY avg_rating DESC; 


# 9. Which day of the week has the best average ratings per branch? 
 
SELECT  
 day_name, 
 branch, 
 Avg(rating) as ARB 
FROM sales 
WHERE branch in (select branch from sales) 
GROUP BY day_name, branch 
ORDER BY ARB DESC;



# ***************************************** SALES ANALYSIS **************************************** 

# 1. Number of sales made in each time of the day per  weekday  
SELECT 
 time_of_day, day_name,
 count(invoice) AS total_sales 
FROM sales 
WHERE day_name Not In ("Saturday", "Sunday")
GROUP BY time_of_day, day_name  
ORDER BY total_sales DESC; 

# 2. Which of the customer types brings the most revenue? 
 
SELECT 
 customer_type, 
 SUM(total) AS total_revenue 
FROM sales 
GROUP BY customer_type 
ORDER BY total_revenue;

# 3.  Which city has the largest tax/VAT percent? 
SELECT 
city, 
ROUND(AVG(tax), 2) AS avg_tax_pct 
FROM sales 
GROUP BY city  
ORDER BY avg_tax_pct DESC;


# 4. Which customer type pays the most in VAT? 
 
SELECT 
customer_type, 
AVG(tax) AS total_tax 
FROM sales 
GROUP BY customer_type 
ORDER BY total_tax; 












