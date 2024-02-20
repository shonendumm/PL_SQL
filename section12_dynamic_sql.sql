SELECT * FROM CUSTOMER;
/

-- dynamic sql with bind variable

CREATE OR REPLACE PROCEDURE GET_CUSTOMER
(
    c_id customer.customer_id%type,
    c_fname customer.first_name%type
)
AS
    sql_stmt VARCHAR2(500) := 'SELECT * FROM CUSTOMER WHERE 1 = 1';  
    rec customer%ROWTYPE;

BEGIN

    IF c_id IS NOT NULL AND c_fname is NULL THEN
        EXECUTE IMMEDIATE sql_stmt || 'AND customer_id = :var1' INTO rec USING c_id;
    ELSIF c_fname IS NOT NULL AND c_id is NULL THEN
        EXECUTE IMMEDIATE sql_stmt || 'AND first_name = :var1' INTO rec USING c_fname;
    END IF;
    
        dbms_output.put_line(rec.customer_id);
        dbms_output.put_line(rec.first_name);
        

END GET_CUSTOMER;
/

EXEC GET_CUSTOMER(1000, null);
/

EXEC GET_CUSTOMER(null, 'TOM');
/

-- dynamic sql with cursors
CREATE OR REPLACE PROCEDURE GET_CUSTOMER
(
    c_id customer.customer_id%type,
    c_fname customer.first_name%type
)
AS
    sql_stmt VARCHAR2(500) := 'SELECT * FROM CUSTOMER WHERE 1 = 1';  
    rec customer%ROWTYPE;
--    c_cursor SYS_REFCURSOR;
    TYPE sales_cursor IS REF CURSOR;
    s_cursor sales_cursor;

BEGIN

    IF c_id IS NOT NULL AND c_fname is NULL THEN
        OPEN c_cursor for (sql_stmt || 'AND customer_id = :var1') USING c_id;
    ELSIF c_fname IS NOT NULL AND c_id is NULL THEN
        OPEN c_cursor for (sql_stmt || 'AND first_name = :var1') USING c_fname;
    END IF;
    
    LOOP
        FETCH c_cursor INTO REC;
        EXIT WHEN c_cursor%NOTFOUND;
        dbms_output.put_line(rec.customer_id);
        dbms_output.put_line(rec.first_name);
    END LOOP;
    
    CLOSE c_cursor;
        

END GET_CUSTOMER;
/

SELECT * FROM CUSTOMER;
/

-- dynamic sql with cursors and bulk collect
DECLARE
    sql_stmt VARCHAR2(500) := 'SELECT * FROM CUSTOMER WHERE 1 = 1';  
        TYPE cust_cursor IS REF CURSOR;
        c_cursor cust_cursor;
        c_mname customer.middle_name%type := 'K';
        c_id customer.customer_id%type;
        
        TYPE cust_collection IS TABLE OF customer%ROWTYPE;
        c_table cust_collection;

BEGIN

    IF c_id IS NOT NULL AND c_mname is NULL THEN
        OPEN c_cursor for (sql_stmt || 'AND customer_id = :var1') USING c_id;
    ELSIF c_mname IS NOT NULL AND c_id is NULL THEN
        OPEN c_cursor for (sql_stmt || 'AND middle_name = :var1') USING c_mname;
    END IF;
    
        FETCH c_cursor BULK COLLECT INTO c_table;
    
        FOR i in 1..c_table.count LOOP
            dbms_output.put_line(c_table(i).first_name);
        END LOOP;
    
    CLOSE c_cursor;
        

END;


/
-- DYNAMIC SQL with BULK COLLECT, remember to use collections for bulk collect
DECLARE
    sql_stmt VARCHAR2(500) := 'SELECT * FROM CUSTOMER WHERE 1 = 1';  
    TYPE collection_customer IS TABLE OF customer%ROWTYPE;
    t_customer collection_customer;
    c_middle customer.middle_name%TYPE := 'A';

BEGIN

    IF c_middle IS NOT NULL THEN
        sql_stmt := sql_stmt || ' AND customer.middle_name = :var1';
    END IF;
        
    EXECUTE IMMEDIATE sql_stmt BULK COLLECT INTO t_customer USING c_middle;
    
    FOR i IN 1..t_customer.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(t_customer(i).first_name);    
    END LOOP;   
    
    FORALL i in 1..t_customer.COUNT
        UPDATE customer c
            SET c.middle_name = 'K'
            WHERE c.middle_name = t_customer(i).middle_name;
        COMMIT;
    

END; 
/


