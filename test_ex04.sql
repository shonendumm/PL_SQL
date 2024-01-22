--I. Write the exceptions block for all the below procedures/functions which you have
--written in the Exercise #3.
--    1) Write a procedure to fetch data from table SALES for a given parameter orderid and
--    display the data.
--    2) Write a procedure which does the following operations
--     Fetch data from table SALES for a given parameter orderid and display the
--    data.
--     Return the number of rows(using OUT parameter) in the SALES table for that
--    sales date (get sales date from the about operation)
--    3) Write a function which accepts 2 numbers N1 and N2 and returns the power of
--    N1 to N2. (Example: If I pass values 10 and 3, the output should be 1000)
--    4) Write a function to display the number of rows in the SALES table for a given sales
--    date.
--    


CREATE OR REPLACE PROCEDURE EX_FETCH_SALES
(
    s_id sales.order_id%TYPE
)
AS
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

END;
/

SELECT * FROM SALES;
/


EXEC ex_fetch_sales(1269);
/

--II. Write a user defined exception for function 3 which displays an exception saying “Invalid
--Number” or “Number must be less than 100”, if it meets the below conditions
--     If N1 or N2 is null or zero
--     If N1 or N2 is greater than 100.

CREATE OR REPLACE FUNCTION ex_power
(
    n1 number,
    n2 number
) RETURN number
AS
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

END;
/

DECLARE
    ans number;
BEGIN

SELECT ex_power(2,5) INTO ans FROM dual;
dbms_output.put_line('ans: ' || ans);

END;


/








