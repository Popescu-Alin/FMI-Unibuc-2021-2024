--1


SELECT * from emp_pva;

DECLARE
     TYPE emp_record IS RECORD 
     (cod employees.employee_id%TYPE, 
     salariu employees.salary%TYPE);
    type t is varray(5) of emp_record ;
    tabel t:=t();
    sal_modif employees.salary%TYPE;
BEGIN 
    
    select employee_id,salary BULK COLLECT into tabel
    from(
        select * 
        from employees
        where commission_pct is null
        order by salary
    )where rownum<6;
    
    for i in tabel.first..tabel.last loop
        update emp_pva
        set salary = tabel(i).salariu*105/100
        where emp_pva.employee_id=tabel(i).cod;
    end loop;
    
    for i in tabel.first..tabel.last loop
        select salary into sal_modif
        from emp_pva
        where emp_pva.employee_id=tabel(i).cod;
        
        DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul '|| tabel(i).cod || ' salariu ' || tabel(i).salariu ||  ' initial ' || sal_modif);
    end loop;
 
END;
/

--2
CREATE OR REPLACE TYPE tip_oras_pva AS VARRAY(10) OF varchar(100);
/
CREATE TABLE excursie_pva ( cod_excursie NUMBER(4),
                            denumire VARCHAR2(20),
                            orase tip_oras_pva,
                            status varchar(20));



--a
DECLARE
    t tip_oras_pva := tip_oras_pva('Pitesti','Bucuresti','Galati','Ploiesti');
BEGIN 
     insert into excursie_pva
    values(1,'best_trip1',tip_oras_pva('Bucuresti'),'disponibil');
    insert into excursie_pva
    values(2,'best_trip2',t,'disponibil');
    
    insert into excursie_pva
    values(3,'best_trip3',NULL,'disponibil');
    
    insert into excursie_pva
    values(4,'best_trip4',tip_oras_pva('Bucuresti','Galati'),'disponibil');
    
    insert into excursie_pva
    values(5,'best_trip5',tip_oras_pva('Bucuresti','Galati','Braila','Iasi'),'disponibil');
        
END;
/
select* from excursie_pva;

--b
--i
DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva:=tip_oras_pva();  
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva
    where cod_excursie=id;
    
    if oraseDinTabela is not null then
        total:=oraseDinTabela.count();
        oraseDinTabela.extend();
        oraseDinTabela(total+1):=oras;
        
        update excursie_pva
        set orase = oraseDinTabela
        where cod_excursie=id;
    else
        update excursie_pva
        set orase = tip_oras_pva(oras)
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

--b
--ii




DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva:=tip_oras_pva();  
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=oraseDinTabela.count();
        oraseDinTabela.extend();
        while total>=2 loop
            oraseDinTabela(total+1):=oraseDinTabela(total);
            total:=total-1;
        end loop;
        oraseDinTabela(2):=oras;
        
        update excursie_pva
        set orase = oraseDinTabela
        where cod_excursie=id;
    else
        update excursie_pva
        set orase = tip_oras_pva(oras)
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/
select * from excursie_pva;
rollback;


--b 
--iii

DECLARE
    oras1 varchar(200);
    oras2 varchar(200);
    id int;
    indice1 int;
    indice2 int;
    total int;
    oraseDinTabela tip_oras_pva:=tip_oras_pva();  
BEGIN 
    id := &IdExcursie;
    oras1 := '&Oras';
    oras2 := '&Oras';
    indice1:=-1;
    indice2:=-2;
    
    select orase into oraseDinTabela
    from excursie_pva
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=oraseDinTabela.count();
        if total!=1 then
            --determin indicele celor 2 orase.
            for i in oraseDinTabela.first..oraseDinTabela.last loop
                if lower(oraseDinTabela(i))=lower(oras1) then
                    indice1:=i;
                elsif lower(oraseDinTabela(i))=lower(oras2) then
                    indice2:=i;
                end if;
            end loop;
            
            if indice1=-1 or indice2=-1 then
                DBMS_OUTPUT.PUT_LINE ('unul dinre orase nu exista');
            else
                oraseDinTabela(indice1):=oras2;
                oraseDinTabela(indice2):=oras1;
                update excursie_pva
                set orase = oraseDinTabela
                where cod_excursie=id;                    
            end if;
    
        end if;
    else
        DBMS_OUTPUT.PUT_LINE ('nu exista orase in excursie.');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

select* from excursie_pva;

--b
--iv

DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva:=tip_oras_pva();  
    oraseUpdate tip_oras_pva:=tip_oras_pva();  
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=1;
        for i in oraseDinTabela.first..oraseDinTabela.last loop
            if lower(oraseDinTabela(i))!=lower(oras) then
                oraseUpdate.extend();
                oraseUpdate(total):=oraseDinTabela(i);
                total:=total+1;
            end if;
        end loop;
        
        update excursie_pva
        set orase = oraseUpdate
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

select* from excursie_pva;

--update excursie_pva
--set orase = NULL   
--where cod_excursie=3;


--c
DECLARE
  
    id int;
    oraseDinTabela tip_oras_pva:=tip_oras_pva();  
BEGIN 
    id := &IdExcursie; 
    
    select orase into oraseDinTabela
    from excursie_pva
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        DBMS_OUTPUT.PUT_LINE (oraseDinTabela.count());
        for i in oraseDinTabela.first..oraseDinTabela.last loop
            DBMS_OUTPUT.PUT_LINE (oraseDinTabela(i));
        end loop;
    else
        DBMS_OUTPUT.PUT_LINE('nu exista orase in excursie');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

--d
DECLARE
     TYPE ex_record IS RECORD 
     (denumire excursie_pva.denumire%TYPE, 
     orase excursie_pva.orase%TYPE);
    type t is varray(200) of ex_record ;
    excursii t:=t();  
BEGIN 
    
    select denumire,orase BULK COLLECT into excursii
    from excursie_pva;
    
    if excursii is not null then
        for i in excursii.first..excursii.last loop
            DBMS_OUTPUT.PUT_LINE (excursii(i).denumire);
            
            if excursii(i).orase is not null then
                if excursii(i).orase.count()>0 then
                    for j in excursii(i).orase.first..excursii(i).orase.last loop
                        DBMS_OUTPUT.PUT_LINE (excursii(i).orase(j));
                    end loop;
                else
                    DBMS_OUTPUT.PUT_LINE('nu exista orase in aceasta excursie');
                end if;
            else 
                DBMS_OUTPUT.PUT_LINE('nu exista orase in aceasta excursie');
            end if;
            
            DBMS_OUTPUT.PUT_LINE('');

        end loop;
        
    else
        DBMS_OUTPUT.PUT_LINE('nu exista excursii');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;

/

--e
DECLARE
     TYPE ex_record IS RECORD 
     (id excursie_pva.cod_excursie%type,
     orase excursie_pva.orase%TYPE);
    type t is varray(200) of ex_record ;
    excursii t:=t();  
    minim int;
    temp int;
BEGIN 
    minim:=20000;
    select cod_excursie,orase BULK COLLECT into excursii
    from excursie_pva;
    
    if excursii is not null then
        for i in excursii.first..excursii.last loop            
            if excursii(i).orase is not null then 
                temp:=excursii(i).orase.count();
                if temp<minim then
                    minim:=temp;
                end if;
            else--daca nu am orase inseamna ca min =0
                minim:=0;
            end if;
        end loop;
        
        for i in excursii.first..excursii.last loop
        
            if excursii(i).orase is not null then 
               temp:=excursii(i).orase.count();
            else--daca nu am orase inseamna ca min =0
                temp:=0;
            end if;
            
            if temp=minim then
                update excursie_pva
                set status='indisponibil'
                where cod_excursie=excursii(i).id;
                
            end if;
            
        end loop;
        
        
    else
    
        DBMS_OUTPUT.PUT_LINE('nu exista excursii');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/


select * from excursie_pva;



--3

CREATE OR REPLACE TYPE tip_oras_pva2 IS TABLE OF VARCHAR2(200);
/
CREATE TABLE excursie_pva22 ( cod_excursie NUMBER(4),
                            denumire VARCHAR2(20),
                            orase tip_oras_pva2,
                            status varchar(20)
                            )
                            nested table orase store as excursie_pva2;



--a

DECLARE
    t tip_oras_pva2 := tip_oras_pva2('Pitesti','Bucuresti','Galati','Ploiesti');
BEGIN 
    insert into excursie_pva22
    values(1,'best_trip1',tip_oras_pva2('Bucuresti'),'disponibil');
   
    insert into excursie_pva22
    values(2,'best_trip2',t,'disponibil');
    
    insert into excursie_pva22
    values(3,'best_trip3',NULL,'disponibil');
    
    insert into excursie_pva22
    values(4,'best_trip4',tip_oras_pva2('Bucuresti','Galati'),'disponibil');
    
    insert into excursie_pva22
    values(5,'best_trip5',tip_oras_pva2('Bucuresti','Galati','Braila','Iasi'),'disponibil');
        
END;
/
select * from excursie_pva22;

--b
--i

DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva2:=tip_oras_pva2();  
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva22
    where cod_excursie=id;
    
    if oraseDinTabela is not null then
        total:=oraseDinTabela.count();
        oraseDinTabela.extend();
        oraseDinTabela(total+1):=oras;
        
        update excursie_pva22
        set orase = oraseDinTabela
        where cod_excursie=id;
    else
        update excursie_pva22
        set orase = tip_oras_pva2(oras)
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/


select * from excursie_pva22;

--ii
DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva2:=tip_oras_pva2(); 
   
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva22
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=oraseDinTabela.count();
        oraseDinTabela.extend();
        while total>=2 loop
            oraseDinTabela(total+1):=oraseDinTabela(total);
            total:=total-1;
        end loop;
        oraseDinTabela(2):=oras;
        
        update excursie_pva22
        set orase = oraseDinTabela
        where cod_excursie=id;
    else
        update excursie_pva22
        set orase = tip_oras_pva2(oras)
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

select * from excursie_pva22;
rollback;

--iii
DECLARE
    oras1 varchar(200);
    oras2 varchar(200);
    id int;
    indice1 int;
    indice2 int;
    total int;
    oraseDinTabela tip_oras_pva2:=tip_oras_pva2();  
BEGIN 
    id := &IdExcursie;
    oras1 := '&Oras';
    oras2 := '&Oras';
    indice1:=-1;
    indice2:=-2;
    
    select orase into oraseDinTabela
    from excursie_pva22
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=oraseDinTabela.count();
        if total!=1 then
            --determin indicele celor 2 orase.
            for i in oraseDinTabela.first..oraseDinTabela.last loop
                IF oraseDinTabela.EXISTS(i) THEN 
                    if lower(oraseDinTabela(i))=lower(oras1) then
                        indice1:=i;
                    elsif lower(oraseDinTabela(i))=lower(oras2) then
                        indice2:=i;
                    end if;
                end if;
            end loop;
            
            if indice1=-1 or indice2=-1 then
                DBMS_OUTPUT.PUT_LINE ('unul dinre orase nu exista');
            else
                oraseDinTabela(indice1):=oras2;
                oraseDinTabela(indice2):=oras1;
                
                update excursie_pva22
                set orase = oraseDinTabela
                where cod_excursie=id;                    
            end if;
    
        end if;
    else
        DBMS_OUTPUT.PUT_LINE ('nu exista orase in excursie.');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

select * from excursie_pva22;


--iv

DECLARE
    oras varchar(200);
    id int;
    indice int;
    total int;
    oraseDinTabela tip_oras_pva2:=tip_oras_pva2();  
    oraseUpdate tip_oras_pva2:=tip_oras_pva2();
BEGIN 
    id := &IdExcursie;
    oras := '&Oras';  
    
    select orase into oraseDinTabela
    from excursie_pva22
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        total:=1;
        for i in oraseDinTabela.first..oraseDinTabela.last loop
            if lower(oraseDinTabela(i))!=lower(oras) then
                oraseUpdate.extend();
                oraseUpdate(total):=oraseDinTabela(i);
                total:=total+1;
            end if;
        end loop;
        
        update excursie_pva22
        set orase = oraseUpdate
        where cod_excursie=id;
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

select * from excursie_pva22;


--c
DECLARE
  
    id int;
    oraseDinTabela tip_oras_pva2:=tip_oras_pva2();  
BEGIN 
    id := &IdExcursie; 
    
    select orase into oraseDinTabela
    from excursie_pva22
    where cod_excursie=id;
    
    if oraseDinTabela is not null and oraseDinTabela.count()>0 then
        DBMS_OUTPUT.PUT_LINE (oraseDinTabela.count());
        for i in oraseDinTabela.first..oraseDinTabela.last loop
            DBMS_OUTPUT.PUT_LINE (oraseDinTabela(i));
        end loop;
    else
        DBMS_OUTPUT.PUT_LINE('nu exista orase in excursie');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

--d

DECLARE
     TYPE ex_record IS RECORD 
     (denumire excursie_pva22.denumire%TYPE, 
     orase excursie_pva22.orase%TYPE);
    type t is varray(200) of ex_record ;
    excursii t:=t();  
BEGIN 
    
    select denumire,orase BULK COLLECT into excursii
    from excursie_pva22;
    
    if excursii is not null  then
        for i in excursii.first..excursii.last loop
            DBMS_OUTPUT.PUT_LINE (excursii(i).denumire);
            
            if excursii(i).orase is not null then
                if excursii(i).orase.count()>0 then
                    for j in excursii(i).orase.first..excursii(i).orase.last loop
                        DBMS_OUTPUT.PUT_LINE (excursii(i).orase(j));
                    end loop;
                else
                    DBMS_OUTPUT.PUT_LINE('nu exista orase in aceasta excursie');
                end if;
            else 
                DBMS_OUTPUT.PUT_LINE('nu exista orase in aceasta excursie');
            end if;
            
            DBMS_OUTPUT.PUT_LINE('');

        end loop;
        
    else
        DBMS_OUTPUT.PUT_LINE('nu exista excursii');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/

--e
DECLARE
     TYPE ex_record IS RECORD 
     (id excursie_pva22.cod_excursie%type,
     orase excursie_pva22.orase%TYPE);
    type t is varray(200) of ex_record ;
    excursii t:=t();  
    minim int;
    temp int;
BEGIN 
    minim:=20000;
    select cod_excursie,orase BULK COLLECT into excursii
    from excursie_pva22;
    
    if excursii is not null then
        for i in excursii.first..excursii.last loop            
            if excursii(i).orase is not null then 
                temp:=excursii(i).orase.count();
                if temp<minim then
                    minim:=temp;
                end if;
            else--daca nu am orase inseamna ca min =0
                minim:=0;
            end if;
        end loop;
        
        for i in excursii.first..excursii.last loop
        
            if excursii(i).orase is not null then 
               temp:=excursii(i).orase.count();
            else--daca nu am orase inseamna ca min =0
                temp:=0;
            end if;
            
            if temp=minim then
                update excursie_pva22
                set status='indisponibil'
                where cod_excursie=excursii(i).id;
                
            end if;
            
        end loop;
        
        
    else
    
        DBMS_OUTPUT.PUT_LINE('nu exista excursii');
    end if; 
   
EXCEPTION
    WHEN NO_DATA_FOUND 
        THEN DBMS_OUTPUT.PUT_LINE ('id-ul nu exista') ;    
END;
/


select * from excursie_pva22;
