connect ADMINLC/ADMINLC;
--CS#5
alter session set "_ORACLE_SCRIPT"=true;  
CREATE ROLE TruongKhoa;

CREATE OR REPLACE VIEW v_TruongKhoa
AS
SELECT PC.*
FROM ADMINLC.PHANCONG PC
JOIN ADMINLC.HOCPHAN HP ON PC.MAHP = HP.MAHP
JOIN ADMINLC.DONVI DV ON HP.MADV = DV.MADV
WHERE DV.TENDV = 'V?n phòng khoa';
/
GRANT INSERT,DELETE,UPDATE ON v_TruongKhoa TO TruongKhoa;
GRANT SELECT, INSERT, DELETE, UPDATE ON ADMINLC.NHANSU TO TruongKhoa;
--GRANT SELECT ON ADMINLC TO TruongKhoa;
--SELECT TABLE_NAME FROM ALL_TABLES WHERE OWNER = 'ADMINLC';

BEGIN
  FOR t IN (SELECT TABLE_NAME FROM ALL_TABLES WHERE OWNER = 'ADMINLC')
  LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT ON ' || t.TABLE_NAME || ' TO TruongKhoa';
  END LOOP;
END;

CREATE OR REPLACE PROCEDURE GRANT_ROLE_TRUONGKHOA
AS
    CURSOR CUR IS (select MANV
                    from ADMINLC.NHANSU
                    where MANV like 'NS05%'
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
   OPEN CUR;
   LOOP
      FETCH CUR INTO USR;
      EXIT WHEN CUR%NOTFOUND;
      STRSQL := 'GRANT TruongKhoa TO ' || USR;
      EXECUTE IMMEDIATE STRSQL;
   END LOOP;
   CLOSE CUR;
END;

EXEC GRANT_ROLE_TRUONGKHOA;


--CS#6
--USER DEMO
--POLICY FUNCTIONS
--1
DROP FUNCTION SV_function;
connect ADMINLC/ADMINLC;
Create OR REPLACE function SV_policiy_function(p_schema varchar2, p_obj varchar2)
Return varchar2
As
user_role VARCHAR2(30);
Begin
    user_role := SYS_CONTEXT('USERENV', 'SESSION_USER');
    if (user_role like 'SV%') THEN
        return 'MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSE
        RETURN '1=1';
    END IF;
End;
/
--2.
connect ADMINLC/ADMINLC;

RETURN VARCHAR2
AS
user_role VARCHAR2(30);
BEGIN
    user_role := SYS_CONTEXT('USERENV', 'SESSION_USER');
    if (user_role like 'SV%') THEN
        RETURN 'MACT = (SELECT MACT FROM ADMINLC.SINHVIEN WHERE MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
    ELSE
        RETURN '1=1';
    END IF;
END;
--3.
connect ADMINLC/ADMINLC;
CREATE OR REPLACE FUNCTION DK_policy_function (p_schema VARCHAR2, p_obj VARCHAR2)
RETURN VARCHAR2
AS
user_role VARCHAR2(30);
    Nam2 varchar2(50);
BEGIN
    select TO_CHAR(SYSDATE, 'YYYY') into Nam2 from DUAL;
    user_role := SYS_CONTEXT('USERENV', 'SESSION_USER');
    if (user_role like 'SV%') THEN
        RETURN 'MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') AND NAM =' ||Nam2;
    ELSE
        RETURN '1=1';
    END IF;
END;
--SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
--

--DROP POLICY
--1.
BEGIN
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'SINHVIEN',
        policy_name     => 'SV_policy1'
    );
    
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'SINHVIEN',
        policy_name     => 'SV_policy2'
    );
END;
--2.
BEGIN
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'HOCPHAN',
        policy_name     => 'HP_KHMO_policy1'
    );
    
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'KHMO',
        policy_name     => 'HP_KHMO_policy2'
    );
END;
--3
BEGIN
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'DANGKY',
        policy_name     => 'DK_policy1'
    );
END;
--4
BEGIN
    DBMS_RLS.DROP_POLICY (
        object_schema   => 'ADMINLC',
        object_name     => 'DANGKY',
        policy_name     => 'DK_policy2'
    );
END;
--ADD POLICY
BEGIN
--1.1 SELECT
dbms_rls.add_policy (
    object_schema => 'ADMINLC',
    object_name => 'SINHVIEN',
    policy_name => 'SV_policy1',
    function_schema => 'ADMINLC',
    policy_function => 'SV_policiy_function',
    statement_types => 'SELECT',
    enable => TRUE
);  

--1.2 UPDATE
dbms_rls.add_policy (
    object_schema => 'ADMINLC',
    object_name => 'SINHVIEN',
    policy_name => 'SV_policy2',
    function_schema => 'ADMINLC',
    policy_function => 'SV_policiy_function',
    sec_relevant_cols => 'DCHI, DT',
    statement_types => 'UPDATE',
    enable => TRUE
);  
END;
/
--2
BEGIN
    DBMS_RLS.ADD_POLICY (
        object_schema    => 'ADMINLC',
        object_name      => 'HOCPHAN', 
        policy_name      => 'HP_KHMO_policy1', 
        function_schema  => 'ADMINLC', 
        policy_function  => 'HP_KHMO_policy_function2',
        statement_types  => 'SELECT',
        enable => TRUE
    );

    DBMS_RLS.ADD_POLICY (
        object_schema    => 'ADMINLC',
        object_name      => 'KHMO', 
        policy_name      => 'HP_KHMO_policy2',
        function_schema  => 'ADMINLC', 
        policy_function  => 'HP_KHMO_policy_function',
        statement_types  => 'SELECT',
        enable => TRUE
    );
END;
/
--3.
BEGIN
    DBMS_RLS.ADD_POLICY (
        object_schema    => 'ADMINLC',
        object_name      => 'DANGKY', 
        policy_name      => 'DK_policy1', 
        function_schema  => 'ADMINLC',
        policy_function  => 'DK_policy_function',
        statement_types  => 'SELECT',
        enable => TRUE
    );
END;
/
--4.
BEGIN
    DBMS_RLS.ADD_POLICY (
        object_schema    => 'ADMINLC',
        object_name      => 'DANGKY', 
        policy_name      => 'DK_policy2', 
        function_schema  => 'ADMINLC',
        policy_function  => 'SV_policiy_function',
        statement_types  => 'SELECT',
        enable => TRUE
    );
END;
/

alter session set "_ORACLE_SCRIPT"=true;  
CREATE ROLE SinhVien;
GRANT SELECT, UPDATE ON ADMINLC.SINHVIEN TO SinhVien;
GRANT SELECT ON ADMINLC.HOCPHAN TO SinhVien;
GRANT SELECT ON ADMINLC.KHMO TO SinhVien;
GRANT SELECT, INSERT, DELETE ON ADMINLC.DANGKY TO SinhVien;

GRANT SinhVien TO SV21000001;

CREATE OR REPLACE PROCEDURE USP_CREATEUSER_SV
AS
    CURSOR CUR IS (SELECT SV.MASV
                    FROM ADMINLC.SINHVIEN SV
                    WHERE SV.MASV NOT IN (SELECT USERNAME
                                            FROM ALL_USERS)
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
    OPEN CUR;
        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ;
        EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER  '||USR||' IDENTIFIED BY '||USR;
        EXECUTE IMMEDIATE (STRSQL);
        STRSQL := 'GRANT CONNECT TO '||USR;
        EXECUTE IMMEDIATE (STRSQL);
        STRSQL := 'GRANT SinhVien TO '||USR;
        EXECUTE IMMEDIATE (STRSQL);
    END LOOP;
        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
        EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/
EXEC USP_CREATEUSER_SV
CONNECT SV21000001/123;
SHOW USER
select * from donvi;
--TEST 1.1
grant all on adminlc.SINHVIEN to ADMINLC;

CONNECT SV21003704/123;
SELECT *
FROM ADMINLC.SINHVIEN;

--TEST 1.2
GRANT UPDATE ON ADMINLC.SINHVIEN TO SV21000001;
CONNECT SV21000001/123;
UPDATE ADMINLC.SINHVIEN
SET DT = '2222395076' WHERE MASV = 'SV21000001'

alter session set "_ORACLE_SCRIPT" =true;
CREATE USER SV2100000A IDENTIFIED BY 123;
DROP USER SV2100000A;
GRANT CONNECT TO SV2100000A;
GRANT SELECT ON ADMINLC.DANGKY TO SV2100000A;
CONNECT SV21000001/123;
SELECT *
FROM ADMINLC.HOCPHAN
SELECT *
FROM ADMIN_OLS.THONGBAO
GRANT TruongKhoa TO NS05000001;