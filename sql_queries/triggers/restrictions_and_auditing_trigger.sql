CREATE OR REPLACE TRIGGER item_security_audit_trg
FOR INSERT OR UPDATE OR DELETE ON Item
COMPOUND TRIGGER

    -- Variables visible across all sections
    v_day VARCHAR2(10);
    v_today DATE := TRUNC(SYSDATE);
    v_holiday_count NUMBER;
    v_user VARCHAR2(100);
    v_status VARCHAR2(10);
    v_message VARCHAR2(255);
    v_op VARCHAR2(10);

BEFORE STATEMENT IS
BEGIN
    -- Get the current weekday and holiday info
    SELECT TO_CHAR(v_today, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') INTO v_day FROM dual;

    SELECT COUNT(*) INTO v_holiday_count
    FROM Holidays
    WHERE holiday_date = v_today;

    v_user := SYS_CONTEXT('USERENV', 'SESSION_USER');

    IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') THEN
        v_status := 'DENIED';
        v_message := 'Blocked: DML not allowed on weekdays.';
        RAISE_APPLICATION_ERROR(-20001, v_message);
    ELSIF v_holiday_count > 0 THEN
        v_status := 'DENIED';
        v_message := 'Blocked: DML not allowed on public holidays.';
        RAISE_APPLICATION_ERROR(-20002, v_message);
    ELSE
        v_status := 'ALLOWED';
        v_message := 'DML operation permitted.';
    END IF;
END BEFORE STATEMENT;

AFTER EACH ROW IS
BEGIN
    -- Determine the operation type
    IF INSERTING THEN
        v_op := 'INSERT';
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
    ELSIF DELETING THEN
        v_op := 'DELETE';
    END IF;

    -- Log the action
   audit_pkg.log_item_action(v_user, v_op, v_status, v_message);

END AFTER EACH ROW;

END item_security_audit_trg;
