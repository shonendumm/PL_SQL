-- Collections

-- Index by tables / Associative Array
-- Indexed by numbers, strings
-- Cannot be stored in database
-- values can be inserted at any integer / sparse table

DECLARE
    TYPE customer_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    
    customer_table customer_type;
    v_idx number;

BEGIN
    customer_table(0) := 'Zero'; -- can also be zero
    customer_table(1) := 'Mike';
    customer_table(2) := 'Alpha';
    customer_table(3) := 'Beta';
    customer_table(6) := 'Charlie';
    
    customer_table.DELETE(1);
    
    v_idx := customer_table.FIRST();
    
    WHILE v_idx IS NOT NULL LOOP
        dbms_output.put_line(customer_table(v_idx));
        v_idx := customer_table.NEXT(v_idx);
    END LOOP;
    
--    dbms_output.put_line(customer_table(1)); -- no data found because already deleted at position 1  
END;
/

-- Another array using index by string VARCHAR2
DECLARE
    TYPE customer_type IS TABLE OF VARCHAR2(100) INDEX BY VARCHAR2(50);
    
    customer_table customer_type;
    v_idx VARCHAR2(50);

BEGIN
    customer_table('Zero') := 'Zero'; -- can also be zero
    customer_table('One') := 'Mike';
    customer_table('Two') := 'Alpha';
    
    customer_table.DELETE('One');
    
    v_idx := customer_table.FIRST();
    
    WHILE v_idx IS NOT NULL LOOP
        dbms_output.put_line(customer_table(v_idx));
        v_idx := customer_table.NEXT(v_idx);
    END LOOP;
    
END;
/


-- NESTED TABLES
-- Need to be initialized
-- Can be stored in a database
-- indexed only by integer
-- almost always dense
DECLARE
    TYPE customer_type IS TABLE OF VARCHAR2(100);
    customer_table customer_type := customer_type();
    v_idx NUMBER;
    
BEGIN
    customer_table.EXTEND(4);
    customer_table(1) := 'Zero';
    customer_table(2) := 'Alpha';
    customer_table(3) := 'Beta';
--    customer_table(6) := 'Charlie'; -- subscript beyond count error

    v_idx := customer_table.FIRST();
    
    customer_table.EXTEND(4);
    
    customer_table.DELETE(2);

    WHILE v_idx IS NOT NULL LOOP
        dbms_output.put_line(customer_table(v_idx));
        v_idx := customer_table.NEXT(v_idx);
    END LOOP;
        
END;
/

-- VARRAY
-- Similar to nested tables, but must specify upper bound (same as initialization, and extend)

DECLARE
    TYPE customer_type IS VARRAY(4) OF VARCHAR2(100);
    customer_table customer_type := customer_type();
    v_idx NUMBER;
    
BEGIN
    customer_table.EXTEND(4);
    customer_table(1) := 'Zero';
    customer_table(2) := 'Alpha';
    customer_table(3) := 'Beta';
--    customer_table(4) := 'Charlie'; -- subscript beyond count error

    v_idx := customer_table.FIRST();
    
--    customer_table.EXTEND(4); -- cannot extend again
--    customer_table.DELETE(2); -- Cannot delete item

    WHILE v_idx IS NOT NULL LOOP
        dbms_output.put_line(customer_table(v_idx));
        v_idx := customer_table.NEXT(v_idx);
    END LOOP;
    
    
        
END;
/

-- MULTISET OPERATORS

DECLARE

    TYPE t_table IS TABLE OF NUMBER;
    tab1 t_table := t_table(1,2,3,4,5);
    tab2 t_table := t_table(5,6,7,8,9,10);

BEGIN

--    tab1 := tab1 MULTISET UNION tab2;
--    tab1 := tab1 MULTISET UNION DISTINCT tab2; -- unique set
--    tab1 := tab1 MULTISET EXCEPT tab2; -- set 1 minus set 2
    tab1 := tab1 MULTISET INTERSECT tab2; -- intersection of 1 with 2
    
    
    FOR i IN tab1.FIRST .. tab1.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(tab1(i));
     
    END LOOP;
    

END;
/








    


