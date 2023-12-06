# 1.3. Качество данных

## Оценка качества данных, хранимых в источнике.

При анализе данных в схеме 'production' были выявлены следующие аспекты качества данных:

    Полнота: все обязательные поля заполнены, за исключением поля name в таблице production.users.
    Актуальность: значения в полях order_ts и dttm имеют тип timestamp, что гарантирует их актуальность.
    Точность: в полях price и cost используется тип numeric, что обеспечивает точность данных.
    Консистентность: в таблицах production.orderstatuslog и production.orderitems присутствуют внешние ключи, что обеспечивает целостность данных.
    Уникальность: в таблице production.users в поле id используется первичный ключ, что дает уникальность данным.

В целом, качество данных в схеме 'production' является хорошим. Однако, для обеспечения полноты данных, поле name в таблице production.users должно быть заполнено для всех пользователей.

## Инструменты обеспечения качества данных в источнике.


| Таблицы                  | Объект              | Инструмент                     |        Для чего используется         |
| ----------------------   | --------------------| ---------------                | ------------------------------------ |
production.users            id int                Ограничение NOT NULL PRIMARY KEY Гарантирует начичие уникальных id
production.users	    login varchar         Ограничение NOT NULL	           Гарантирует наличие login
production.users	    name varchar
production.orders	    order_id int	  Ограничение NOT NULL             Гарантирует наличие order_id
production.orders	    order_ts timestamp	  Ограничение NOT NULL	           Гарантирует наличие order_ts
production.orders           user_id int           Ограничение NOT NULL             Гарантирует наличие user_id
production.orders           bonus_payment num     Ограничение NOT NULL             Гарантирует наличие bonus_payment
production.orders           cost num              Ограничение NOT NULL             Гарантирует наличие cost
production.orders           bonus_grant num       Ограничение NOT NULL             Гарантирует наличие bonus_grant
production.orders	    status int		  Ограничение NOT NULL             Гарантирует наличие status
production.products         id int                Ограничение NOT NULL             Гарантирует наличие id
production.products	    name varchar	  Ограничение NOT NULL	           Гарантирует наличие name
production.products	    price num		  Ограничение NOT NULL             Гарантирует наличие price
production.orderitems       id int                Ограничение NOT NULL             Гарантирует наличие id
production.orderitems	    product_id int        Ограничение NOT NULL FOREIGN KEY Гарантирует наличие уникальных product_id
production.orderitems	    order_id int	  Ограничение NOT NULL FOREIGN KEY Гарантирует наличие уникальных order_id
production.orderitems	    name varchar          Ограничение NOT NULL	 	   Гарантирует наличие name
production.orderitems	    price num	          Ограничение NOT NULL             Гарантирует наличие price	
production.orderitems	    discount num 	  Ограничение NOT NULL	           Гарантирует наличие discount
production.orderitems	    quantity int	  Ограничение NOT NULL	           Гарантирует наличие quantity
production.orderstatuslog   id int                Ограничение NOT NULL             Гарантирует наличие id
production.orderstatuslog   order_id int	  Ограничение NOT NULL FOREIGN KEY Гарантирует наличие уникальных order_id
production.orderstatuslog   status_id int	  Ограничение NOT NULL FOREIGN KEY Гарантирует наличие уникальных status_id
production.orderstatuslog   dttm timestamp	  Ограничение NOT NULL	           Гарантирует наличие dttm
production.orderstatuses    id int                Ограничение NOT NULL             Гарантирует наличие id
production.orderstatuses    key varchar           Ограничение NOT NULL             Гарантирует наличие key

