select
    deptno 부서번호,
    avg(sal) 평균급여
from emp
group by deptno
having avg(sal) >= 2000;

select
    p_date 판매일자,
    sum(p_qty) 판매수량,
    sum(p_total) 판매금액
from panmae
group by p_date;

select
    p_date 판매일자,
    p_code 상품코드,
    sum(p_qty) 판매수량,
    sum(p_total) 판매금액
from panmae
group by rollup(p_date, p_code);