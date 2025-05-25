CREATE OR REPLACE PROCEDURE mark_order_delivered(
    p_order_id IN NUMBER
) AS
    v_driver_id Delivery_Driver.driver_id%TYPE;
    v_status    Orders.status%TYPE;
BEGIN
    -- Get order status and driver
    SELECT status, driver_id
    INTO v_status, v_driver_id
    FROM Orders
    WHERE order_id = p_order_id;

    -- Only proceed if the order is assigned
    IF v_status != 'assigned' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Order is not in assigned status.');
    END IF;

    -- Update order status to delivered
    UPDATE Orders
    SET status = 'delivered'
    WHERE order_id = p_order_id;

    -- Set driver back to available
    UPDATE Delivery_Driver
    SET status = 'available'
    WHERE driver_id = v_driver_id;

    DBMS_OUTPUT.PUT_LINE('Order ' || p_order_id || ' marked as delivered. Driver ' || v_driver_id || ' is now available.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
