CREATE TABLE analysis.tmp_rfm_monetary_value (
    user_id INT NOT NULL PRIMARY KEY,
    monetary_value INT NOT NULL CHECK (monetary_value >= 1 AND monetary_value <= 5)
);

INSERT INTO analysis.tmp_rfm_monetary_value (user_id, monetary_value)
SELECT
    u.id AS user_id,
    CASE
        WHEN total_amount IS NULL THEN 1
        ELSE NTILE(5) OVER (ORDER BY total_amount)
    END AS monetary_value
FROM analysis.Users u
LEFT JOIN (
    SELECT
        o.user_id,
        SUM(oi.price * oi.quantity) AS total_amount
    FROM analysis.Orders o
    LEFT JOIN analysis.OrderItems oi ON o.order_id = oi.order_id
    LEFT JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
    LEFT JOIN analysis.OrderStatuses os ON osl.status_id = os.id
    WHERE os.key = 'Closed' OR os.key IS NULL
    GROUP BY o.user_id
) filtered_orders ON u.id = filtered_orders.user_id;
