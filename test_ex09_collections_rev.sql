--Create an Associative array of character datatype and index it by number and perform
--the below operations.
-- Insert 10 values into this array
-- Delete 3rd element from the array
-- Delete 7th element from the array
-- Display the data from the array

DECLARE
    TYPE assoc_array_char IS TABLE OF varchar2(100) INDEX BY BINARY_INTEGER;
    table1 ASSOC_ARRAY_CHAR;

BEGIN

    FOR i IN 1..10 
    LOOP
        table1(i) := 'soo' || i;
    END LOOP;
    
    table1.delete(3);
    table1.delete(7);
    
    FOR i IN 1..10 
    LOOP
        IF i = 3 or i=7 THEN
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE(table1(i));
    END LOOP;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('no such value');
    WHEN OTHERS THEN
        dbms_output.put_line('ERRORS FOUND');

END;

/



DECLARE
    TYPE nested_table IS TABLE OF varchar2(100);
    table1 nested_table := nested_table();

BEGIN

    table1.extend(10);
    
    dbms_output.put_line(table1.last); -- outputs 10

    FOR i IN 1..10 LOOP
        table1(i) := 'soo' || i;
    END LOOP;
    
    table1.extend(10);

   
    table1.delete(3);
    table1.delete(7);
    
    FOR i IN 1..10
    LOOP
        IF i = 3 or i=7 THEN
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE(table1(i));
    END LOOP;


END;
/