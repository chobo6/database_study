CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);

select * from product_quiz;
-----------------------------------------------------------

select
    case
        when price < 10000 then '0'
        when price between 10000 and 19999 then '10000'
        when price between 10000 and 29999 then '20000'
        else '30000'
    end price_group,
    count(*) products
from product_quiz
group by
    case
        when price < 10000 then '0'
        when price between 10000 and 19999 then '10000'
        when price between 10000 and 29999 then '20000'
        else '30000'
    end
order by price_group;

-----------------------------------------------------------

--테이블 생성시, product_quiz 테이블명으로 생성

CREATE TABLE product_quiz
(
    product_id INTEGER NOT NULL,
    product_code VARCHAR(8) NOT NULL,
    price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);
---------

select * from product_quiz;

select count(*)
from product_quiz;  -- 1 3  1 1 

select price, count(*)
from product_quiz
group by price;



--1) 가격대 별로 나눠서 갯수 계산 -> 합치기
select 0 price_group, COUNT(*) products
from product_quiz
--where price BETWEEN 0 AND 9999;
where price >= 0 AND price < 10000
UNION ALL
select 10000, COUNT(*)
from product_quiz
where price BETWEEN 10000 AND 19999
UNION ALL
select 20000, COUNT(*)
from product_quiz
where price BETWEEN 20000 AND 29999
UNION ALL
select 30000, COUNT(*)
from product_quiz
where price BETWEEN 30000 AND 39999;

--2) 가격대별로 그룹으로 묶어서 갯수 세기
select
    CASE
        WHEN price BETWEEN 0 AND 9999 THEN 0
        WHEN price BETWEEN 10000 AND 19999 THEN 10000
        WHEN price BETWEEN 20000 AND 29999 THEN 20000
        WHEN price BETWEEN 30000 AND 39999 THEN 30000
    END PRICE_GROUP,
    COUNT(*) products
from product_quiz
group by
    CASE
        WHEN price BETWEEN 0 AND 9999 THEN 0
        WHEN price BETWEEN 10000 AND 19999 THEN 10000
        WHEN price BETWEEN 20000 AND 29999 THEN 20000
        WHEN price BETWEEN 30000 AND 39999 THEN 30000
    END
order by PRICE_GROUP;

--price 가격을 변경시켜서 갯수 + 서브쿼리 방식

select price price_group, count(*) products
from 
    (select
        CASE
            WHEN price BETWEEN 0 AND 9999 THEN 0
            WHEN price BETWEEN 10000 AND 19999 THEN 10000
            WHEN price BETWEEN 20000 AND 29999 THEN 20000
            WHEN price BETWEEN 30000 AND 39999 THEN 30000
        END price
    from product_quiz)
group by price
order by 1;


select
    price,
    price/10000,
    TRUNC(price/10000),
    TRUNC(price/10000)*10000
from product_quiz;

--만원대 숫자 뽑아내서 활용
select 
    TRUNC(price/10000)*10000 price_group,
    count(*) products
from product_quiz
group by TRUNC(price/10000)*10000
order by 1;

--만원대 숫자 뽑아내서 활용 + 서브쿼리


select price_group, count(*) products
from (
    select
        product_id,
        product_code,
        price,
        TRUNC(price/10000)*10000 price_group
    from product_quiz
    )
group by price_group
order by price_group;


select price_code*10000 price_group, count(*) products
from (
    select
        product_id,
        product_code,
        price,
        TRUNC(price/10000) price_code,
        TRUNC(price/10000)*10000 price_group
    from product_quiz
    )
group by price_code
order by price_code;





