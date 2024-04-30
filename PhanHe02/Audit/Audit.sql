
connect sys/258789258789 as sysdba
GRANT SELECT ON dba_audit_trail TO ADMINLC;
GRANT SELECT ON DBA_FGA_AUDIT_TRAIL TO ADMINLC;
GRANT ALL privileges ON sys.aud$ to ADMINLC;

--View history Standard audit
select username,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,obj_name,action_name,sql_text from dba_audit_trail order by extended_timestamp DESC;

--View history FGA
SELECT  db_user,TO_CHAR(extended_timestamp, 'DD/MM/YYYY HH24:MI:SS')as Time,object_name,statement_type,sql_text from DBA_FGA_AUDIT_TRAIL order by extended_timestamp DESC;



--DELETE history
connect sys/258789258789 as sysdba
truncate table sys.aud$;

--Standard AUDIT


AUDIT TABLE;
AUDIT TABLE WHENEVER NOT SUCCESSFUL;


AUDIT SELECT,UPDATE ON ADMINLC.DANGKY WHENEVER NOT SUCCESSFUL;
AUDIT UPDATE ON ADMINLC.DANGKY WHENEVER SUCCESSFUL;

AUDIT SELECT,UPDATE ON ADMINLC.NHANSU WHENEVER NOT SUCCESSFUL;
AUDIT UPDATE ON ADMINLC.NHANSU WHENEVER SUCCESSFUL;

AUDIT UPDATE,SELECT,INSERT ON ADMINLC.SINHVIEN WHENEVER NOT SUCCESSFUL;
AUDIT UPDATE,INSERT ON ADMINLC.SINHVIEN WHENEVER SUCCESSFUL;

--FGA
connect sys/258789258789 as sysdba
grant select on DBA_ROLE_PRIVS to system;
grant execute on DBMS_FGA to ADMINLC;

connect ADMINLC/ADMINLC
CREATE OR REPLACE FUNCTION system.f_CheckRoleGiangVien(pTxtUser IN VARCHAR2)
    RETURN NUMBER 
    AS
        cnt NUMBER;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM DBA_ROLE_PRIVS WHERE GRANTEE = pTxtUser AND GRANTED_ROLE = 'R_GiangVien';
        IF(cnt = 1) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
/ 

--DROP
BEGIN
DBMS_FGA.DROP_POLICY(
object_schema => 'ADMINLC',
object_name => 'DANGKY',
policy_name => 'AUD_CHECKDOIDIEM_KHONGPHAIGIANG_VIEN');
END;
/
BEGIN
DBMS_FGA.DROP_POLICY(
object_schema => 'ADMINLC',
object_name => 'NHANSU',
policy_name => 'AUD_CHECKDOCPHUCAP_CUANGUOIKHAC');
END;
/
--ADD
BEGIN
DBMS_FGA.ADD_POLICY(OBJECT_SCHEMA   => 'ADMINLC'
                    , OBJECT_NAME     => 'DANGKY'
                    , POLICY_NAME     => 'AUD_CHECKDOIDIEM_KHONGPHAIGIANG_VIEN'
                    , AUDIT_CONDITION => 'system.f_CheckRoleGiangVien(SYS_CONTEXT(''USERENV'', ''SESSION_USER'')) = 0'
                    , audit_column => 'DIEMTHI,DIEMQT,DIEMCK,DIEMTK'
                    , STATEMENT_TYPES => 'UPDATE'
                );
END;
/
BEGIN
DBMS_FGA.ADD_POLICY(OBJECT_SCHEMA   => 'ADMINLC'
                    , OBJECT_NAME     => 'NHANSU'
                    , POLICY_NAME     => 'AUD_CHECKDOCPHUCAP_CUANGUOIKHAC'
                    , AUDIT_CONDITION => 'SYS_CONTEXT(''USERENV'', ''SESSION_USER'') <> MANV'
                    , audit_column => 'PHUCAP'
                    , STATEMENT_TYPES => 'SELECT'
                );
END;

