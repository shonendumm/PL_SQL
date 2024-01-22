SELECT * FROM SALES;
/
--1) Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Explicit cursors and ROWTYPE)

CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    s_date sales.sales_date%type
)
AS 
    CURSOR sale_cursor
    IS 
    SELECT * FROM SALES
    WHERE sales_date = s_date;

    s_rec sales%rowtype;

BEGIN
    
    OPEN sale_cursor;
      
    LOOP
    
        FETCH sale_cursor into s_rec;
        EXIT WHEN sale_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(s_rec.order_id);
            
    END LOOP;
    
    CLOSE sale_cursor;

END FETCH_SALES;
/
EXEC FETCH_SALES(TO_DATE('09/02/15'));

/







--2) Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Cursor FOR loop)

CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    s_date sales.sales_date%type
)
AS 
BEGIN
    
    FOR cur IN
    (SELECT * FROM SALES
    WHERE sales_date = s_date)
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(cur.order_id);
    END LOOP;

END FETCH_SALES;
/
EXEC FETCH_SALES(TO_DATE('09/02/15'));

/

--3) Write a procedure to fetch data from table SALES for a given parameter sales date and
--pass that cursor to another program.
--Write another procedure which calls the above procedure and displays the data.


-- first, need a procedure that takes a cursor as parameter OUT, for open
-- Then, another procedure that declares and passes in the cursor to first procedure

CREATE OR REPLACE PROCEDURE SEND_SALES_REF
(
    s_date sales.sales_date%type,
    s_cur OUT SYS_REFCURSOR
) AS
BEGIN

    OPEN s_cur FOR
        SELECT * FROM SALES
        WHERE sales_date = s_date;

END SEND_SALES_REF;
/

CREATE OR REPLACE PROCEDURE GET_SALES_REF
(
    s_date sales.sales_date%type
) AS
    s_cur2 SYS_REFCURSOR;
    s_rec sales%ROWTYPE;
BEGIN

    SEND_SALES_REF(s_date, s_cur2);
    
    LOOP
        FETCH s_cur2 INTO s_rec;
        EXIT WHEN s_cur2%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(s_rec.order_id);
    END LOOP;
    
    CLOSE s_cur2;

END GET_SALES_REF;

/

EXEC GET_SALES_REF(TO_DATE('09/02/15'));