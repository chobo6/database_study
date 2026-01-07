/*********************************/
DML 테이블 내부의 데이터 조작
데이터
저장  INSERT
수정  UPDATE
삭제  DELETE
병합  MERGE


INSERT INTO 테이블명 (컬럼명, 컬럼명 ...)
VALUES (데이터값, 데이터값, ...)

전체 컬럼에 데이터 저장 + 컬럼 순서 맞춰서 저장 -> 컬럼명 생략 가능
INSERT INTO 테이블명
VALUES (데이터값, 데이터값, ...)
;
select * from new_table;

insert into new_table (no, name, birth)
values (1, '이름1', SYSDATE);

insert into new_table (name, birth, no)
values ('이름2', SYSDATE, 2);

insert into new_table (name, birth, no)  --저장 컬럼 타입
values (SYSDATE, 2, '이름2'); -- 타입 순서가 안맞으면 저장 불가

insert into new_table (no, name, birth)
values (3, '이름3', TO_DATE('2021-05-12'));

--모든컬럼값 저장
insert into new_table
values (4, '이름4', TO_DATE('2021-05-13'));

insert into new_table (no, name)
values (5, '이름5');

insert into new_table
values (6, '이름6', null);

INSERT ALL
INTO new_table values (7, '이름7', null)
INTO new_table values (8, '이름8', SYSDATE)
INTO new_table values (9, '이름9', TO_DATE('2022-03-13'))
select * from dual;

--다른 테이블 데이터를 조회해서 저장
select * from new_table2;

INSERT INTO new_table2
select no, name, birth from new_table;

INSERT INTO new_table2
select no, name, birth from new_table
where no < 5;

INSERT INTO new_table2
select 10, '이름10', SYSDATE from dual;


/***************************/
수정 UPDATE

UPDATE 테이블명
SET 컬럼명 = 값,
    컬럼명 = 값
WHERE 조건;

select * from dept3;
--Seoul Branch Office -> Incheon Branch Office

UPDATE dept3
SET area = 'Incheon Branch Office'
--select * from dept3
where area = 'Seoul Branch Office';

UPDATE dept3
SET dname = 'Sales First Team'
--select * from dept3
--where dcode = '1008'
;

CREATE TABLE professor2
AS
SELECT * FROM professor;

--bonus 받는 교수들 보너스금액 +100 인상
UPDATE professor2
SET bonus = bonus + 100
--select * from professor2
where bonus is not null;


/*****************/
Transaction

commit; --확정
rollback; -- 되돌리기(취소)

DML대상(insert, update, delete) -> commit or rollback

select * from new_table2;
insert into new_table2 values (99, '999이름', null);



/*****************/
DELETE 데이터 삭제 (db tool 에서 쿼리 수행시 rollback 가능 : 자동commit 설정이 아닌경우)

DELETE FROM 테이블명 
WHERE 조건;

select * from dept3;

select *
--delete 
from dept3
where dcode = '0001';

commit;
