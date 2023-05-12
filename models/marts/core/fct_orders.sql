with
    customers as (select * from {{ ref("stg_customers") }}),
    orders as (select * from {{ ref("stg_orders") }}),
    payments as (select * from {{ ref("stg_payments") }}),
    order_amount as (
        select orders.order_id, sum(payments.amount) as order_amount
        from orders
        left join payments on orders.order_id = payments.order_id
        group by 1
    ),
    final as (
        select customers.*, orders.order_id, order_amount.order_amount
        from customers
        left join orders
        left join
            order_amount
            on customers.customer_id = orders.customer_id
            and orders.order_id = order_amount.order_id
    )
select *
from final
