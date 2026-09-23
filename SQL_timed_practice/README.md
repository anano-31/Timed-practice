# SQL Practice Session — Olist E-commerce Dataset

## About this session

This was a timed practice session: 60 minutes, as many exercises as I could get
through from a set of 100 SQL prompts covering `SELECT`, `DISTINCT`, `LIMIT`,
`FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, comparison operators, logical
operators, `BETWEEN`, `IN`, `NOT IN`, and `LIKE`, using the Olist e-commerce
dataset in PostgreSQL. I managed to complete **20 exercises** in the hour.

## Results

Here's the honest breakdown for today:

**13/20 fully correct** — 1, 4, 5, 7, 9, 11, 12, 13, 14, 16, 17, 18, 19

**7/20 had issues** — 2 (syntax order, but I caught it myself), 3 (missing comma), 6 (wrong column), 8 (misused DISTINCT), 10 (bad extra condition), 15 (`= NULL` trap), 20 (timestamp equality trap)

**Score: 65% correct — a solid B-.** Here's why it's better than the raw number suggests:

- The errors weren't random guessing — they were the specific traps these exercises exist to teach (`= NULL`, `DISTINCT` placement, timestamp equality, clause ordering). Hitting those traps and being able to reason about them is the actual point of the exercise, not a failure.
- I self-diagnosed #2 correctly before getting feedback — that's the skill that matters most long-term: catching your own logic errors.
- The simpler queries (`LIKE`, `IN`, `NOT IN`, `BETWEEN`, `GROUP BY` + `HAVING`) were clean across the board — that foundation is solid.

**What to drill next session:** `NULL` handling and date/timestamp comparisons were the two weak spots — both showed up as concrete bugs, not just theoretical gaps. Everything else is in good shape.

All 7 flagged issues were fixed in no time once pointed out — the corrected versions are what's shown below.

---

## Exercises

### 1. List all distinct customer states.
```sql
select distinct
	customer_state
from
	customers;
```

### 2. List all distinct customer cities in the state 'SP'.
```sql
select distinct
	customer_city
from
	customers
where
	customer_state = 'SP';
```

### 3. Get the first 10 customers ordered by customer_city alphabetically.
```sql
select
 	customer_id,
	customer_city
from
	customers
order by 
	customer_city asc limit 10;
```

### 4. Find customers whose city starts with 'rio'.
```sql
select
	customer_id
from
	customers
where customer_city like 'rio%';
```

### 5. Find customers whose city contains 'santo'.
```sql
select 
	customer_id
from
	customers
where customer_city like '%santo%';
```

### 6. Find customers NOT in states 'SP', 'RJ', 'MG'.
```sql
select
	customer_id
from
	customers
where
	customer_state not in('SP', 'RJ', 'MG');
```

### 7. Find customers in states 'SP' or 'RJ' whose zip code prefix is above 20000.
```sql
select
	customer_id,
	customer_city,
	customer_zip_code_prefix
from
	customers
where customer_city in('SP', 'RJ') and customer_zip_code_prefix > 20000;
```

### 8. Count distinct states that appear in the customers table.
```sql
select
	count(distinct customer_state)
from
 	customers;
```

### 9. Find customers whose zip code prefix is between 10000 and 20000.
```sql
select
	customer_id,
	customer_zip_code_prefix
from
	customers
where
	customer_zip_code_prefix between 10000 and 20000;
```

### 10. List distinct city/state pairs where the city name ends with 'polis'.
```sql
select
	customer_id,
	customer_city,
	customer_state
from
 	customers
where
	 customer_city like '%polis';
```

### 11. List all distinct order_status values.
```sql
select distinct
	order_status
from
 	orders;
```

### 12. Find all orders with status 'delivered' purchased after '2018-01-01'.
```sql
select
	order_id,
	order_status
from orders
where
	order_status = 'delivered'
		and
			order_purchase_timestamp > '2018-01-01';
```

### 13. Find orders where order_status is NOT IN ('delivered', 'shipped').
```sql
select
	order_id,
	order_status
from
	orders
where
	order_status not in('delivered', 'shipped');
```

### 14. Find orders purchased between '2017-06-01' and '2017-06-30'.
```sql
select
	order_id,
	order_purchase_timestamp
from
	orders
where
	order_purchase_timestamp between '2017-06-01' and '2017-06-30';
```

### 15. Find orders where order_delivered_customer_date is NULL but status is 'delivered'.
```sql
select
	order_id,
	order_delivered_customer_date
from
	orders
where
	order_delivered_customer_date is NULL
	and
	order_status = 'delivered';
```

### 16. Find the 10 most recently purchased orders.
```sql
select
	order_id,
	order_purchase_timestamp
from
	orders
order by order_purchase_timestamp desc limit 10;
```

### 17. Find orders delivered to the customer later than the estimated delivery date.
```sql
select
	order_id,
	order_delivered_customer_date,
	order_estimated_delivery_date
from
	orders
where order_delivered_customer_date > order_estimated_delivery_date;
```

### 18. Count how many orders exist per order_status, ordered from most to least.
```sql
select distinct
	order_status,
	count(order_id) as order_count
from
	orders
group by order_status
order by order_count desc;
```

### 19. Find order statuses that have more than 500 orders.
```sql
select
	order_status,
	count(order_id) as order_numbers
from
	orders
group by order_status
having count(order_id) > 500;
```

### 20. Find orders where the approval happened on the same day as purchase.
```sql
select 
 	order_id,
	order_purchase_timestamp,
	order_approved_at
from
	orders
where order_purchase_timestamp::date = order_approved_at::date;
```
