SELECT * FROM SHOP;

/
CREATE OR REPLACE PROCEDURE FETCH_SHOP
(
    sh_id shop.shop_id%type
)
AS 
    rec shop%ROWTYPE;
BEGIN

    FOR cur IN
        (SELECT * FROM SHOP
        WHERE shop_id = sh_id)
    LOOP        
        rec := cur;
        dbms_output.put_line(rec.shop_name);
    END LOOP;

END FETCH_SHOP;
/

EXEC FETCH_SHOP(4);
/

CREATE OR REPLACE PROCEDURE FETCH_SHOP
(
    sh_id shop.shop_id%TYPE
)
AS
    CURSOR cur IS
        SELECT * FROM SHOP
        WHERE shop_id = sh_id;
    
    rec shop%ROWTYPE;
BEGIN
    OPEN cur;
    
    LOOP
        EXIT WHEN cur%NOTFOUND;
        FETCH cur INTO rec;
        dbms_output.put_line(rec.shop_name);
    END LOOP;
    
    CLOSE cur;


END FETCH_SHOP;
/
EXEC FETCH_SHOP(4);



