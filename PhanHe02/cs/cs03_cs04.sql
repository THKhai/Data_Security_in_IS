connect ADMINLC/ADMINLC;

--CS3
alter session set"_ORACLE_SCRIPT" = true;
create role R_GiaoVu;
grant R_NhanSu to R_GiaoVu;
grant select, insert, update on ADMINLC.SINHVIEN to R_GiaoVu;
grant select, insert, update on ADMINLC.DONVI to R_GiaoVu;
grant select, insert, update on ADMINLC.HOCPHAN to R_GiaoVu;
grant select, insert, update on ADMINLC.KHMO to R_GiaoVu;
grant select on ADMINLC.PHANCONG to R_GiaoVu;

create or replace view V_GiaoVu_PhanCong
as
    select pc.magv,pc.mahp,pc.hk,pc.nam,pc.mact from ADMINLC.phancong pc,ADMINLC.nhansu ns where pc.magv = ns.manv and ns.madv = 'DV0001';
/

grant select ,update on V_GiaoVu_PhanCong to R_GiaoVu;
grant insert,delete on ADMINLC.DANGKY to R_GiaoVu;

CREATE OR REPLACE PROCEDURE GRANT_ROLE_GIAOVU AS
   CURSOR CUR IS 
      select MANV
        from ADMINLC.NHANSU
        where MANV like 'NS03%';
   STRSQL VARCHAR(2000);
   USR VARCHAR2(10);
BEGIN
   OPEN CUR;
   LOOP
      FETCH CUR INTO USR;
      EXIT WHEN CUR%NOTFOUND;
      STRSQL := 'GRANT R_GiaoVu TO ' || USR;
      EXECUTE IMMEDIATE STRSQL;
   END LOOP;
   CLOSE CUR;
END;
/
EXEC GRANT_ROLE_GIAOVU;

connect NS03000001/NS03000001
select * from ADMINLC.SINHVIEN;
--CS4
alter session set"_ORACLE_SCRIPT" = true;
create role R_TRUONGDONVI;
grant R_GiangVien to R_TRUONGDONVI;

create or replace view V_TRUONGDONVI_PhanCong
as
    select pc.magv,pc.mahp,pc.hk,pc.nam,pc.mact from ADMINLC.phancong pc,ADMINLC.hocphan hp,ADMINLC.donvi dv where pc.mahp = hp.mahp and hp.madv = dv.madv and dv.trgdv = sys_context('USERENV', 'SESSION_USER');

/
create or replace view V_TRUONGDONVI_PhanCong_xem
as
    select pc.magv,pc.mahp,pc.hk,pc.nam,pc.mact from ADMINLC.phancong pc,ADMINLC.nhansu ns,ADMINLC.donvi dv where pc.magv = ns.manv and ns.madv = dv.madv and dv.trgdv = sys_context('USERENV', 'SESSION_USER');

/
grant select,insert,delete,update on V_TRUONGDONVI_PhanCong to R_TRUONGDONVI;
grant select on V_TRUONGDONVI_PhanCong_xem to R_TRUONGDONVI;

CREATE OR REPLACE PROCEDURE GRANT_ROLE_TRUONGDONVI AS
   CURSOR CUR IS 
      select MANV
        from ADMINLC.NHANSU
        where MANV like 'NS04%';
   STRSQL VARCHAR(2000);
   USR VARCHAR2(10);
BEGIN
   OPEN CUR;
   LOOP
      FETCH CUR INTO USR;
      EXIT WHEN CUR%NOTFOUND;
      STRSQL := 'GRANT R_TRUONGDONVI TO ' || USR;
      EXECUTE IMMEDIATE STRSQL;
   END LOOP;
   CLOSE CUR;
END;
/
EXEC GRANT_ROLE_TRUONGDONVI;
