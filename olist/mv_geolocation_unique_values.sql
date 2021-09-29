-- drop materialized view mv_geo_unique_values;
create materialized view mv_geo_unique_values as
select o.geolocation_zip_code_prefix
      ,o.geolocation_lat
      ,o.geolocation_lng
      ,geolocation_city
      ,geolocation_state
      ,'BR' geolocation_country
  from (select geolocation_zip_code_prefix
              ,avg(geolocation_lat) geolocation_lat
              ,avg(geolocation_lng) geolocation_lng
          from public.geolocation
         where geolocation_lat <= 5.27438888
           and geolocation_lat >= -33.75116944
           and geolocation_lng <= -34.79314722
           and geolocation_lng >= -73.98283055
         group by 1
        ) o
  left join
       (select geolocation_zip_code_prefix
              ,last_value(geolocation_city) over(partition by geolocation_zip_code_prefix) as geolocation_city
              ,last_value(geolocation_state) over(partition by geolocation_zip_code_prefix) as geolocation_state
              ,row_number() over(partition by geolocation_zip_code_prefix) as row
          from public.geolocation
         where geolocation_lat <= 5.27438888
           and geolocation_lat >= -33.75116944
           and geolocation_lng <= -34.79314722
           and geolocation_lng >= -73.98283055
        ) p
    on o.geolocation_zip_code_prefix = p.geolocation_zip_code_prefix
   and p.row = 1