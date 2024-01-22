DECLARE

    -- global variables
    ordernumber constant number := 1001;
    orderid number default 1002;
    customername varchar2(20):= 'john';
    num1 number := 1650;


BEGIN

    --ordernumber := 234;
    dbms_output.put_line('hello soohian hi');
    dbms_output.put_line(ordernumber);
    dbms_output.put_line(orderid);
    dbms_output.put_line(customername);

    DECLARE
        -- local vars
        num2 number := 165;
    BEGIN
        -- always use single quotes
        dbms_output.put_line('num2 is ' || num2);
        dbms_output.put_line('num1 is ' || num1); --num1 global is accessible here
    
    END;


END;

/* this 
is a multi line comment
*/

