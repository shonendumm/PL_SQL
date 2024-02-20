-- BULK COLLECT helps reduce the number of context switches between PL SQL and SQL.
-- It works with both cursors and select statements to bulk collect multiple rows into collections, 
--e.g. associative arrays and nested tables.

-- EXAMPLE OF BULK COLLECT:
DECLARE
    TYPE collect_sales IS TABLE OF sales%ROWTYPE;
    t_sales collect_sales;

BEGIN
    SELECT * BULK COLLECT INTO t_sales
    FROM SALES;    
    
    FOR i in 1..t_sales.COUNT
    LOOP
        dbms_output.put_line(t_sales(i).order_id);
        
    END LOOP;
    
END;
/

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

-- BULK PROCESSING PROCEDURE THAT USES THE ABOVE
-- input tax_rate number
-- declare variables for the procedure:
-- ch_order_id, eligible boolean, a collection type for order_id and two collections (associative arrays)
--

CREATE OR REPLACE PROCEDURE UPDATE_TAX(tax_rate IN NUMBER)
AS
    ch_order_id sales.order_id%type;
    eligible boolean;
    TYPE COLLECTION_ORDERIDS IS TABLE OF SALES.ORDER_ID%TYPE INDEX BY PLS_INTEGER;
    all_orderids collection_orderids;
    eligible_orderids collection_orderids;

BEGIN

-- Bulk collect all the distinct order_ids
    SELECT distinct order_id BULK COLLECT INTO all_orderids
    FROM sales;

-- loop to check each order_id and assign it to eligible_orderids collection
    FOR indx in 1 .. all_orderids.count
    LOOP
        CHECK_ELIGIBLE_ORDER(all_orderids(indx), eligible);
        
        IF eligible
        THEN
            eligible_orderids(eligible_orderids.count + 1) := all_orderids(indx);
        END IF;
        
    END LOOP;

-- Bulk process: for all eligible_orderids, update the tax amount
    
    FORALL indx in 1 .. eligible_orderids.count
        UPDATE SALES s
            SET s.tax_amount = s.total_amount * tax_rate
            WHERE s.order_id = eligible_orderids(indx);

    COMMIT;

END UPDATE_TAX;

/

SELECT * FROM SALES;
/

EXEC update_tax(2);
/

    SELECT total_amount FROM SALES
    WHERE ORDER_ID = 1270 AND ROWNUM = 1;
/



-- difference between indx and all_orderids(indx)
DECLARE
    TYPE COLLECTION_ORDERIDS IS TABLE OF SALES.ORDER_ID%TYPE INDEX BY PLS_INTEGER;
    all_orderids collection_orderids;
    eligible_orderids collection_orderids;

BEGIN
-- Bulk collect all the distinct order_ids
    SELECT distinct order_id BULK COLLECT INTO all_orderids
    FROM sales;

-- loop to check each order_id and assign it to eligible_orderids collection
    FOR indx in 1 .. all_orderids.count
    LOOP
        dbms_output.put_line(indx);
        dbms_output.put_line(all_orderids(indx));

    END LOOP;
END;