CREATE TABLE analysis.tmp_rfm_recency (
    user_id INT NOT NULL PRIMARY KEY,
    recency INT NOT NULL CHECK (recency >= 1 AND recency <= 5)
);

INSERT INTO analysis.tmp_rfm_recency (user_id, recency)
SELECT
    o.user_id,
    NTILE(5) OVER (ORDER BY CURRENT_DATE - MAX(o.order_ts)) AS recency
FROM analysis.Orders o
GROUP BY o.user_id;
