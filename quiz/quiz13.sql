select
    empno 사번,
    name 이름,
    birthday 생년월일,
    hobby 취미,
    pay 급여,
    pay*1.5 성과급,
    replace(emp_type, 'employee', 'family') 직원분류,
    tel,
    case
        when pay > 60000000 then '상'
        when pay > 45000000 then '중'
        when pay > 35000000 then '하'
        else '화이팅'
    end 급여수준
from emp2
where
    (TO_CHAR(birthday, 'yy') between 70 and 79) and
    substr(tel, 1, instr(tel, ')')-1) in (02, 031);
    