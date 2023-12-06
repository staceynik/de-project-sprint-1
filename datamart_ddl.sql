CREATE TABLE analysis.datamart (
    order_id INT PRIMARY KEY,
    order_ts TIMESTAMP NOT NULL,
    user_id INT NOT NULL,
    user_login VARCHAR NOT NULL,
    user_name VARCHAR,
    bonus_payment NUMERIC NOT NULL,
    cost NUMERIC NOT NULL,
    bonus_grant NUMERIC NOT NULL,
    status INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR NOT NULL,
    product_price NUMERIC NOT NULL,
    order_item_id INT NOT NULL,
    order_item_name VARCHAR NOT NULL,
    order_item_price NUMERIC NOT NULL,
    discount NUMERIC NOT NULL,
    quantity INT NOT NULL
);
