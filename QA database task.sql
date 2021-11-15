-- 0) create database and connect it;
create database customer;

-- можно запустить полностью, можно по одному запросу по очереди, тут уж как захотите)
begin transaction;
-- 1) create tables
create table customer
(
    id    integer primary key,
    name  varchar not null,
    phone varchar not null unique
);
create table orders
(
    id    integer primary key,
    name  varchar not null,
    price integer not null
);
create table customer_orders
(
    customer_id integer references customer (id),
    order_id    integer references orders (id)
);

-- 2) insert values
insert into orders
values (1, 'Apple', 12),
       (2, 'Banana', 34),
       (3, 'Orange', 25),
       (4, 'Milk', 40);
insert into customer
values (1, 'John Connor', '88005553535'),
       (2, 'Rembo', '88008761595'),
       (3, 'Batman', '88006218934'),
       (4, 'Dude', '89124687912');
insert into customer_orders
values (1, 1),
       (1, 2),
       (1, 3),
       (2, 4),
       (2, 3),
       (3, 1),
       (4, 1),
       (4, 4);
end;

-- 3) task: 
--     find customer's name, customer's phone and orders sum of all his orders and sort it's by sum (from biggest sum to smallest sum)
--     найти имя клиента, телефон клиента и сумму заказов по всем его заказам и отсортировать их по сумме (от самой большой суммы до самой маленькой суммы)


--
select customer.name, customer.phone, sum(orders.price) as sum
from customer_orders
join customer on costomer.id = customer_orders.customer_id
join orders on orders.id = customer_orders.order_id
group by customer.name, customer.phone
order by sum desc;

--    name     |    phone    | sum
---------------+-------------+-----
-- John Connor | 88005553535 |  71
-- Rembo       | 88008761595 |  65
-- Dude        | 89124687912 |  52
-- Batman      | 88006218934 |  12
