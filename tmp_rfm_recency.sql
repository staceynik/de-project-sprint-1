CREATE TABLE analysis.tmp_rfm_recency (
    user_id INT NOT NULL PRIMARY KEY,
    recency INT NOT NULL CHECK (recency >= 1 AND recency <= 5)
);

INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
SELECT
    o.user_id,
    NTILE(5) OVER (ORDER BY MAX(o.order_ts) DESC) AS recency
FROM analysis.Orders o
JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
JOIN production.OrderStatuses os ON osl.status_id = os.id
WHERE os.key = 'Closed'
GROUP BY o.user_id;
