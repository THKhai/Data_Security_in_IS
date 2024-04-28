-- create user
-- cs01
alter session set "_ORACLE_SCRIPT" =true;
create role R_NhanSu;
create or replace view V_NhanSU
as
    select*
    from NhanSu
    where manv = sys_context('USERENV', 'SESSION_USER');
    
    
grant select,update(DT) on V_NhanSu to R_NhanSu;
grant select on SINHVIEN to R_NhanSu;
grant select on DONVI to R_NhanSu;
grant select on HOCPHAN to R_NhanSu;
grant select on KHMO to R_NhanSu;

create or replace procedure GRANT_ROLE_NS
as
   CURSOR CUR IS (SELECT manv
                    FROM nhansu);
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
begin
    OPEN CUR;
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'GRANT R_NhanSu TO '||USER;
        EXECUTE IMMEDIATE(STRSQL);
    END LOOP;
    CLOSE CUR;
END;
/
exec GRANT_ROLE_NS;
