CREATE OR REPLACE TRIGGER CUSTOMER_AFTER_UPDATE
    AFTER UPDATE
    ON CUSTOMER
    FOR EACH ROW -- TO INDICATE A ROW LEVEL TRIGGER

DECLARE
    V_USERNAME VARCHAR2(50);

BEGIN
    SELECT USER INTO V_USERNAME FROM DUAL;
    
    INSERT INTO AUDIT_TABLE
    VALUES ('CUSTOMER', V_USERNAME, SYSDATE, 'UPDATE OPERATION ROW LEVEL');

END;
/
SELECT * FROM CUSTOMER;
/

UPDATE CUSTOMER
SET FIRST_NAME = 'PETER'
WHERE FIRST_NAME = 'PETER A';
COMMIT;
/
select to_char(operation_date, 'DD-MM-YYYY HH:MM:SS') from audit_table
order by operation_date;

/

-- OLD and NEW pseudo records WITH CONDITIONAL WHEN
CREATE OR REPLACE TRIGGER CUSTOMER_UPDATE_VALUES
    AFTER UPDATE
        ON CUSTOMER
        FOR EACH ROW
        WHEN (OLD.REGION = 'EAST') -- USING CONDITIONALS TO CONTROL TRIGGER EXECUTION FOR CERTAIN COLUMN VALUES ONLY
DECLARE
    V_USERNAME VARCHAR2(50);
BEGIN

    SELECT USER INTO V_USERNAME FROM DUAL;
    
    INSERT INTO AUDIT_LOG (USERID, OPERATION_DATE, B_CUSTOMERID, A_CUSTOMERID, B_FIRSTNAME, A_FIRSTNAME) -- STORING THE OLD AND NEW VALUES
    VALUES (V_USERNAME, SYSDATE, :OLD.CUSTOMER_ID, :NEW.CUSTOMER_ID, :OLD.FIRST_NAME, :NEW.FIRST_NAME);

END;
/

SELECT * FROM AUDIT_LOG;

SELECT * FROM CUSTOMER;

/

UPDATE CUSTOMER
    SET FIRST_NAME = 'PETER'
    WHERE FIRST_NAME = 'SONU';
    COMMIT;
/


-- USING ANOTHER CONDITIONAL: OF
CREATE OR REPLACE TRIGGER CUSTOMER_UPDATE_VALUES
    AFTER UPDATE
        OF CUSTOMER_ID -- TO CONTROL TRIGGER FOR CERTAIN COLUMNS ONLY
        ON CUSTOMER
        FOR EACH ROW
DECLARE
    V_USERNAME VARCHAR2(50);
BEGIN

    SELECT USER INTO V_USERNAME FROM DUAL;
    
    INSERT INTO AUDIT_LOG (USERID, OPERATION_DATE, B_CUSTOMERID, A_CUSTOMERID, B_FIRSTNAME, A_FIRSTNAME) -- STORING THE OLD AND NEW VALUES
    VALUES (V_USERNAME, SYSDATE, :OLD.CUSTOMER_ID, :NEW.CUSTOMER_ID, :OLD.FIRST_NAME, :NEW.FIRST_NAME);

END;
/
SELECT * FROM AUDIT_LOG;

SELECT * FROM CUSTOMER;
/

UPDATE CUSTOMER
SET CUSTOMER_ID = 1000
WHERE CUSTOMER_ID = 10;


--  VARIOUS OPERATIONS ON TRIGGERS


-- DISABLE/ENABLE A TRIGGER
ALTER TRIGGER CUSTOMER_AFTER_UPDATE DISABLE;
ALTER TRIGGER CUSTOMER_AFTER_UPDATE ENABLE;

-- DISABLE/ENABLE ALL TRIGGERS ON A TABLE
ALTER TABLE CUSTOMER DISABLE ALL TRIGGERS;
ALTER TABLE CUSTOMER ENABLE ALL TRIGGERS;

-- RENAME A TRIGGER
ALTER TRIGGER CUSTOMER_AFTER_UPDATE RENAME TO CUSTOMER_AFTER_UPDATE_ACTION;
 
-- DELETE TRIGGER
DROP TRIGGER CUSTOMER_AFTER_UPDATE_ACTION;
