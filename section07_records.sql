CREATE OR REPLACE PROCEDURE SHOW_SHOP
(
    sh_id shop.shop_id%TYPE
)
IS 
    sh_rec shop%ROWTYPE;
BEGIN
    
    SELECT * INTO sh_rec
    FROM shop
    WHERE shop_id = sh_id;
    
    dbms_output.put_line(sh_rec.shop_name);
    dbms_output.put_line(sh_rec.city);
    
    COPY_SHOP_REC(sh_rec);
    

END SHOW_SHOP;
/

SELECT * FROM shop;

/
EXEC SHOW_SHOP(1);


/

-- INSERT VALUES

CREATE OR REPLACE PROCEDURE COPY_SHOP_REC
(
    sh_rec_in shop%ROWTYPE
)
IS

BEGIN
    INSERT INTO SHOP
    VALUES SH_REC_IN;
    COMMIT;

END COPY_SHOP_REC;
/


-- DELETE VALUES
CREATE OR REPLACE PROCEDURE DELETE_SHOP
(
    sh_id shop.shop_id%type
)
IS 
BEGIN
    
    DELETE FROM SHOP
    WHERE SHOP_ID = SH_ID;
    COMMIT;

END DELETE_SHOP;
/

EXEC DELETE_SHOP(7);


-- ADD SHOP
CREATE OR REPLACE PROCEDURE CREATE_SHOP
(
    sh_id shop.shop_id%TYPE,
    sh_name shop.shop_name%TYPE,
    sh_city shop.city%TYPE
)
IS
    sh_rec shop%ROWTYPE;
BEGIN
    sh_rec.shop_id := sh_id;
    sh_rec.shop_name := sh_name;
    sh_rec.city := sh_city;
    
    INSERT INTO SHOP
    VALUES sh_rec;
    COMMIT;


END CREATE_SHOP;
/

EXEC create_shop(4, 'satki', 'sg');

-- update shop
/

CREATE OR REPLACE PROCEDURE UPDATE_SHOP
(
    SH_REC SHOP%ROWTYPE
)
IS
BEGIN
    UPDATE SHOP 
    SET ROW = SH_REC
    WHERE SHOP_ID = SH_REC.SHOP_ID;
    COMMIT;

END UPDATE_SHOP;

/

CREATE OR REPLACE PROCEDURE PROCESS_SHOP
(
    sh_id shop.shop_id%TYPE,
    sh_name shop.shop_name%TYPE
)
IS 
    sh_rec shop%ROWTYPE;
BEGIN
    
    SELECT * INTO sh_rec
    FROM shop
    WHERE shop_id = sh_id;
    
    sh_rec.shop_name := sh_name;
    
    UPDATE_SHOP(sh_rec);
    

END PROCESS_SHOP;
/

EXEC process_shop('4', 'SATKI');
/
SELECT * FROM SHOP;
/


-- USER DEFINED RECORD DATATYPE

CREATE OR REPLACE PROCEDURE process_shop
(
    sh_id shop.shop_id%type    
)
IS
TYPE SHOP_REC IS RECORD
(
    s_name VARCHAR2(50),
    s_city VARCHAR2(50)
);
    sh_rec SHOP_REC;

BEGIN
    SELECT shop_name, city INTO sh_rec
    FROM SHOP
    WHERE shop_id = sh_id;
    
    dbms_output.put_line(sh_rec.s_name);

END process_shop;

/

EXEC PROCESS_SHOP(2);





