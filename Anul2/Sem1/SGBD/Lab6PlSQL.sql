
create table info_dept_pva(
    id number,
    nume_dep varchar(100),
    plati number
    );


DECLARE
    n number:=0; 
BEGIN
    
    for i in (select department_name , department_id from departments) loop
        n := n+1;
        insert into info_dept_pva values(n,i.department_name,(select nvl(sum(salary),0) from employees where department_id=i.department_id));
        
    end loop;

END;
/


CREATE OR REPLACE PROCEDURE modific_plati_pva (v_codd info_dept_pva.id%TYPE, v_plati info_dept_pva.plati%TYPE) AS
BEGIN
     UPDATE info_dept_pva
     SET plati = NVL (plati, 0) + v_plati
     WHERE id = v_codd;
END;
/


--5
--a

create table info_emp_pva(
    id number,
    nume varchar(100),
    prenume varchar(100),
    salariu number(10,2),
    id_dept number
    );


--b
DECLARE
    n number:=0; 
BEGIN
    
    for i in (select first_name , last_name ,salary, department_id,department_name from employees join departments using (department_id)) loop
        n := n+1;
        
        insert into info_emp_pva values(n,i.first_name,i.last_name,i.salary,(select id from info_dept_pva where upper(i.department_name)=upper(nume_dep)));
        
    end loop;

END;
/


--c

create or replace view view_pva as 
    select e.*,d.nume_dep from info_emp_pva e join  info_dept_pva d on(e.id_dept=d.id);


--e
CREATE OR REPLACE TRIGGER trig_e_pva
INSTEAD OF INSERT OR DELETE OR UPDATE ON view_pva
FOR EACH ROW
    BEGIN
    IF DELETING THEN 
        -- delete un angajat
        delete from  info_emp_pva where id=:old.id;
        update info_dept_pva set plati =plati-:old.salariu where id=:old.id_dept;
     ELSIF UPDATING THEN
        --update pt toate coloanele unui angajat 
        update info_emp_pva set 
            salariu=:new.salariu,
            nume=:new.nume,
            prenume=:new.prenume,
            id_dept=:new.id_dept
        where id=:old.id;
        
        update info_dept_pva set plati =plati-:old.salariu +:new.salariu where id=:old.id_dept;
        
    
     ELSE 
        -- pt inser
         insert into info_emp_pva values(:new.id,:new.nume,:new.prenume,:new.salariu,:new.id_dept);
         update info_dept_pva set plati =plati+:new.salariu where id=:new.id_dept;
     END IF;
END;
/


select * from info_dept_pva;
select * from info_emp_pva;

select * from view_pva;
--presupunem ca adaugam date extra doar pentru emp nu si pt departament, iar la modificare modificam doar datele pt emp;
--la insert insereaza la inceput de tabel=) 
insert into view_pva values (107, 'Nume', 'Prenume',10,8,'Sales');
delete info_emp_pva where id=107;




