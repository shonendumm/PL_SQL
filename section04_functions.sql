SELECT * FROM SALES;

/
CREATE OR REPLACE FUNCTION find_salescount
(
    p_sales_date IN date
) RETURN NUMBER
AS
    num_of_sales number := 0;
BEGIN
    
    SElECT COUNT(*) INTO num_of_sales FROM SALES
    WHERE sales_date = p_sales_date;
    
    RETURN num_of_sales;
END find_salescount;
/


select find_salescount(to_date('01/01/15', 'dd/mm/yy')) from dual;
/

DECLARE
scount number := 0;
BEGIN
scount := find_salescount(to_date('01/01/15', 'dd/mm/yy'));
dbms_output.put_line(scount || ' number of sales');

END;

/
SELECT * FROM SALES;

