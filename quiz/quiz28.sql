create table T_ITEM_LIST
(
    no NUMBER(6) PRIMARY KEY,
    item_name VARCHAR2(24) NOT NULL,
    price NUMBER(6),
    create_date DATE DEFAULT SYSDATE
);

select * from t_item_list;
---------------------------------------
create sequence t_item_list_pk_seq
increment by 1
start with 1
maxvalue 999999
nocycle;

drop sequence t_item_list_pk_seq;
----------------------------------------
select t_item_list_pk_seq.nextval from dual;
select t_item_list_pk_seq.currval from dual;
----------------------------------------
insert into t_item_list (no, item_name, price) values (t_item_list_pk_seq.nextval, '이름1', '10000');
insert into t_item_list (no, item_name, price) values (t_item_list_pk_seq.nextval, '이름2', '10000');
insert into t_item_list (no, item_name, price) values (t_item_list_pk_seq.nextval, '이름3', '10000');
insert into t_item_list (no, item_name, price) values (t_item_list_pk_seq.nextval, '이름4', '20000');

select * from t_item_list;
