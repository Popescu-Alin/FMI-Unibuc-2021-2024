--1
DECLARE
     FUNCTION f1  ( v_nume in employees.last_name%TYPE)    RETURN employees.salary%type 
     IS
        salariu employees.salary%type; 
     BEGIN
         SELECT salary INTO salariu 
         FROM employees
         WHERE last_name = v_nume;
         RETURN salariu;
     
    END f1;
     
BEGIN
     DBMS_OUTPUT.PUT_LINE('Salariul este '|| f1('&p_nume'));

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END;
/

--3
DECLARE
     Procedure    f1  ( v_nume in employees.last_name%TYPE)    
     IS
        salariu employees.salary%type; 
     BEGIN
         SELECT salary INTO salariu 
         FROM employees
         WHERE last_name = v_nume;
         
        DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
     END f1;
     
BEGIN
     f1('&p_nume');
END;
/

--4
create or replace
Procedure    f1  ( v_nume in employees.last_name%TYPE)    
     IS
        salariu employees.salary%type; 
     BEGIN
         SELECT salary INTO salariu 
         FROM employees
         WHERE last_name = v_nume;
         
        DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END f1;
/
DECLARE
     
     
BEGIN
     f1('&p_nume');
END;
/

--5
DECLARE
    id employees.employee_id%type:=&id_cva;
    
     Procedure    f1  ( id_c in out employees.employee_id%TYPE)    
     IS
        
     BEGIN
         SELECT manager_id INTO id_c 
         FROM employees
         WHERE employee_id = id_c;
         
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
     END f1;
     
BEGIN
     f1(id);
     DBMS_OUTPUT.PUT_LINE(id);
END;
/
--7
DECLARE
    
    
     FUNCTION  f1  ( id_d in  employees.department_id%TYPE) return number    
     IS
        medie employees.salary%type; 
     BEGIN
         SELECT avg(salary) INTO medie 
         FROM employees
         WHERE department_id = id_d;
         return medie;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
     END f1;
     
     
     FUNCTION  f1  ( id_d in  employees.department_id%TYPE, id_j in employees.job_id%TYPE ) return number    
     IS
        medie employees.salary%type; 
     BEGIN
         SELECT avg(salary) INTO medie 
         FROM employees
         WHERE department_id = id_d and job_id=id_j;
         return medie;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
     END f1;
     
BEGIN
     
     DBMS_OUTPUT.PUT_LINE(f1(80));
     DBMS_OUTPUT.PUT_LINE(f1(80,'SA_REP'));
END;
/
select * from employees where department_id=80;



--8
DECLARE
     
     FUNCTION  f1  ( nr in  number) return number    
     IS
        
     BEGIN
        if nr=0 then
            return 1;
        end if;
         return nr * f1(nr-1);
    
     END f1;
     
BEGIN
     
     DBMS_OUTPUT.PUT_LINE(f1(5));
    
END;
/




--tema
--1.
CREATE TABLE info_PVA(
    nume VARCHAR2(250) ,
    data date ,
    comanda VARCHAR2(250),
    eroare VARCHAR2(250) ,
    nr_linii number(3)
);

select * from info_PVA;


--2
--functia de la 2
create or replace
FUNCTION f2  ( v_nume in employees.last_name%TYPE)    RETURN employees.salary%type 
     IS
        salariu employees.salary%type; 
     BEGIN
         SELECT salary INTO salariu 
         FROM employees
         WHERE last_name = v_nume;
         insert into info_PVA
             values ((select user from dual),sysdate,'f2('||v_nume||')','exist? un singur angajat cu numele specificat',1);
         RETURN salariu;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             insert into info_PVA
             values ((select user from dual),sysdate,'f2('||v_nume||')','nu exist?  angajati cu numele specificat',0);
             
        WHEN TOO_MANY_ROWS THEN
            insert into info_PVA
             values ((select user from dual),sysdate,'f2('||v_nume||')','exist? mai mul?i angaja?i cu numele specificat',(SELECT count(*) 
                                                                                        FROM employees
                                                                                        WHERE last_name = v_nume));
END f2;
/

DECLARE
     
     
BEGIN
     DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2('&p_nume'));

EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '|| 'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END;
/

--procedura de la 4.



