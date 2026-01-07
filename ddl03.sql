/****************************/
DDL 제약조건  KEY 

PK(Primary Key) 기본키 (테이블에 한개만 설정 가능)
FK(Foreign Key) 외래키

CREATE TABLE tt03
(
    no NUMBER(3) PRIMARY KEY,  --기본키설정 -> NOT NULL UNIQUE
    name VARCHAR2(16),
    birth DATE
);

insert into tt03 values (1, 'n1', sysdate);
insert into tt03 values (1, 'n1', sysdate); --no 중복 X
insert into tt03 values (null, 'n1', sysdate); --no null X

CREATE TABLE tt04
(
    no NUMBER(3) PRIMARY KEY,    --기본키(PK)설정  PK는 테이블에 1개만 존재 제약
    id VARCHAR2(32) PRIMARY KEY, --기본키(PK)설정  PK는 테이블에 1개만 존재 제약
    name VARCHAR2(16) NOT NULL,
    birth DATE
);

CREATE TABLE tt04
(
    no NUMBER(3),    --기본키(PK)설정  PK는 테이블에 1개만 존재 제약
    id VARCHAR2(32), --기본키(PK)설정  PK는 테이블에 1개만 존재 제약
    name VARCHAR2(16) NOT NULL,
    birth DATE,
    CONSTRAINT tt04_pk PRIMARY KEY (no, id) --두개의 컬럼을 조합해서 PK로 설정
);

/********************************/
student -> (profno) -> professor

외래키 FK : 다른테이블에 있는 키값 참조하는 컬럼
- 참조하는 테이블(부모테이블)에 존재하는 값만 사용 가능(+null 가능)
- 외래키 대상으로 설정된 부모테이블에서 자신을 참조하는
  자식테이블의 데이터 참조가 존재하면, 삭제 불가
  
외래키 삭제 조건
ON DELETE CASCADE;  --부모데이터 삭제시, 그 값을 참조하는 자식데이터도 같이 삭제
ON DELETE SET NULL; --부모데이터 삭제시, 그 값을 참조하는 자식데이터를 NULL 값으로 변경


CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32)
);
--T_TABLE
--V_VIEW

DROP TABLE T_MEMBER;
CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32),
    --club_id REFERENCES T_CLUB(id) --외래키(FK) 설정
    --club_id REFERENCES T_CLUB(id) ON DELETE CASCADE --외래키(FK) 설정
    club_id REFERENCES T_CLUB(id) ON DELETE SET NULL --외래키(FK) 설정
);

select * from T_CLUB;

INSERT INTO T_CLUB VALUES(1, '독서');
INSERT INTO T_CLUB VALUES(2, '게임');
INSERT INTO T_CLUB VALUES(3, '등산');
INSERT INTO T_CLUB VALUES(4, '낚시');

select * from T_MEMBER;

INSERT INTO T_MEMBER VALUES(1, '이름1', 2);
INSERT INTO T_MEMBER VALUES(2, '이름2', 1);
INSERT INTO T_MEMBER VALUES(3, '이름3', 1);

select *
from T_MEMBER m, T_CLUB c
where m.club_id = c.id(+);

INSERT INTO T_MEMBER VALUES(1, '이름4', 3);  --MEMBER pk id중복
INSERT INTO T_MEMBER VALUES(null, '이름4', 3);  --MEMBER pk not null
INSERT INTO T_MEMBER VALUES(4, '이름4', 5);  
--FK 참조하는 부모테이블 id 값에 5가 존재하지 않음 (1~4까지만 존재)
INSERT INTO T_MEMBER VALUES(4, '이름4', null);  
INSERT INTO T_MEMBER VALUES(5, '이름5', 3);  

select *
from T_MEMBER;

select *
--delete
from t_club  --id가 3인 데이터를 외부 (자식 테이블)에서 참조하는 데이터가 존재하면 삭제 불가
where id = 3
;

select *
--delete
from T_MEMBER
where club_id = 3;
--삭제하고 싶으면? 참조하는 자식테이블 데이터 먼저 삭제

select *
--delete
from t_club  --참조하는 외부 테이블데이터가 없으면 삭제 가능
where id =4
;

