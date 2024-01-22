CREATE OR REPLACE PROCEDURE GET_SHOP
(
    s_id shop.shop_id%TYPE
)
AS
    s_name shop.shop_name%TYPE;
    s_city shop.city%TYPE;
    s_id_exception EXCEPTION;
    
BEGIN

IF s_id <= 0 THEN
RAISE s_id_exception;
END IF;

    SELECT shop_name, city INTO s_name, s_city
    FROM shop
    WHERE shop_id = s_id;
    
    dbms_output.put_line('shop name is: ' || s_name);
    dbms_output.put_line('located at: ' || s_city);

    
    
EXCEPTION
    WHEN s_id_exception THEN
        dbms_output.put_line('shop_id must be greater than 0');
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Too many rows.');
    WHEN OTHERS THEN
        dbms_output.put_line('Some errors.');

END;
/

EXEC get_shop(7);
/

SELECT * FROM SHOP;