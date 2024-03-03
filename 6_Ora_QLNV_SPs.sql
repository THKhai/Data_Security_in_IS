-- 21127620 - Tr?n Ho角ng Kh?i

-- Nh車m l?nh x車a c?u tr迆c d? li?u
drop table SALGRADE_21127620; 
drop table EMP_21127620;
drop table DEPT_21127620;

-- t?o b?ng SALGRADE
create table SALGRADE_21127620(
    GRADE number primary key,
    LOSAL number,
    HISAL number
);
-- T?o b?ng DEPT
create table DEPT_21127620(
    DEPTNO number(2) primary key,
    DNAME varchar2(14),
    Loc varchar2(13) 
);
-- T?o b?ng EMP
create table EMP_21127620(
    EMPNO number(4) primary key,
    ENAME varchar2(10),
    JOB varchar2(9),
    MGR number(4),
    HIREDATE date,
    SAL number(7,2),
    COMM number(7,2),
    DEPTNO number(2) not null 
);

-- Th那m kh車a ngo?i cho b?ng EMP
alter table EMP_21127620
add foreign key (MGR) references EMP_21127620(EMPNO);
alter table EMP_21127620
add foreign key (DEPTNO) references DEPT_21127620(DEPTNO);

/

-- insert into SALGRADE_21117620
insert into SALGRADE_21127620(GRADE,LOSAL,HISAL ) values(1,700,1200);
insert into SALGRADE_21127620(GRADE,LOSAL,HISAL ) values(2,1201,1400);
insert into SALGRADE_21127620(GRADE,LOSAL,HISAL ) values(3,1401,2000);
insert into SALGRADE_21127620(GRADE,LOSAL,HISAL ) values(4,2001,3000);
insert into SALGRADE_21127620(GRADE,LOSAL,HISAL ) values(5,3001,9999);

--insert into DEPT_21127620
insert into DEPT_21127620(DEPTNO,DNAME,LOC) values (10,'ACCOUNTING','EW YORK');
insert into DEPT_21127620(DEPTNO,DNAME,LOC) values (20,'RESEARCH','DALLAS');
insert into DEPT_21127620(DEPTNO,DNAME,LOC) values (30,'SALES','CHICAGO');
insert into DEPT_21127620(DEPTNO,DNAME,LOC) values (40,'OPERATIONS','BOSTON');

--insert into EMP_21127620
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7839,'KING','PRESIDENT',NULL,TO_DATE('17-11-1981','DD-MM-YYYY'),5000,NULL,10);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7698,'BLAKE','MANAGER',7839,TO_DATE('01-05-1981','DD-MM-YYYY'),2850,null,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7782,'CLANK','MANAGER',7839,TO_DATE('09-06-1981','DD-MM-YYYY'),2450,null,10);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7566,'JONES','MANAGER',7839,TO_DATE('03-04-1982','DD-MM-YYYY'),2975,null,20);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7654,'MARTIN','SALESMAN',7698,TO_DATE('28-09-1981','DD-MM-YYYY'),1250,1400,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7499,'ALLEN','SALESMAN',7698,TO_DATE('20-02-1981','DD-MM-YYYY'),1600,300,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7844,'TURNER','SALESMAN',7698,TO_DATE('08-09-1981','DD-MM-YYYY'),1500,0,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7900,'JAMES', 'CLERK',7698,TO_DATE('03-12-1981','DD-MM-YYYY'),950,null,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7521,'WARD','SALESMAN',7698,TO_DATE('22-02-1981','DD-MM-YYYY'),1250,500,30);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7902,'FORD','ANALYST',7566,TO_DATE('03-12-1981','DD-MM-YYYY'),3000,null,20);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7369,'SMITH','CLERK',7902,TO_DATE('17-12-1980','DD-MM-YYYY'),800,null,20);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7788, 'SCOTT','ANALYST',7566,TO_DATE('09-12-1982','DD-MM-YYYY'),3000,null,20);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7876,'ADAMS','CLERK',7788,TO_DATE('12-01-1983','DD-MM-YYYY'),1100,null,20);
insert into EMP_21127620(EMPNO,ENAME,job,mgr,hiredate,sal,comm,deptno) values (7934,'MILLER','CLERK',7782,TO_DATE('23-01-1982','DD-MM-YYYY'),1300,null,10);

-- KHANG ( BEGIN )
CREATE OR REPLACE PROCEDURE usp_C1_ThuNhapNV_21127622
AS
    cursor_ SYS_REFCURSOR;
BEGIN
    OPEN cursor_ FOR
        SELECT ENAME, SAL
        FROM EMP_21127620;
    DBMS_SQL.RETURN_RESULT(cursor_); 
END;
/
BEGIN 
    usp_C1_ThuNhapNV_21127622;
END;
/

CREATE OR REPLACE PROCEDURE usp_C2_CauTrucBangEMP_21127622--(cursor_2 OUT SYS_REFCURSOR)
AS
    cursor_ SYS_REFCURSOR;
BEGIN
    OPEN cursor_ FOR
        SELECT *
        FROM USER_TAB_COLS
        WHERE table_name = 'EMP_21127620'
        ORDER BY column_id;
    DBMS_SQL.RETURN_RESULT(cursor_); 
END;
/
BEGIN 
    usp_C2_CauTrucBangEMP_21127622;
END;
/

CREATE OR REPLACE PROCEDURE usp_C3_SalHireDate_21127622
(
  SALAlias         VARCHAR2,
  HIREDATEAlias    VARCHAR2,
  SALDisplayFormat VARCHAR2,
  HIREDATEFormat   VARCHAR2
)
AS
  sysRefCursor SYS_REFCURSOR;
BEGIN
  OPEN sysRefCursor
  FOR 'SELECT TO_CHAR( SAL, :s ) AS ' || SALAlias
      || ', TO_CHAR( HIREDATE, :h ) AS ' || HIREDATEAlias
      || ' FROM EMP_21127620' USING SALDisplayFormat, HIREDATEFormat;
  DBMS_SQL.RETURN_RESULT(sysRefCursor);
END;
/
BEGIN
  usp_C3_SalHireDate_21127622( 'salary', 'hd', '99999999.00', 'YYYY-MM-DD' );
END;
/
CREATE OR REPLACE PROCEDURE usp_C4_DanhSachNVLuong_21127622
AS
    cursor_ SYS_REFCURSOR;
BEGIN
    OPEN cursor_ FOR
        SELECT *
        FROM EMP_21127620
        WHERE SAL <= 2000 AND SAL >= 1000;
    DBMS_SQL.RETURN_RESULT(cursor_); 
END;
/
BEGIN 
    usp_C4_DanhSachNVLuong_21127622;
END;
/
-- KHANG (END)

--TO?N (BEGIN)
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE usp_C5_DanhSachNV_THLL_21127705 
IS
BEGIN
    FOR emp IN (SELECT * FROM EMP_21127620 WHERE EMP_21127620.ENAME LIKE '%LL%' OR EMP_21127620.ENAME LIKE '%TH%')
    LOOP
        DBMS_OUTPUT.PUT_LINE('EMPNO: '||emp.EMPNO||' | ENAME: ' || emp.ENAME||' | JOB: '|| emp.JOB||' | MGR: '|| emp.MGR ||' | HIREDATE: '|| emp.HIREDATE||' | SAL: '|| emp.SAL|| ' | COMM: '||emp.COMM|| '| DEPTNO: '|| emp.DEPTNO);
    END LOOP;
END;
/
--6
CREATE OR REPLACE PROCEDURE usp_C6_DanhSachNV_VAO1993_21127705 
IS
BEGIN
    FOR emp IN (SELECT * FROM EMP_21127620 WHERE EXTRACT(YEAR FROM EMP_21127620.HIREDATE) = 1993)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ENAME: ' || emp.ENAME||' | HIREDATE: '|| emp.HIREDATE||'| DEPTNO: '|| emp.DEPTNO);
    END LOOP;
END;
/
--7
CREATE OR REPLACE PROCEDURE usp_C7_DanhSachNV_Luongtang15_21127705 
IS
BEGIN
    FOR emp IN (SELECT * FROM EMP_21127620 WHERE (((EMP_21127620.SAL + EMP_21127620.COMM) / EMP_21127620.SAL) - 1) > 0.25)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ENAME: ' || emp.ENAME||' | SAL: '|| emp.SAL||'| DEPTNO: '|| emp.DEPTNO);
    END LOOP;
END;
/
--TO?N (END)

--KH?I (BEGIN)
-- cau 8
CREATE OR REPLACE PROCEDURE usp_C8Hienthi_21127620 
AS
BEGIN
    for emp in (select e.ENAME || '(' || e.job || ')' as EMPLOYEE from EMP_21127620 e)LOOP
    DBMS_OUTPUT.PUT_LINE(emp.EMPLOYEE);
    END LOOP;   
END;
/
exec usp_C8Hienthi_21127620;



-- cau 9
CREATE OR REPLACE PROCEDURE  usp_C9_DanhSachNV20_Hienthi_2127620 AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ENAME      Date_Hired');    
    FOR emp IN (select e.ENAME,e.hiredate from emp_21127620 e where e.deptno = 20) LOOP
        DBMS_OUTPUT.PUT_LINE(emp.ENAME || '      ' || TO_CHAR(emp.hiredate, 'DD-MON-YYYY'));
    END LOOP;
END;
/
exec usp_C9_DanhSachNV20_Hienthi_2127620;

--cau 10


CREATE OR REPLACE PROCEDURE usp_C10_DanhSachNhanVienLuong_21127620
as
        max_sal number;
        min_sal number;
        avg_sal number;
begin
    select max(e.SAL)
    into max_sal
    from EMP_21127620 e;

    select min(e.SAL)
    into min_sal
    from EMP_21127620 e;
    
    select round (avg(e.SAL),2)
    into avg_sal
    from EMP_21127620 e;
    
    DBMS_OUTPUT.PUT_LINE('MAX SALARY: ' || max_sal);
    DBMS_OUTPUT.PUT_LINE('MIN SALARY: ' || min_sal);
    DBMS_OUTPUT.PUT_LINE('AVERAGE SALARY: ' || avg_sal);
end;
/
exec usp_C10_DanhSachNhanVienLuong_21127620;
--KH?I (END)
