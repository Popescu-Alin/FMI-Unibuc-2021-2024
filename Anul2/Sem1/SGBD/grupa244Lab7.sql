
select department_name , (select count(*) from employees e where e.department_id=d.department_id) as nr from
departments d
where (select count(*) from employees e where e.department_id=d.department_id)=6;

select * from employees;

Declare
    cursor C is 
        select department_name , (select count(*) from employees e where e.department_id=d.department_id) from
        departments d ;  
    nr number;
    nume departments.department_name%type;
    total number;
Begin
    open C;
    total:=0;
    fetch C into nume,nr;
    while C%found loop
        total:=total+1;
        if nr=0 then
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' nu lucreaza angajati');
        elsif nr=1 then
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' lucreaza 1 angajat');
        else
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' lucreaza '||nr ||' angajati');
        end if;
        fetch C into nume,nr;
        
    end loop;
    close C ;
    DBMS_OUTPUT.PUT_LINE (total);
    
end;
/

Declare
    cursor C is 
        select department_name , (select count(*) from employees e where e.department_id=d.department_id) from
        departments d ;  
    type t is varray(100) of number; 
    nr t:=t();
    type t2 is varray(100) of departments.department_name%type; 
    nume t2:=t2();
    total number;
Begin
    open C;
    total:=0;
    fetch C  bulk collect into nume , nr;
    for i in nr.first..nr.last loop
        total:=total+1;
        if nr(i)=0 then
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume(i) ||' nu lucreaza angajati');
        elsif nr(i)=1 then
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume(i) ||' lucreaza 1 angajat');
        else
            DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume(i) ||' lucreaza '||nr(i) ||' angajati');
        end if;
        
        
    end loop;
    close C ;
    DBMS_OUTPUT.PUT_LINE (total);
    
end;
/

select employee_id ,(select count(*) from employees ee where ee.manager_id=e.employee_id) as nr
from employees e
order by nr Desc;


Declare
    cursor CC is 
        select first_name || last_name as nume ,(select count(*) from employees ee where ee.manager_id=e.employee_id) as nr
        from employees e
        order by nr Desc;  
    total number;
Begin
    
    total:=0;
    for i in CC loop
        
        DBMS_OUTPUT.PUT_LINE (i.nume||' are ' || i.nr || 'angajati');
        total:=total+1;
        
        if total>=3 then
            exit;
        end if;
    end loop;
    

  
    
end;
/



Declare
      
    nr number;
    nume departments.department_name%type;
    x number :=&numar;
    cursor C (x number) is 
        select department_name , (select count(*) from employees e where e.department_id=d.department_id) from
        departments d 
        where (select count(*) from employees e where e.department_id=d.department_id)=x;
 
Begin
   
    open C(x);

    fetch C into nume,nr;
    while C%found loop
        
            if nr=0 then
                DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' nu lucreaza angajati');
            elsif nr=1 then
                DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' lucreaza 1 angajat');
            else
                DBMS_OUTPUT.PUT_LINE ('In departamentul ' || nume ||' lucreaza '||nr ||' angajati');
            end if;
        
        fetch C into nume,nr;
        
    end loop;
    close C ;
    
end;
/
