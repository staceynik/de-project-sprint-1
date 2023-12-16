CREATE TABLE analysis.tmp_rfm_recency (
    user_id INT NOT NULL PRIMARY KEY,
    recency INT NOT NULL CHECK (recency >= 1 AND recency <= 5)
);

INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
SELECT
    u.id AS user_id,
    COALESCE(NTILE(5) OVER (ORDER BY MAX(o.order_ts) DESC), 1) AS recency
FROM analysis.Users u
LEFT JOIN analysis.Orders o ON u.id = o.user_id
LEFT JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
LEFT JOIN analysis.OrderStatuses os ON osl.status_id = os.id
WHERE os.key = 'Closed' OR os.key IS NULL
GROUP BY u.id;
