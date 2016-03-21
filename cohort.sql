1) 유저를 첫번째 렌탈일 기준으로 나눈다(cohort)


[1단계]
#Customer's First Rental

DROP TEMPORARY TABLE IF EXISTS first_rental ;
CREATE TEMPORARY TABLE first_rental

SELECT
r.customer_id ,
MIN(r .rental_date) first_time

FROM
rental r

GROUP BY 1
;

SELECT *
FROM
first_rental
;

[2단계]


