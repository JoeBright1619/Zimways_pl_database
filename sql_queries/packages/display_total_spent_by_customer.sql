CREATE OR REPLACE PACKAGE customer_spending_pkg AS
    FUNCTION get_total_spending(p_customer_id NUMBER) RETURN NUMBER;
    PROCEDURE print_all_customer_spending;
END customer_spending_pkg;
/



CREATE OR REPLACE PACKAGE BODY customer_spending_pkg AS

    -- Function to get total spending of one customer
    FUNCTION get_total_spending(p_customer_id NUMBER) RETURN NUMBER IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(total_amount), 0)
        INTO v_total
        FROM Orders
        WHERE customer_id = p_customer_id;

        RETURN v_total;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in get_total_spending: ' || SQLERRM);
            RETURN -1;
    END;

    -- Procedure to print total spending of all customers
    PROCEDURE print_all_customer_spending IS
        CURSOR cust_cursor IS
            SELECT customer_id, name FROM Customer;

        v_cust_id Customer.customer_id%TYPE;
        v_name Customer.name%TYPE;
        v_spending NUMBER;
    BEGIN
        OPEN cust_cursor;
        LOOP
            FETCH cust_cursor INTO v_cust_id, v_name;
            EXIT WHEN cust_cursor%NOTFOUND;

            v_spending := get_total_spending(v_cust_id);
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_name || 
                                 ' | ID: ' || v_cust_id || 
                                 ' | Total Spent: ' || v_spending);
        END LOOP;
        CLOSE cust_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in print_all_customer_spending: ' || SQLERRM);
    END;

END customer_spending_pkg;
/