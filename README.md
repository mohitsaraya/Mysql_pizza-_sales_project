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

pizzasTable

pizza_id: Primary key, unique identifier for each pizza.
pizza_type: Foreign key referencing the pizza_type table.
size: Size of the pizza (e.g., small, medium, large).
price: Price of the pizza
