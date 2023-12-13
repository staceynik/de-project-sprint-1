CREATE TABLE analysis.tmp_rfm_monetary_value (
    user_id INT NOT NULL PRIMARY KEY,
    monetary_value INT NOT NULL CHECK (monetary_value >= 1 AND monetary_value <= 5)
);

INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value)
SELECT
    u.id AS user_id,
    NTILE(5) OVER (ORDER BY SUM(oi.price * oi.quantity)) AS monetary_value
FROM production.users u
LEFT JOIN production.orders o ON u.id = o.user_id
LEFT JOIN production.orderitems oi ON o.order_id = oi.order_id
JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
JOIN production.OrderStatuses os ON osl.status_id = os.id
WHERE os.key = 'Closed' 
GROUP BY u.id;
