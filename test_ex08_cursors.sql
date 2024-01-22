--Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Explicit cursors and ROWTYPE)


CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    s_id sales.order_id%TYPE
)
AS
    CURSOR cur IS 
        SELECT * FROM SALES
        WHERE order_id = s_id;
    
    s_row sales%ROWTYPE;
BEGIN
    OPEN cur;
    
    LOOP
        FETCH cur into s_row;
        EXIT WHEN CUR%NOTFOUND;
        
        dbms_output.put_line(s_row.sales_date);
    END LOOP;
    
    CLOSE cur;


END FETCH_SALES;
/

EXEC FETCH_SALES(1270);
/
SELECT * FROM SALES;
/



--Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Cursor FOR loop)


CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    s_orderid sales.order_id%type
)
AS 
BEGIN

    FOR cur in
    (SELECT * FROM SALES
    WHERE order_id = s_orderid)
    
    LOOP
        dbms_output.put_line(cur.sales_date);
    END LOOP;


END FETCH_SALES;

/ 

EXEC FETCH_SALES(1270);
/


--Write a procedure to fetch data from table SALES for a given parameter sales date and
--pass that cursor to another program.
--Write another procedure which calls the above procedure and displays the data.

CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    ord_id sales.order_id%TYPE,
    cur OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN CUR FOR
        SELECT * FROM SALES
        WHERE order_id = ord_id;

END FETCH_SALES;
/

CREATE OR REPLACE PROCEDURE GET_SALES
(
    order_id sales.order_id%TYPE
)
AS
    s_cur SYS_REFCURSOR;
    s_rec sales%ROWTYPE;
BEGIN

    FETCH_SALES(order_id, s_cur);
    
    LOOP
        FETCH s_cur into s_rec;
        EXIT WHEN s_cur%NOTFOUND;
        dbms_output.put_line(s_rec.sales_date);
    END LOOP;
    
    CLOSE s_cur;


END GET_SALES;
/

EXEC GET_SALES(1270);
/







