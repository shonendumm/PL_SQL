CREATE OR REPLACE PROCEDURE CHECK_ELIGIBLE_ORDER
(
    CH_ORDER_ID SALES.ORDER_ID%TYPE,
    ELIGIBLE OUT BOOLEAN
)
AS CH_TOTAL_AMOUNT SALES.TOTAL_AMOUNT%TYPE;
BEGIN
    
    SELECT total_amount INTO CH_TOTAL_AMOUNT FROM SALES
    WHERE ORDER_ID = CH_ORDER_ID AND ROWNUM = 1; -- select the first row if there are duplicate order_ids
    
    IF CH_TOTAL_AMOUNT > 1000 THEN
        ELIGIBLE := TRUE;
    END IF;


END CHECK_ELIGIBLE_ORDER;
/

-- Bulk Collect into collection/table of order_id, with LIMIT, using loop with cursor

CREATE OR REPLACE PROCEDURE UPDATE_TAX(tax_rate IN NUMBER)
AS
    eligible BOOLEAN;
    TYPE collection_orderids IS TABLE OF sales.order_id%TYPE INDEX BY PLS_INTEGER;
        all_orderids collection_orderids;
        eligible_ids collection_orderids;
    CURSOR sales_cursor
    IS SELECT DISTINCT order_id FROM sales;

BEGIN
    OPEN sales_cursor;
    
    LOOP
        FETCH sales_cursor
        BULK COLLECT INTO all_orderids
        LIMIT 100; -- process in batches of 100
        
        FOR idx IN 1 .. all_orderids.count
        LOOP
            check_eligible_order(all_orderids(idx), eligible);
            
            IF eligible THEN
                eligible_ids(eligible_ids.count + 1) := all_orderids(idx);
            END IF;
        END LOOP;
        
        EXIT WHEN all_orderids.count = 0;
        
    END LOOP;

    -- update in 1 go       
    FORALL idx IN 1 .. eligible_ids.count
        UPDATE sales 
            SET tax_amount = total_amount * tax_rate
        WHERE order_id = eligible_ids(idx);
    
    COMMIT;
            
    
    CLOSE sales_cursor;

END UPDATE_TAX;

/
SELECT * FROM sales;
/

EXEC update_tax(0.5);


-- Bulk collect into collection/table of rowtype, with limit and cursor

CREATE OR REPLACE PROCEDURE FETCH_SALES_CUR(s_date DATE)
AS
    TYPE row_table IS TABLE OF sales%ROWTYPE;
    sales_table row_table;
    
    CURSOR sales_cursor
    IS
        SELECT * FROM SALES 
        WHERE sales_date = s_date;
BEGIN

    OPEN sales_cursor;
    
    LOOP
        FETCH sales_cursor BULK COLLECT INTO sales_table
        LIMIT 100;
        
        FOR idx IN 1 .. sales_table.COUNT
        LOOP
            dbms_output.put_line('Total amount is ' || sales_table(idx).total_amount);
        END LOOP;
    
    EXIT WHEN sales_cursor%NOTFOUND;
    
    END LOOP;

    CLOSE sales_cursor;


END FETCH_SALES_CUR;

/

EXEC fetch_sales_cur(TO_DATE('09/02/15'));

/
-- -- Bulk collect and update as one set

CREATE OR REPLACE PROCEDURE UPDATE_SALES_CUR(s_date DATE)
AS
    TYPE row_table IS TABLE OF sales%ROWTYPE;
    sales_table row_table;
    sales_cursor SYS_REFCURSOR;
            
BEGIN

    OPEN sales_cursor FOR
    SELECT * FROM SALES 
        WHERE sales_date = s_date;
    
    FETCH sales_cursor BULK COLLECT INTO sales_table;
    
    FORALL idx IN 1..sales_table.COUNT
        UPDATE sales s
            SET s.unit_price = s.unit_price + 1
            WHERE s.order_id = sales_table(idx).order_id;
    COMMIT;
        

    CLOSE sales_cursor;


END UPDATE_SALES_CUR;
/

SELECT * FROM sales;
/

EXEC UPDATE_SALES_CUR(TO_DATE('09/02/15'));
/

DROP TABLE sales_copy;

-- Clone a table without copying its values over
CREATE TABLE SALES_COPY AS 
SELECT * FROM sales WHERE 1=2;

SELECT * FROM sales_copy;

-- set a column as the primary key
ALTER TABLE sales_copy
ADD PRIMARY KEY (order_id);

SELECT * FROM SALES;

DELETE FROM SALES
WHERE order_id = 1272;
COMMIT;


-- Bulk Collect Exceptions using SQL%BULK_EXCEPTIONS pseudo collection
CREATE OR REPLACE PROCEDURE INSERT_SALES_CUR(in_date IN DATE)
AS
    CURSOR s_cursor IS
        SELECT * FROM SALES
        WHERE sales_date = in_date;
        
    TYPE sales_collection IS TABLE OF sales%rowtype;
        sales_table sales_collection;

BEGIN

    OPEN s_cursor;
    
    LOOP
        FETCH s_cursor BULK COLLECT INTO sales_table
            LIMIT 100;
            
        FORALL idx in 1 .. sales_table.COUNT SAVE EXCEPTIONS
            INSERT INTO sales_copy VALUES sales_table(idx);
            COMMIT;
            
        EXIT WHEN s_cursor%NOTFOUND;
        
    END LOOP;
    
    CLOSE s_cursor;
    
EXCEPTION
    WHEN OTHERS
    THEN
--        IF SQLCODE = -24381 THEN
            FOR idx in 1.. SQL%BULK_EXCEPTIONS.COUNT
            LOOP
                dbms_output.put_line(SQL%BULK_EXCEPTIONS(idx).ERROR_INDEX); -- row index of collection that had the error
                dbms_output.put_line(SQLERRM(SQL%BULK_EXCEPTIONS(idx).ERROR_CODE));   -- SQLERRM function to get error message associated with error code         
            END LOOP;
--        ELSE RAISE;
--        END IF;

END INSERT_SALES_CUR;

/

EXEC INSERT_SALES_CUR(TO_DATE('09/02/15'));
/

SELECT * FROM sales WHERE sales_date = TO_DATE('09/02/15');
SELECT * FROM sales_copy;
