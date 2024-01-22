--1) Write a procedure to fetch data from table SALES for a given parameter orderid and
--display the data(use ROWTYPE to capture the data)

CREATE OR REPLACE PROCEDURE FETCH_SALES
(
    s_orderid sales.order_id%type,
    s_rec OUT sales%rowtype
)
AS
BEGIN
    SELECT * INTO s_rec
    FROM SALES
    WHERE sales.order_id = s_orderid;
    
    DBMS_OUTPUT.PUT_LINE(s_rec.sales_date);
    DBMS_OUTPUT.PUT_LINE(s_rec.order_id);
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than 1 row.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other errors.');

END FETCH_SALES;
/

DECLARE
    s_rec sales%rowtype;
BEGIN

FETCH_SALES(1271, s_rec);

END;

/
SELECT * FROM SALES;

/
--2) Modify the above procedure to return the row you have stored in the ROWTYPE
--variable using an OUT parameter.
CREATE OR REPLACE FUNCTION F_FETCH_SALES
(
    s_orderid sales.order_id%type
) RETURN sales%rowtype AS 
    s_row_out sales%rowtype;
BEGIN
    SELECT * INTO s_row_out
    FROM SALES
    WHERE sales.order_id = s_orderid 
    AND ROWNUM <= 1;
    
    RETURN s_row_out;


EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than 1 row.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Other errors.');
        RAISE;


END F_FETCH_SALES;
/

DECLARE
    s_row_out sales%rowtype;
BEGIN

FETCH_SALES(1269, s_row_out);

END;
/
--3) Write a procedure to call the above procedure and display the data.


CREATE OR REPLACE PROCEDURE GET_SALES
(
    order_id sales.order_id%type
)
AS
    s_row_out sales%rowtype;
BEGIN
    FETCH_SALES(order_id, s_row_out);
END GET_SALES;
/

EXEC GET_SALES(1271);

/
--4) Perform the following steps.
-- Create a table SALES_COPY which is similar to SALES table.
-- Write a procedure to call the procedure you have created in #2 and insert the
--data in the SALES_COPY table.

CREATE TABLE SALES_COPY AS
SELECT * FROM SALES WHERE 1 = 2;
/


CREATE OR REPLACE PROCEDURE COPY_DATA
(
    order_id number,
    new_id number
)
AS  sales_rec sales%rowtype;
BEGIN
    sales_rec := F_FETCH_SALES(order_id);
    sales_rec.order_id := new_id;
    
    INSERT INTO SALES_COPY
    VALUES sales_rec;
    COMMIT;
    

END COPY_DATA;
/
SELECT * FROM SALES_COPY; 
/
EXEC COPY_DATA(0, 1272);
/
--5) Write a procedure to call the procedure you have created in #2 and update the column
--TOTAL_AMOUNT to SALES_AMOUNT + TAX_AMOUNT in the SALES table.

CREATE OR REPLACE PROCEDURE UPDATE_SALES
(
    s_order_id sales.order_id%type
)
AS
    rec sales%rowtype;
BEGIN

    rec := F_FETCH_SALES(s_order_id);
  
    UPDATE sales
    SET total_amount = rec.sales_amount + rec.tax_amount + 10
    WHERE order_id = s_order_id;
    COMMIT;
    

END UPDATE_SALES;

/

EXEC UPDATE_SALES(1272);
/

CREATE OR REPLACE PROCEDURE UPDATE_SALES
(
    s_order_id sales.order_id%type
)
AS s_rec sales%ROWTYPE;
BEGIN
    FETCH_SALES(s_order_id, s_rec);
    
    UPDATE SALES
    SET total_amount = s_rec.sales_amount + s_rec.tax_amount + 5
    WHERE order_id = s_rec.order_id;
    COMMIT;

END UPDATE_SALES;

/
EXEC UPDATE_SALES(1272);
/
SELECT * FROM SALES;
/


--6) Write a procedure to fetch SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID and
--QUANTITY from SALES table and display the data. (Use a User defined record type).

CREATE OR REPLACE PROCEDURE CUSTOM_DISPLAY
(
    s_order_id sales.order_id%TYPE
) AS 
TYPE user_def_record IS RECORD
(
    s_date sales.sales_date%type,
    s_order_id number,
    s_product_id number,
    s_customer_id number,
    s_quantity number
);
    user_rec user_def_record;
BEGIN
    SELECT sales_date, order_id, product_id, customer_id, quantity INTO user_rec
    FROM SALES
    WHERE order_id = s_order_id;

    DBMS_OUTPUT.PUT_LINE(user_rec.s_date);

END CUSTOM_DISPLAY;
/

EXEC CUSTOM_DISPLAY(1272);



