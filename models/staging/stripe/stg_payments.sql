select
    orderid as order_id,
    created as order_date,
    paymentmethod as payment_type,
    amount / 100 as amount
from {{ source('stripe', 'payment') }}
where status = 'success'
