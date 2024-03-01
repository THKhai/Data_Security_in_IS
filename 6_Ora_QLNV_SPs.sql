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
    ENNAME varchar2(10),
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
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7839,'KING','PRESIDENT',NULL,TO_DATE('17-11-1981','DD-MM-YYYY'),5000,NULL,10);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7698,'BLAKE','MANAGER',7839,TO_DATE('01-05-1981','DD-MM-YYYY'),2850,null,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7782,'CLANK','MANAGER',7839,TO_DATE('09-06-1981','DD-MM-YYYY'),2450,null,10);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7566,'JONES','MANAGER',7839,TO_DATE('03-04-2982','DD-MM-YYYY'),2975,null,20);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7654,'MARTIN','SALESMAN',7698,TO_DATE('28-09-1981','DD-MM-YYYY'),1250,1400,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7499,'ALLEN','SALESMAN',7698,TO_DATE('20-02-1981','DD-MM-YYYY'),1600,300,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7844,'TURNER','SALESMAN',7698,TO_DATE('08-09-1981','DD-MM-YYYY'),1500,0,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7900,'JAMES', 'CLERK',7698,TO_DATE('03-12-1981','DD-MM-YYYY'),950,null,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7521,'WARD','SALESMAN',7698,TO_DATE('22-02-1981','DD-MM-YYYY'),1250,500,30);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7902,'FORD','ANALYST',7566,TO_DATE('03-12-1981','DD-MM-YYYY'),3000,null,20);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7369,'SMITH','CLERK',7902,TO_DATE('17-12-1980','DD-MM-YYYY'),800,null,20);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7788, 'SCOTT','ANALYST',7566,TO_DATE('09-12-1982','DD-MM-YYYY'),3000,null,20);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7876,'ADAMS','CLERK',7788,TO_DATE('12-01-1983','DD-MM-YYYY'),1100,null,20);
insert into EMP_21127620(EMPNO,enname,job,mgr,hiredate,sal,comm,deptno) values (7934,'MILLER','CLERK',7782,TO_DATE('23-01-1982','DD-MM-YYYY'),1300,null,10);

-- KHANG ( BEGIN )
-- KHANG (END)

--TO?N (BEGIN)
--TO?N (END)

--KH?I (BEGIN)
    
--KH?I (END)
