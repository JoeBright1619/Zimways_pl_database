CREATE OR REPLACE PROCEDURE place_order_per_vendor(p_customer_id IN NUMBER) AS
    v_cart_id     NUMBER;
    v_order_id    NUMBER;
    v_vendor_id   NUMBER;
    v_total       NUMBER;
BEGIN
    -- Get cart ID
    SELECT cart_id INTO v_cart_id
    FROM Cart
    WHERE customer_id = p_customer_id;

    -- Loop through all distinct vendor IDs in the customer's cart
    FOR vendor_rec IN (
        SELECT DISTINCT i.vendor_id
        FROM Cart_Item ci
        JOIN Item i ON ci.item_id = i.item_id
        WHERE ci.cart_id = v_cart_id
    ) LOOP
        v_vendor_id := vendor_rec.vendor_id;

        -- Calculate total amount for this vendor
        SELECT SUM(i.price * ci.quantity)
        INTO v_total
        FROM Cart_Item ci
        JOIN Item i ON ci.item_id = i.item_id
        WHERE ci.cart_id = v_cart_id
          AND i.vendor_id = v_vendor_id;

        -- Generate a new order ID
        SELECT NVL(MAX(order_id), 0) + 1
        INTO v_order_id
        FROM Orders;

        -- Insert new order
        INSERT INTO Orders (
            order_id, customer_id, vendor_id, total_amount, status, order_date, driver_id
        ) VALUES (
            v_order_id, p_customer_id, v_vendor_id, v_total, 'pending', SYSDATE, NULL
        );

        DBMS_OUTPUT.PUT_LINE('Order placed for Vendor ID ' || v_vendor_id || 
                             ' | Order ID: ' || v_order_id || 
                             ' | Total: ' || v_total);
    END LOOP;

    -- Clear the cart using the existing clear_cart procedure
    clear_cart(p_customer_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No cart found for customer or cart is empty.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error placing order: ' || SQLERRM);
END;
/
