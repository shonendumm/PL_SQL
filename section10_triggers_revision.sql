CREATE TABLE sales_audit_table
(
    userid VARCHAR2(200),
    operation_date TIMESTAMP,
    operation VARCHAR2(200)
);

INSERT INTO sales_audit_table
VALUES ('TEST', SYSDATE, 'updating');

SELECT * FROM sales_audit_table;

DROP TABLE sales_audit_table;

SELECT USER FROM DUAL;

/

-- CREATE TRIGGER
CREATE OR REPLACE TRIGGER UPDATED_SALES_TABLE
    AFTER UPDATE OR INSERT OR DELETE
    ON SALES
    FOR EACH ROW

DECLARE
    username VARCHAR2(200);
    operation_name VARCHAR2(200);

BEGIN
    SELECT USER INTO USERNAME FROM DUAL;
    
    IF UPDATING THEN
        operation_name := 'updated sales table';
    ElSIF INSERTING THEN
        operation_name := 'inserted into sales table';
    ELSIF DELETING THEN
        operation_name := 'deleted sales table';
    END IF;
    
    INSERT INTO sales_audit_table
    VALUES (username, SYSTIMESTAMP, operation_name);
    
    
END UPDATED_SALES_TABLE;

/

SELECT * FROM SALES;
SELECT * FROM SALES_AUDIT_TABLE;

/

UPDATE SALES
    SET ORDER_ID = 1272
    WHERE ORDER_ID = 1270 AND ROWNUM = 1;

/

INSERT INTO SALES
SELECT * FROM SALES WHERE ORDER_ID = 1272;
/

DELETE SALES
WHERE ORDER_ID = 1272 AND ROWNUM = 1;

