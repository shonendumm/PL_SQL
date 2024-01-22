-- defining the package specifications
CREATE OR REPLACE PACKAGE CUSTOMER_PKG
AS

PROCEDURE ADD_CUSTOMER
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
);

PROCEDURE DELETE_CUSTOMER
(
    c_id IN number := 17
);


END CUSTOMER_PKG;
/


-- defining the package body

CREATE OR REPLACE PACKAGE BODY CUSTOMER_PKG
AS

PROCEDURE ADD_CUSTOMER
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

PROCEDURE DELETE_CUSTOMER
(
    c_id IN number := 17
)
AS
BEGIN
    DELETE FROM customer
    WHERE customer_id = c_id;
    COMMIT;
    dbms_output.put_line('customer has been deleted: ' || c_id);

END DELETE_CUSTOMER;


END CUSTOMER_PKG; --body

/




