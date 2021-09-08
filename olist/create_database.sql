/*
 * Se define la estructura general de la BD
 * →→→→→→→→→→→→→→→ Se debe ajustar la ubicación del tablespace ←←←←←←←←←←←←←←←
 */
create tablespace olist 
    owner postgres 
    location 'D:\PostgreSQL\olist';

alter tablespace olist 
    owner to postgres;

create database olist
    with
    tablespace = olist
    owner = postgres
    encoding = 'UTF8'
    connection limit = -1;

/*
 * Se crean las tablas en las que será cargada la información de la BD
 */
create table customers (
    customer_id varchar(32) primary key
   ,customer_unique_id varchar(32) null
   ,customer_zip_code_prefix int null
   ,customer_city varchar(40) null
   ,customer_state varchar(2) null
);

create table geolocation (
    geolocation_zip_code_prefix int null
   ,geolocation_lat float null
   ,geolocation_lng float null
   ,geolocation_city varchar(40) null
   ,geolocation_state varchar(2)
);

create table order_items (
    order_id varchar(32)
   ,order_item_id int null
   ,product_id varchar(32) null
   ,seller_id varchar(32) null
   ,shipping_limit_date timestamp null
   ,price float null
   ,freight_value float null
   ,primary key (order_id, order_item_id)
);

create table order_payments (
    order_id varchar(32) null
   ,payment_sequential int null
   ,payment_type varchar(15) null
   ,payment_installments int null
   ,payment_value float null
   ,primary key (order_id, payment_sequential)
);

create table order_reviews (
    review_id varchar(32)
   ,order_id varchar(32) null
   ,review_score int null
   ,review_comment_title varchar(32) null
   ,review_comment_message varchar(250) null
   ,review_creation_date date null
   ,review_answer_timestamp timestamp null
   ,primary key (review_id, order_id)
);

create table orders (
    order_id varchar(32) primary key
   ,customer_id varchar(32) null
   ,order_status varchar(15) null
   ,order_purchase_timestamp timestamp null
   ,order_approved_at timestamp null
   ,order_delivered_carrier_date timestamp null
   ,order_delivered_customer_date timestamp null
   ,order_estimated_delivery_date date null
);

create table products (
    product_id varchar(32) primary key
   ,product_category_name varchar(50) null
   ,product_name_lenght int null
   ,product_description_lenght int null
   ,product_photos_qty int null
   ,product_weight_g int null
   ,product_length_cm int null
   ,product_height_cm int null
   ,product_width_cm int null
);

create table sellers (
    seller_id varchar(32) primary key
   ,seller_zip_code_prefix int null
   ,seller_city varchar(40) null
   ,seller_state varchar(2) null
);
  
create table product_category (
    product_category_name varchar(50) primary key
   ,product_category_name_english varchar(50) null
);

/*
 * Se crean índices para optimizar los tiempos de lectura, entendiendo que es una solución de análitica
 */
create index geolocation_idx
    on geolocation(geolocation_zip_code_prefix);

create index orders_status_idx
    on orders(order_status);

create index orders_order_purchase_timestamp_status_idx
    on orders(order_purchase_timestamp, order_status);

create index orders_order_order_purchase_timestamp_idx
    on orders using brin (order_purchase_timestamp);
    
