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
GROUP BY ord.order_id , customer_name , cus.city , cus.state , ord.order_date , prod.product_name , cat.category_name , sto.store_name , staff_name , brd.brand_name
