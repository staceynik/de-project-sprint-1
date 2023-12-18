CREATE TABLE analysis.tmp_rfm_frequency (
    user_id INT NOT NULL PRIMARY KEY,
    frequency INT NOT NULL CHECK (frequency >= 1 AND frequency <= 5)
);

INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency)
SELECT
    u.id AS user_id,
    CASE
        WHEN order_count IS NULL THEN 1
        ELSE NTILE(5) OVER (ORDER BY order_count)
    END AS frequency
FROM analysis.Users u
LEFT JOIN (
    SELECT
        o.user_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM analysis.Orders o
    LEFT JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
    LEFT JOIN analysis.OrderStatuses os ON osl.status_id = os.id
    WHERE os.key = 'Closed' OR os.key IS NULL
    GROUP BY o.user_id
) filtered_orders ON u.id = filtered_orders.user_id;
