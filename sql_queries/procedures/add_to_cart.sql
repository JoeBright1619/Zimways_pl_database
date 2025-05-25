CREATE OR REPLACE PROCEDURE add_to_cart (
    p_customer_id IN NUMBER,
    p_item_id     IN NUMBER,
    p_quantity    IN NUMBER
) AS
    v_cart_id NUMBER;
BEGIN
    -- Step 1: Check if the customer already has a cart
    BEGIN
        SELECT cart_id INTO v_cart_id
        FROM Cart
        WHERE customer_id = p_customer_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Step 2: If not, create one
            SELECT NVL(MAX(cart_id), 0) + 1 INTO v_cart_id FROM Cart;

            INSERT INTO Cart(cart_id, customer_id, created_on)
            VALUES (v_cart_id, p_customer_id, SYSDATE);

            DBMS_OUTPUT.PUT_LINE('Cart created for customer ' || p_customer_id || '.');
    END;

    -- Step 3: Try to update the item quantity if it exists
    UPDATE Cart_Item
    SET quantity = quantity + p_quantity
    WHERE cart_id = v_cart_id AND item_id = p_item_id;

    -- Step 4: If no rows updated, insert the item
    IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO Cart_Item(cart_id, item_id, quantity)
        VALUES (v_cart_id, p_item_id, p_quantity);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Item ' || p_item_id || ' added to cart for customer ' || p_customer_id);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding item to cart: ' || SQLERRM);
END;
/
