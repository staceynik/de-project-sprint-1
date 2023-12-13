CREATE TABLE analysis.tmp_rfm_frequency (
    user_id INT NOT NULL PRIMARY KEY,
    frequency INT NOT NULL CHECK (frequency >= 1 AND frequency <= 5)
);

INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency)
SELECT
    u.id AS user_id,
    NTILE(5) OVER (ORDER BY COUNT(DISTINCT o.order_id)) AS frequency
FROM production.users u
LEFT JOIN production.orders o ON u.id = o.user_id
JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
JOIN production.OrderStatuses os ON osl.status_id = os.id
WHERE os.key = 'Closed'
GROUP BY u.id
HAVING COUNT(DISTINCT o.order_id) >= 1 AND COUNT(DISTINCT o.order_id) <= 5;
