CREATE OR REPLACE PROCEDURE clear_cart (
    p_customer_id IN NUMBER
) AS
    v_cart_id NUMBER;
BEGIN
    -- Step 1: Get the customer's cart ID
    SELECT cart_id INTO v_cart_id
    FROM Cart
    WHERE customer_id = p_customer_id;

    -- Step 2: Delete all items from that cart
    DELETE FROM Cart_Item
    WHERE cart_id = v_cart_id;

    DBMS_OUTPUT.PUT_LINE('Cart cleared successfully for customer ID ' || p_customer_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No cart found for the customer.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error clearing cart: ' || SQLERRM);
END;
/
