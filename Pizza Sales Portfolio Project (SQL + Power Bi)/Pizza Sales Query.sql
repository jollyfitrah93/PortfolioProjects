SELECT *
FROM pizza_sales

--Breakdown of the total number of orders for each day of the week in the specified quarter.
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY DATENAME(DW, order_date)

--change order time format then add the fixed column to the table after that drop the original
--SELECT FORMAT(order_time, 'HH:mm:ss') as order_time_fixed
--FROM pizza_sales

--ALTER TABLE pizza_sales, 
--ADD order_time_fixed TIME

--UPDATE pizza_sales
--SET order_time_fixed = CAST(order_time AS TIME)

--ALTER TABLE pizza_sales
--DROP COLUMN order_time

--Breakdown of the total number of distinct orders for each hour of the day based on the order_time_fixed column
SELECT DATEPART(HOUR, order_time_fixed) as order_hours, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
group by DATEPART(HOUR, order_time_fixed)
order by DATEPART(HOUR, order_time_fixed)

--Total Revenue and Percentage for pizza category
SELECT pizza_category, CAST(SUM(total_price) as DECIMAL (10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) as Percentage
FROM pizza_sales
GROUP BY pizza_category	

--Daily Trends For Total Order
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

--Monthly Trends For Orders
SELECT DATENAME(MONTH, order_date) as order_month, COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC

--Percentage of sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) as Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC

--Percentage of sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) as Percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC	

--Total Pizza Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as total_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_sold DESC

--Top 5 Pizza by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC

--Bottom 5 Pizza by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) as total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC

--Top 5 Pizza by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC

--Bottom 5 Pizza by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) as total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold ASC

--Top 5 Pizza by Total Order
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_order DESC

---Bottom 5 Pizza by Total Order
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as total_order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_order ASC


