-- Using dbms_sql for dynamic sql

CREATE OR REPLACE PROCEDURE DELETE_CUSTOMER( customer_id IN NUMBER)
AS

    cursor_name integer;
    rows_processed integer;

BEGIN

--    OPEN THE CURSOR
    CURSOR_NAME := DBMS_SQL.OPEN_CURSOR;
    
--    PARSING THE SQL STATEMENT
    DBMS_SQL.PARSE(CURSOR_NAME, 'DELETE FROM CUSTOMER WHERE CUSTOMER_ID = :VAR1', DBMS_SQL.NATIVE);
    
--    BIND THE VARIABLES
    DBMS_SQL.BIND_VARIABLE(CURSOR_NAME, ':VAR1', CUSTOMER_ID);
    
--    EXECUTE THE CURSOR
    ROWS_PROCESSED := DBMS_SQL.EXECUTE(CURSOR_NAME);
    DBMS_OUTPUT.PUT_LINE(ROWS_PROCESSED);
                        
--    CLOSING THE CURSOR
    DBMS_SQL.CLOSE_CURSOR(CURSOR_NAME);
    
    

EXCEPTION
    WHEN OTHERS THEN
        DBMS_SQL.CLOSE_CURSOR(CURSOR_NAME);
    
END;

/
SELECT * FROM CUSTOMER;
/
EXEC DELETE_CUSTOMER(1000);

/

SELECT FIRST_NAME, LAST_NAME FROM CUSTOMER WHERE CUSTOMER_ID = 11;
/



DECLARE
    stmt VARCHAR2(500) := 'SELECT FIRST_NAME, LAST_NAME FROM CUSTOMER WHERE CUSTOMER_ID = :VAR1';
    c_cursor INTEGER;
    f_name customer.first_name%type;
    l_name customer.last_name%type;
    c_id customer.customer_id%type := 11;
    ROWS_PROCESSED integer;

BEGIN

    c_cursor := DBMS_SQL.open_cursor;
    
    DBMS_SQL.parse(c_cursor, stmt, DBMS_SQL.NATIVE);
    
    DBMS_SQL.BIND_VARIABLE(c_cursor, ':VAR1', c_id);
    
    DBMS_SQL.define_column(c_cursor, 1, f_name, 50);
    DBMS_SQL.define_column(c_cursor, 2, l_name, 50);
            
    ROWS_PROCESSED := DBMS_SQL.execute(c_cursor);
    
--    dbms_output.put_line(ROWS_PROCESSED);

--    DBMS_SQL.FETCH_ROWS(c_cursor);
    
    WHILE ROWS_PROCESSED > 0 LOOP
        dbms_output.put_line('done');
        dbms_sql.column_value(c_cursor,1, f_name);
        dbms_output.put_line(f_name);
    END LOOP;
    
    DBMS_SQL.close_cursor(c_cursor);

END;
/

