--audit package
CREATE OR REPLACE PACKAGE audit_pkg AS
    PROCEDURE log_item_action(
        p_user    VARCHAR2,
        p_op      VARCHAR2,
        p_status  VARCHAR2,
        p_message VARCHAR2
    );
END audit_pkg;

--audit body

CREATE OR REPLACE PACKAGE BODY audit_pkg AS
    PROCEDURE log_item_action(
        p_user    VARCHAR2,
        p_op      VARCHAR2,
        p_status  VARCHAR2,
        p_message VARCHAR2
    ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;  
    BEGIN
        INSERT INTO Item_Audit_Log (
            user_id,
            action_time,
            operation,
            status,
            message
        ) VALUES (
            p_user,
            SYSTIMESTAMP,
            p_op,
            p_status,
            p_message
        );
        COMMIT;  
    END log_item_action;
END audit_pkg;


