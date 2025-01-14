

  create or replace view `mywagon-445720`.`home_exchange`.`monthy_sub`
  OPTIONS()
  as 

SELECT

DATE_TRUNC(subscription_date, MONTH) AS sub_month,
*
 FROM `mywagon-445720`.`home_exchange`.`stg_subscriptions`
 WHERE subscription_date between '2019-01-01' and '2021-12-31';

