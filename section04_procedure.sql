-- procedure is saved in the database
CREATE OR REPLACE PROCEDURE ADD_CUSTOMER
(
    c_id IN number,
    c_fname IN varchar2,
    c_lname IN varchar2,
    c_mname IN varchar2,
    c_add1 IN varchar2,
    c_add2 IN varchar2,
    c_city IN varchar2,
    c_country IN varchar2,
    c_date_added IN date,
    c_region IN varchar2
)
AS
BEGIN

    INSERT INTO CUSTOMER(customer_id, first_name, last_name, middle_name, address_line1, address_line2, city, country, date_added, region)
    VALUES (c_id, c_fname, c_lname, c_mname, c_add1, c_add2, c_city, c_country, c_date_added, c_region);
    
    COMMIT;
    
    dbms_output.put_line('Data successfully inserted!');


END ADD_CUSTOMER;
/


SELECT * FROM customer;
/


-- how to use the procedure METHOD 1
BEGIN
    add_customer(17, 'soohian', 'foo', 'donaldo', 'amk', 'ave 10', 'SG', 'Singapore', SYSDATE, 'Central');
END;
/

-- how to use the procedure METHOD 2
BEGIN
    add_customer
    (
        c_id    => 18, 
        c_fname => 'ester', 
        c_lname => 'phoon', 
        c_mname => 'sk', 
        c_add1  => 'amk', 
        c_add2  => 'ave 10', 
        c_city  => 'SG', 
        c_country   => 'Singapore', 
        c_date_added    => SYSDATE, 
        c_region    => 'Central');


END;
/

BEGIN
    
    UPDATE customer set customer_id = 19
    WHERE first_name = 'ester' and customer_id = 17;
    COMMIT;

END;
/

BEGIN

    DELETE FROM customer
    WHERE customer_id = 19;
    COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE DELETE_CUSTOMER
(
    c_id IN number := 17
)
AS
BEGIN
    DELETE FROM customer
    WHERE customer_id = c_id;
    COMMIT;
    dbms_output.put_line('customer has been deleted: ' || c_id);
    
END;
/
BEGIN -- Try the procedure
    delete_customer();
END;
/







