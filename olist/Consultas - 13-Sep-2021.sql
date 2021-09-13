-- DataSet → Olist
------------------------------------------------------------------------------------------------------------
-- Muestre un conteo de ordenes segmentado por estado, mes y año
------------------------------------------------------------------------------------------------------------
select order_status
      ,date_trunc('month', order_purchase_timestamp) as date
      ,count(distinct order_id) as count
      ,count(*)
  from public.orders
 group by 1, 2
 order by 1, 2;

------------------------------------------------------------------------------------------------------------
-- Muestre la calificación promedio de las ordenes canceladas
------------------------------------------------------------------------------------------------------------
select avg(r.review_score)
  from public.orders o
  join public.order_reviews r
    on r.order_id = o.order_id
 where o.order_status = 'canceled';

------------------------------------------------------------------------------------------------------------
-- Numero de clientes que han hecho por lo menos una compra
------------------------------------------------------------------------------------------------------------
select count(distinct customer_id)
  from customers c
  left join public.orders o using(customer_id)
 where o.customer_id is not null
   and o.order_status not in ('canceled');

------------------------------------------------------------------------------------------------------------
-- Muestre el top 5 categorias con más productos vendidos
------------------------------------------------------------------------------------------------------------
select product_category_name
      ,count(product_category_name)
  from products p
 inner join order_items oi
    on p.product_id = oi.product_id
 inner join orders o
    on oi.order_id = o.order_id
 where o.order_status = 'delivered'
 group by p.product_category_name
 order by 2 desc
 limit 5;

select product_category_name
      ,count(product_category_name)
  from product_category pc 
  join products p using(product_category_name)
 group by product_category_name
 order by 2 desc
 fetch first 5 rows only;

select product_category_name
      ,count(product_category_name) 
  from order_items oi inner join products p on oi.product_id = p.product_id
 group by product_category_name 
 order by 2 desc
 limit 5;

select product_category_name
      ,count(o.order_id) 
  from products p, order_items oi, orders o
 where p.product_id = oi.product_id
   and o.order_id = oi.order_id
   and o.order_status = 'delivered'
 group by 1, order_status
 order by 2 desc
 limit 5;

select product_category_name , count(product_category_name) 
  from products prod 
  join order_items ord_i using (product_id)
  join orders ord using(order_id)
 where ord.order_status in ( 'delivered')
 group by product_category_name
 order by 2 desc
 limit 5;

select p.product_category_name as "category"
      ,count(distinct p.product_id) as "amount"
  from order_items i
  join orders o using (order_id)
  join products p on (i.product_id = p.product_id)
 where o.order_status = 'delivered'
 group by p.product_category_name
 order by "amount" desc
 limit 5;

select product_category_name_english
      ,sum(total_price) as total_price
      ,sum(units) as units
  from (select oi.product_id
              ,sum(oi.price) as total_price
              ,count(oi.order_item_id) as units
          from public.orders o
          left join order_items oi using(order_id)
         where o.order_status = 'delivered'
         group by 1
        ) o
  left join products p using(product_id)
  left join product_category c using(product_category_name)
 where p.product_category_name is not null
 group by 1
 order by 3 desc
 limit 5;

------------------------------------------------------------------------------------------------------------
-- ¿Qué categoría de productos tiene la mayor cantidad de ordenes canceladas?
------------------------------------------------------------------------------------------------------------
select product_category_name_english as category_name
      ,count(distinct o.order_id) as canceled_order_count
  from public.orders o
  left join order_items oi using(order_id)
  left join products p using(product_id)
  left join product_category c using(product_category_name)
 where o.order_status = 'canceled'
   and c.product_category_name is not null
 group by 1
 order by 2 desc
 limit 1;