--1) Create an Associative array of character datatype and index it by number and perform
--the below operations.
--     Insert 10 values into this array
--     Delete 3rd element from the array
--     Delete 7th element from the array
--     Display the data from the array

DECLARE
    TYPE char_table IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;
        c_table char_table;
        c_index NUMBER;
BEGIN
    c_table(1) := 'A';
    c_table(2) := 'B';
    c_table(3) := 'C';
    c_table(4) := 'D';
    c_table(5) := 'E';
    c_table(6) := 'F';
    c_table(7) := 'G';
    c_table(8) := 'H';
    
    c_table.DELETE(3);
    c_table.DELETE(7);
    
    
    c_index := c_table.FIRST();
    
    WHILE c_index IS NOT NULL LOOP
        dbms_output.put_line(c_table(c_index));
        c_index := c_table.NEXT(c_index);
    END LOOP;
    
END;
/
    
    
-- 2) Create a Nested Table array of character datatype and perform the below operations.
--     Insert 10 values into this array
--     Delete 3rd element from the array
--     Delete 7th element from the array
--     Display the data from the array

DECLARE
    TYPE char_table IS TABLE OF VARCHAR2(50);
    c_table CHAR_TABLE := CHAR_TABLE();
    v_index NUMBER;

BEGIN
    c_table.EXTEND(10);

    c_table(1) := 'A';
    c_table(2) := 'B';
    c_table(3) := 'C';
    c_table(4) := 'D';
    c_table(5) := 'E';
    c_table(6) := 'F';
    c_table(7) := 'G';
    c_table(8) := 'H';
    c_table(9) := 'I';
    
    c_table.DELETE(3);
    c_table.DELETE(7);
    
    v_index := c_table.FIRST();
    
    WHILE v_index IS NOT NULL LOOP
        dbms_output.put_line(c_table(v_index));
        v_index := c_table.next(v_index);
    END LOOP;
    

END;
/



--3) Create a VARRAY array of character datatype which holds 10 values and perform the
--below operations.
--     Insert 10 values into this array
--     Display the data from the array

DECLARE
    TYPE var_table IS VARRAY(20) OF VARCHAR2(50);
    v_table var_table := var_table();
    v_index NUMBER;

BEGIN
    
    v_table.EXTEND(10);
    
    v_table(1) := 'A';
    v_table(2) := 'B';
    v_table(3) := 'C';
    v_table(4) := 'D';
    v_table(5) := 'E';
    v_table(6) := 'F';
    v_table(7) := 'G';
    v_table(8) := 'H';
    v_table(9) := 'I';
    
    v_index := v_table.FIRST();
    
    WHILE v_index IS NOT NULL LOOP
        dbms_output.put_line(v_table(v_index));
        v_index := v_table.next(v_index);
    END LOOP;
    

END;
/


