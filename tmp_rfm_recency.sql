CREATE TABLE analysis.tmp_rfm_recency (
    user_id INT NOT NULL PRIMARY KEY,
    recency INT NOT NULL CHECK (recency >= 1 AND recency <= 5)
);

INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
SELECT
    u.id AS user_id,
    CASE
        WHEN max_order_ts IS NULL THEN 1
        ELSE NTILE(5) OVER (ORDER BY max_order_ts DESC)
    END AS recency
FROM analysis.Users u
LEFT JOIN (
    SELECT
        o.user_id,
        MAX(o.order_ts) AS max_order_ts
    FROM analysis.Orders o
    LEFT JOIN production.OrderStatusLog osl ON o.order_id = osl.order_id
    LEFT JOIN analysis.OrderStatuses os ON osl.status_id = os.id
    WHERE os.key = 'Closed' OR os.key IS NULL
    GROUP BY o.user_id
) filtered_orders ON u.id = filtered_orders.user_id;
