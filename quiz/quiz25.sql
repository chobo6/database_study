create table t_menu_12
(
    id number primary key,
    name varchar2(128) not null,
    price number(10),
    m_type varchar2(64),
    m_date date
);

insert all
    into t_menu_12 (id, name, price, m_type, m_date)
    values (1, '싸이버거', 6000, '완전식품', sysdate)
    
    into t_menu_12 (id, name, price, m_type, m_date)
    values (2, '콩나물비빔밥', 7000, '탄수화물', sysdate)
    
    into t_menu_12 (id, name, price, m_type, m_date)
    values (3, '닭가슴살', 3000, '단백질', sysdate)
    
    into t_menu_12 (id, name, price, m_type, m_date)
    values (4, '베트남쌀국수', 8000, '탄수화물', sysdate)
    
    into t_menu_12 (id, name, price, m_type, m_date)
    values (5, '라면', 2000, '밀가루', sysdate)
select * from dual;

select * from t_menu_12;

update t_menu_12
set price = 8500
where name = '베트남쌀국수';

delete t_menu_12
where name = '라면';