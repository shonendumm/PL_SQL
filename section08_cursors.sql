SELECT * FROM CUSTOMER;
/

-- using cursor for loop 

BEGIN
    FOR c_rec IN (SELECT * FROM CUSTOMER)
    LOOP
    DBMS_OUTPUT.PUT_LINE(c_rec.first_name);
    END LOOP;
END;

/
