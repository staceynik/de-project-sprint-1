## Data Quality Assessment of the Source Data

When analyzing the data in the 'production' schema, the following data quality aspects were identified:

- Completeness: All mandatory fields are filled, except for the 'name' field in the production.users table.
- Timeliness: The fields order_ts and dttm are of the timestamp type, which ensures their relevance.
- Accuracy: The fields price and cost use the numeric type, which ensures data accuracy.
- Consistency: The production.orderstatuslog and production.orderitems tables include foreign keys, ensuring data integrity.
- Uniqueness: In the production.users table, the id field uses a primary key, ensuring data uniqueness.

Overall, the data quality in the 'production' schema is good. However, to ensure completeness, the 'name' field in the production.users table should be filled in for all users.

## Data Quality Assurance Tools in the Source

| Tables                        | Object            | Tool                           | Purpose                                 |
| ----------------------------- | ----------------- | ------------------------------ | --------------------------------------- |
| `production.users`            | id int            | NOT NULL PRIMARY KEY constraint | Ensures the presence of unique ids      |
| `production.users`            | login varchar     | NOT NULL constraint             | Ensures the presence of login           |
| `production.users`            | name varchar      |                                |                                         |
| `production.orders`           | order_id int      | NOT NULL constraint             | Ensures the presence of order_id        |
| `production.orders`           | order_ts timestamp| NOT NULL constraint             | Ensures the presence of order_ts        |
| `production.orders`           | user_id int       | NOT NULL constraint             | Ensures the presence of user_id         |
| `production.orders`           | bonus_payment num | NOT NULL constraint             | Ensures the presence of bonus_payment   |
| `production.orders`           | cost num          | NOT NULL constraint             | Ensures the presence of cost            |
| `production.orders`           | bonus_grant num   | NOT NULL constraint             | Ensures the presence of bonus_grant     |
| `production.orders`           | status int        | NOT NULL constraint             | Ensures the presence of status          |
| `production.products`         | id int            | NOT NULL constraint             | Ensures the presence of id              |
| `production.products`         | name varchar      | NOT NULL constraint             | Ensures the presence of name            |
| `production.products`         | price num         | NOT NULL constraint             | Ensures the presence of price           |
| `production.orderitems`       | id int            | NOT NULL constraint             | Ensures the presence of id              |
| `production.orderitems`       | product_id int    | NOT NULL FOREIGN KEY constraint | Ensures the presence of unique product_id |
| `production.orderitems`       | order_id int      | NOT NULL FOREIGN KEY constraint | Ensures the presence of unique order_id |
| `production.orderitems`       | name varchar      | NOT NULL constraint             | Ensures the presence of name            |
| `production.orderitems`       | price num         | NOT NULL constraint             | Ensures the presence of price           |
| `production.orderitems`       | discount num      | NOT NULL constraint             | Ensures the presence of discount        |
| `production.orderitems`       | quantity int      | NOT NULL constraint             | Ensures the presence of quantity        |
| `production.orderstatuslog`   | id int            | NOT NULL constraint             | Ensures the presence of id              |
| `production.orderstatuslog`   | order_id int      | NOT NULL FOREIGN KEY constraint | Ensures the presence of unique order_id |
| `production.orderstatuslog`   | status_id int     | NOT NULL FOREIGN KEY constraint | Ensures the presence of unique status_id|
| `production.orderstatuslog`   | dttm timestamp    | NOT NULL constraint             | Ensures the presence of dttm            |
| `production.orderstatuses`    | id int            | NOT NULL constraint             | Ensures the presence of id              |
| `production.orderstatuses`    | key varchar       | NOT NULL constraint             | Ensures the presence of key             |
