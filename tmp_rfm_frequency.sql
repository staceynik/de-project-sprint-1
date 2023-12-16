CREATE TABLE analysis.tmp_rfm_frequency (
    user_id INT NOT NULL PRIMARY KEY,
    frequency INT NOT NULL CHECK (frequency >= 1 AND frequency <= 5)
);

INSERT INTO analysis.tmp_rfm_frequency (user_id, frequency)
SELECT
    u.id AS user_id,
    COALESCE(NTILE(5) OVER (ORDER BY COUNT(DISTINCT o.order_id)), 1) AS frequency
FROM analysis.Users u
LEFT JOIN analysis.Orders o ON u.id = o.user_id
LEFT JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
LEFT JOIN analysis.OrderStatuses os ON osl.status_id = os.id
WHERE os.key = 'Closed' OR os.key IS NULL
GROUP BY u.id;
