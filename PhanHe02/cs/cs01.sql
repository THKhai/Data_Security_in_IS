---- create user
---- cs01
--
--
connect ADMINLC/ADMINLC;
--
create role R_NhanSu;
create or replace view V_NhanSu
as
    select*
    from ADMINLC.NhanSu
    where manv = sys_context('USERENV', 'SESSION_USER');
    
    
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


