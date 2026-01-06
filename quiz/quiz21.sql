select d.dname, s2.max_height, s.name, s.height
from student s join department d
    on s.deptno1 = d.deptno,(
    select deptno1, max(height) max_height
    from student s
    group by deptno1) s2
where s.deptno1 = s2.deptno1 and s.height = s2.max_height;
            
select s2.grade, name, height, s2.avg_height
from student s,
    (select grade, avg(height) avg_height
    from student
    group by grade) s2
where s.grade = s2.grade and s.height >= s2.avg_height
order by s2.grade, s.height;

1.
student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.

--다중컬럼
--서브쿼리 계산하고 비교
--rank 순위

select d.dname, s.height 학과별최대키, s.name, s.height 학생키
from student s, department d
where (deptno1, height) IN (
                        select deptno1, MAX(height)
                        from student
                        group by deptno1)
AND s.deptno1 = d.deptno;


select C.dname, A.max_height, B.name, B.height
from 
(select deptno1, MAX(height) max_height
    from student
    group by deptno1) A, student B, department C
where A.deptno1 = B.deptno1
AND A.max_height = B.height
AND A.deptno1 = C.deptno;

2.
student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
해당 학년의 평균 키를 출력 하세요.
(학년 컬럼으로 오름차순 정렬해서 출력하세요)
;


select 
    s1.grade, 
    s1.name, 
    s1.height,
    ( select AVG(s2.height)
                    from student s2
                    where s2.grade = s1.grade
                    ) 평균키
from student s1
where s1.height > ( select AVG(s2.height)
                    from student s2
                    where s2.grade = s1.grade
                    );

select * from student;

select B.grade, B.name, B.height, A.avg_height
from 
(select grade, AVG(s2.height) avg_height
from student s2
group by grade) A, student B
where A.grade = B.grade
AND A.avg_height < B.height;

