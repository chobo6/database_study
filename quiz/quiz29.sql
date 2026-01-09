DELETE FROM 테이블명; -- 조건에 맞는 테이블 데이터 일부 삭제
TRUNCATE TABLE 테이블명; --테이블 전체 삭제
--차이점 : 롤백 가능 여부
-----------------------------------------------------------
create table T_MEMBER_POINT
(
    id number(6),
    no number(6),
    mid varchar(24) not null,
    score number(3),
    score_date date default sysdate,
    constraint t_member_point primary key (id, no)
);

select * from t_member_point;
-----------------------------------------------------------
create sequence t_member_point_pk_seq
increment by 1
start with 1
maxvalue 999999
nocycle ;

drop sequence t_member_point_pk_seq;
select t_member_point_pk_seq.nextval from dual;
select t_member_point_pk_seq.currval from dual;
-----------------------------------------------------------
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'A'), 'A', 30);
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'B'), 'B', 40);
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'C'), 'C', 40);
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'A'), 'A', 50);
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'B'), 'B', 60);
insert into t_member_point (id, no, mid, score) values (t_member_point_pk_seq.nextval,
    (select nvl(max(no), 0)+1 from t_member_point where mid = 'A'), 'A', 70);

select * from t_member_point;

delete from t_member_point;