{{ config(materialized='view') }}

select
    *
from {{ source("staging", "fhv_tripdata") }}

{% if var("is_test_run", default=true) %}

    limit 100

{% endif %}