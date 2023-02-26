
CREATE table emp_PVA as SELECT * FROM employees;
SELECT * FROM emp_pva;



DEFINE p_cod_sal= 200
DEFINE p_cod_dept = 80
DEFINE p_procent =20
DECLARE
 v_cod_sal emp_PVA.employee_id%TYPE:= &p_cod_sal;
 v_cod_dept emp_PVA.department_id%TYPE:= &p_cod_dept;
 v_procent NUMBER(8):=&p_procent;
BEGIN 
    
        
        update emp_PVA
            SET department_id = v_cod_dept, 
                salary=salary + (salary* v_procent/100)
        WHERE employee_id= v_cod_sal;
        
    if( SQL%ROWCOUNT =0) then
        DBMS_OUTPUT.PUT_LINE('ok');
    else
        DBMS_OUTPUT.PUT_LINE('nu s a gasit');
    end if;
    
END;
/
--11
CREATE table zile_pva(
    nr int,
    zi Date,
    ch varchar(200));
    

DECLARE
 contor NUMBER(6) := 1;
 v_data DATE;
 maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
     while contor < maxim LOOP 
         v_data := sysdate+contor;
         INSERT INTO zile_pva
         VALUES (contor,v_data,to_char(v_data,'Day'));
         contor := contor + 1;
     END LOOP;
END;
/

SELECT * FROM zile_pva;


------Ex lab

--2 

CREATE table octombrie_pva(
    nr int,
    zi Date);

DECLARE
 contor NUMBER(6) := 1;
 v_data DATE;
 maxim NUMBER(2) := LAST_DAY(SYSDATE)-TRUNC(SYSDATE,'MM');
BEGIN
     while contor < maxim LOOP 
         v_data := TRUNC(SYSDATE,'MM')+contor;
         INSERT INTO octombrie_pva
         VALUES (contor,v_data);
         contor := contor + 1;
     END LOOP;
END;
/

select * from octombrie_pva;

select  zi ,(select count(*) 
            from rental
            where to_char(rental.book_date,'dd-mm-yy') = to_char(zi,'dd-mm-yy') ) as "nr"
from octombrie_pva;


--3

DECLARE
 contor NUMBER(6);
 total NUMBER(6);
BEGIN   
        
        select count(*) into total from title;        
        
        
        select count(*)  into contor
        from (
            select distinct title_id
            from
            member m join rental r on (m.member_id=r.member_id)
            where lower(first_name)=lower('&f_name') );
        
        
        case 
            when contor*100/total >=75 
                then DBMS_OUTPUT.PUT_LINE('C1');
            
            when contor*100/total >=50 
                then DBMS_OUTPUT.PUT_LINE('C2');

            when contor*100/total >=25
                then DBMS_OUTPUT.PUT_LINE('C3');
                
            else DBMS_OUTPUT.PUT_LINE('C4');
        end case;
    
    
EXCEPTION 
    when  TOO_MANY_ROWS then 
        DBMS_OUTPUT.PUT_LINE('prea multi cu numele asta');
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('nu e xista');
END;
/

--5
--am creat noua tabela.
create table member_pva as select * from member;
select * from member_pva;
alter table member_pva
add discount number(5) ;

select * from member_pva;

DECLARE
    TYPE tab_ind IS TABLE OF number INDEX BY PLS_INTEGER;
    t    tab_ind;
    contor NUMBER(6);
    total NUMBER(6);
BEGIN   
        
        select count(*) into total from title;
        
        SELECT member_id BULK COLLECT INTO t
        from member_PVA;
        
        FOR i IN t.FIRST..t.LAST LOOP 
            select count(*)  into contor
            from (
                select distinct title_id
                from
                member m join rental r on (m.member_id=r.member_id)
                where m.member_id=t(i) );
                
                update member_pva 
                set discount =(  case 
                                    when contor*100/total >=75 
                                        then 10
                                    when contor*100/total >=50 
                                        then 5
                        
                                    when contor*100/total >=25
                                        then 3
                                        
                                    else 0
                                end )
                where member_id=t(i);
                
                DBMS_OUTPUT.PUT_LINE(t(i) ||' '|| contor*100/total);
        END LOOP;
        

  
    
EXCEPTION 
    when  TOO_MANY_ROWS then 
        DBMS_OUTPUT.PUT_LINE('prea multi cu numele asta');
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('nu e xista');
END;
/




