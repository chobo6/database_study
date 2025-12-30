/********************************/
1. 조회하기 SELECT

SELECT 조회대상(컬럼명) FROM 테이블명;
* : 전체 ALL

테이블 구조 확인 (Describe)
DESC 테이블명;
desc emp;


select * from dept;
SELECT * FROM DEPT;

select * from fruit;   --fruit 테이블에 있는 모든 컬럼 데이터 조회
select * from LOAN;
select * from product; --product 테이블에 있는 모든 컬럼 데이터 조회

select * from emp;
select job from emp;
select job, hiredate, mgr from emp;

desc product;

--가독성
select 
    job,
    hiredate,
    mgr 
from emp;

select *
from emp;

/*******************************************/
--컬럼명 별도 지정 (별칭)
SELECT 컬럼명 AS "컬럼별칭",
       컬럼명 "컬럼별칭",
       컬럼명 컬럼별칭
FROM 테이블명;

select
    empno AS "사원번호",
    ename "사원명",
    job 직업,
    sal "급여 데이터"
from emp;
    
select 
    empno,
    empno empnumber,
    empno employeeno,
    ename, job
from emp;

/*******************************************/
--조회데이터 리터럴 값 활용
select '문자', 123 from emp;
select * from emp;
select '문자', 123 from dept;

select '문자', 123 from dual;  --dual 임시테이블

select '문자확인' AS "문자컬럼별칭",
        123+333+444 숫자연산결과
from dual;

select dname, loc, '안녕하세요', 12345 from dept;
select '문자''작은따옴표' from dual;
select q'[이 안에다가 문자 " 문자 ' 이런식으로]' from dual;

/*******************************************/
-- 문자 이어 붙이기 ||
select '오늘' || '너무춥다' from dual;
select 
    '부서번호 : '||deptno AS "부서번호",
    deptno,
    '부서번호에 500 더하면 : ' || (deptno + 500) "부서번호plus500"
from dept;

/*******************************************/
--DISTINCT 중복제거
select * from emp;
select DISTINCT job from emp;
select DISTINCT(job) from emp;

SELECT deptno FROM emp;
select distinct(deptno) from emp;

SELECT distinct job, deptno FROM EMP;
--SELECT distinct(job), deptno FROM EMP;





