DECLARE
    c_id number := 11;
    c_name varchar2(50);
    c_addr varchar2(50);
    
    -- use %type to get same type, e.g.
    c_city customer.city%type;
    -- useful if database changes the type


BEGIN
    SELECT first_name, country, city INTO c_name, c_addr, c_city
    FROM customer
    WHERE customer_id = c_id;
    
    dbms_output.put_line('Name: ' || c_name);
    dbms_output.put_line('Country: ' || c_addr);
    dbms_output.put_line('City: ' || c_city);


END;
/ 
-- a way to say execute this block only if cursor is here



SELECT * FROM customer;
/



DECLARE


BEGIN
    
    INSERT INTO CUSTOMER(customer_id, first_name, last_name, middle_name, address_line1, address_line2, city, country, date_added, region)
    VALUES (13, 'JEFF', 'AFONSO', 'A', '23 SUWANEE RD', NULL, 'ALPHARETTA', 'USA', SYSDATE, 'SOUTH');
    COMMIT;

END;
/




