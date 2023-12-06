DROP VIEW IF EXISTS analysis.Orders;
CREATE OR REPLACE VIEW analysis.Orders AS
SELECT
    o.order_id,
    o.order_ts,
    o.user_id,
    osl.status_id AS order_status,
    o.bonus_payment,
    o.cost,
    o.bonus_grant
FROM
    production.Orders o
LEFT JOIN LATERAL (
    SELECT
        os1.status_id
    FROM
        production.OrderStatusLog os1
    WHERE
        os1.order_id = o.order_id
    ORDER BY
        os1.dttm DESC
    LIMIT 1
) osl ON TRUE;
