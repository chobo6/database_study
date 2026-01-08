CREATE TABLE temp_dept2
AS
SELECT * FROM dept2;

insert into temp_dept2 values(9010, 'temp_10', 1006, 'temp area');

--select * from temp_dept2;

insert into temp_dept2 (dcode, dname, pdept) values(9020, 'temp_20', 1006);

create table new_professor
as
select profno, name, pay, bonus from professor where profno < 3000;

--select * from new_professor;

update new_professor
set bonus = 100
where name = 'Winona Ryder';