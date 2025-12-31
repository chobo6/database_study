select
    deptno,
    name,
    decode(name, 'Audie Murphy', 'BEST!') decode
from professor;

select
    deptno,
    name,
    case
        when deptno = '101' AND name = 'Audie Murphy' then 'BEST!'
        when deptno = '101' then 'GOOD!'
    END 비고
from professor;

select
    deptno,
    name,
    case
        when deptno = '101' AND name = 'Audie Murphy' then 'BEST!'
        when deptno = '101' then 'GOOD!'
        else 'N/A'
    END 비고
from professor;

select
    name,
    jumin,
    decode(substr(jumin, 7, 1), '1', '남자', '2', '여자') 성별
from student
where deptno1 = '101';

select
    name,
    tel,
    case substr(tel, 1, instr(tel, ')')-1)
        when '02' then '서울'
        when '031' then '경기'
        when '051' then '부산'
        when '052' then '울산'
        when '055' then '경남'
        else '기타'
    end 지역명
from student
where deptno1 = '101';
