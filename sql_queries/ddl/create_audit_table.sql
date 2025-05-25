CREATE TABLE Item_Audit_Log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id VARCHAR2(100),             -- USER ID (captured using SYS_CONTEXT)
    action_time TIMESTAMP DEFAULT SYSTIMESTAMP, -- Date and time of action
    operation VARCHAR2(10),            -- INSERT, UPDATE, DELETE
    status VARCHAR2(10),               -- ALLOWED or DENIED
    message VARCHAR2(255)              -- Explanation message (optional)
);
