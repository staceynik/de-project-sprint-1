CREATE OR REPLACE VIEW analysis.Orders AS
SELECT
    o.order_id,
    o.order_ts,
    o.user_id,
    o.bonus_payment,
    o.cost,
    osl.status_id AS order_status,
    o.bonus_grant,
    o.status
FROM
    production.Orders o
LEFT JOIN (
    SELECT
        os1.order_id,
        os1.status_id,
        ROW_NUMBER() OVER (PARTITION BY os1.order_id ORDER BY os1.dttm DESC) AS rn
    FROM
        production.OrderStatusLog os1
) osl ON o.order_id = osl.order_id AND osl.rn = 1;
