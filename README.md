# Mysql_pizza_sales_project

Database Schema

Tables and Columns

order_details Table

order_details_id: Primary key, unique identifier for each order detail.
order_id: Foreign key referencing the orders table.
pizza_id: Foreign key referencing the pizzas table.
quantity: Number of pizzas in the order.

orders Table

order_id: Primary key, unique identifier for each order.
date: Date of the order.
time: Time of the order.

pizza_type Table

pizza_type: Primary key, unique identifier for each pizza type.
name: Name of the pizza.
category: Category of the pizza (e.g., vegetarian, non-vegetarian, vegan).
ingredients: List of ingredients used in the pizza.

pizzas Table

pizza_id: Primary key, unique identifier for each pizza.
pizza_type: Foreign key referencing the pizza_type table.
size: Size of the pizza (e.g., small, medium, large).
price: Price of the pizza

Following are the questions which we are going to solve.
Basic:
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.


Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.

Advanced:
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.
