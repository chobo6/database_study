/***************************************/
JOIN 조인

--JOIN 기준 -> 어떤 것을 기준으로 테이블 데이터를 합쳐서(연결) 조회

select * from emp;  --deptno 컬럼 부서번호
select * from dept; --부서정보 deptno 컬럼

select e.empno, e.ename, d.dname, d.loc, e.deptno
--select *
from emp e, dept d
where e.deptno = d.deptno;

select e.empno, e.ename, d.dname, d.loc, e.deptno
from emp e INNER JOIN dept d
ON e.deptno = d.deptno;

--emp, dept 조인 -> 부서번호 20, 30 번만 조회
select e.empno, e.ename, d.dname, d.loc, e.deptno
--select *
from emp e, dept d
where e.deptno = d.deptno
AND e.deptno IN (20, 30);

select e.empno, e.ename, d.dname, d.loc, e.deptno
from emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno IN (20, 30);


select *
from emp e, dept d; --JOIN 조건 누락 -> 카티션 곱

-----

select * from student;    -- profno 교수번호 컬럼
select * from professor;  -- profno 교수번호 컬럼

select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
--select *
from student s, professor p
where s.profno = p.profno;


select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
from student s INNER JOIN professor p
ON s.profno = p.profno;


--INNER JOIN  vs  OUTER JOIN

select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
from student s, professor p
where s.profno = p.profno;

--INNER JOIN 수행 -> 조인기준 profno 가 같은가? -> profno null 비교불가 제외
select COUNT(*) from student;
select COUNT(*) from professor;

--select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
select *
from student s, professor p
--where s.profno = p.profno(+);
--where p.profno = s.profno(+);
--where s.profno(+) = p.profno;
where p.profno(+) = s.profno;

--select s.name 학생명, p.name 교수명, s.studno, p.profno, p.email
select *
--from student s LEFT OUTER JOIN professor p
--from student s RIGHT OUTER JOIN professor p
--from professor p RIGHT OUTER JOIN student s
from professor p LEFT OUTER JOIN student s
ON s.profno = p.profno;



