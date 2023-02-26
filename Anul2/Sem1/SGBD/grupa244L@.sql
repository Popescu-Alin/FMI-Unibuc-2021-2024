--5
select distinct title_id ,(select count(tc.title_id)
                        from title_copy tcc
                        where  tcc.title_id=tc.title_id
                        group by(tc.title_id))
                        -
                        nvl((select count(tc.title_id)
                        from rental r
                        where r.act_ret_date is null and r.title_id=tc.title_id
                        group by(tc.title_id)),0)
from title_copy tc;

--6

select copy_id , title_id ,status ,  nvl((select distinct CASE
                                                            WHEN  act_ret_date is null and title_id in (select title_id from rental rent) and copy_id in (select copy_id from rental)
                                                                THEN 'rented'
                                                            ELSE 'available'
                                                        END  
                                                from rental rigt join title_copy using(title_id,copy_id)
                                                where book_date = (select max(rent.book_date)
                                                                    from rental rent
                                                                    where rent.title_id=tc.title_id and rent.copy_id=tc.copy_id)), 'available') as "Actual Status"
from title_copy tc;



--tema de la 7 la 12

select count(*) 
from rental
where to_char(rental.book_date,'dd') =13 or to_char(rental.book_date,'dd')=12;



-----Lab3

variable x varchar(200);
variable nr number(2);
begin
    select department_name,(select  max(count(*)) from employees group by(department_id)) into :x , :nr
    from departments d
    where (select count(*) from employees e where e.department_id=d.department_id)=(select  max(count(*)) from employees group by(department_id));
    
    
    
    DBMS_OUTPUT.PUT_LINE(:x);
    DBMS_OUTPUT.PUT_LINE(:nr);
    
end;
/

SET VERIFY off
DECLARE
     v_cod employees.employee_id%TYPE:=&p_cod;
     v_bonus NUMBER(8);
     v_salariu_anual NUMBER(8);
BEGIN
     SELECT salary*12 INTO v_salariu_anual
     FROM employees 
     WHERE employee_id = v_cod;
     
    IF v_salariu_anual>=200001
        THEN v_bonus:=20000;
    ELSIF v_salariu_anual BETWEEN 100001 AND 200000
        THEN v_bonus:=10000;
    ELSE v_bonus:=5000;
    
    END IF;
    
DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
SET VERIFY ON
/


DECLARE
     v_cod employees.employee_id%TYPE:=&p_cod;
     v_bonus NUMBER(8);
     v_salariu_anual NUMBER(8);
BEGIN
     SELECT salary*12 INTO v_salariu_anual
     FROM employees 
     WHERE employee_id = v_cod;
     
    case
        when v_salariu_anual>=200001
            THEN v_bonus:=20000;
        when v_salariu_anual BETWEEN 100001 AND 200000
            THEN v_bonus:=10000;
        ELSE v_bonus:=5000;
    
    END case;
    
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
/
