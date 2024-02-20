SELECT * FROM CUSTOMER;

/
CREATE OR REPLACE PROCEDURE FETCH_CUSTOMER
(
    c_fname customer.first_name%TYPE,
    c_id customer.customer_id%TYPE
)
AS

    command varchar2(500) := 'SELECT * FROM CUSTOMER ';
    c_rec customer%ROWTYPE;
    
BEGIN
    IF c_fname is NULL and c_id is not NULL THEN
        EXECUTE IMMEDIATE command || 'WHERE customer_id = :var1' into c_rec using c_id;
    ELSIF c_id is NULL and c_fname is not NULL THEN
        EXECUTE IMMEDIATE command || 'WHERE first_name = :var1' into c_rec using c_fname;
    END IF;
        
    DBMS_OUTPUT.PUT_LINE(c_rec.first_name);


END;

/

EXEC FETCH_CUSTOMER(null, 1000);
/
EXEC FETCH_CUSTOMER('TOM', null);
/


-- USING CURSOR

CREATE OR REPLACE PROCEDURE FETCH_CUSTOMER
(
    c_fname customer.first_name%TYPE,
    c_id customer.customer_id%TYPE
)
AS
    command varchar2(500) := 'SELECT * FROM CUSTOMER ';
    c_rec customer%ROWTYPE;
    TYPE c_cur IS REF CURSOR;
    cur c_cur;
    
    
BEGIN
    IF c_fname is NULL and c_id is not NULL THEN
        OPEN cur FOR (command || 'WHERE customer_id = :var1') using c_id;
    ELSIF c_id is NULL and c_fname is not NULL THEN
        OPEN cur FOR (command || 'WHERE first_name = :var1') using c_fname;
    END IF;
    
    LOOP
        FETCH cur INTO c_rec;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_rec.first_name || ' cursor method');
    END LOOP;
    
    CLOSE cur;

END;

/

EXEC FETCH_CUSTOMER(null, 1000);
/
EXEC FETCH_CUSTOMER('TOM', null);
/

INSERT INTO CUSTOMER
VALUES(1000, 'SOO', 'FOO', 'H', 'AMK', null, 'SG','Singapore', TO_DATE('10/01/24'), 'SOUTH');
COMMIT;
/

DECLARE
    terms varchar2(10);
    i number;
BEGIN
    i := FLOOR(DBMS_RANDOM.VALUE(1, 10));
    dbms_output.put_line(i);
    terms := DBMS_RANDOM.STRING('u', i);
    dbms_output.put_line(terms);

END;

/
DECLARE
    name varchar2(10);
    name2 varchar2(10);

    i number;
    d number := 30;

BEGIN

    WHILE TRUE LOOP
        EXIT WHEN d = 40;
        
        name := DBMS_RANDOM.STRING('u', 10);
        name2 := DBMS_RANDOM.STRING('u', 10);
        
        INSERT INTO CUSTOMER
        VALUES(d, name, name2, 'Z', 'TPY', null, 'SG', 'Singapore', SYSDATE, 'SOUTH');
        d := d + 1;
    END LOOP;
    
    COMMIT;

END;
/
BEGIN
    FOR C IN 
        (SELECT * FROM CUSTOMER 
        WHERE middle_name = 'Z')
    LOOP
        dbms_output.put_line(c.first_name);
    END LOOP;
END;
/
DECLARE
    TYPE c_table IS TABLE OF customer%ROWTYPE;
    c_tab c_table;
BEGIN
    SELECT * 
    BULK COLLECT INTO c_tab
    FROM CUSTOMER WHERE middle_name = 'Z';
    
    FOR i in 1.. c_tab.count LOOP
        dbms_output.put_line(c_tab(i).first_name);
    END LOOP;
     
    
END;
/


