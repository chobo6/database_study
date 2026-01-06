/********************************/
서브쿼리 (Sub-query)

SELECT (쿼리 : 스칼라 서브쿼리)
FROM (쿼리 : 인라인 뷰)
WHERE (쿼리 : 서브쿼리)
;

select * from emp;

20번 부서 사람들만 조회
select * from emp
where deptno = 20;

사번이 7844인 사원과 같은 부서 사람들 조회

select * from emp
--where deptno = 30;  --7844사번의 소속 부서번호
where deptno = ( select deptno
                    from emp
                    where empno = 7844);


select * from emp2;
select * from dept2;

포항 사무실에서 일하는 직원 목록 조회

select * from dept2
where area = 'Pohang Main Office';

--JOIN 버전
select * 
from emp2 e, dept2 d
where e.deptno = d.dcode
AND d.area = 'Pohang Main Office';

--서브쿼리 버전
select *
from emp2
where deptno IN (
                select dcode
                from dept2
                where area = 'Pohang Main Office');
        -- IN (0001, 1003, 1006, 1007)


select *
from emp2
where deptno IN (
                select dcode
                from dept2
                where area = 'Pohang Main Office'
                    AND dcode != '0001');
        
                    
select *
from emp2
where deptno IN (
                select dcode
                from dept2
                where area = 'Pohang Main Office'
                    AND dcode = deptno);

select *
from emp2
where EXISTS  (
                select dcode
                from dept2
                where area = 'Pohang Main Office'
                    AND dcode = deptno);
                    
select dcode
from dept2
where area = 'Pohang Main Office'
    AND dcode = '1002';
    
    

--학생 student  학번이 9513인 학생보다 키가 작은 학생들 조회

select *
from student
where height < (select height
                from student
                where studno = 9513);
                
-- 2학년 학생들 기준 제일 많은 몸무게보다 더 많은 몸무게 나가는 학생 목록 조회
select *
from student
where weight > (select MAX(weight)
                from student
                where grade = 2);

select MAX(weight)
from student
where grade = 2;

--각 학년별로 가장 큰 몸무게
select *
from student
where weight >ANY (select MAX(weight)
                    from student
                    group by grade);
  >ANY 58 --  81 82 83 58
  >ALL 83 --  81 82 83 58
  <ANY 83 --  81 82 83 58
  <ALL 58 --  81 82 83 58


-- 단일행 비교   =  IN ...
-- 다중행 비교   IN NOT IN
-- 다중컬럼 비교  (컬럼수를 맞춰서)

학년별로 몸무게가 제일 많이 나가는 학생들 정보만 조회

select *
from student
where (grade, weight) IN (  --학년 + 몸무게 두 컬럼 모두 비교
                select grade, MAX(weight)
                from student
                group by grade );

--emp2 기준   전체의 평균급여보다 많이 받는 직원 조회
select *
from emp2
where pay > (select AVG(pay)
                from emp2);

--emp2 기준   자신과 같은 직급(position)의 평균 급여보다 많이 받는 직원목록 조회
select *
from emp2;

select AVG(pay)
from emp2
where position = (select position
                from emp2
                where empno = '19960101');

select *
from emp2 A
where A.pay > (select AVG(pay)
                from emp2 B
                where B.position = A.position);

select AVG(pay)
from emp2
where position = 'Section head';




--emp2 기준   자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회
select *
from emp2 A
where A.pay < (select AVG(pay)
                from emp2 B
                where B.emp_type = A.emp_type);



/******************************************/
select * from emp2;
select * from dept2;

사원이름, 부서번호, 부서이름

--JOIN
select e.name, e.deptno, d.dname
from emp2 e, dept2 d
where e.deptno = d.dcode;


--Subquery 
select 
    e.name,
    e.deptno,
    (select dname
        from dept2
        where dcode = e.deptno) 부서명
from emp2 e;

select dname
from dept2
where dcode = '1004';


select * from panmae;
select * from product;

--join
select pm.p_date, pm.p_code, pd.p_name
from panmae pm, product pd
where pm.p_code = pd.p_code;

--subquery
select 
    p_date,
    p_code,
    (select p_name
        from product pd
        where pd.p_code = pm.p_code) AS "상품명"
from panmae pm;
    


/******************************************/

select job, mgr, hiredate, sal, comm
from emp;
    

select empno, ename, job --, sal  from절에 속해있는 select 결과를 테이블로 간주
from (select empno, ename, job
        from emp);
    
    
select enumber, emp_name, jj 
from 
(select empno enumber,  --컬럼 별칭이 외부에서 조회시 컬럼명으로 인식
        ename emp_name,
        job jj
        from emp);

select *
from (
    select e.name, e.deptno, d.dname
    from emp2 e, dept2 d
    where e.deptno = d.dcode);


--emp2 기준   자신과 같은 고용형태(emp_type)의 평균 급여보다 적게 받는 직원목록 조회
select * from emp2;

select *
from
    emp2 A, (select emp_type, AVG(pay) avg_pay
                from emp2
                group by emp_type) B
where A.emp_type = B.emp_type
AND A.pay < B.avg_pay;
    
    

/*******************************/
ROWNUM 활용
    
select 
    ROWNUM,
    CEIL(ROWNUM / 3),
    studno,
    name,
    grade,
    height
from student
order by height desc;
    
select ROWNUM, rn, team, studno, name
from (
    select 
        ROWNUM rn,
        CEIL(ROWNUM / 3) team,
        studno,
        name,
        grade,
        height
    from student
    order by height desc
    );
    



--그냥 5명
select ROWNUM, studno, name, height
from student
where ROWNUM <= 5;

-- 키 큰사람 5명
select ROWNUM, studno, name, height
from student
where ROWNUM <= 5   --기존 ROWNUM으로 인식해서 다른 결과가 조회
order by height desc; 


--키순으로 정렬된 테이블 상태를 기준으로 다시 ROWNUM으로 인식해서 키큰사람 5명 조회
select ROWNUM, studno, name, height 
from (
    select studno, name, height
    from student
    order by height desc
    )
WHERE ROWNUM <= 5;


-- 팀 3팀 조회 안되는 케이스
select 
        ROWNUM rn,
        CEIL(ROWNUM / 3) team,
        studno,
        name,
        grade,
        height
    from student
    where CEIL(ROWNUM / 3) = 3;
    
select *
from (
        select 
                ROWNUM rn,
                CEIL(ROWNUM / 3) team,
                studno,
                name,
                grade,
                height
            from student)
where team = 3;


/***********************************/
집계 group by  -> 서브쿼리, Join

부서번호, 부서별 최대급여, 부서명
select deptno, MAX(sal)
from emp
group by deptno;

select * from dept;

--groupby집계 -> JOIN
select e.deptno, e.max_sal, d.dname
from
(select deptno, MAX(sal) max_sal
from emp
group by deptno) e, dept d
where e.deptno = d.deptno;

--groupby집계 -> select subquery
select 
    e.deptno, 
    e.max_sal, 
    (select d.dname 
        from dept d 
        where d.deptno = e.deptno) dname
from
(select deptno, MAX(sal) max_sal
from emp
group by deptno) e;

-- JOIN -> group by 집계

select deptno, dname, MAX(sal)
from (
    select e.deptno, e.sal, d.dname
    from emp e, dept d
    where e.deptno = d.deptno )
group by deptno, dname;
