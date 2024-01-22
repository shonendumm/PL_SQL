DECLARE

ord_id sales.order_id%type;
ord_date sales.sales_date%type;
ord_prodid sales.product_id%type;

BEGIN

    SELECT order_id, sales_date, product_id into ord_id, ord_date, ord_prodid
    FROM sales
    WHERE order_id = 1269;
    
    dbms_output.put_line(ord_id || ' ' || ord_date || ' ' || ord_prodid);


END;
/

SELECT * FROM SALES;
/

-- insert data into sales table
DECLARE

BEGIN
    INSERT INTO SALES(sales_date, order_id, product_id, customer_id, salesperson_id, quantity, unit_price, sales_amount, tax_amount, total_amount)
    VALUES (TO_DATE('2024-01-31', 'YYYY-MM-DD'),1300, 999, 11, 2000, 999, 10, 9990, 100, 1090);
    COMMIT;

END;
/

DECLARE

    new_sales_amount sales.sales_amount%type := 5000;

BEGIN

    UPDATE sales 
    SET sales_amount = new_sales_amount
    WHERE order_id = 1300;
    COMMIT;


END;
/

DECLARE

BEGIN

    DELETE FROM sales
    WHERE order_id = 1300;
    COMMIT;
    
    
END;
/

SELECT * FROM sales;





