--KPI QUERIES

SELECT * 
FROM pizza_sales

--Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

--Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value
FROM pizza_sales

--total pizza sold
SELECT SUM(quantity) as total_pizza_sold
FROM pizza_sales

--total orders
SELECT COUNT(DISTINCT order_id) as total_order
FROM pizza_sales

--Avg Pizza Per Order
SELECT CAST((SUM(quantity) / COUNT(DISTINCT order_id)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order
FROM pizza_sales