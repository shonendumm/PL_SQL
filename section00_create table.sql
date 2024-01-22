CREATE TABLE SHOP
(
    SHOP_ID number,
    SHOP_NAME varchar2(50),
    CITY varchar2(50)
);

BEGIN 
    INSERT INTO SHOP(shop_id, shop_name, city)
    VALUES (1, 'Econ', 'SG');
    COMMIT;
END;

/
BEGIN
dbms_output.put_line('checking');
END;
/

CREATE OR REPLACE PROCEDURE ADD_SHOP
(   shop_id number,
    shop_name varchar2,
    city varchar2
)
AS
BEGIN
    INSERT INTO SHOP(shop_id, shop_name, city)
    VALUES (shop_id, shop_name, city);
    COMMIT;
    dbms_output.put_line('new shop created!');
END;
/
BEGIN
add_shop(2, 'Ester''s Food', 'SG');
END;
/

SELECT * FROM SHOP;
/


DELETE FROM SHOP
WHERE SHOP_ID = 1;
COMMIT;

/
BEGIN
ADD_SHOP(
    city => 'MY',
    shop_id => 1,
    shop_name => 'Econ');
END;



