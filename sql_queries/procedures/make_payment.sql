CREATE OR REPLACE PROCEDURE make_payment(
    p_order_id   IN NUMBER,
    p_amount     IN NUMBER,
    p_method     IN VARCHAR2
) AS
    v_expected_amount NUMBER;
    v_payment_id      NUMBER;
    v_driver_id       NUMBER;
BEGIN
    -- Check if order exists and get expected amount
    SELECT total_amount
    INTO v_expected_amount
    FROM Orders
    WHERE order_id = p_order_id;

    -- Check if payment matches expected amount
    IF p_amount != v_expected_amount THEN
        RAISE_APPLICATION_ERROR(-20002, 'Payment amount does not match the order total.');
    END IF;

    -- Generate payment ID
    SELECT NVL(MAX(payment_id), 0) + 1 INTO v_payment_id FROM Payment;

    -- Insert payment
    INSERT INTO Payment(payment_id, order_id, amount, method)
    VALUES (v_payment_id, p_order_id, p_amount, p_method);

    -- Update order status to 'paid'
    UPDATE Orders
    SET status = 'paid'
    WHERE order_id = p_order_id;

    -- Try assigning to first available driver
    BEGIN
        SELECT driver_id
        INTO v_driver_id
        FROM Delivery_Driver
        WHERE status = 'available'
        FETCH FIRST 1 ROWS ONLY;

        -- Update driver status to busy
        UPDATE Delivery_Driver
        SET status = 'busy'
        WHERE driver_id = v_driver_id;

        -- Assign driver to order and update status to picked_up
        UPDATE Orders
        SET driver_id = v_driver_id,
            status = 'assigned'
        WHERE order_id = p_order_id;

        DBMS_OUTPUT.PUT_LINE('Driver assigned (ID: ' || v_driver_id || '). Order marked as picked_up.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No available driver. Order remains in paid status.');
    END;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/
