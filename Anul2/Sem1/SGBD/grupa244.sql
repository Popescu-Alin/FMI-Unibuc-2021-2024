select avg(salary), manager_id
from employees
group by manager_id;

COMMENT ON TABLE employees IS 'Informa?ii despre angajati';

select * from user_tab_comments;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

select sysdate from dual;


SELECT EXTRACT(day FROM SYSDATE)
FROM dual;

SELECT * FROM user_tables WHERE (table_name) like '%_PVA';


create table EMP_PVA as select * from employees;
create table DEP_PVA as select * from departments;

select * from EMP_PVA;



--20
--SET FEEDBACK OFF ascunde numarul de inregistrari afectate de select, delete, update sau insert.

--23

create table DEPARTMENTS_PVA as select * from DEPARTMENTS;

select * from departments_pva;

