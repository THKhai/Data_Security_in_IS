SELECT VALUE FROM v$option WHERE parameter = 'Oracle Label Security';
SELECT status FROM dba_ols_status WHERE name = 'OLS_CONFIGURE_STATUS';
EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;
--
SHUTDOWN IMMEDIATE;
STARTUP;
/
ALTER USER lbacsys IDENTIFIED BY lbacsys ACCOUNT UNLOCK CONTAINER=ALL ;
ALTER PLUGGABLE DATABASE DBA_SECURITY  OPEN READ WRITE;
ALTER SESSION SET CONTAINER= DBA_SECURITY;
SHOW CON_NAME;

--drop user ADMIN_OLS cascade;
alter session set "_ORACLE_SCRIPT" = true;
Drop user ADMIN_OLS;
alter session set "_ORACLE_SCRIPT" = false;  


CREATE USER ADMIN_OLS IDENTIFIED BY ADMIN_OLS CONTAINER = CURRENT;
/
GRANT CONNECT,RESOURCE TO ADMIN_OLS; --C?P QUY?N CONNECT V? RESOURCE
GRANT UNLIMITED TABLESPACE TO ADMIN_OLS; --C?P QUOTA CHO ADMIN_OLS
GRANT SELECT ANY DICTIONARY TO ADMIN_OLS; --C?P QUY?N ??C DICTIONARY
/
GRANT EXECUTE ON LBACSYS.SA_COMPONENTS TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_user_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_label_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON sa_policy_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON char_to_label TO ADMIN_OLS WITH GRANT OPTION;
/
GRANT LBAC_DBA TO ADMIN_OLS;
GRANT EXECUTE ON sa_sysdba TO ADMIN_OLS;
GRANT EXECUTE ON TO_LBAC_DATA_LABEL TO ADMIN_OLS; -- C?P QUY?N TH?C THI

 -- C?P QUY?N TH?C THI

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY;
CONNECT ADMIN_OLS/123@DESKTOP-OB2NBQU:1521/PDBQLDL;

-- create policy ols
----------------------------------------------------------
--select* from all_SA_LABELS;
----/
--begin
--    SA_SYSDBA.DROP_POLICY( policy_name => 'Notification_Policy');
--end;
/
--select* from all_SA_LABELS;
------------------------------------------------------------

begin
    SA_SYSDBA.CREATE_POLICY(
    policy_name => 'Notification_Policy',
    column_name => 'Notification_Label'
    );
end;
/
--connect lbacsys/lbacsys;
--GRANT  Notification_Policy_dba TO ADMIN_OLS;
--commit;
connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
EXEC SA_SYSDBA.ENABLE_POLICY ('Notification_Policy');
-- tao componenet c?a label
-- tao level
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',60,'TK','TruongKhoa');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',50,'TDV','TruongDonVi');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',40,'GV','GiangVien');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',30,'GVU','GiaoVu');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',20,'NV','NhanVien');
EXECUTE SA_COMPONENTS.CREATE_LEVEL('Notification_Policy',10,'SV','SINHVIEN');
-- tao Compartment
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',120,'HTTT','HeThongThongTin');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',110,'CNPM','CongNghePhanMem');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',100,'KHMT','KhoaHocMayTinh');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',90,'CNTT','CongNgheThongTin');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',80,'TGMT','ThiGiacMayTinh');
EXECUTE SA_COMPONENTS.CREATE_COMPARTMENT('Notification_Policy',70,'MMT','MangMayTinh');
-- tao Group
EXECUTE SA_COMPONENTS.CREATE_GROUP('Notification_Policy',130,'cs1','CO SO 1');
EXECUTE SA_COMPONENTS.CREATE_GROUP('Notification_Policy',140,'cs2','CO SO 2');

-- check COMPONENT

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 

SELECT * FROM DBA_SA_LEVELS;
SELECT * FROM DBA_SA_GROUPS;
SELECT* FROM DBA_SA_COMPARTMENTS;
SELECT * FROM DBA_SA_GROUP_HIERARCHY;
/

-- create table THONGBAO
-----------------------------------
connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
DROP TABLE THONGBAO;
-----------------------------------
connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
create table THONGBAO(
    MATB varchar2(10) primary key,
    NOIDUNG varchar2(2000) 
);
insert into THONGBAO values ('TB00000001','THONG BAO 01: KIEM TRA');
insert into THONGBAO values ('TB00000002','THONG BAO 02: NOI DUNG KIEM TRA');
insert into THONGBAO values ('TB00000003','THONG BAO 03: LAM BAI');
insert into THONGBAO values ('TB00000004','THONG BAO 04: NOP BAI');
insert into THONGBAO values ('TB00000005','THONG BAO 05: TRA BAI');

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY;
select* from ADMIN_OLS.THONGBAO;
/
--select* from ADMIN_OLS.THONGBAO;
-- Cap Nhat Nhan Trong Bang

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
BEGIN
    SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
    POLICY_NAME => 'Notification_Policy',
    SCHEMA_NAME => 'ADMIN_OLS',
    TABLE_NAME => 'THONGBAO',
    TABLE_OPTIONS => 'NO_CONTROL'
    );
END;
/
-- tao nhan 
connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
UPDATE THONGBAO set Notification_Label = CHAR_TO_LABEL('Notification_Policy','TK:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2')
where MATB = 'TB00000001';
UPDATE THONGBAO set  Notification_Label = CHAR_TO_LABEL('Notification_Policy','TK')
where MATB = 'TB00000002';
UPDATE THONGBAO set  Notification_Label = CHAR_TO_LABEL('Notification_Policy','TK')
where MATB = 'TB00000003';
UPDATE THONGBAO set  Notification_Label = CHAR_TO_LABEL('Notification_Policy','TK')
where MATB = 'TB00000004';
UPDATE THONGBAO set  Notification_Label = CHAR_TO_LABEL('Notification_Policy','SV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2')
where MATB = 'TB00000005';

--Ap dung OLS vao bang

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
BEGIN
    SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(policy_name => 'Notification_Policy',
    schema_name => 'ADMIN_OLS',
    table_name => 'THONGBAO'
    );
end;
/
begin
    -----------------------------------------------------------------------------
    SA_POLICY_ADMIN.APPLY_TABLE_POLICY(
    policy_name => 'Notification_Policy',
    schema_name => 'ADMIN_OLS',
    table_name => 'THONGBAO',
    table_options => 'LABEL_DEFAULT,write_CONTROL,READ_CONTROL',
    predicate => NULL
    );
END;
--- finish setting
/
--connect lbacsys/lbacsys;
--begin
--    sa_user_admin.set_user_privs
--    (policy_name => 'Notification_Policy',
--    user_name => 'ADMIN_OLS',
--    PRIVILEGES => 'PROFILE_ACCESS');    
--end;
---- yeu cau a)
--update ADMIN_OLS.THONGBAO set MATB = MATB;
----
--BEGIN
--    SA_LABEL_ADMIN.create_label(
--            policy_name => 'Notification_Policy',
--            label_tag => 10000500,
--            label_value => 'TK:CNPM,KHMT,CNTT,TGMT,MMT,HTTT:cs1,cs2'
--    );
--END;
--/


-- cau a
connect ADMINLC/ADMINLC;
GRANT SELECT on ADMINLC.NHANSU to ADMIN_OLS;
GRANT SELECT on ADMINLC.SINHVIEN to ADMIN_OLS;

connect ADMIN_OLS/ADMIN_OLS@localhost:1521/DBA_SECURITY 
CREATE OR REPLACE PROCEDURE SET_LABELS_TK AS
    CURSOR CUR IS (SELECT MANV FROM ADMINLC.NHANSU WHERE MANV LIKE 'NS05%');
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'TK:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
            max_write_label => 'TK',
            min_write_label => 'TK',
            def_label       => 'TK:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
            row_label       => 'TK:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
END;
/
EXEC SET_LABELS_TK;

-- cau b
create or replace procedure SET_LABELS_TBM as
    CURSOR CUR IS (SELECT MANV FROM ADMINLC.NHANSU WHERE MANV LIKE 'NS04%');
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'TDV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
--            max_write_label => 'TDV',
--            min_write_label => 'TDV',
--            def_label       => 'TDV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
--            row_label       => 'TDV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
end;
/

exec SET_LABELS_TBM;
-- cau c

create or replace procedure SET_LABELS_GVU as
    CURSOR CUR IS (SELECT MANV FROM ADMINLC.NHANSU WHERE MANV LIKE 'NS03%');
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
--            max_write_label => 'GVU',
--            min_write_label => 'GVU',
--            def_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
--            row_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
end;
/

exec SET_LABELS_GVU;

create or replace procedure SET_T1_TDV(MA in varchar2) as
    STRSQL VARCHAR2(200);
BEGIN
        -- Thi?t l?p nh?n cho d¨°ng th?ng b¨¢o v?i MATB = MA
        STRSQL := 'UPDATE ADMIN_OLS.THONGBAO SET Notification_Label = CHAR_TO_LABEL(''Notification_Policy'',''TDV'') WHERE MATB = :1';
        EXECUTE IMMEDIATE STRSQL USING MA;
END;
/
--cau e
EXEC SET_T1_TDV('TB00000001');
create or replace procedure SET_T2_SV(MA in varchar2) as
    STRSQL VARCHAR2(200);
BEGIN
        STRSQL := 'UPDATE ADMIN_OLS.THONGBAO SET Notification_Label = CHAR_TO_LABEL(''Notification_Policy'',''SV:HTTT:CS1'') WHERE MATB = :1';
        EXECUTE IMMEDIATE STRSQL USING MA;
END;
/
--cau f
create or replace procedure SET_T3_TBM_CS1(MA in varchar2) as
    STRSQL VARCHAR2(200);
BEGIN
        -- Thi?t l?p nh?n cho d¨°ng th?ng b¨¢o v?i MATB = MA
        STRSQL := 'UPDATE ADMIN_OLS.THONGBAO SET Notification_Label = CHAR_TO_LABEL(''Notification_Policy'',''TBM:KHMT:CS1'') WHERE MATB = :1';
        EXECUTE IMMEDIATE STRSQL USING MA;
END;
/
--cau g
create or replace procedure SET_T4_TBM_CS12(MA in varchar2) as
    STRSQL VARCHAR2(200);
BEGIN
        -- Thi?t l?p nh?n cho d¨°ng th?ng b¨¢o v?i MATB = MA
        STRSQL := 'UPDATE ADMIN_OLS.THONGBAO SET Notification_Label = CHAR_TO_LABEL(''Notification_Policy'',''TBM:KHMT:CS1,CS2'') WHERE MATB = :1';
        EXECUTE IMMEDIATE STRSQL USING MA;
END;
/

--h.
--CS1: Giao vien duoc xem cac thong bao lien quan den giao vien, khong phan biet co so
create or replace procedure SET_LABELS_SV as
    CURSOR CUR IS (SELECT MASV FROM ADMINLC.SINHVIEN);
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'SV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
--            max_write_label => 'GVU',
--            min_write_label => 'GVU',
--            def_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
--            row_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
end;
/
--CS2: Nhan vien o CS1 chi do duoc thong bao o CS1

create or replace procedure SET_LABELS_NVCS1 as
    CURSOR CUR IS (SELECT MANV FROM ADMINLC.NHANSU WHERE MANV LIKE 'NS01%');
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'NV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1'
--            max_write_label => 'GVU',
--            min_write_label => 'GVU',
--            def_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
--            row_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
end;
/
--CS3: Giao vu d??c xem thong bao cua Giao vien va Sinh vien
create or replace procedure SET_LABELS_GVU2 as
    CURSOR CUR IS (SELECT MANV FROM ADMINLC.NHANSU WHERE MANV LIKE 'NS03%');
    STRSQL VARCHAR2(2000);
    USER_NAME VARCHAR2(10);    
BEGIN
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER_NAME;
        EXIT WHEN CUR%NOTFOUND;
        
        -- C?p quy?n SELECT cho ng??i d¨´ng
        STRSQL := 'GRANT SELECT ON ADMIN_OLS.THONGBAO TO ' || USER_NAME;
        EXECUTE IMMEDIATE STRSQL;
        
        -- Thi?t l?p nh?n cho ng??i d¨´ng
        SA_USER_ADMIN.SET_USER_LABELS(
            policy_name => 'Notification_Policy',
            user_name => USER_NAME,
            max_read_label => 'GVU,GV,SV:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
--            max_write_label => 'GVU',
--            min_write_label => 'GVU',
--            def_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2',
--            row_label       => 'GVU:MMT,TGMT,CNTT,KHMT,CNPM,HTTT:cs1,cs2'
        );
    END LOOP;
    CLOSE CUR;
end;
/