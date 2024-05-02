---- create user
---- cs01
connect ADMINLC/ADMINLC;
--
alter session set"_ORACLE_SCRIPT" = true;
drop role R_NhanSu;

create role R_NhanSu;
create or replace view V_NhanSu
as
    select*
    from ADMINLC.NhanSu
    where manv = sys_context('USERENV', 'SESSION_USER');
    
/
grant select,update(DT) on  ADMINLC.V_NhanSu to R_NhanSu;
grant select on ADMINLC.SINHVIEN to R_NhanSu;
grant select on ADMINLC.DONVI to R_NhanSu;
grant select on ADMINLC.HOCPHAN to R_NhanSu;
grant select on ADMINLC.KHMO to R_NhanSu;

CREATE OR REPLACE PROCEDURE GRANT_ROLE_NS AS
   CURSOR CUR IS 
      SELECT ns.manv
      FROM ADMINLC.nhansu ns;
   STRSQL VARCHAR(2000);
   USR VARCHAR2(10);
BEGIN
   OPEN CUR;
   LOOP
      FETCH CUR INTO USR;
      EXIT WHEN CUR%NOTFOUND;
      STRSQL := 'GRANT R_NhanSu TO ' || USR;
      EXECUTE IMMEDIATE STRSQL;
   END LOOP;
   CLOSE CUR;
END;
/
--
exec GRANT_ROLE_NS;
-- cs2
-- 
connect ADMINLC/ADMINLC;
/
alter session set"_ORACLE_SCRIPT" = true;
--DROP ROLE R_GIANGVIEN;
create role R_GiangVien;
alter session set"_ORACLE_SCRIPT" = false;
/
create or replace view V_PhanCong_GV
as
    select*
    from ADMINLC.PHANCONG PC
    where PC.MAGV = SYS_CONTEXT('USERENV','SESSION_USER');
create or replace view V_DangKy_GV
as
    select*
    from ADMINLC.DANGKY dk
    where dk.MAGV = SYS_CONTEXT('USERENV','SESSION_USER');
    
grant select on ADMINLC.V_PhanCong_GV to R_GiangVien;
grant select,update(DIEMTHI,DIEMQT,DIEMCK,DIEMTK) on ADMINLC.V_DangKy_GV to R_GiangVien;

create or replace procedure GRANT_ROLE_GV
as
    cursor cur is
        select MANV
        from ADMINLC.NHANSU
        where MANV like 'NS02%';
    STRSQL varchar2(2000);
    USER varchar2(10);
begin
    OPEN CUR;
    LOOP
        FETCH CUR INTO USER;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL:='GRANT R_GIANGVIEN TO '||USER;
        EXECUTE IMMEDIATE STRSQL;
    END LOOP;
    CLOSE CUR;
end;
/
EXEC GRANT_ROLE_GV;
--test

--connect NS02000001/NS02000001;
--select* from ADMINLC.V_NHANSU;
--select* from ADMINLC.V_PHANCONG_GV;
--select* from ADMINLC.V_DANGKY_GV;
--update ADMINLC.V_DANGKY_GV set DIEMTHI = 1, DIEMQT = 2, DIEMCK = 2, DIEMTK = 3 where MAHP = 'HP02000001';
--update ADMINLC.V_DANGKY_GV set DIEMTHI = 1, DIEMQT = 2, DIEMCK = 2, DIEMTK = 3 where MAHP = 'HP02000002';