/*************************************/
DML Merge


--신발가게 날짜별 매출
CREATE TABLE T_SHOE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (10, 20, 30, 40 ..)
    sales_income NUMBER(10) --매출금액  
);

--옷가게 날짜별 매출
CREATE TABLE T_CLOTH
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (1,2,3,4...)
    sales_income NUMBER(10) --매출금액  
);


--본사 날짜별 전체 매출 취합
CREATE TABLE T_COMPANY
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10) --매출금액  
);

INSERT ALL
INTO T_SHOE VALUES (TO_DATE('2025-03-01'), 1, 5000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 1, 15000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 1, 30000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 2, 4000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 2, 90000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 2, 120000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 1, 90000)
select * from dual;

--취합 이후에 추가된 데이터 처리 시나리오를 위한 데이터 추가
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-07'), 1, 210000);

SELECT *
--DELETE
FROM T_SHOE WHERE work_date = '2025-03-07';

INSERT ALL
INTO T_CLOTH VALUES (TO_DATE('2025-03-01'), 10, 59000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-02'), 10, 25000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-03'), 10, 33000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-04'), 20, 4400)
INTO T_CLOTH VALUES (TO_DATE('2025-03-05'), 20, 99000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-06'), 20, 790000)
select * from dual;

--취합 이후에 수정된 데이터 처리 시나리오를 위한 데이터 수정
UPDATE T_CLOTH
SET sales_income = 890000
WHERE work_date = '2025-03-06'
AND store_code = 20;


DELETE FROM T_CLOTH;




select * from T_SHOE;
select * from T_CLOTH;


T_SHOE
T_CLOTH     >>> T_COMPANY 전체 취합(병합)


INSERT INTO T_COMPANY
SELECT * from T_SHOE;
--where work_date = '2025-03-05';

select * from T_COMPANY;

INSERT INTO T_COMPANY
SELECT work_date, store_code, sales_income from T_CLOTH;

select store_code, SUM(sales_income)
from T_COMPANY
group by store_code;


select work_date, SUM(sales_income)
from T_COMPANY
group by work_date
order by work_date;


--주기적으로 배치(Batch)처리 
--하드코딩으로는 힘들다.

--임시 시나리오
--데이터는 어제 밤 22시, 배치시작은 오늘 새벽2시
--어제꺼 조회해서 처리해라 
SELECT * from T_SHOE
where TO_CHAR(work_date, 'YYYYMMDD') = TO_CHAR(SYSDATE-1, 'YYYYMMDD');


1) 전체 DELETE -> 다시 전부 INSERT

select * from T_COMPANY;

DELETE FROM T_COMPANY;

INSERT INTO T_COMPANY
SELECT * from T_SHOE;

INSERT INTO T_COMPANY
SELECT work_date, store_code, sales_income from T_CLOTH;

2) MERGE

MERGE INTO 최종 저장할 대상 테이블명
USING 데이터를 가져올 테이블명
ON (병합/비교 기준조건)
WHEN MATCHED THEN
    --있을때
    UPDATE SET --수정
    DELETE WHERE --삭제
WHEN NOT MATCHED THEN
    --없을때
    INSERT VALUES --추가
;

--날짜 1개 기준 -> 동일 날짜로 겹치는 데이터로 인해서, 정확한 병합이 불가능
MERGE INTO T_COMPANY CP
USING T_CLOTH CL   --T_CLOTH 테이블꺼 병합
ON (CP.work_date = CL.work_date)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = CL.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (CL.work_date, CL.store_code, CL.sales_income);

DELETE FROM T_COMPANY;
select * from T_COMPANY;
SELECT * from T_SHOE;
SELECT * from T_cloth;

MERGE INTO T_COMPANY CP
USING T_SHOE SH   --T_SHOE 테이블꺼 병합
ON (CP.work_date = SH.work_date)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = SH.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (SH.work_date, SH.store_code, SH.sales_income);


--날짜 + 매장코드 병합기준
MERGE INTO T_COMPANY CP
USING T_SHOE SH   --T_SHOE 테이블꺼 병합
ON (CP.work_date = SH.work_date AND CP.store_code = SH.store_code)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = SH.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (SH.work_date, SH.store_code, SH.sales_income);

select * from T_COMPANY;

MERGE INTO T_COMPANY CP
USING T_CLOTH CL   --T_CLOTH 테이블꺼 병합
ON (CP.work_date = CL.work_date AND CP.store_code = CL.store_code)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = CL.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (CL.work_date, CL.store_code, CL.sales_income);


--Merge 확인용 데이터 추가
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-09'), 2, 35000);

UPDATE T_CLOTH
SET sales_income = 897000
WHERE work_date = '2025-03-06'
AND store_code = 20;


/************************************/
--본사 취합 테이블
--날짜 + 매장코드 -> 매출

select work_date, SUM(sales_income) 
--select *
from T_COMPANY
group by work_date;

select DISTINCT(store_code)
from T_shoe;

select *
from T_COMPANY
where store_code IN (
                    select DISTINCT(store_code)
                    from T_cloth);

--매장 판매유형 구분코드 컬럼 추가한 버전

CREATE TABLE T_COMPANY_TYPE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10), --매출금액
    store_type VARCHAR2(8)  --매장 유형 구분코드 'C' 옷가게  'S' 신발가게 
);


MERGE INTO T_COMPANY_TYPE CP
USING T_SHOE SH   --T_SHOE 테이블꺼 병합
ON (CP.work_date = SH.work_date AND CP.store_code = SH.store_code)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = SH.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (SH.work_date, SH.store_code, SH.sales_income, 'S');

select * from T_COMPANY_TYPE;

MERGE INTO T_COMPANY_TYPE CP
USING T_CLOTH CL   --T_CLOTH 테이블꺼 병합
ON (CP.work_date = CL.work_date AND CP.store_code = CL.store_code)
WHEN MATCHED THEN
    UPDATE SET CP.sales_income = CL.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (CL.work_date, CL.store_code, CL.sales_income, 'C');

select * from T_COMPANY_TYPE
where store_type = 'S';


select store_type, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY store_type;

select store_type, store_code, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY store_type, store_code
order by 1, 2;

select store_type, store_code, SUM(sales_income) from T_COMPANY_TYPE
GROUP BY ROLLUP(store_type, store_code);


select *
from T_SHOE
UNION ALL
select *
from T_CLOTH;

