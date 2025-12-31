select avg(sal)
from emp;

select avg(sal)
from emp
where deptno = '30';

select deptno, avg(sal)
from emp
group by deptno
order by deptno;

select deptno, count(deptno), avg(sal)
from emp
group by deptno
order by deptno;

select job, avg(sal)
from emp
group by job
order by job;

select job, max(sal)
from emp
group by job
order by job;

select deptno, max(sal)
from emp
group by deptno
order by deptno;
