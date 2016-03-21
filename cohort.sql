응용문제 1 - 3월21일

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
각각의 cohort에 포함된 유저 수를 구한다(cohort size)

# 2단계
# 각각의 cohort에 포함된 유저 수를 구한다(cohort size)
# Cohort Size
# RPU를 구하기 위해 코호트 사이즈를 구하는 것이다.

DROP TEMPORARY TABLE IF EXISTS cohort_size;
CREATE TEMPORARY TABLE cohort_size

SELECT
	LEFT(first_time, 7) Month,
	COUNT(*) num
	
FROM
	first_rental
	
GROUP BY 1
;

[3단계- A버전(WHERE/AND)]

#3단계
#각각의 cohort, 월에 대해서 매출을 구한다.

SELECT
	r.*,
	LEFT(fr.first_time,7) cohort,
	p.amount
	
FROM
	rental r,
	first_rental fr,
	cohort_size cs,
	payment p
	
WHERE
	r.customer_id=fr.customer_id
	AND cs.month = LEFT(fr.first_time,7)
	AND p.rental_id = r.rental_id
;

↓↓↓
↓↓↓

[3단계- B버전(JOIN/ON)]
# WHREE은 너무 느려져서! JOIN으로 변경

SELECT
    r.*,
    LEFT(fr .first_time, 7) cohort,
    p.amount

FROM
    rental r
    JOIN  first_rental fr
    ON    r .customer_id= fr.customer_id

    JOIN  cohort_size cs
    ON    cs .month = LEFT(fr .first_time, 7)

    JOIN  payment p
    ON    p .rental_id = r.rental_id
;

