-- Session 01 — SQL Timed Practice
-- Olist E-commerce Dataset (PostgreSQL)
-- 60 minutes, 20 exercises

-- 1
select distinct
	customer_state
from
	customers;

-- 2 FAIL (initial attempt had WHERE before FROM — fixed below)
select distinct
	customer_city
from
	customers
where
	customer_state = 'SP';

-- 3
select
 	customer_id,
	customer_city
from
	customers
order by 
	customer_city asc limit 10;

-- 4
select
	customer_id
from
	customers
where customer_city like 'rio%';

-- 5
select 
	customer_id
from
	customers
where customer_city like '%santo%';

-- 6
select
	customer_id
from
	customers
where
	customer_state not in('SP', 'RJ', 'MG');

-- 7
select
	customer_id,
	customer_city,
	customer_zip_code_prefix
from
	customers
where customer_city in('SP', 'RJ') and customer_zip_code_prefix > 20000;

-- 8
select
	count(distinct customer_state)
from
 	customers;

-- 9
select
	customer_id,
	customer_zip_code_prefix
from
	customers
where
	customer_zip_code_prefix between 10000 and 20000;

-- 10
select
	customer_id,
	customer_city,
	customer_state
from
 	customers
where
	 customer_city like '%polis';

-- 11
select distinct
	order_status
from
 	orders;

-- 12
select
	order_id,
	order_status
from orders
where
	order_status = 'delivered'
		and
			order_purchase_timestamp > '2018-01-01';

-- 13
select
	order_id,
	order_status
from
	orders
where
	order_status not in('delivered', 'shipped');

-- 14
select
	order_id,
	order_purchase_timestamp
from
	orders
where
	order_purchase_timestamp between '2017-06-01' and '2017-06-30';

-- 15
select
	order_id,
	order_delivered_customer_date
from
	orders
where
	order_delivered_customer_date is NULL
	and
	order_status = 'delivered';

-- 16
select
	order_id,
	order_purchase_timestamp
from
	orders
order by order_purchase_timestamp desc limit 10;

-- 17
select
	order_id,
	order_delivered_customer_date,
	order_estimated_delivery_date
from
	orders
where order_delivered_customer_date > order_estimated_delivery_date;

-- 18 (! used ai help !)
select distinct
	order_status,
	count(order_id) as order_count
from
	orders
group by order_status
order by order_count desc;

-- 19
select
	order_status,
	count(order_id) as order_numbers
from
	orders
group by order_status
having count(order_id) > 500;

-- 20
select 
 	order_id,
	order_purchase_timestamp,
	order_approved_at
from
	orders
where order_purchase_timestamp::date = order_approved_at::date;
