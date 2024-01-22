-- USE A WHILE LOOP

DECLARE

    counter number := 1;


BEGIN

    FOR i in reverse 1..10
    LOOP
        dbms_output.put_line('value of i: ' || i);
    END LOOP;
    
    

    FOR j in 10..20 -- 10 and 20 are included
    LOOP
        dbms_output.put_line('value of j: ' || j);
    END LOOP;
    

   
    WHILE counter <= 10
    LOOP
        dbms_output.put_line('Value of counter:' || counter);
        counter := counter + 1;
    END LOOP;

END;
