DECLARE

salary number := 15000;
name varchar(20) := 'john';
signup date;


BEGIN

--    signup := TO_DATE('2024-01-31', 'YYYY-MM-DD');
--    dbms_output.put_line('Your salary is ' || salary);
--    dbms_output.put_line('Today''s date is ' || signup);
    
    
    DECLARE
        counter number := 200;
    
    BEGIN
--        if salary > 100000
--        then
--        dbms_output.put_line('Grade A');
--        elsif salary > 50000 and salary <= 100000
--        then
--        dbms_output.put_line('Grade B');
--        elsif salary > 25000 and salary <= 50000
--        then
--        dbms_output.put_line('Grade C');
--        elsif salary > 10000 and salary <= 25000
--        then
--        dbms_output.put_line('Grade D');
--        else
--        dbms_output.put_line('Grade E');        
--        end if;

--        CASE
--            when salary > 100000
--            then
--            dbms_output.put_line('Grade A');
--            when salary > 50000 and salary <= 100000
--            then
--            dbms_output.put_line('Grade B');
--            else
--            dbms_output.put_line('Grade E');        
--        END CASE;
        
--        WHILE counter <= 300
--            LOOP
--                dbms_output.put_line(counter);
--                counter := counter + 1;
--            END LOOP;
            
        FOR j in 200..300
            LOOP
                dbms_output.put_line(j);
            END LOOP;
        
    
    END;
    
    


END;