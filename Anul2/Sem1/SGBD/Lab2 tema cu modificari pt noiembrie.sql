---Lab2
--6

select copy_id , title_id ,status ,  nvl((select distinct CASE
                                                            WHEN  act_ret_date is null 
                                                                THEN 'rented'
                                                            ELSE 'available'
                                                        END  
                                                from rental rigt join title_copy using(title_id,copy_id)
                                                where book_date = (select max(rent.book_date)
                                                                    from rental rent
                                                                    where rent.title_id=tc.title_id and rent.copy_id=tc.copy_id)), 'available') as "Actual Status"
from title_copy tc;

--7
--a
select count(*)
from
(select copy_id , title_id ,status ,  nvl((select distinct CASE
                                                            WHEN  act_ret_date is null
                                                                THEN 'rented'
                                                            ELSE 'available'
                                                        END  
                                                from rental rigt join title_copy using(title_id,copy_id)
                                                where book_date = (select max(rent.book_date)
                                                                    from rental rent
                                                                    where rent.title_id=tc.title_id and rent.copy_id=tc.copy_id)), 'available') as "A_S"
from title_copy tc)
where upper(status)!= upper(A_S);

--b 
create TABLE title_copy_PVA as  select * from title_copy;

drop TABLE title_copy_PVA;

update title_copy_pva tcpva
set status=(CASE
            when lower(status) != 'available' then 'rented'
            else 'available'
            end)
where title_id  in 
(select title_id
from
    (select copy_id , title_id ,status ,  nvl((select distinct CASE
                                                                WHEN  act_ret_date is null 
                                                                    THEN 'rented'
                                                                ELSE 'available'
                                                            END  
                                                    from rental rigt join title_copy using(title_id,copy_id)
                                                    where book_date = (select max(rent.book_date)
                                                                        from rental rent
                                                                        where rent.title_id=tc.title_id and rent.copy_id=tc.copy_id)), 'available') as A_S
    from title_copy tc)  sursa
where upper(status)!= upper(A_S) and sursa.title_id=tcpva.title_id and sursa.copy_id=tcpva.copy_id
)
and
copy_id  in 
(select copy_id
from
    (select copy_id , title_id ,status ,  nvl((select distinct CASE
                                                                WHEN  act_ret_date is null 
                                                                    THEN 'rented'
                                                                ELSE 'available'
                                                            END  
                                                    from rental rigt join title_copy using(title_id,copy_id)
                                                    where book_date = (select max(rent.book_date)
                                                                        from rental rent
                                                                        where rent.title_id=tc.title_id and rent.copy_id=tc.copy_id)), 'available') as A_S
    from title_copy tc) sursa
where upper(status)!= upper(A_S) and sursa.title_id=tcpva.title_id and sursa.copy_id=tcpva.copy_id
);


select * from title_copy_PVA;


--8

select * from member;
select * from rental;
select * from reservation;

select * 
from reservation re join member m on (re.member_id=m.member_id);


select  case 
            when ( select res_date
                from reservation re join member m on (re.member_id=m.member_id)
                                     join rental r on (r.member_id=m.member_id and r.title_id=re.title_id) 
                where to_char(res_date,'dd-mm-yy')!=to_char(book_date,'dd-mm-yy') and ROWNUM <= 1) is null 
                then 'Da'
            else 'Nu'
        end as ok
                        
from dual;

--9
select distinct first_name || ' ' || last_name  as "nume" , title as "titlu" , (select count(*) from rental where r.title_id = title_id and r.member_id=member_id ) as "NR"
from member m join rental r on(r.member_id=m.member_id)
            join title t on (r.title_id=t.title_id); 

--10
select distinct first_name || ' ' || last_name  as "nume" , title as "titlu",copy_id , (select count(*) from rental where r.title_id = title_id and r.copy_id=copy_id and r.member_id=member_id ) as "NR"
from member m join rental r on(r.member_id=m.member_id)
            join title t on (r.title_id=t.title_id); 
            
--11

SELECT tc.* ,(select count(*) from rental where title_id=tc.title_id and copy_id=tc.copy_id)
from title_copy tc
where nvl((select count(*) from rental where title_id=tc.title_id and copy_id=tc.copy_id),0)=nvl((select max(count(*)) from rental  where title_id=tc.title_id GROUP by(copy_id)),0) ;

select * from title_copy;

--12 \
select * 
from rental;
--a
select count(*) 
from rental
where to_char(rental.book_date,'dd') =1 or to_char(rental.book_date,'dd')=2;
--b
select distinct to_char(rent.book_date,'dd')as "day" ,(select count(*) 
                                                            from rental
                                                            where to_char(rental.book_date,'dd-mm-yy') = to_char(rent.book_date,'dd-mm-yy') ) as "nr"

from rental rent
order by to_char(rent.book_date,'dd');

--c
select  to_char(Data_Din_Luna,'dd') as "zi" , to_char(Data_Din_Luna,'month')as "luna" ,(select count(*) 
                                                                                                      from rental
                                                                                                      where to_char(rental.book_date,'dd-mm-yy') = to_char(Data_Din_Luna,'dd-mm-yy') ) as "nr"

from
(SELECT to_date('01-nov-2022','dd-mon-yyyy') + rownum - 1 as Data_Din_Luna
from dual
connect by rownum <= 30) ;



