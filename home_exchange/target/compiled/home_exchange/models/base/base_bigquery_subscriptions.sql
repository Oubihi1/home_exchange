with source as (
      select * from `mywagon-445720`.`home_exchange`.`subscriptions`
),
renamed as (
    select
        `subscription_date`,
        `user_id`,
        `renew`,
        `first_subscription_date`,
        `first_subscription`,
        `referral`,
        `promotion`,
        `payment3x`,
        `payment2`,
        `payment3`,
        `country`,
        `region`,
        `department`,
        `city`

    from source
)
select * from renamed