-- ___________________________________--- Basic: ________________________________________________
                            
-- Retrieve the total number of orders placed.
SELECT 
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(quantity * price), 0) AS Revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price AS highest_price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.quantity) As qty
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id group by 1 order by 2 desc limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(quantity) AS QTY
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- ______________________________________________Intermediate:_____________________________________________________________
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category, SUM(order_details.quantity) AS QTY
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY 1;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time), COUNT(quantity)
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY 1;
-- OR
SELECT 
    HOUR(order_time) as Hour, COUNT(order_id) As Orders 
FROM
    orders
GROUP BY 1;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(orders.order_id) as orders
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY 1;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select order_date, count(order_id) as orders from orders group by 1;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(price * order_details.quantity) AS revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;


-- ------------------------------------------------------Advanced:--------------------------------------------------
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    ROUND(ROUND(SUM(price * order_details.quantity), 0) / (SELECT 
                    ROUND(SUM(quantity * price), 0) AS Revenue
                FROM
                    pizzas
                        JOIN
                    order_details ON pizzas.pizza_id = order_details.pizza_id) * 100) AS revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- Analyze the cumulative revenue generated over time.

select order_date ,
round(sum(revenue) over (order by order_date ),0) as cum_rev
from(
select orders.order_date,
sum(order_details.quantity*pizzas.price) as revenue
from order_details join pizzas 
on pizzas.pizza_id  = order_details.pizza_id
join orders 
on orders.order_id = order_details.order_id group by orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category,name,revenue
from
(
SELECT
category,name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(
SELECT 
    category,
    name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1 , 2
ORDER BY 3 DESC) as rev ) as b where rn <=3;


