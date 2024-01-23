DECLARE

    name varchar2(20):= 'soohian';
    age number := 13;

BEGIN

    dbms_output.put_line('Hello ' || name);
    dbms_output.put_line('Your age is ' || age || '.');
    
    CASE
    WHEN age > 40
    then
    dbms_output.put_line('You are old enough.');
    WHEN age > 21
    then
    dbms_output.put_line('You are an adult.');
    WHEN age >= 13
    then
    dbms_output.put_line('You are a teenager.');
    else
    dbms_output.put_line('You are not an adult.');
    end CASE;
    


END;