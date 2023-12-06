-- Заполнение таблицы analysis.tmp_rfm_recency
INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
SELECT
    o.user_id,
    CASE
        WHEN DATE_PART('day', CURRENT_DATE - MAX(o.order_ts)) <= 30 THEN 5
        WHEN DATE_PART('day', CURRENT_DATE - MAX(o.order_ts)) <= 60 THEN 4
        WHEN DATE_PART('day', CURRENT_DATE - MAX(o.order_ts)) <= 90 THEN 3
        WHEN DATE_PART('day', CURRENT_DATE - MAX(o.order_ts)) <= 180 THEN 2
        ELSE 1
    END AS recency
FROM analysis.Orders o
GROUP BY o.user_id;

-- Заполнение таблицы analysis.tmp_rfm_frequency
INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency)
SELECT
    u.id AS user_id, -- Используем поле "id" из таблицы "users" в схеме "production"
    COUNT(DISTINCT o.order_id) AS frequency
FROM production.users u -- Обращаемся к таблице "users" в схеме "production"
LEFT JOIN production.orders o ON u.id = o.user_id -- Обращаемся к таблице "orders" в схеме "production"
GROUP BY u.id
HAVING COUNT(DISTINCT o.order_id) >= 1 AND COUNT(DISTINCT o.order_id) <= 5; -- Ограничение по частоте

-- Заполнение таблицы analysis.tmp_rfm_monetary_value
INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value)
SELECT
    u.id AS user_id,
    CASE
        WHEN SUM(oi.price * oi.quantity) <= 10000 THEN 1
        WHEN SUM(oi.price * oi.quantity) <= 20000 THEN 2
        WHEN SUM(oi.price * oi.quantity) <= 30000 THEN 3
        WHEN SUM(oi.price * oi.quantity) <= 40000 THEN 4
        ELSE 5
    END AS monetary_value
FROM production.users u
LEFT JOIN production.orders o ON u.id = o.user_id
LEFT JOIN production.orderitems oi ON o.order_id = oi.order_id
GROUP BY u.id;

-- Заполнение витрины analysis.dm_rfm_segments
INSERT INTO analysis.dm_rfm_segments (user_id, recency, frequency, monetary_value)
SELECT
    r.user_id,
    r.recency,
    f.frequency,
    m.monetary_value
FROM analysis.tmp_rfm_recency r
JOIN analysis.tmp_rfm_frequency f ON r.user_id = f.user_id
JOIN analysis.tmp_rfm_monetary_value m ON r.user_id = m.user_id;


-- Первые десять строк из таблицы analysis.dm_rfm_segments отсортированные по user_id.

user_id | recency | frequency |monetary_value

  71	   1	     5	          2
  74	   1	     5	          2
  109	   1	     5	          2
  127	   1	     5	          2
  128	   1	     5	          2
  159	   1	     5	          1
  166	   1	     5	          2
  172	   1	     5	          1
  211	   1	     3	          1
  224	   1	     4	          1
