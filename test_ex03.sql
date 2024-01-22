--1) Write a procedure to fetch data from table SALES for a given parameter orderid and
--display the data.

CREATE OR REPLACE PROCEDURE fetch_order
(
    ord_id IN sales.order_id%type
)
AS
    s_date date;
    s_order_id sales.order_id%type;
    p_id sales.product_id%type;
    c_id sales.customer_id%type;
    s_id sales.salesperson_id%type;
    s_quantity  sales.quantity%type;
    s_unitp  sales.unit_price%type;
    s_amt  sales.sales_amount%type;
    s_tax  sales.tax_amount%type;
    s_total  sales.total_amount%type;
BEGIN
    SELECT sales_date, order_id, product_id, customer_id, salesperson_id, quantity, unit_price, sales_amount, tax_amount, total_amount
    INTO
    s_date, s_order_id, p_id, c_id, s_id, s_quantity, s_unitp, s_amt, s_tax, s_total
    FROM sales
    WHERE order_id = ord_id;
    
    dbms_output.put_line(ord_id);
    dbms_output.put_line(p_id);
    
END;
/


EXEC fetch_order(1269);

/

SELECT * FROM sales;

/

--2) Write a procedure which does the following operations
-- Fetch data from table SALES for a given parameter orderid and display the data.
-- Return the number of rows(using OUT parameter) in the SALES table for that
--sales date (get sales date from the above operation)


CREATE OR REPLACE PROCEDURE fetch_sales_date
(
    orderid IN sales.order_id%type
) 
AS
    s_date sales.sales_date%type;
    total_rows number;
BEGIN
    SELECT sales_date INTO s_date
    FROM sales
    WHERE order_id = orderid
    FETCH FIRST 1 ROW ONLY;
    
    SELECT COUNT(*) INTO total_rows
    FROM sales
    WHERE sales_date = s_date;
    
    dbms_output.put_line('Date: ' || s_date);
    dbms_output.put_line('Total sales: ' || total_rows);
END;
/


EXEC fetch_sales_date(1270);

/

--3) Write a function which accepts 2 numbers n1 and n2 and returns the power of n1 to n2.
--(Example: If I pass values 10 and 3, the output should be 1000)

CREATE OR REPLACE FUNCTION do_power
(
    n1 number,
    n2 number
) RETURN number
AS
    res number;
BEGIN
    SELECT POWER(n1, n2) INTO res FROM dual;
    
    RETURN res;

END;
/

DECLARE
res number := 0;
BEGIN
    res := do_power(2,3);
    dbms_output.put_line('result: ' || res);

END;

/
--4) Write a function to display the number of rows in the SALES table for a given sales date.

CREATE OR REPLACE FUNCTION f_get_salesdate_rows
(
    s_date date
) RETURN NUMBER
AS
    res number;
BEGIN
    SELECT count(*) INTO res FROM sales
    WHERE sales_date = s_date;
    RETURN res;

END;
/

DECLARE
    res number := 0;
BEGIN
    SELECT f_get_salesdate_rows(TO_DATE('09/02/15', 'dd/mm/yy')) into res from dual;
    dbms_output.put_line('Number of rows: ' || res);
END;









