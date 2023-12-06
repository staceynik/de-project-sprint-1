CREATE OR REPLACE VIEW analysis.Users AS
SELECT * FROM production.users;

CREATE OR REPLACE VIEW analysis.OrderItems AS
SELECT * FROM production.orderitems;

CREATE OR REPLACE VIEW analysis.OrderStatuses AS
SELECT * FROM production.orderstatuses;

CREATE OR REPLACE VIEW analysis.Products AS
SELECT * FROM production.products;

CREATE OR REPLACE VIEW analysis.Orders AS
SELECT * FROM production.orders;
