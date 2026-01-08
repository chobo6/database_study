사전준비.
CREATE TABLE temp_professor
AS
SELECT * FROM professor;

select * from temp_professor;

1.
temp_professor 테이블에서 
직급이 조교수(assistant professor) 인 교수들의 
BONUS 를 200 만원으로 인상하세요.
;
select * from temp_professor
where position = 'assistant professor';

UPDATE temp_professor
SET bonus = 200  --200만원으로
--SET bonus = bonus + 200 --200만원 인상
--SET bonus = NVL(bonus, 0) + 200 --200만원 인상 , null 대상도 0으로 간주하고 200증가
--select * from temp_professor
where position = 'assistant professor';
-- AND bonus is not null;


2.
temp_professor 테이블에서 
'Sharon Stone' 교수의 직급과 동일한 직급을 가진 교수들 중 
현재 급여가 250 만원이 안 되는 교수들의 급여를 15% 인상하세요.

UPDATE temp_professor
SET pay = pay * 1.15
--select *
--from temp_professor
where position = (select position from temp_professor
                    where name = 'Sharon Stone')
AND pay < 250;


select *
from temp_professor
where position = (select position from temp_professor
                    where name = 'Sharon Stone');
