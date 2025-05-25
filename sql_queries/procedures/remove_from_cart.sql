CREATE OR REPLACE PROCEDURE remove_from_cart (
    p_customer_id IN NUMBER,
    p_item_id     IN NUMBER,
    p_quantity    IN NUMBER
) AS
    v_cart_id   NUMBER;
    v_quantity  NUMBER;
    ex_quantity_low EXCEPTION;
BEGIN
    -- Step 1: Get the cart ID for the customer
    SELECT cart_id INTO v_cart_id
    FROM Cart
    WHERE customer_id = p_customer_id;

    -- Step 2: Get current quantity of the item in the cart
    SELECT quantity INTO v_quantity
    FROM Cart_Item
    WHERE cart_id = v_cart_id AND item_id = p_item_id;

    -- Step 3: Check if enough quantity exists
    IF v_quantity < p_quantity THEN
        RAISE ex_quantity_low;
    ELSIF v_quantity = p_quantity THEN
        -- Remove the item completely
        DELETE FROM Cart_Item
        WHERE cart_id = v_cart_id AND item_id = p_item_id;
    ELSE
        -- Just subtract the quantity
        UPDATE Cart_Item
        SET quantity = quantity - p_quantity
        WHERE cart_id = v_cart_id AND item_id = p_item_id;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Removed ' || p_quantity || ' of item ' || p_item_id || ' from cart.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Item not found in cart.');
    WHEN ex_quantity_low THEN
        DBMS_OUTPUT.PUT_LINE('Error: Specified quantity not available in cart to remove.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/