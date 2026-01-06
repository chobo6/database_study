/***********************************/
DDL
테이블


테이블 생성

CREATE TABLE 테이블명
(
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약,
    컬럼명 컬럼타입    기타속성/제약
);


CREATE TABLE new_table      --테이블 스키마(Schema)
(
    no NUMBER(3),           --숫자형 3자리수
    name VARCHAR2(16),      --문자형 16바이트
    birth DATE              --날짜형 
);

select * from new_table;


CREATE TABLE new_table2      --테이블 스키마(Schema)
(
    no NUMBER(3),           --숫자형 3자리수
    name VARCHAR2(16),      --문자형 16바이트
    birth DATE              --날짜형 
);

select * from new_table2;

select * 
from tab
where tname LIKE '%NEW%';


테이블 복사
select * from dept2;

CREATE TABLE dept3
AS
SELECT * FROM dept2;  --dept2 테이블 구조 + 데이터복사 -> 새로운 테이블 생성

select * from dept3;

CREATE TABLE dept4
AS
SELECT dcode, dname FROM dept2;  --dept2 컬럼 일부 + 데이터복사 -> 새로운 테이블 생성

select * from dept4;

--컬럼구조 (테이블 구조) 만 동일하게 데이터 없이 복사 -> 새로운 테이블 생성
CREATE TABLE dept5
AS
SELECT * FROM dept2
where 1=2;  --데이터가 조회되지 않도록 거짓 조건 추가

select * from dept5;



-------
테이블 변경 (수정)

select * from dept4;

--컬럼추가
ALTER TABLE dept4
ADD (loc VARCHAR2(32));

ALTER TABLE dept4
ADD (lv NUMBER(3) DEFAULT 1);

--컬럼삭제
ALTER TABLE dept4
DROP COLUMN lv;


-- 테이블 삭제 (rollback 불가 / 자동 commit)
DROP TABLE 테이블명;

--테이블 내부 데이터 삭제 (rollback 불가 / 자동 commit)
TRUNCATE TABLE 테이블명;

select * from dept4;

truncate table dept4;
drop table dept4;


