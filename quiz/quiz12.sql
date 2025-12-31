select
    name,
    jumin,
    birthday,
    case
        when substr(jumin, 3, 2) < 4 then '1분기'
        when substr(jumin, 3, 2) < 7 then '2분기'
        when substr(jumin, 3, 2) < 10 then '3분기'
        when substr(jumin, 3, 2) < 13 then '4분기'
    end 분기
from student;

select 
    empno,
    ename,
    sal,
    case
        when sal < 1001 then 'Level 1'
        when sal < 2001 then 'Level 2'
        when sal < 3001 then 'Level 3'
        when sal < 4001 then 'Level 4'
        else 'Level 5'
    end 급여등급
from emp;