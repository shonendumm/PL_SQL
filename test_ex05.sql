-- First, define the package
CREATE OR REPLACE PACKAGE SALES_PKG
AS

PROCEDURE FETCH_SALES
(
    s_id sales.order_id%TYPE
);

FUNCTION ex_power
(
    n1 number,
    n2 number
) RETURN number;

END SALES_PKG;
/



-- Second, define the package body
CREATE OR REPLACE PACKAGE BODY SALES_PKG
AS


PROCEDURE FETCH_SALES
(
    s_id sales.order_id%TYPE
)
IS
    s_date sales.sales_date%TYPE;
    s_number_of_rows number;
    
BEGIN  
    
    SELECT sales_date INTO s_date
    FROM sales
    WHERE order_id = s_id;
    
    SELECT COUNT(*) INTO s_number_of_rows
    FROM sales
    WHERE sales_date = s_date;
    
    dbms_output.put_line('date is: ' || s_date);
    dbms_output.put_line('number of rows: ' || s_number_of_rows);

EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Too many rows.');
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No data found.');
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Value error');
    WHEN OTHERS THEN
        dbms_output.put_line('Other errors.');

END FETCH_SALES;



FUNCTION ex_power
(
    n1 number,
    n2 number
) RETURN number
IS
    answer number;
    bigger_than_null EXCEPTION;
    greater_than_100 EXCEPTION;
BEGIN
    IF n1 is null or n2 is null or n1 = 0 or n2 = 0  THEN
        RAISE bigger_than_null;
    END IF;

    IF n1 > 100 or n2 > 100 THEN
        RAISE greater_than_100;
    END IF;

    SELECT POWER(n1,n2) INTO answer FROM dual;
    RETURN answer;

EXCEPTION
    WHEN bigger_than_null THEN
        dbms_output.put_line('Invalid number.');

    WHEN greater_than_100 THEN
        dbms_output.put_line('n1 or n2 must be smaller than 100.');

END ex_power;

END SALES_PKG;
/

DECLARE
    ans number;
BEGIN
    SELECT sales_pkg.ex_power(2,5) INTO ans FROM dual;
    dbms_output.put_line('ans: ' || ans);
END;
/

EXEC sales_pkg.fetch_sales(1269);