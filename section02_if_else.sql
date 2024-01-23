-- if then elif then else end if

DECLARE

    total_amount number := 101;
    discount number := 0;

BEGIN

    if total_amount > 200
    then
    discount := total_amount * .2;
    elsif total_amount >= 100 and total_amount <= 200
    then
    discount := total_amount * .1;
    else   
    discount := total_amount * .05;
    end if;    
    
    dbms_output.put_line(discount);
    
END;