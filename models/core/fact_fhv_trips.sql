{{ config(materialized="table") }}

with fhv_trips as (
   select
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    pulocationid,
    dolocationid,
    sr_flag,
    affiliated_base_number
   from {{ ref('stg_fhv_tripdata') }}
),

dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    dispatching_base_num,
    pickup_datetime,
    pulocationid,
    dolocationid,
    sr_flag,
    affiliated_base_number
    pickup_zone
from fhv_trips
inner join dim_zones as pickup_zone
on fhv_trips.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_trips.dolocationid = dropoff_zone.locationid