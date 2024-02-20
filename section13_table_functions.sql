SELECT * FROM sales;
/

-- Create object in the database
CREATE OR REPLACE TYPE SALES_ROW AS OBJECT
(
    S_DATE DATE,
    S_ORDERID NUMBER,
    S_PRODUCTID NUMBER,
    S_CUSTOMERID NUMBER,
    S_TOTALAMOUNT NUMBER
);
/

-- CREATE A TABLE OF TYPE SALES_ROW in database
CREATE TYPE SALES_TABLE IS TABLE OF SALES_ROW;
/


-- table functions
CREATE OR REPLACE FUNCTION FETCH_SALES_TABLE(S_ORDERID NUMBER) 
RETURN SALES_TABLE
IS
    RESULT_TABLE SALES_TABLE := SALES_TABLE();
BEGIN

-- For cursor in.. loop is a way of looping and fetching rows    
    FOR C IN
        (
        SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, TOTAL_AMOUNT
        FROM SALES WHERE ORDER_ID = S_ORDERID
        )
    LOOP
        RESULT_TABLE.EXTEND;
        RESULT_TABLE(RESULT_TABLE.LAST) := SALES_ROW(C.SALES_DATE, C.ORDER_ID, C.PRODUCT_ID, C.CUSTOMER_ID, C.TOTAL_AMOUNT);
    END LOOP;

    RETURN RESULT_TABLE;
END; 

/

SELECT * FROM TABLE(FETCH_SALES_TABLE(1270));

/

-- Pipelined Functions, process and send out data as they are created, saving memory
-- allows subsequent processing as the rows are generated
CREATE OR REPLACE FUNCTION PIPE_SALES_TABLE(S_ORDERID NUMBER) 
RETURN SALES_TABLE
PIPELINED
IS
--    RESULT_TABLE SALES_TABLE := SALES_TABLE();
BEGIN
 
    FOR C IN
        (
        SELECT SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID, TOTAL_AMOUNT
        FROM SALES WHERE ORDER_ID = S_ORDERID
        )
    LOOP
--        RESULT_TABLE.EXTEND;
--        RESULT_TABLE(RESULT_TABLE.LAST) := SALES_ROW(C.SALES_DATE, C.ORDER_ID, C.PRODUCT_ID, C.CUSTOMER_ID, C.TOTAL_AMOUNT);
            PIPE ROW (SALES_ROW(C.SALES_DATE, C.ORDER_ID, C.PRODUCT_ID, C.CUSTOMER_ID, C.TOTAL_AMOUNT));
    END LOOP;

END; 

/

SELECT * FROM TABLE(PIPE_SALES_TABLE(1270));





















-- Using cursors bulk collect does not work for sales_row and result_table.
-- Because we cannot select sales_row from sales.

DECLARE
    
    CURSOR C IS
        SELECT * FROM SALES WHERE ORDER_ID = 1270;
        
    TYPE collection_sales IS TABLE OF C%ROWTYPE;
        COLLECT_SALES COLLECTION_SALES;
BEGIN
    OPEN C;
        
    FETCH C BULK COLLECT INTO COLLECT_SALES;
    
    CLOSE C;
    
    FOR idx IN 1..COLLECT_SALES.COUNT
        LOOP
            dbms_output.put_line(collect_sales(idx).order_id);
        END LOOP;
    
END;
/


