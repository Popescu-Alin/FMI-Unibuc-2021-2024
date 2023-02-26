DECLARE
 TYPE emp_record IS RECORD 
 (cod employees.employee_id%type, 
 salariu employees.salary%TYPE, 
 job employees.job_id%TYPE);
 v_ang emp_record;
BEGIN
 v_ang.cod:=700;
 v_ang.salariu:= 9000;
 v_ang.job:='SA_MAN';
 DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul '|| v_ang.cod || 
 ' si jobul ' || v_ang.job || ' are salariul ' || v_ang.salariu);
END;
/

select employee_id from employees;