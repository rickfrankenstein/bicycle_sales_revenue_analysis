# Three-Year (2016-2018) Sales/Revenue Report of Wheels-N-More Bicycle Company

## 1. Introduction

### 1.1 Project Overview
This report provides a comprehensive analysis of the sales data over the past three years for Wheels-N-More, a bicycle-selling company. The objective is to identify key trends, performance metrics, and actionable insights to inform business strategies.

### 1.2 Purpose of the Report
The primary goals of this analysis are to:
- Understand sales performance over the three years.
- Identify top-performing products, categories, and brands.
- Analyze customer demographics and purchasing behavior.
- Evaluate store and staff performance.
- Provide recommendations based on the findings.

## 2. Data Model Description

### 2.1 Entities and Relationships
- **Categories**: `category_id`, `category_name`
- **Stores**: `store_id`, `store_name`, `phone`, `email`, `street`, `city`, `state`, `zip_code`
- **Staffs**: `staff_id`, `first_name`, `last_name`, `email`, `phone`, `active`, `store_id`, `manager_id`
- **Orders**: `order_id`, `customer_id`, `order_status`, `order_date`, `required_date`, `shipped_date`, `store_id`, `staff_id`
- **Order Items**: `order_id`, `item_id`, `product_id`, `quantity`, `list_price`, `discount`
- **Products**: `product_id`, `product_name`, `brand_id`, `category_id`, `model_year`, `list_price`
- **Customers**: `customer_id`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `state`, `zip_code`
- **Brands**: `brand_id`, `brand_name`
- **Stocks**: `store_id`, `product_id`, `quantity`

### 2.2 Relationships Between Entities
- **One-to-Many Relationships**:
  - Each category can have multiple products.
  - Each store can have multiple staffs.
  - Each customer can have multiple orders.
  - Each order can have multiple order items.
  - Each product can be in multiple order items.
  - Each store can stock multiple products.
- **Many-to-One Relationships**:
  - Each product belongs to one category.
  - Each product is associated with one brand.
  - Each order is associated with one store and one staff member.

## 3. Data Analysis Methodology

### 3.1 Data Collection
The data was collected from the sales database, which records details of sales transactions, customer information, product inventory, and staff activities over the past three years.

**Data retrieval query**:
```sql
SELECT 
    ord.order_id,
    CONCAT(cus.first_name, ' ', cus.last_name) AS customer_name,
    cus.city,
    cus.state,
    ord.order_date,
    SUM(ordit.quantity) AS total_units,
    SUM(ordit.quantity * ordit.list_price) AS total_revenue,
    prod.product_name,
    cat.category_name,
    sto.store_name,
    CONCAT(sta.first_name, ' ', sta.last_name) AS staff_name,
    brd.brand_name
FROM
    sales.orders ord
        INNER JOIN
    sales.customers cus ON ord.customer_id = cus.customer_id
        INNER JOIN
    sales.order_items ordit ON ord.order_id = ordit.order_id
        INNER JOIN
    production.products prod ON ordit.product_id = prod.product_id
        INNER JOIN
    production.categories cat ON prod.category_id = cat.category_id
        INNER JOIN
    sales.stores sto ON ord.store_id = sto.store_id
        INNER JOIN
    sales.staffs sta ON ord.staff_id = sta.staff_id
        INNER JOIN
    production.brands brd ON prod.brand_id = brd.brand_id
GROUP BY ord.order_id, customer_name, cus.city, cus.state, ord.order_date, prod.product_name, cat.category_name, sto.store_name, staff_name, brd.brand_name;
