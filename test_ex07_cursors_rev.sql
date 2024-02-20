--Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Explicit cursors and ROWTYPE)

SELECT * FROM sales;
/

CREATE OR REPLACE PROCEDURE FETCH_SALES_CUR
(
    s_date sales.sales_date%type
)
AS
    CURSOR sales_cursor
    IS
        SELECT * FROM sales
        WHERE sales_date = s_date;
    
    s_row sales%ROWTYPE;
    
BEGIN

    OPEN sales_cursor;
    
    LOOP
    FETCH sales_cursor INTO s_row;
    EXIT WHEN sales_cursor%NOTFOUND;
        dbms_output.put_line(s_row.PRODUCT_ID);
    
    END LOOP;
    
    CLOSE sales_cursor;

END FETCH_SALES_CUR;
/

EXEC FETCH_SALES_CUR(TO_DATE('09/02/15'));
/

CREATE OR REPLACE PROCEDURE FETCH_SALES_COLLECT
AS
    TYPE collection_sales IS TABLE OF sales%rowtype;
    sales_table collection_sales;
    
    CURSOR s_cursor IS
        SELECT * FROM SALES ;
    
BEGIN
    OPEN s_cursor;

    LOOP
        FETCH s_cursor BULK COLLECT INTO sales_table
        LIMIT 100;
                   
        FORALL idx IN 1.. sales_table.COUNT SAVE EXCEPTIONS
            UPDATE sales s
                SET s.total_amount = s.tax_amount + s.sales_amount
                WHERE s.product_id = sales_table(idx).product_id;
        
            COMMIT;
            
        EXIT WHEN s_cursor%NOTFOUND;        
    
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        FOR idx IN 1.. SQL%BULK_EXCEPTIONS.COUNT
        LOOP
            dbms_output.put_line(SQL%BULK_EXCEPTIONS(idx).ERROR_INDEX);
            dbms_output.put_line(SQLERRM(SQL%BULK_EXCEPTIONS(idx).ERROR_CODE));
        END LOOP;


END FETCH_SALES_COLLECT;
/

SELECT * FROM sales;
/
EXEC FETCH_SALES_COLLECT();