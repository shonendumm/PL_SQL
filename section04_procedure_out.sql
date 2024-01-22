CREATE OR REPLACE PROCEDURE ADD_SHOP
(
    SHOP_ID IN number,
    SHOP_NAME IN varchar2,
    CITY IN varchar2,
    total_count OUT number
)
AS
BEGIN
    INSERT INTO SHOP(shop_id, shop_name, city)
    VALUES (SHOP_ID, SHOP_NAME, CITY);
    COMMIT;
    dbms_output.put_line('Data inserted successfully');

    SELECT COUNT(*) INTO total_count FROM SHOP;
    dbms_output.put_line('Total shops: ' || total_count);
    
END ADD_SHOP;
/

DECLARE
    tcount number(10);
BEGIN
    add_shop(5, 'Ninja', 'SG', tcount);
END;
/

SELECT * FROM SHOP;

/

DELETE FROM SHOP WHERE SHOP_ID = 3;
COMMIT;
/

-- IN OUT MODE

CREATE OR REPLACE PROCEDURE ADD_SHOP
(
    SHOP_ID IN OUT number,
    SHOP_NAME IN varchar2,
    CITY IN varchar2
)
AS
BEGIN
    INSERT INTO SHOP(shop_id, shop_name, city)
    VALUES (SHOP_ID, SHOP_NAME, CITY);
    COMMIT;
    dbms_output.put_line('Data inserted successfully');

    SELECT COUNT(*) INTO SHOP_ID FROM SHOP;
    dbms_output.put_line('Total shops: ' || SHOP_ID);
    
END ADD_SHOP;
/

DECLARE
    tcount number := 7;
BEGIN
    add_shop(tcount,'Apple', 'NY');
END;
/

SELECT * FROM SHOP
ORDER BY SHOP_ID;
/


-- This cannot work because we cannot insert value into 10.
-- It has to be a variable.
add_shop(10, 'Teas', 'SG');





