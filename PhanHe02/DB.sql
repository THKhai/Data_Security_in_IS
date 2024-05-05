-- 
-- adminlc
declare
    STRSQL varchar(2000);
    user_count numeric;
begin
    select count(*) into user_count from ALL_USERS where USERNAME = 'ADMINLC';
    if user_count = 1 then
        STRSQL := 'alter session set "_ORACLE_SCRIPT" =true';
        execute  immediate (STRSQL);
        STRSQL := 'drop user ADMINLC CASCADE';
        execute immediate (STRSQL);
        STRSQL := 'alter session set "_ORACLE_SCRIPT" =false';
        execute  immediate (STRSQL);
    end if;
end;
/

alter session set "_ORACLE_SCRIPT" =true;
create user ADMINLC identified by ADMINLC ;
grant all privileges to ADMINLC;
grant execute on dbms_rls to ADMINLC;
grant connect to ADMINLC;
grant alter session to ADMINLC;
/
-- connect ADMINLC
connect ADMINLC/ADMINLC;
/
--
drop table ADMINLC.DANGKY;
drop table ADMINLC.PHANCONG;
drop table ADMINLC.KHMO;
drop table ADMINLC.HOCPHAN;
drop table ADMINLC.NHANSU;
drop table ADMINLC.DONVI;
drop table ADMINLC.SINHVIEN;
/
create table NHANSU(
    MANV char(10) primary key,
    HOTEN varchar(60),
    PHAI char(5) check (PHAI = 'Nam' or PHAI = 'N?'),
    NGSINH DATE,
    PHUCAP INT, 
    DT char(13),
    VAITRO varchar(50),
    MADV char(10) -- khoa ngoai toi DONVI
);
/
create table SINHVIEN(
    MASV char(10) primary key,
    HOTEN varchar(50),
    PHAI char(5) check (PHAI = 'Nam' or PHAI = 'N?'),
    NGSINH DATE,
    DCHI varchar(200),
    DT char(13),
    MACT char(10), -- khoa ngoai toi CHUONGTRINH
    MANGANH char(10),
    SOTCTL int,
    DTBTL int
);
/
create table DONVI (
    MADV char(10) primary key,
    TENDV varchar(50),
    TRGDV varchar(50) --ch?a ch?c , kh��a ngo?i t?i NHANSU
);
/

create table HOCPHAN(
    MAHP char(10) primary key,
    TENHP varchar(50),
    SOTC int,
    STLT int,
    STTH int,
    SOSVTD int,
    MADV char(10) -- t?i b?ng ??n v???
);
/
create table KHMO(
    MAHP char(10),
    HK int,
    NAM int,
    MACT char(10),
    PRIMARY KEY (MAHP,HK,NAM,MACT) 
);
/
create table PHANCONG (
    MAGV char(10),
    MAHP char(10),
    HK int,
    NAM int,
    MACT char(10),
    primary key (MAGV,MAHP,HK,NAM,MACT)
);
/
create table DANGKY(
    MASV char(10),
    MAGV char(10),
    MAHP char(10),
    HK int,
    NAM int, 
    MACT char(10),
    DIEMTHI float,
    DIEMQT float,
    DIEMCK float,
    DIEMTK float,
    primary key (MASV,MAGV,MAHP,HK,NAM,MACT)
);
/

-----------------------------------------foreign key----------------------------------------------------
-- Nhansu, MADV--DONVI MADV
alter table NHANSU add  foreign key (MADV) references DONVI(MADV);
-- HOCPHAN, MADV -- DONVI MADV
alter table HOCPHAN add  foreign key (MADV) references DONVI(MADV);
-- KHMO
alter table KHMO add  FOREIGN key (MAHP) references HOCPHAN(MAHP);
--PHANCONG
alter table PHANCONG add  foreign key (MAGV) references NHANSU(MANV);
alter table PHANCONG add  foreign key (MAHP,HK,NAM,MACT) references KHMO(MAHP,HK,NAM,MACT);
-- DANG KY
alter table DANGKY add foreign key (MASV) references SINHVIEN(MASV);
alter table DANGKY add  foreign key (MAGV,MAHP,HK,NAM,MACT) references PHANCONG(MAGV,MAHP,HK,NAM,MACT);

----------------------------------------import data---------------------------------------------
-- DONVI
INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0001', 'V?n ph��ng khoa', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0002', 'HTTT', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0003', 'CNPM ', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0004', 'KHMT', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0005', 'CNTT', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0006', 'TGMT', NULL);

INSERT INTO DONVI (MADV, TENDV, TRGDV) 
VALUES ('DV0007', 'MMT v�� Vi?n Th?ng', NULL);
/
--NHANSU

INSERT INTO NHANSU  
VALUES ('NS01000001', 'Tara Walia', 'Nam', to_date('1965-06-28', 'YYYY-MM-DD'), 386000, '+914876475938', 'Nh?n vi��n c? b?n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS01000002', 'Raunak Boase', 'Nam', to_date('2011-02-12', 'YYYY-MM-DD'), 238000, '+919489241157', 'Nh?n vi��n c? b?n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS01000003', 'Sumer Kalla', 'N?', to_date('1951-04-15', 'YYYY-MM-DD'), 171000, '3877840801', 'Nh?n vi��n c? b?n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS01000004', 'Rhea Tella', 'Nam', to_date('2015-02-04', 'YYYY-MM-DD'), 368000, '0975351393', 'Nh?n vi��n c? b?n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS01000005', 'Zaina Bobal', 'N?', to_date('2017-07-25', 'YYYY-MM-DD'), 281000, '7115871484', 'Nh?n vi��n c? b?n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS01000006', 'Ira Ganesan', 'N?', to_date('2019-02-06', 'YYYY-MM-DD'), 344000, '3989471965', 'Nh?n vi��n c? b?n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS01000007', 'Riaan Chanda', 'N?', to_date('1934-01-10', 'YYYY-MM-DD'), 152000, '+910947112201', 'Nh?n vi��n c? b?n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS01000008', 'Renee Lala', 'N?', to_date('1945-10-06', 'YYYY-MM-DD'), 304000, '3396947751', 'Nh?n vi��n c? b?n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS01000009', 'Manjari Bhardwaj', 'N?', to_date('1974-06-16', 'YYYY-MM-DD'), 144000, '5330413525', 'Nh?n vi��n c? b?n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS01000010', 'Biju Bedi', 'Nam', to_date('2014-11-01', 'YYYY-MM-DD'), 256000, '+913098910139', 'Nh?n vi��n c? b?n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000001', 'Vihaan Bath', 'N?', to_date('1958-08-17', 'YYYY-MM-DD'), 389000, '+910903217300', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000002', 'Miraya Bedi', 'N?', to_date('2022-01-06', 'YYYY-MM-DD'), 320000, '01314562087', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000003', 'Kimaya Bedi', 'Nam', to_date('2003-06-06', 'YYYY-MM-DD'), 366000, '03457923022', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000004', 'Eva Dass', 'N?', to_date('1924-03-15', 'YYYY-MM-DD'), 285000, '7207698456', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000005', 'Indrans Mand', 'N?', to_date('2002-04-09', 'YYYY-MM-DD'), 134000, '+917150842375', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000006', 'Pari Gola', 'N?', to_date('1988-08-02', 'YYYY-MM-DD'), 486000, '9246610935', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000007', 'Nakul Choudhury', 'N?', to_date('1995-01-01', 'YYYY-MM-DD'), 482000, '06960696027', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000008', 'Pranay Sarna', 'N?', to_date('1929-09-17', 'YYYY-MM-DD'), 489000, '08789007547', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000009', 'Zoya Tata', 'Nam', to_date('2018-10-27', 'YYYY-MM-DD'), 375000, '03812066503', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000010', 'Saanvi Shroff', 'Nam', to_date('1908-07-28', 'YYYY-MM-DD'), 335000, '8913193442', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000011', 'Anika Varma', 'N?', to_date('1962-03-29', 'YYYY-MM-DD'), 131000, '1047142851', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000012', 'Ranbir Varghese', 'N?', to_date('1910-10-12', 'YYYY-MM-DD'), 340000, '+910348559097', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000013', 'Navya Kalla', 'Nam', to_date('1958-12-10', 'YYYY-MM-DD'), 334000, '2369402245', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000014', 'Vritika Gour', 'Nam', to_date('2006-01-14', 'YYYY-MM-DD'), 487000, '+915900422945', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000015', 'Ira Bhattacharyya', 'N?', to_date('1948-03-08', 'YYYY-MM-DD'), 320000, '+917304281465', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000016', 'Zeeshan Bhagat', 'Nam', to_date('1921-10-12', 'YYYY-MM-DD'), 335000, '7755171760', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000017', 'Shamik Shah', 'Nam', to_date('2001-10-07', 'YYYY-MM-DD'), 145000, '+912961113306', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000018', 'Divyansh Hegde', 'Nam', to_date('1983-12-27', 'YYYY-MM-DD'), 443000, '4779361534', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000019', 'Adah Char', 'Nam', to_date('1957-01-17', 'YYYY-MM-DD'), 149000, '+911087317643', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000020', 'Yasmin Chokshi', 'N?', to_date('1993-02-05', 'YYYY-MM-DD'), 348000, '+911376582197', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000021', 'Jivika Jain', 'N?', to_date('1995-02-18', 'YYYY-MM-DD'), 293000, '6875773893', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000022', 'Shlok Sastry', 'Nam', to_date('2009-12-03', 'YYYY-MM-DD'), 145000, '05082492694', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000023', 'Chirag Sura', 'Nam', to_date('1919-10-09', 'YYYY-MM-DD'), 205000, '0132040752', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000024', 'Neysa Karpe', 'Nam', to_date('1958-10-15', 'YYYY-MM-DD'), 177000, '6880918916', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000025', 'Riaan Loyal', 'N?', to_date('1989-09-21', 'YYYY-MM-DD'), 269000, '07699300248', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000026', 'Shamik Bali', 'Nam', to_date('1975-06-02', 'YYYY-MM-DD'), 357000, '04666022345', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000027', 'Armaan Khosla', 'N?', to_date('1965-02-14', 'YYYY-MM-DD'), 185000, '+917912560976', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000028', 'Badal Bedi', 'Nam', to_date('1972-05-04', 'YYYY-MM-DD'), 377000, '+910099251853', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000029', 'Vardaniya Soni', 'N?', to_date('2014-01-23', 'YYYY-MM-DD'), 148000, '01097951942', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000030', 'Yasmin Din', 'Nam', to_date('2009-10-02', 'YYYY-MM-DD'), 249000, '1830675375', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000031', 'Azad Yohannan', 'Nam', to_date('1913-09-10', 'YYYY-MM-DD'), 427000, '04089933188', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000032', 'Dishani Dua', 'N?', to_date('1923-09-10', 'YYYY-MM-DD'), 129000, '+916961161162', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000033', 'Vritika Kapoor', 'Nam', to_date('1966-12-03', 'YYYY-MM-DD'), 157000, '6075415115', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000034', 'Shray Ghosh', 'N?', to_date('1932-06-18', 'YYYY-MM-DD'), 205000, '+913519230310', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000035', 'Tushar Sant', 'Nam', to_date('1911-08-10', 'YYYY-MM-DD'), 278000, '3227175420', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000036', 'Taran Ganesh', 'Nam', to_date('1972-09-04', 'YYYY-MM-DD'), 205000, '04852911894', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000037', 'Uthkarsh Yadav', 'Nam', to_date('1928-03-31', 'YYYY-MM-DD'), 448000, '+913583324560', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000038', 'Kismat Anne', 'Nam', to_date('1961-11-05', 'YYYY-MM-DD'), 292000, '+911264862964', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000039', 'Dharmajan Dash', 'N?', to_date('1968-10-15', 'YYYY-MM-DD'), 273000, '5806606573', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000040', 'Ritvik Keer', 'Nam', to_date('1920-08-23', 'YYYY-MM-DD'), 183000, '+911418927626', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000041', 'Jayant Dasgupta', 'Nam', to_date('1969-12-18', 'YYYY-MM-DD'), 235000, '08257173407', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000042', 'Aarush Chopra', 'N?', to_date('1948-11-19', 'YYYY-MM-DD'), 281000, '+914892671738', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000043', 'Ranbir Raval', 'N?', to_date('1911-03-12', 'YYYY-MM-DD'), 437000, '+914004689671', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000044', 'Sumer Dhar', 'Nam', to_date('2011-01-14', 'YYYY-MM-DD'), 452000, '3910144851', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000045', 'Tarini Bumb', 'Nam', to_date('1917-07-08', 'YYYY-MM-DD'), 172000, '04482983816', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000046', 'Seher Sood', 'N?', to_date('2015-07-10', 'YYYY-MM-DD'), 358000, '04759221166', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000047', 'Hiran Mammen', 'N?', to_date('1999-03-15', 'YYYY-MM-DD'), 474000, '05763778570', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000048', 'Rohan Bora', 'N?', to_date('2009-09-03', 'YYYY-MM-DD'), 279000, '00930576081', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000049', 'Piya Shanker', 'Nam', to_date('1999-04-21', 'YYYY-MM-DD'), 314000, '00501904432', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000050', 'Kanav Ben', 'Nam', to_date('1967-04-28', 'YYYY-MM-DD'), 375000, '05625662728', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000051', 'Hansh Chawla', 'N?', to_date('1933-09-05', 'YYYY-MM-DD'), 461000, '05667633739', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000052', 'Vidur Badal', 'N?', to_date('1940-02-07', 'YYYY-MM-DD'), 148000, '1250239491', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000053', 'Trisha Vyas', 'N?', to_date('1956-04-21', 'YYYY-MM-DD'), 153000, '07088697747', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000054', 'Shayak Deol', 'Nam', to_date('1913-12-31', 'YYYY-MM-DD'), 384000, '+910250402163', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000055', 'Ivana Choudhry', 'Nam', to_date('1969-12-31', 'YYYY-MM-DD'), 428000, '+915919155875', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000056', 'Aniruddh Lal', 'Nam', to_date('1914-04-15', 'YYYY-MM-DD'), 351000, '+915138533444', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000057', 'Onkar Khosla', 'Nam', to_date('1955-01-23', 'YYYY-MM-DD'), 190000, '3048107770', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000058', 'Bhamini Karpe', 'N?', to_date('1968-02-24', 'YYYY-MM-DD'), 329000, '+911131263791', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000059', 'Jhanvi Shroff', 'N?', to_date('2021-02-14', 'YYYY-MM-DD'), 330000, '00237324556', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000060', 'Ivana Yogi', 'Nam', to_date('1947-02-09', 'YYYY-MM-DD'), 307000, '8347897844', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000061', 'Advik Bhargava', 'Nam', to_date('1991-12-08', 'YYYY-MM-DD'), 208000, '1263340886', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000062', 'Gatik Handa', 'N?', to_date('1996-01-23', 'YYYY-MM-DD'), 296000, '01953843318', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000063', 'Pari Gade', 'N?', to_date('1940-01-17', 'YYYY-MM-DD'), 412000, '07492208855', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000064', 'Zoya Bhattacharyya', 'Nam', to_date('1962-02-02', 'YYYY-MM-DD'), 162000, '+912812379332', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000065', 'Tara Handa', 'Nam', to_date('1956-05-10', 'YYYY-MM-DD'), 384000, '9271908957', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000066', 'Sahil Ahuja', 'Nam', to_date('1938-03-15', 'YYYY-MM-DD'), 230000, '2778514296', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000067', 'Samar Srivastava', 'Nam', to_date('1947-12-15', 'YYYY-MM-DD'), 141000, '00305357345', 'Gi?ng vi��n', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS02000068', 'Ryan Anand', 'Nam', to_date('1956-10-01', 'YYYY-MM-DD'), 227000, '8025070030', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000069', 'Mamooty Sachdeva', 'N?', to_date('1952-09-16', 'YYYY-MM-DD'), 421000, '+910562376254', 'Gi?ng vi��n', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS02000070', 'Nehmat Gala', 'N?', to_date('2007-05-05', 'YYYY-MM-DD'), 289000, '6606488709', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000071', 'Yuvraj  Hayer', 'N?', to_date('1931-07-27', 'YYYY-MM-DD'), 188000, '+918298215323', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000072', 'Zara Wason', 'N?', to_date('1931-03-26', 'YYYY-MM-DD'), 117000, '8216919729', 'Gi?ng vi��n', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS02000073', 'Ojas Garde', 'N?', to_date('2017-12-07', 'YYYY-MM-DD'), 486000, '6007154273', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000074', 'Ishaan Shah', 'N?', to_date('2010-09-24', 'YYYY-MM-DD'), 245000, '05476048487', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS02000075', 'Trisha Lata', 'N?', to_date('1985-11-23', 'YYYY-MM-DD'), 191000, '4076165700', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000076', 'Seher Badal', 'Nam', to_date('1942-10-23', 'YYYY-MM-DD'), 105000, '9438856431', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000077', 'Zara Dara', 'Nam', to_date('1988-01-10', 'YYYY-MM-DD'), 402000, '8522509092', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000078', 'Taran Dhingra', 'Nam', to_date('1993-05-30', 'YYYY-MM-DD'), 276000, '05769620290', 'Gi?ng vi��n', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS02000079', 'Gokul Garde', 'Nam', to_date('1909-07-09', 'YYYY-MM-DD'), 124000, '7493186428', 'Gi?ng vi��n', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS02000080', 'Chirag Sahni', 'N?', to_date('1995-04-10', 'YYYY-MM-DD'), 113000, '+919188966444', 'Gi?ng vi��n', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS03000001', 'Aaryahi Sood', 'N?', to_date('2019-10-27', 'YYYY-MM-DD'), 366000, '4488855362', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000002', 'Suhana Kumer', 'N?', to_date('1929-05-23', 'YYYY-MM-DD'), 387000, '9657086930', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000003', 'Eva Buch', 'N?', to_date('2000-10-31', 'YYYY-MM-DD'), 387000, '+915703934261', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000004', 'Miraan Sharaf', 'Nam', to_date('2005-05-26', 'YYYY-MM-DD'), 285000, '08132716644', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000005', 'Tanya Soman', 'N?', to_date('1956-09-21', 'YYYY-MM-DD'), 411000, '5140704366', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000006', 'Urvi Ravi', 'N?', to_date('1993-05-26', 'YYYY-MM-DD'), 196000, '6097592945', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000007', 'Vivaan Khalsa', 'Nam', to_date('1979-04-03', 'YYYY-MM-DD'), 438000, '+910195501318', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000008', 'Azad Dugar', 'Nam', to_date('2022-10-05', 'YYYY-MM-DD'), 437000, '+915624629264', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000009', 'Ishaan Bhatnagar', 'N?', to_date('1926-06-25', 'YYYY-MM-DD'), 132000, '00808625911', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS03000010', 'Prerak Chaudhuri', 'N?', to_date('2017-02-27', 'YYYY-MM-DD'), 194000, '05448727820', 'Gi��o v?', 'DV0001');

INSERT INTO NHANSU  
VALUES ('NS04000001', 'Nayantara Kunda', 'Nam', to_date('1912-11-06', 'YYYY-MM-DD'), 102000, '01379378252', 'Tr??ng ??n v?', 'DV0002');

INSERT INTO NHANSU  
VALUES ('NS04000002', 'Trisha Mall', 'N?', to_date('1916-01-12', 'YYYY-MM-DD'), 192000, '1850116959', 'Tr??ng ??n v?', 'DV0003');

INSERT INTO NHANSU  
VALUES ('NS04000003', 'Shamik Thaman', 'Nam', to_date('1959-09-15', 'YYYY-MM-DD'), 119000, '5125022059', 'Tr??ng ??n v?', 'DV0004');

INSERT INTO NHANSU  
VALUES ('NS04000004', 'Azad Jhaveri', 'Nam', to_date('1996-02-02', 'YYYY-MM-DD'), 314000, '+914609251607', 'Tr??ng ??n v?', 'DV0005');

INSERT INTO NHANSU  
VALUES ('NS04000005', 'Lavanya Yohannan', 'Nam', to_date('1992-08-26', 'YYYY-MM-DD'), 332000, '04976207436', 'Tr??ng ??n v?', 'DV0006');

INSERT INTO NHANSU  
VALUES ('NS04000006', 'Taimur Bava', 'Nam', to_date('1925-01-15', 'YYYY-MM-DD'), 242000, '+915026905787', 'Tr??ng ??n v?', 'DV0007');

INSERT INTO NHANSU  
VALUES ('NS05000001', 'Dhanush Varughese', 'N?', to_date('1915-04-17', 'YYYY-MM-DD'), 440000, '6408115517', 'Tr??ng khoa', 'DV0001');
/
-- SINH VIEN



INSERT INTO SINHVIEN
VALUES ('SV21000001', 'Indrans Kuruvilla', 'N?', to_date('1993-05-21', 'YYYY-MM-DD'), 'H.No. 00 Ganguly Marg Sangli-Miraj', '2222395076', 'VP', 'KHMT', 0, 6.06);
INSERT INTO SINHVIEN
VALUES ('SV21000002', 'Mamooty Dara', 'Nam', to_date('1994-10-07', 'YYYY-MM-DD'), 'H.No. 52 Goda Ganj Kamarhati', '+916759269029', 'VP', 'HTTT', 53, 5.53);

INSERT INTO SINHVIEN
VALUES ('SV21000003', 'Piya Hayer', 'Nam', to_date('2006-01-13', 'YYYY-MM-DD'), '200 Kumer Path Delhi', '+910199226066', 'VP', 'CNTT', 71, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21000004', 'Riya Dasgupta', 'N?', to_date('1927-01-04', 'YYYY-MM-DD'), 'H.No. 83 Iyengar Circle Srinagar', '+916951663763', 'VP', 'HTTT', 24, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21000005', 'Nakul Roy', 'Nam', to_date('1973-09-27', 'YYYY-MM-DD'), '91 Devi Road Hajipur', '08099734095', 'CLC', 'CNPM', 51, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21000006', 'Mishti Bera', 'Nam', to_date('1980-12-28', 'YYYY-MM-DD'), 'H.No. 260 Setty Marg Singrauli', '01797225762', 'CQ', 'CNTT', 119, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21000007', 'Tarini Krishnamurthy', 'Nam', to_date('1923-07-26', 'YYYY-MM-DD'), 'H.No. 52 Sinha Path Bhalswa Jahangir Pur', '8034295460', 'VP', 'CNTT', 32, 8.19);

INSERT INTO SINHVIEN
VALUES ('SV21000008', 'Ishita Kale', 'N?', to_date('1912-12-31', 'YYYY-MM-DD'), '64/635 Bhatti Street Bhubaneswar', '5206967116', 'VP', 'CNPM', 85, 5.31);

INSERT INTO SINHVIEN
VALUES ('SV21000009', 'Jayan Bose', 'Nam', to_date('1936-06-27', 'YYYY-MM-DD'), '308 Tank Street Kumbakonam', '09451642585', 'CTTT', 'CNPM', 127, 7.59);

INSERT INTO SINHVIEN
VALUES ('SV21000010', 'Uthkarsh Shankar', 'N?', to_date('2009-06-24', 'YYYY-MM-DD'), '43/65 Keer Marg Sasaram', '06612209981', 'VP', 'KHMT', 132, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21000011', 'Kimaya Rout', 'Nam', to_date('1990-05-03', 'YYYY-MM-DD'), '14/92 Basak Marg Vadodara', '+911575175947', 'CTTT', 'KHMT', 33, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21000012', 'Indranil Mand', 'N?', to_date('1983-04-30', 'YYYY-MM-DD'), 'H.No. 820 Vyas Street Hazaribagh', '09376409262', 'CTTT', 'CNPM', 10, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21000013', 'Jivika Bala', 'N?', to_date('1959-04-18', 'YYYY-MM-DD'), 'H.No. 965 Kulkarni Ganj Sirsa', '+917914878674', 'VP', 'MMT', 39, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21000014', 'Manikya Madan', 'N?', to_date('1957-11-01', 'YYYY-MM-DD'), '492 Banerjee Chowk Coimbatore', '06968147314', 'CQ', 'KHMT', 75, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21000015', 'Taran Tak', 'N?', to_date('1921-01-24', 'YYYY-MM-DD'), '029 Chaudhary Circle Chennai', '+916897178551', 'CTTT', 'CNPM', 114, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21000016', 'Nakul Comar', 'Nam', to_date('1975-12-29', 'YYYY-MM-DD'), 'H.No. 43 Kota Nagar Raichur', '5114963562', 'CTTT', 'MMT', 52, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21000017', 'Reyansh Chaudhry', 'N?', to_date('2009-04-16', 'YYYY-MM-DD'), '54 Ramesh Marg Bikaner', '+916587355645', 'VP', 'HTTT', 53, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21000018', 'Tiya Sinha', 'Nam', to_date('2005-06-23', 'YYYY-MM-DD'), 'H.No. 17 Bhasin Road Amroha', '+915325731667', 'CLC', 'TGMT', 77, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21000019', 'Jivika Thakkar', 'Nam', to_date('1992-05-16', 'YYYY-MM-DD'), '684 Dada Chowk Satna', '0175636090', 'CTTT', 'HTTT', 24, 8.05);

INSERT INTO SINHVIEN
VALUES ('SV21000020', 'Divij Deep', 'N?', to_date('1935-07-07', 'YYYY-MM-DD'), '52/125 Dada Nagar Varanasi', '+916802199317', 'CQ', 'CNTT', 47, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21000021', 'Aarav Lad', 'Nam', to_date('1992-10-27', 'YYYY-MM-DD'), '18 Dada Street Ambattur', '06706360940', 'CLC', 'MMT', 133, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21000022', 'Renee Gour', 'N?', to_date('2020-10-25', 'YYYY-MM-DD'), 'H.No. 72 Kuruvilla Tiruchirappalli', '01140292639', 'CLC', 'CNTT', 138, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21000023', 'Krish Kade', 'Nam', to_date('1977-05-23', 'YYYY-MM-DD'), '18/17 Kumar Zila Sultan Pur Majra', '02785264619', 'CTTT', 'CNPM', 96, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21000024', 'Mehul Karan', 'Nam', to_date('1942-01-25', 'YYYY-MM-DD'), 'H.No. 76 Kapoor Nagar Chennai', '6736347723', 'VP', 'MMT', 27, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21000025', 'Raunak Gole', 'Nam', to_date('1997-03-01', 'YYYY-MM-DD'), '92 Sani Circle Chandigarh', '+914810250592', 'CTTT', 'TGMT', 70, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21000026', 'Vidur Sane', 'N?', to_date('1933-10-15', 'YYYY-MM-DD'), '73 Hayre Street Nashik', '08352889962', 'CQ', 'KHMT', 19, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21000027', 'Nitara Mangal', 'N?', to_date('1937-04-17', 'YYYY-MM-DD'), '70/37 Upadhyay Ratlam', '3000237931', 'CLC', 'CNPM', 15, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21000028', 'Neelofar Ravel', 'Nam', to_date('1947-03-25', 'YYYY-MM-DD'), '57/325 Upadhyay Circle Raurkela Industrial Township', '7675712312', 'CLC', 'CNTT', 106, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21000029', 'Anahi Sathe', 'N?', to_date('1981-10-29', 'YYYY-MM-DD'), '500 Chawla Marg Chandigarh', '09968302874', 'CQ', 'MMT', 99, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21000030', 'Inaaya  Luthra', 'Nam', to_date('1917-03-29', 'YYYY-MM-DD'), 'H.No. 970 Kadakia Ganj Tadepalligudem', '04103909852', 'VP', 'KHMT', 24, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21000031', 'Pranay Bhakta', 'Nam', to_date('1989-01-10', 'YYYY-MM-DD'), '43 Handa Marg Guna', '03941025997', 'CTTT', 'HTTT', 124, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21000032', 'Eshani Khatri', 'Nam', to_date('1967-06-01', 'YYYY-MM-DD'), 'H.No. 60 Kalla Zila Medininagar', '2201630446', 'CQ', 'HTTT', 118, 7.74);

INSERT INTO SINHVIEN
VALUES ('SV21000033', 'Shray Dhingra', 'Nam', to_date('1959-02-12', 'YYYY-MM-DD'), '38/80 Kurian Path Suryapet', '+912704525198', 'CLC', 'KHMT', 15, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21000034', 'Vritika Sibal', 'Nam', to_date('1917-06-17', 'YYYY-MM-DD'), 'H.No. 91 Barad Circle Dharmavaram', '+917083518323', 'CLC', 'TGMT', 87, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21000035', 'Krish Ramanathan', 'N?', to_date('2003-04-20', 'YYYY-MM-DD'), '75/245 Varkey Circle Kollam', '+917524801545', 'VP', 'KHMT', 25, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21000036', 'Dharmajan Ramesh', 'Nam', to_date('1910-03-04', 'YYYY-MM-DD'), 'H.No. 12 Chaudhuri Road Anand', '5716886119', 'CQ', 'CNTT', 51, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21000037', 'Samarth Chahal', 'N?', to_date('1948-08-12', 'YYYY-MM-DD'), '640 Tiwari Nagar Bangalore', '4155840382', 'CTTT', 'MMT', 82, 5.63);

INSERT INTO SINHVIEN
VALUES ('SV21000038', 'Kimaya Bala', 'N?', to_date('2015-03-22', 'YYYY-MM-DD'), '64 Chowdhury Nizamabad', '08771652803', 'CQ', 'TGMT', 26, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21000039', 'Veer Aurora', 'Nam', to_date('1940-09-16', 'YYYY-MM-DD'), 'H.No. 412 Kanda Street Kanpur', '08618374466', 'CLC', 'HTTT', 90, 8.46);

INSERT INTO SINHVIEN
VALUES ('SV21000040', 'Rasha Balakrishnan', 'N?', to_date('1930-08-09', 'YYYY-MM-DD'), '85/332 Sura Ganj Barasat', '+912848023623', 'CTTT', 'KHMT', 132, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21000041', 'Kavya Sangha', 'Nam', to_date('1931-02-12', 'YYYY-MM-DD'), '38/407 Balasubramanian Ganj Bulandshahr', '+916863688712', 'CQ', 'CNTT', 132, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21000042', 'Hazel Ahluwalia', 'Nam', to_date('2020-07-15', 'YYYY-MM-DD'), 'H.No. 036 Sandal Chowk Bally', '05641293300', 'VP', 'KHMT', 15, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21000043', 'Rania Kapoor', 'Nam', to_date('1942-02-20', 'YYYY-MM-DD'), '29 Dhillon Circle Ahmedabad', '2555484207', 'VP', 'HTTT', 80, 7.57);

INSERT INTO SINHVIEN
VALUES ('SV21000044', 'Mahika Issac', 'N?', to_date('1954-06-10', 'YYYY-MM-DD'), '47 Khanna Street Sagar', '5596696849', 'CQ', 'CNTT', 18, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21000045', 'Kanav Kale', 'Nam', to_date('1937-09-13', 'YYYY-MM-DD'), 'H.No. 82 Boase Circle Kavali', '8875464780', 'CTTT', 'TGMT', 33, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21000046', 'Onkar Karnik', 'Nam', to_date('2002-05-07', 'YYYY-MM-DD'), 'H.No. 039 Varty Zila Bardhaman', '+913292594000', 'CQ', 'CNPM', 53, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21000047', 'Sahil Tara', 'Nam', to_date('1940-05-22', 'YYYY-MM-DD'), '75 Bassi Path Ballia', '01020984536', 'CLC', 'CNTT', 79, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21000048', 'Samar Chanda', 'N?', to_date('2016-07-14', 'YYYY-MM-DD'), '729 Krishnan Vellore', '3006902816', 'CTTT', 'HTTT', 58, 7.29);

INSERT INTO SINHVIEN
VALUES ('SV21000049', 'Shalv Ravel', 'Nam', to_date('1993-06-27', 'YYYY-MM-DD'), '30/52 Saha Path Panipat', '07954172184', 'VP', 'MMT', 56, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21000050', 'Mahika Kapur', 'N?', to_date('1965-08-02', 'YYYY-MM-DD'), '29/621 Som Gorakhpur', '+917416441588', 'CLC', 'TGMT', 30, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21000051', 'Aayush Bahri', 'Nam', to_date('1990-12-23', 'YYYY-MM-DD'), 'H.No. 216 Srinivasan Marg Ongole', '+915216930360', 'CQ', 'MMT', 87, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21000052', 'Kismat Srinivas', 'N?', to_date('1962-08-10', 'YYYY-MM-DD'), '846 Walla Marg Bongaigaon', '+917828239219', 'CLC', 'CNPM', 94, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21000053', 'Reyansh Desai', 'Nam', to_date('1942-08-24', 'YYYY-MM-DD'), '600 Soman Circle Coimbatore', '+914228215052', 'VP', 'CNPM', 88, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21000054', 'Kavya Sheth', 'Nam', to_date('1916-10-07', 'YYYY-MM-DD'), 'H.No. 534 Gandhi Chowk Shivpuri', '08811576687', 'CLC', 'CNPM', 91, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21000055', 'Ela Bansal', 'Nam', to_date('1938-02-06', 'YYYY-MM-DD'), '685 Wable Street Madurai', '+912069118494', 'CLC', 'TGMT', 90, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21000056', 'Nitya Virk', 'Nam', to_date('2007-03-06', 'YYYY-MM-DD'), '69 Sharaf Path Kirari Suleman Nagar', '5380655803', 'VP', 'CNPM', 45, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21000057', 'Anika Bhakta', 'Nam', to_date('1958-05-02', 'YYYY-MM-DD'), '93 Arora Circle Kadapa', '1095052547', 'CQ', 'KHMT', 105, 6.64);

INSERT INTO SINHVIEN
VALUES ('SV21000058', 'Tanya Wadhwa', 'N?', to_date('1965-04-16', 'YYYY-MM-DD'), 'H.No. 375 Bains Street Nangloi Jat', '2649730799', 'CTTT', 'HTTT', 9, 6.39);

INSERT INTO SINHVIEN
VALUES ('SV21000059', 'Manjari Kant', 'Nam', to_date('1951-02-27', 'YYYY-MM-DD'), '56/92 Kala Circle Katni', '+915643343895', 'CLC', 'HTTT', 106, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21000060', 'Miraan Ram', 'N?', to_date('1954-03-20', 'YYYY-MM-DD'), '25/32 Maharaj Road Malegaon', '9177329593', 'VP', 'TGMT', 50, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21000061', 'Hrishita Kothari', 'N?', to_date('1936-11-14', 'YYYY-MM-DD'), 'H.No. 64 Chaudhuri Circle Raichur', '05003392871', 'VP', 'MMT', 36, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21000062', 'Damini Dhawan', 'Nam', to_date('2001-12-22', 'YYYY-MM-DD'), '65 Bala Marg Raipur', '+915249874867', 'CTTT', 'TGMT', 40, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21000063', 'Madhup Sandhu', 'N?', to_date('1920-06-15', 'YYYY-MM-DD'), '11/809 Gandhi Circle Kavali', '+919300141962', 'CLC', 'CNPM', 124, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21000064', 'Ranbir Divan', 'Nam', to_date('1929-11-09', 'YYYY-MM-DD'), '932 Vora Street Ambattur', '07429431262', 'CLC', 'CNPM', 46, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21000065', 'Khushi Anand', 'Nam', to_date('1956-01-31', 'YYYY-MM-DD'), '72/41 Varkey Alwar', '3023906227', 'CLC', 'CNPM', 79, 7.89);

INSERT INTO SINHVIEN
VALUES ('SV21000066', 'Damini Dutta', 'Nam', to_date('1938-03-11', 'YYYY-MM-DD'), '27/573 Sandal Road Maheshtala', '+915745894348', 'CTTT', 'MMT', 23, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21000067', 'Chirag Chahal', 'N?', to_date('1959-05-14', 'YYYY-MM-DD'), 'H.No. 918 Sehgal Street Jaunpur', '+916483214756', 'VP', 'HTTT', 20, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21000068', 'Shray Thaman', 'Nam', to_date('1961-05-01', 'YYYY-MM-DD'), '68/289 Sagar Street Visakhapatnam', '09789637361', 'VP', 'TGMT', 62, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21000069', 'Heer Iyer', 'N?', to_date('1924-10-19', 'YYYY-MM-DD'), '72/03 Dara Ganj Bareilly', '6618383371', 'VP', 'KHMT', 107, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21000070', 'Divyansh Kunda', 'N?', to_date('1925-12-22', 'YYYY-MM-DD'), '38/98 Kale Ghaziabad', '04790553037', 'CLC', 'CNPM', 5, 6.47);

INSERT INTO SINHVIEN
VALUES ('SV21000071', 'Ela Sanghvi', 'N?', to_date('1937-02-09', 'YYYY-MM-DD'), 'H.No. 237 Bath Chowk Mahbubnagar', '04654191759', 'CQ', 'CNTT', 128, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21000072', 'Manikya Vasa', 'N?', to_date('1926-10-10', 'YYYY-MM-DD'), '30 Dhaliwal Chowk Asansol', '5218551533', 'CTTT', 'CNPM', 25, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21000073', 'Elakshi Sarkar', 'N?', to_date('1965-12-08', 'YYYY-MM-DD'), '66/027 Dhawan Zila Bhatpara', '3975292964', 'CQ', 'KHMT', 25, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21000074', 'Farhan Brar', 'Nam', to_date('1927-03-18', 'YYYY-MM-DD'), '86 Tripathi Street Agra', '07915117380', 'VP', 'KHMT', 90, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21000075', 'Rhea Sanghvi', 'Nam', to_date('2017-09-06', 'YYYY-MM-DD'), '17/49 Sarna Road Kishanganj', '02319827303', 'CQ', 'CNPM', 27, 7.0);

INSERT INTO SINHVIEN
VALUES ('SV21000076', 'Renee Rama', 'Nam', to_date('2000-02-04', 'YYYY-MM-DD'), '299 Bandi Street Aligarh', '01497949601', 'CLC', 'TGMT', 94, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21000077', 'Alisha Balan', 'Nam', to_date('1955-06-26', 'YYYY-MM-DD'), 'H.No. 46 Zachariah Marg Lucknow', '03319238375', 'CQ', 'CNTT', 129, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21000078', 'Tarini Dass', 'Nam', to_date('1965-07-11', 'YYYY-MM-DD'), '88/25 Sagar Deoghar', '03417434415', 'VP', 'TGMT', 80, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21000079', 'Alisha Arya', 'N?', to_date('1960-10-29', 'YYYY-MM-DD'), '70/489 Kaur Marg Phagwara', '8320416437', 'CLC', 'MMT', 81, 5.88);

INSERT INTO SINHVIEN
VALUES ('SV21000080', 'Prerak Kurian', 'N?', to_date('1963-04-04', 'YYYY-MM-DD'), '974 Saran Street Kanpur', '+915410645935', 'CLC', 'HTTT', 4, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21000081', 'Vanya Bhatt', 'Nam', to_date('1995-06-27', 'YYYY-MM-DD'), 'H.No. 357 Chadha Chowk Raichur', '06659118721', 'VP', 'CNTT', 135, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21000082', 'Zaina Lala', 'N?', to_date('2003-08-18', 'YYYY-MM-DD'), '73 Ray Marg Jalandhar', '00492448185', 'CQ', 'CNPM', 27, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21000083', 'Hridaan Acharya', 'N?', to_date('1920-12-06', 'YYYY-MM-DD'), 'H.No. 57 Dara Ganj Dindigul', '9748276010', 'CLC', 'HTTT', 63, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21000084', 'Shalv Seshadri', 'Nam', to_date('1936-07-10', 'YYYY-MM-DD'), 'H.No. 81 Sood Circle Barasat', '+911894031272', 'CTTT', 'CNPM', 78, 6.52);

INSERT INTO SINHVIEN
VALUES ('SV21000085', 'Anahita Dayal', 'N?', to_date('2021-02-21', 'YYYY-MM-DD'), '27/908 Anand Marg Bhilai', '+914163463798', 'CTTT', 'MMT', 115, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21000086', 'Kabir Kala', 'N?', to_date('1995-04-30', 'YYYY-MM-DD'), 'H.No. 969 Dhar Ganj Sri Ganganagar', '5774542237', 'CTTT', 'CNPM', 119, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21000087', 'Nayantara Apte', 'Nam', to_date('1958-12-03', 'YYYY-MM-DD'), '94 Anne Ganj Kota', '08236958207', 'CTTT', 'HTTT', 0, 4.2);

INSERT INTO SINHVIEN
VALUES ('SV21000088', 'Anahita Sule', 'N?', to_date('1968-04-02', 'YYYY-MM-DD'), 'H.No. 03 Chaudry Jabalpur', '02188694316', 'VP', 'CNTT', 131, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21000089', 'Inaaya  Khare', 'N?', to_date('2005-11-23', 'YYYY-MM-DD'), '50/394 Kapur Marg Kottayam', '4101566634', 'CTTT', 'HTTT', 82, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21000090', 'Yakshit Malhotra', 'Nam', to_date('1908-05-04', 'YYYY-MM-DD'), '64/726 Hora Marg Dharmavaram', '9478546925', 'VP', 'CNPM', 68, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21000091', 'Aarna Kanda', 'N?', to_date('1968-04-02', 'YYYY-MM-DD'), 'H.No. 13 D��Alia Path Gandhinagar', '+919522711290', 'CLC', 'CNTT', 130, 6.6);

INSERT INTO SINHVIEN
VALUES ('SV21000092', 'Nehmat Chakraborty', 'Nam', to_date('1909-08-07', 'YYYY-MM-DD'), '86/624 Kannan Marg Bijapur', '0272117444', 'CTTT', 'KHMT', 68, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21000093', 'Arhaan Raj', 'Nam', to_date('2019-10-31', 'YYYY-MM-DD'), 'H.No. 57 Balan Zila Durg', '+917483616001', 'VP', 'KHMT', 117, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21000094', 'Aarush Din', 'N?', to_date('1950-04-14', 'YYYY-MM-DD'), 'H.No. 009 Brahmbhatt Nagar Hindupur', '+917192082111', 'CQ', 'CNTT', 43, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21000095', 'Krish Tara', 'N?', to_date('1921-11-16', 'YYYY-MM-DD'), '61 Khalsa Zila Amroha', '2812568218', 'VP', 'CNPM', 49, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21000096', 'Samiha Wable', 'N?', to_date('1983-07-09', 'YYYY-MM-DD'), '165 Edwin Circle Kishanganj', '9864391296', 'CQ', 'MMT', 125, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21000097', 'Sara Dhar', 'N?', to_date('1956-04-12', 'YYYY-MM-DD'), '50/00 Dave Street Bhagalpur', '2217724420', 'CLC', 'TGMT', 61, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21000098', 'Nirvi Gill', 'Nam', to_date('2018-12-06', 'YYYY-MM-DD'), '53/187 Raval Street Chandrapur', '03193561468', 'CQ', 'TGMT', 135, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21000099', 'Arhaan Ray', 'Nam', to_date('1953-06-09', 'YYYY-MM-DD'), '606 Deshmukh Circle Kozhikode', '00415604324', 'CQ', 'HTTT', 10, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21000100', 'Eshani Ravel', 'Nam', to_date('1923-09-08', 'YYYY-MM-DD'), '739 Rajagopalan Srinagar', '04040092526', 'CQ', 'CNPM', 11, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21000101', 'Keya Mahal', 'Nam', to_date('2019-08-23', 'YYYY-MM-DD'), '083 Vora Chowk Bongaigaon', '7995551065', 'VP', 'TGMT', 73, 5.35);

INSERT INTO SINHVIEN
VALUES ('SV21000102', 'Anvi Virk', 'N?', to_date('1939-04-16', 'YYYY-MM-DD'), '69/039 Jhaveri Chowk Katni', '+912667341290', 'CQ', 'HTTT', 100, 7.5);

INSERT INTO SINHVIEN
VALUES ('SV21000103', 'Siya Chanda', 'Nam', to_date('1921-09-09', 'YYYY-MM-DD'), '426 Lal Road Bidar', '08677149544', 'VP', 'CNTT', 39, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21000104', 'Uthkarsh Ramanathan', 'N?', to_date('1978-03-09', 'YYYY-MM-DD'), 'H.No. 788 Kakar Ganj Darbhanga', '6006814007', 'CQ', 'TGMT', 79, 7.31);

INSERT INTO SINHVIEN
VALUES ('SV21000105', 'Hazel Gill', 'N?', to_date('1983-01-04', 'YYYY-MM-DD'), '87 Sharaf Circle Fatehpur', '2909534613', 'CTTT', 'KHMT', 127, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21000106', 'Ivan Subramaniam', 'Nam', to_date('1990-10-10', 'YYYY-MM-DD'), '27 Vaidya Path Gandhidham', '2747583058', 'CTTT', 'MMT', 121, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21000107', 'Vihaan Talwar', 'Nam', to_date('1981-01-29', 'YYYY-MM-DD'), '91/428 Bora Street Rajkot', '03007719802', 'CTTT', 'CNPM', 12, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21000108', 'Jivika Bir', 'N?', to_date('1984-11-23', 'YYYY-MM-DD'), 'H.No. 14 Bhattacharyya Path Bhind', '00511914495', 'CTTT', 'MMT', 95, 6.13);

INSERT INTO SINHVIEN
VALUES ('SV21000109', 'Trisha Aggarwal', 'N?', to_date('1997-09-09', 'YYYY-MM-DD'), '66 Bath Ganj Erode', '07676263634', 'CQ', 'CNPM', 102, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21000110', 'Zoya Biswas', 'N?', to_date('1971-07-15', 'YYYY-MM-DD'), 'H.No. 54 Garg Chowk Sambalpur', '+917253721899', 'CLC', 'CNTT', 22, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21000111', 'Samiha Dutt', 'Nam', to_date('1931-12-17', 'YYYY-MM-DD'), 'H.No. 524 Saini Path Bhiwandi', '+916554503422', 'CTTT', 'CNPM', 75, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21000112', 'Anika Dara', 'Nam', to_date('1919-01-19', 'YYYY-MM-DD'), '84/106 Hayre Zila Madhyamgram', '02201216914', 'CLC', 'CNPM', 15, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21000113', 'Kashvi Mannan', 'Nam', to_date('1921-10-25', 'YYYY-MM-DD'), '462 Kara Circle Shimoga', '02642213857', 'CTTT', 'MMT', 61, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21000114', 'Shalv Kuruvilla', 'Nam', to_date('1966-01-01', 'YYYY-MM-DD'), 'H.No. 70 Ghosh Street Akola', '03312761531', 'VP', 'TGMT', 132, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21000115', 'Himmat Chaudhry', 'Nam', to_date('1940-06-27', 'YYYY-MM-DD'), '85/75 Ray Ongole', '4409924388', 'CQ', 'CNTT', 35, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21000116', 'Sahil Kannan', 'Nam', to_date('1931-12-07', 'YYYY-MM-DD'), 'H.No. 078 Mand Circle Pudukkottai', '8665953572', 'CTTT', 'HTTT', 51, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21000117', 'Seher Khosla', 'N?', to_date('2017-12-18', 'YYYY-MM-DD'), '018 Varkey Nagar Durgapur', '+910543103256', 'CTTT', 'CNPM', 56, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21000118', 'Aaina Cheema', 'Nam', to_date('1961-08-15', 'YYYY-MM-DD'), '09/390 Shan Chowk Hyderabad', '02319254475', 'VP', 'CNPM', 112, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21000119', 'Ayesha Gala', 'Nam', to_date('2018-05-08', 'YYYY-MM-DD'), 'H.No. 84 Sule Chowk Deoghar', '06564037466', 'VP', 'MMT', 27, 8.16);

INSERT INTO SINHVIEN
VALUES ('SV21000120', 'Jayesh Khare', 'N?', to_date('1934-02-27', 'YYYY-MM-DD'), '931 Krishnamurthy Road Guna', '+919271736210', 'VP', 'HTTT', 48, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000121', 'Rati Shan', 'N?', to_date('1920-06-25', 'YYYY-MM-DD'), '19/229 Roy Ganj Secunderabad', '01167259839', 'VP', 'CNTT', 13, 6.96);

INSERT INTO SINHVIEN
VALUES ('SV21000122', 'Tarini Raju', 'Nam', to_date('1985-11-03', 'YYYY-MM-DD'), '94 Boase Zila Gurgaon', '+913224452758', 'CQ', 'CNPM', 111, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21000123', 'Tanya Bath', 'Nam', to_date('1962-03-10', 'YYYY-MM-DD'), 'H.No. 035 Wagle Marg Kulti', '06915179743', 'CLC', 'CNPM', 125, 4.39);

INSERT INTO SINHVIEN
VALUES ('SV21000124', 'Riya Balan', 'N?', to_date('1955-03-10', 'YYYY-MM-DD'), 'H.No. 21 Devi Circle Berhampore', '+919228957164', 'CTTT', 'TGMT', 31, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21000125', 'Raunak Atwal', 'Nam', to_date('1963-04-20', 'YYYY-MM-DD'), 'H.No. 712 Gala Road Bihar Sharif', '2770952604', 'CLC', 'HTTT', 94, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21000126', 'Kashvi Swamy', 'N?', to_date('2018-09-18', 'YYYY-MM-DD'), '168 Virk Chowk Deoghar', '2652859211', 'CQ', 'KHMT', 70, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21000127', 'Faiyaz Chaudhuri', 'Nam', to_date('1973-05-10', 'YYYY-MM-DD'), '30/654 Rajagopal Path Nizamabad', '08047637089', 'VP', 'HTTT', 53, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21000128', 'Riya Sura', 'Nam', to_date('2018-09-15', 'YYYY-MM-DD'), 'H.No. 39 Din Path Ujjain', '+914315624492', 'CQ', 'CNPM', 32, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21000129', 'Aniruddh Sama', 'N?', to_date('2020-05-18', 'YYYY-MM-DD'), 'H.No. 266 Barad Zila Jehanabad', '+918135789122', 'VP', 'HTTT', 4, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21000130', 'Advika Soni', 'Nam', to_date('1943-08-30', 'YYYY-MM-DD'), '807 Anand Zila Nashik', '3273849912', 'CTTT', 'MMT', 7, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21000131', 'Inaaya  Swamy', 'N?', to_date('2015-11-10', 'YYYY-MM-DD'), 'H.No. 954 Sule Circle Kamarhati', '4096515451', 'CQ', 'CNPM', 79, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21000132', 'Jivika Borde', 'N?', to_date('1956-03-04', 'YYYY-MM-DD'), 'H.No. 096 Kalita Nagar Muzaffarpur', '09740297810', 'CLC', 'MMT', 13, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21000133', 'Yasmin Bath', 'Nam', to_date('1925-08-02', 'YYYY-MM-DD'), '69 Sha Street Muzaffarnagar', '8100664260', 'CTTT', 'KHMT', 133, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21000134', 'Mohanlal Kade', 'N?', to_date('1978-11-10', 'YYYY-MM-DD'), '859 Sandhu Ganj Patna', '07803572933', 'CLC', 'MMT', 45, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21000135', 'Krish Bhasin', 'Nam', to_date('1948-03-21', 'YYYY-MM-DD'), 'H.No. 54 Chana Street Gangtok', '6406197263', 'CTTT', 'HTTT', 121, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21000136', 'Tarini Hari', 'Nam', to_date('1925-10-09', 'YYYY-MM-DD'), '79/50 Lala Ambattur', '+918673918122', 'VP', 'CNTT', 47, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21000137', 'Aniruddh Dutta', 'Nam', to_date('1923-09-27', 'YYYY-MM-DD'), '989 Mahajan Street Erode', '00520837946', 'CTTT', 'TGMT', 7, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21000138', 'Suhana Dash', 'N?', to_date('1988-06-17', 'YYYY-MM-DD'), 'H.No. 35 Saran Zila Agartala', '05404154353', 'CQ', 'CNPM', 49, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21000139', 'Krish Chandra', 'N?', to_date('2001-06-27', 'YYYY-MM-DD'), '18 Salvi Road Gulbarga', '06080861438', 'CQ', 'CNPM', 103, 9.46);

INSERT INTO SINHVIEN
VALUES ('SV21000140', 'Sara Basak', 'N?', to_date('1922-06-26', 'YYYY-MM-DD'), '68/52 Sur Street Bhilai', '04274389317', 'VP', 'HTTT', 77, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21000141', 'Taimur Kala', 'N?', to_date('1944-10-20', 'YYYY-MM-DD'), 'H.No. 12 Taneja Chowk Etawah', '2176759472', 'CQ', 'MMT', 90, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21000142', 'Azad Jha', 'Nam', to_date('2002-02-26', 'YYYY-MM-DD'), 'H.No. 792 Singh Zila Gorakhpur', '03416948090', 'VP', 'CNPM', 100, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21000143', 'Seher Jhaveri', 'Nam', to_date('1979-07-15', 'YYYY-MM-DD'), 'H.No. 33 Sachdeva Street Moradabad', '+918924578362', 'CQ', 'TGMT', 53, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21000144', 'Shlok Chana', 'N?', to_date('2011-10-19', 'YYYY-MM-DD'), '05/218 Raman Path Shahjahanpur', '+918178974591', 'VP', 'TGMT', 120, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21000145', 'Arnav Ravel', 'N?', to_date('1963-03-27', 'YYYY-MM-DD'), 'H.No. 85 Raja Ganj Mau', '01720174547', 'CTTT', 'CNPM', 37, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21000146', 'Shlok Sha', 'Nam', to_date('1951-12-24', 'YYYY-MM-DD'), '35/556 Anand Ganj Singrauli', '9846908150', 'CLC', 'KHMT', 134, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21000147', 'Hridaan Batra', 'Nam', to_date('2021-12-03', 'YYYY-MM-DD'), '084 Shetty Ganj Mirzapur', '+919136540174', 'CTTT', 'CNPM', 80, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21000148', 'Lakshit Buch', 'Nam', to_date('2006-12-17', 'YYYY-MM-DD'), '02 Chacko Nagar Aurangabad', '0150337449', 'VP', 'CNPM', 4, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21000149', 'Sara Sagar', 'Nam', to_date('1981-04-02', 'YYYY-MM-DD'), 'H.No. 79 Thaker Circle Dhanbad', '+912331210981', 'CLC', 'CNPM', 78, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21000150', 'Amani Sachdev', 'N?', to_date('1969-06-26', 'YYYY-MM-DD'), '09 Rattan Circle Imphal', '8329484698', 'VP', 'TGMT', 14, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21000151', 'Amira Mangal', 'Nam', to_date('1985-05-26', 'YYYY-MM-DD'), '648 Shan Road Jamshedpur', '09484771945', 'VP', 'KHMT', 72, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21000152', 'Saanvi Kamdar', 'N?', to_date('1954-08-24', 'YYYY-MM-DD'), '01/591 Chaudhari Circle Aurangabad', '0004718073', 'CTTT', 'MMT', 10, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21000153', 'Drishya Dora', 'Nam', to_date('2014-12-29', 'YYYY-MM-DD'), 'H.No. 36 Kapoor Morena', '05099941512', 'VP', 'KHMT', 134, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21000154', 'Amani Deep', 'Nam', to_date('2019-01-05', 'YYYY-MM-DD'), 'H.No. 49 Savant Ganj South Dumdum', '7747112804', 'CTTT', 'MMT', 42, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21000155', 'Shamik Gole', 'Nam', to_date('1916-01-05', 'YYYY-MM-DD'), '52 Wagle Road Fatehpur', '+918845495150', 'CTTT', 'HTTT', 12, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21000156', 'Misha Chadha', 'Nam', to_date('1957-02-04', 'YYYY-MM-DD'), '44/70 Brar Chowk Latur', '03106769050', 'CLC', 'KHMT', 76, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21000157', 'Amira Dass', 'Nam', to_date('1937-02-17', 'YYYY-MM-DD'), '27/168 Deo Nagar Vasai-Virar', '+910046894157', 'VP', 'CNPM', 138, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21000158', 'Prerak Ganesh', 'Nam', to_date('1939-10-01', 'YYYY-MM-DD'), 'H.No. 837 Sathe Circle Surat', '6508318308', 'VP', 'MMT', 63, 8.56);

INSERT INTO SINHVIEN
VALUES ('SV21000159', 'Indrajit Sur', 'Nam', to_date('2005-08-11', 'YYYY-MM-DD'), '978 Kalita Chowk Bokaro', '04205454360', 'VP', 'TGMT', 12, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21000160', 'Tiya Sangha', 'N?', to_date('1921-11-23', 'YYYY-MM-DD'), '959 Andra Street Kalyan-Dombivli', '2921228266', 'CQ', 'HTTT', 98, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000161', 'Tushar Dhawan', 'N?', to_date('1955-02-09', 'YYYY-MM-DD'), '03/90 Soman Path Arrah', '01955163594', 'CTTT', 'KHMT', 13, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21000162', 'Lakshit Toor', 'Nam', to_date('1979-08-14', 'YYYY-MM-DD'), '928 Dutta Zila Amaravati', '8919254747', 'VP', 'HTTT', 48, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21000163', 'Vivaan Kadakia', 'Nam', to_date('1957-04-19', 'YYYY-MM-DD'), 'H.No. 524 Ganguly Street Sultan Pur Majra', '+915545263329', 'VP', 'HTTT', 126, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21000164', 'Kimaya Kala', 'N?', to_date('1997-12-04', 'YYYY-MM-DD'), '30/52 Kannan Nagar Alappuzha', '1064936093', 'VP', 'TGMT', 134, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21000165', 'Mannat Kibe', 'Nam', to_date('2022-09-25', 'YYYY-MM-DD'), '96 Jain Marg Ghaziabad', '02251897296', 'CQ', 'MMT', 98, 4.46);

INSERT INTO SINHVIEN
VALUES ('SV21000166', 'Saanvi Bhatnagar', 'N?', to_date('1943-01-09', 'YYYY-MM-DD'), 'H.No. 757 Kumar Path Muzaffarnagar', '09072435049', 'CQ', 'HTTT', 130, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21000167', 'Sana Comar', 'N?', to_date('1909-02-28', 'YYYY-MM-DD'), '962 Sen Road Gangtok', '3269757920', 'CTTT', 'CNTT', 134, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21000168', 'Nirvi Thaker', 'Nam', to_date('1965-11-21', 'YYYY-MM-DD'), 'H.No. 42 Krish Road Bhilwara', '09373277063', 'CQ', 'MMT', 41, 9.06);

INSERT INTO SINHVIEN
VALUES ('SV21000169', 'Prisha Venkatesh', 'N?', to_date('1966-02-20', 'YYYY-MM-DD'), 'H.No. 442 Shroff Street Bhagalpur', '02253992012', 'CQ', 'KHMT', 42, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21000170', 'Kashvi Dhar', 'N?', to_date('1946-11-04', 'YYYY-MM-DD'), '049 Bhagat Path Haridwar', '05988418800', 'VP', 'TGMT', 63, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21000171', 'Samiha Kala', 'N?', to_date('1990-12-02', 'YYYY-MM-DD'), '59 Bhasin Ganj Khandwa', '01948520026', 'CTTT', 'MMT', 124, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21000172', 'Zoya Atwal', 'N?', to_date('1958-12-16', 'YYYY-MM-DD'), 'H.No. 89 Iyengar Panvel', '1198335862', 'VP', 'HTTT', 47, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21000173', 'Dharmajan Babu', 'N?', to_date('1994-11-28', 'YYYY-MM-DD'), 'H.No. 36 Saran Bhiwandi', '03511243236', 'CQ', 'MMT', 43, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21000174', 'Kiaan Varughese', 'N?', to_date('1935-12-02', 'YYYY-MM-DD'), 'H.No. 846 Kumar Ganj Kota', '5548379390', 'VP', 'CNTT', 107, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21000175', 'Prerak Kalita', 'Nam', to_date('1995-06-18', 'YYYY-MM-DD'), 'H.No. 015 Bhandari Path Ichalkaranji', '+913491167253', 'VP', 'CNPM', 67, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21000176', 'Miraan Biswas', 'N?', to_date('1913-08-22', 'YYYY-MM-DD'), '90/778 Dalal Circle Khandwa', '+913915241773', 'CLC', 'TGMT', 45, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21000177', 'Prerak Srivastava', 'Nam', to_date('1973-06-10', 'YYYY-MM-DD'), '729 Thaman Ganj Jehanabad', '05646229871', 'VP', 'KHMT', 68, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21000178', 'Mahika Zacharia', 'N?', to_date('1955-03-30', 'YYYY-MM-DD'), '94/047 Hora Ganj Kamarhati', '09505060980', 'CTTT', 'TGMT', 123, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21000179', 'Baiju Jani', 'N?', to_date('1993-01-26', 'YYYY-MM-DD'), 'H.No. 75 Yohannan Nagar Miryalaguda', '01640500519', 'CTTT', 'MMT', 49, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21000180', 'Mohanlal Lall', 'N?', to_date('1994-01-18', 'YYYY-MM-DD'), 'H.No. 980 Rajagopalan Ganj Amaravati', '04112128337', 'CQ', 'TGMT', 133, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21000181', 'Yakshit Chaudry', 'N?', to_date('1915-03-16', 'YYYY-MM-DD'), '87/13 Hegde Street Berhampore', '+913312676493', 'CLC', 'HTTT', 56, 6.85);

INSERT INTO SINHVIEN
VALUES ('SV21000182', 'Ishita Sarkar', 'Nam', to_date('1998-08-24', 'YYYY-MM-DD'), '27 Tailor Kolhapur', '+914697796583', 'CTTT', 'KHMT', 72, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21000183', 'Rohan Vasa', 'Nam', to_date('1981-01-07', 'YYYY-MM-DD'), '35/43 Kalla Circle Darbhanga', '06553144313', 'CQ', 'MMT', 37, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21000184', 'Hazel Bumb', 'N?', to_date('1951-03-22', 'YYYY-MM-DD'), '673 Lal Road Bharatpur', '01977121844', 'VP', 'HTTT', 22, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21000185', 'Vidur Hegde', 'Nam', to_date('1935-04-27', 'YYYY-MM-DD'), 'H.No. 920 Kala Marg Thoothukudi', '06047990102', 'CTTT', 'KHMT', 7, 8.94);

INSERT INTO SINHVIEN
VALUES ('SV21000186', 'Ivan Yogi', 'Nam', to_date('2006-12-06', 'YYYY-MM-DD'), 'H.No. 62 Dhingra Circle Morbi', '+911429332007', 'CLC', 'TGMT', 112, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21000187', 'Romil Seth', 'Nam', to_date('1979-11-08', 'YYYY-MM-DD'), 'H.No. 679 Bahl Street Rourkela', '0865150783', 'CTTT', 'TGMT', 79, 4.77);

INSERT INTO SINHVIEN
VALUES ('SV21000188', 'Uthkarsh Balan', 'N?', to_date('1967-03-03', 'YYYY-MM-DD'), '72 Raval Ganj Bhubaneswar', '8183865439', 'CQ', 'HTTT', 118, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21000189', 'Samar Sandal', 'Nam', to_date('1946-03-25', 'YYYY-MM-DD'), 'H.No. 992 Karpe Zila Lucknow', '05462082263', 'CTTT', 'MMT', 53, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21000190', 'Lavanya Lata', 'N?', to_date('1987-01-06', 'YYYY-MM-DD'), 'H.No. 030 Sodhi Uluberia', '07944855217', 'CTTT', 'MMT', 38, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21000191', 'Sana Bava', 'N?', to_date('1929-02-23', 'YYYY-MM-DD'), '563 Dass Circle Nagercoil', '5480816196', 'CQ', 'MMT', 49, 6.58);

INSERT INTO SINHVIEN
VALUES ('SV21000192', 'Vritika Bansal', 'Nam', to_date('2009-12-10', 'YYYY-MM-DD'), 'H.No. 726 Jayaraman Street Kishanganj', '+915644219785', 'CLC', 'CNPM', 70, 4.48);

INSERT INTO SINHVIEN
VALUES ('SV21000193', 'Jhanvi Salvi', 'Nam', to_date('2016-07-29', 'YYYY-MM-DD'), '03/786 Malhotra Street Panvel', '+913483408546', 'CQ', 'CNTT', 57, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21000194', 'Armaan Char', 'N?', to_date('1993-04-05', 'YYYY-MM-DD'), 'H.No. 37 Agarwal Road Kalyan-Dombivli', '06802156346', 'CQ', 'CNPM', 47, 4.4);

INSERT INTO SINHVIEN
VALUES ('SV21000195', 'Jivika Brahmbhatt', 'N?', to_date('2006-10-08', 'YYYY-MM-DD'), 'H.No. 530 Vohra Marg Gandhinagar', '05383999073', 'VP', 'CNTT', 39, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21000196', 'Ranbir Buch', 'Nam', to_date('1933-04-26', 'YYYY-MM-DD'), '30 D��Alia Zila Tenali', '06029440934', 'CQ', 'MMT', 79, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21000197', 'Vaibhav Bhalla', 'Nam', to_date('1991-09-17', 'YYYY-MM-DD'), '51/753 Mannan Varanasi', '+915734410196', 'CQ', 'CNTT', 102, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21000198', 'Bhamini Chaudry', 'Nam', to_date('1974-10-07', 'YYYY-MM-DD'), '68/72 Agate Street Loni', '01652199579', 'VP', 'TGMT', 126, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21000199', 'Riya Konda', 'N?', to_date('2000-06-17', 'YYYY-MM-DD'), '02 Dhingra Road Siwan', '06907174785', 'CLC', 'CNPM', 37, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21000200', 'Miraya Banerjee', 'Nam', to_date('1996-12-26', 'YYYY-MM-DD'), 'H.No. 36 Goda Chowk Mango', '2751493928', 'CQ', 'CNTT', 49, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21000201', 'Neysa Baria', 'N?', to_date('1932-05-15', 'YYYY-MM-DD'), '08/987 Khurana Circle Alwar', '+910654600036', 'VP', 'TGMT', 23, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21000202', 'Azad Guha', 'Nam', to_date('1972-03-10', 'YYYY-MM-DD'), '31/40 Khalsa Street Medininagar', '+911042723338', 'CLC', 'CNPM', 69, 4.08);

INSERT INTO SINHVIEN
VALUES ('SV21000203', 'Biju Suresh', 'Nam', to_date('1969-05-15', 'YYYY-MM-DD'), '52 Balasubramanian Zila Kavali', '+910364074182', 'CLC', 'TGMT', 10, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21000204', 'Tushar Seshadri', 'N?', to_date('1951-08-02', 'YYYY-MM-DD'), '83/899 Mand Ganj Kottayam', '08322511466', 'VP', 'TGMT', 39, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21000205', 'Eva Bose', 'N?', to_date('1923-05-05', 'YYYY-MM-DD'), 'H.No. 61 Tandon Street Dhanbad', '08094953000', 'CTTT', 'TGMT', 82, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21000206', 'Mehul Sundaram', 'N?', to_date('2020-11-06', 'YYYY-MM-DD'), 'H.No. 11 Dave Road Kirari Suleman Nagar', '+911634499128', 'CQ', 'TGMT', 91, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21000207', 'Tushar Golla', 'N?', to_date('2015-07-20', 'YYYY-MM-DD'), 'H.No. 50 Jayaraman Zila Jalna', '04027533165', 'CTTT', 'CNTT', 137, 8.34);

INSERT INTO SINHVIEN
VALUES ('SV21000208', 'Ishaan Chakrabarti', 'N?', to_date('1994-12-29', 'YYYY-MM-DD'), '38/14 Sidhu Circle Nadiad', '+915379937817', 'CLC', 'CNTT', 132, 5.0);

INSERT INTO SINHVIEN
VALUES ('SV21000209', 'Stuvan Vig', 'N?', to_date('1990-12-22', 'YYYY-MM-DD'), 'H.No. 59 Yogi Nagpur', '01566532566', 'CQ', 'MMT', 15, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21000210', 'Rhea Tank', 'Nam', to_date('2002-09-30', 'YYYY-MM-DD'), '33/163 Char Street Nashik', '06119890522', 'VP', 'HTTT', 61, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21000211', 'Anahi Johal', 'Nam', to_date('1954-06-22', 'YYYY-MM-DD'), 'H.No. 45 Shankar Marg Tirunelveli', '02726855102', 'CTTT', 'KHMT', 42, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21000212', 'Shaan Salvi', 'N?', to_date('1935-12-12', 'YYYY-MM-DD'), 'H.No. 459 Batta Nagar Bahraich', '8930771313', 'CTTT', 'TGMT', 28, 9.17);

INSERT INTO SINHVIEN
VALUES ('SV21000213', 'Neelofar Sunder', 'Nam', to_date('1989-09-07', 'YYYY-MM-DD'), '550 Saran Road Parbhani', '0590526168', 'CTTT', 'CNTT', 64, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21000214', 'Nirvi Kari', 'N?', to_date('1973-01-02', 'YYYY-MM-DD'), '50/50 Kaul Zila Shivpuri', '0380161627', 'CLC', 'HTTT', 78, 4.77);

INSERT INTO SINHVIEN
VALUES ('SV21000215', 'Kaira Hans', 'N?', to_date('1909-01-04', 'YYYY-MM-DD'), '09/32 Chakrabarti Surendranagar Dudhrej', '+917308087764', 'CQ', 'CNPM', 138, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21000216', 'Shayak Rana', 'N?', to_date('1991-03-29', 'YYYY-MM-DD'), '12/90 Kibe Chowk Nangloi Jat', '06300567399', 'CQ', 'MMT', 69, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21000217', 'Hazel Ratti', 'N?', to_date('1935-06-06', 'YYYY-MM-DD'), '53/24 Loyal Circle South Dumdum', '09146319562', 'CQ', 'TGMT', 50, 9.93);

INSERT INTO SINHVIEN
VALUES ('SV21000218', 'Zara Loyal', 'Nam', to_date('1974-12-01', 'YYYY-MM-DD'), 'H.No. 465 Yadav Path Silchar', '06403753150', 'VP', 'CNTT', 121, 4.85);

INSERT INTO SINHVIEN
VALUES ('SV21000219', 'Aaina Chaudry', 'Nam', to_date('1988-01-27', 'YYYY-MM-DD'), '36 Bhardwaj Path Pune', '+914134132396', 'CLC', 'MMT', 91, 5.55);

INSERT INTO SINHVIEN
VALUES ('SV21000220', 'Ritvik Yogi', 'Nam', to_date('2019-03-14', 'YYYY-MM-DD'), '387 Sheth Nagar Mira-Bhayandar', '09104743882', 'CTTT', 'HTTT', 7, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21000221', 'Ryan Bir', 'N?', to_date('1933-06-04', 'YYYY-MM-DD'), 'H.No. 64 Kar Path Ongole', '02973466705', 'CLC', 'TGMT', 39, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21000222', 'Shlok Rattan', 'Nam', to_date('1914-12-01', 'YYYY-MM-DD'), 'H.No. 75 Zacharia Chowk Jabalpur', '+918449657157', 'CLC', 'MMT', 64, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21000223', 'Inaaya  Babu', 'Nam', to_date('1962-06-17', 'YYYY-MM-DD'), '50/50 Keer Dibrugarh', '6304883983', 'CLC', 'CNPM', 22, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21000224', 'Dishani Jain', 'N?', to_date('1924-04-23', 'YYYY-MM-DD'), '04/55 Kara Nagar Jalgaon', '9099964749', 'CTTT', 'HTTT', 65, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21000225', 'Ritvik Bumb', 'Nam', to_date('1941-10-22', 'YYYY-MM-DD'), '733 Taneja Road Hapur', '+919521633993', 'CQ', 'MMT', 81, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000226', 'Ishaan Kibe', 'N?', to_date('2002-02-03', 'YYYY-MM-DD'), 'H.No. 91 Sinha Zila Aizawl', '+910051744764', 'VP', 'HTTT', 59, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21000227', 'Parinaaz Mammen', 'N?', to_date('1958-10-30', 'YYYY-MM-DD'), '91/56 Bhargava Path Deoghar', '+919799685482', 'VP', 'CNPM', 136, 6.33);

INSERT INTO SINHVIEN
VALUES ('SV21000228', 'Zoya Barad', 'N?', to_date('1929-02-15', 'YYYY-MM-DD'), 'H.No. 403 Gokhale Circle Pali', '5189703860', 'VP', 'TGMT', 2, 5.88);

INSERT INTO SINHVIEN
VALUES ('SV21000229', 'Nitya Kala', 'Nam', to_date('1988-06-08', 'YYYY-MM-DD'), '83/11 Johal Path Katihar', '03772994887', 'CLC', 'MMT', 90, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21000230', 'Divyansh Tiwari', 'N?', to_date('2006-08-21', 'YYYY-MM-DD'), 'H.No. 557 Lata Street Panipat', '+911727482291', 'CLC', 'CNTT', 18, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21000231', 'Damini Sankar', 'Nam', to_date('2004-11-20', 'YYYY-MM-DD'), '701 Goda Circle Thanjavur', '05316799819', 'CQ', 'TGMT', 12, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21000232', 'Romil Aurora', 'N?', to_date('1954-09-07', 'YYYY-MM-DD'), '71/84 Rana Zila Serampore', '+919242573658', 'VP', 'HTTT', 120, 8.58);

INSERT INTO SINHVIEN
VALUES ('SV21000233', 'Umang Gara', 'Nam', to_date('1985-06-18', 'YYYY-MM-DD'), '37 Mandal Marg Ramgarh', '06673270307', 'CQ', 'CNTT', 42, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21000234', 'Indranil Ben', 'N?', to_date('1930-06-29', 'YYYY-MM-DD'), '31/16 Lalla Ganj Jaipur', '+916216583701', 'CTTT', 'TGMT', 31, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21000235', 'Kiaan Lala', 'N?', to_date('1922-07-30', 'YYYY-MM-DD'), 'H.No. 819 Agrawal Zila Bokaro', '07982449993', 'CTTT', 'TGMT', 61, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21000236', 'Ranbir Singh', 'N?', to_date('1926-01-18', 'YYYY-MM-DD'), '72/533 Sharma Street Udupi', '07609290410', 'VP', 'HTTT', 66, 8.54);

INSERT INTO SINHVIEN
VALUES ('SV21000237', 'Arhaan Borde', 'N?', to_date('1937-01-04', 'YYYY-MM-DD'), 'H.No. 13 Mani Nagar Hospet', '06734157659', 'CLC', 'HTTT', 75, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21000238', 'Nirvi Babu', 'N?', to_date('2023-09-10', 'YYYY-MM-DD'), 'H.No. 997 Chaudhari Chowk Sultan Pur Majra', '0430358406', 'CTTT', 'HTTT', 16, 9.65);

INSERT INTO SINHVIEN
VALUES ('SV21000239', 'Rania Chawla', 'N?', to_date('1941-05-29', 'YYYY-MM-DD'), '509 Bakshi Zila Hubli�CDharwad', '+915918643277', 'CLC', 'CNTT', 104, 5.16);

INSERT INTO SINHVIEN
VALUES ('SV21000240', 'Madhup Vora', 'N?', to_date('1988-04-08', 'YYYY-MM-DD'), 'H.No. 882 Swamy Zila Mau', '2146432133', 'CLC', 'HTTT', 134, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21000241', 'Ojas Srinivas', 'Nam', to_date('1914-10-27', 'YYYY-MM-DD'), 'H.No. 287 Sastry Road Guntur', '+911398332737', 'CTTT', 'MMT', 42, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21000242', 'Ehsaan Venkatesh', 'N?', to_date('1957-08-02', 'YYYY-MM-DD'), '82 Jayaraman Nagar Aurangabad', '2926588335', 'VP', 'TGMT', 133, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21000243', 'Miraya Krish', 'N?', to_date('2018-11-29', 'YYYY-MM-DD'), '06/970 Dyal Circle Panihati', '02057189649', 'CQ', 'HTTT', 88, 6.81);

INSERT INTO SINHVIEN
VALUES ('SV21000244', 'Mamooty Salvi', 'N?', to_date('1910-07-13', 'YYYY-MM-DD'), '13 Dhillon Chowk Gudivada', '04095410907', 'VP', 'HTTT', 116, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21000245', 'Indrajit Basak', 'N?', to_date('1915-09-12', 'YYYY-MM-DD'), 'H.No. 41 Tara Zila Jodhpur', '+919905599708', 'VP', 'TGMT', 55, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21000246', 'Samiha Toor', 'N?', to_date('1963-04-04', 'YYYY-MM-DD'), 'H.No. 90 Gokhale Ganj Etawah', '02636004983', 'CQ', 'CNTT', 4, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21000247', 'Indrajit Raju', 'Nam', to_date('1909-11-18', 'YYYY-MM-DD'), '64/300 Chakraborty Bidhannagar', '2395468187', 'CQ', 'HTTT', 48, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21000248', 'Priyansh Deo', 'Nam', to_date('1912-10-26', 'YYYY-MM-DD'), 'H.No. 94 Datta Muzaffarpur', '4584467116', 'VP', 'CNTT', 30, 7.32);

INSERT INTO SINHVIEN
VALUES ('SV21000249', 'Nehmat Chahal', 'Nam', to_date('2001-06-07', 'YYYY-MM-DD'), '34/587 Sarna Chowk Tadipatri', '03875139749', 'CQ', 'CNTT', 92, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21000250', 'Akarsh Babu', 'Nam', to_date('1917-12-15', 'YYYY-MM-DD'), '38/658 Bath Zila Karawal Nagar', '07704887597', 'CTTT', 'TGMT', 36, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21000251', 'Nitya Madan', 'Nam', to_date('1939-01-29', 'YYYY-MM-DD'), '07/933 Comar Visakhapatnam', '01656529672', 'CTTT', 'HTTT', 127, 8.54);

INSERT INTO SINHVIEN
VALUES ('SV21000252', 'Indranil D��Alia', 'Nam', to_date('1913-06-04', 'YYYY-MM-DD'), 'H.No. 77 Sani Zila Ozhukarai', '09240384431', 'CQ', 'HTTT', 30, 8.94);

INSERT INTO SINHVIEN
VALUES ('SV21000253', 'Farhan Lata', 'Nam', to_date('1974-07-16', 'YYYY-MM-DD'), '52/481 Chaudry Nagar Korba', '08255343806', 'CLC', 'MMT', 98, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21000254', 'Riaan Hari', 'Nam', to_date('1944-11-30', 'YYYY-MM-DD'), 'H.No. 009 Comar Street Karaikudi', '+918299422970', 'VP', 'CNTT', 122, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21000255', 'Kimaya Wali', 'Nam', to_date('1950-08-11', 'YYYY-MM-DD'), '35/13 Bose Ganj Bhatpara', '08747435327', 'CLC', 'TGMT', 18, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21000256', 'Vedika Wali', 'Nam', to_date('1930-06-26', 'YYYY-MM-DD'), '36/64 Ghosh Ganj Aizawl', '02667639049', 'CQ', 'MMT', 61, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21000257', 'Nirvi Khosla', 'N?', to_date('1986-09-22', 'YYYY-MM-DD'), 'H.No. 699 Atwal Street Kanpur', '4210450461', 'CTTT', 'CNTT', 32, 7.13);

INSERT INTO SINHVIEN
VALUES ('SV21000258', 'Yuvraj  Shan', 'Nam', to_date('1953-04-06', 'YYYY-MM-DD'), '329 Tata Chowk Yamunanagar', '07829147912', 'VP', 'HTTT', 135, 4.21);

INSERT INTO SINHVIEN
VALUES ('SV21000259', 'Hazel Dash', 'N?', to_date('1997-02-18', 'YYYY-MM-DD'), '56/95 Vora Zila Mirzapur', '00122442325', 'CTTT', 'HTTT', 63, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21000260', 'Pihu Krishna', 'N?', to_date('1938-06-05', 'YYYY-MM-DD'), '908 Magar Ganj Unnao', '02677378643', 'VP', 'MMT', 108, 5.25);

INSERT INTO SINHVIEN
VALUES ('SV21000261', 'Ela Seth', 'N?', to_date('1971-03-24', 'YYYY-MM-DD'), '94 Bassi Path Jalandhar', '+913782072872', 'CLC', 'TGMT', 71, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21000262', 'Miraan Chander', 'N?', to_date('1935-01-23', 'YYYY-MM-DD'), '05/57 Subramaniam Road Ozhukarai', '5514617959', 'VP', 'CNTT', 36, 7.66);

INSERT INTO SINHVIEN
VALUES ('SV21000263', 'Vedika Kale', 'Nam', to_date('1921-01-25', 'YYYY-MM-DD'), '10/289 Suri Path New Delhi', '+911814664570', 'CQ', 'KHMT', 97, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21000264', 'Purab Sarma', 'N?', to_date('1953-03-10', 'YYYY-MM-DD'), '50 Barad Zila Thane', '09204949385', 'VP', 'HTTT', 15, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21000265', 'Lagan Biswas', 'N?', to_date('1992-02-28', 'YYYY-MM-DD'), '62 Deo Zila Gandhinagar', '05465306251', 'CQ', 'HTTT', 24, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21000266', 'Mehul Lalla', 'Nam', to_date('1925-10-08', 'YYYY-MM-DD'), '49 Kapadia Nagar Gandhidham', '2861993768', 'VP', 'CNPM', 109, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21000267', 'Ivana Choudhury', 'Nam', to_date('1914-03-31', 'YYYY-MM-DD'), 'H.No. 496 Choudhary Street Berhampur', '9698220319', 'CQ', 'HTTT', 44, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21000268', 'Nakul Master', 'Nam', to_date('1923-12-06', 'YYYY-MM-DD'), 'H.No. 033 Chopra Street Naihati', '08615915618', 'CTTT', 'CNTT', 96, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21000269', 'Baiju Barad', 'Nam', to_date('1914-11-13', 'YYYY-MM-DD'), 'H.No. 40 Bhagat Street Dindigul', '04276331162', 'VP', 'MMT', 26, 5.32);

INSERT INTO SINHVIEN
VALUES ('SV21000270', 'Kiara Kuruvilla', 'N?', to_date('1970-01-04', 'YYYY-MM-DD'), '82/01 Khosla Nagar Jamnagar', '+915901884245', 'CQ', 'TGMT', 28, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21000271', 'Fateh Shan', 'N?', to_date('1961-08-30', 'YYYY-MM-DD'), '04/846 Dutt Shimla', '4007210343', 'CLC', 'MMT', 17, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21000272', 'Mishti Lad', 'N?', to_date('1938-08-17', 'YYYY-MM-DD'), '38/464 Warrior Chowk Morena', '9633035243', 'CQ', 'MMT', 4, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21000273', 'Ivana Kalla', 'N?', to_date('1963-11-16', 'YYYY-MM-DD'), '53/24 Bhattacharyya Zila Allahabad', '00218110126', 'VP', 'TGMT', 41, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21000274', 'Aniruddh Kannan', 'N?', to_date('1922-03-12', 'YYYY-MM-DD'), '998 Ahuja Circle Muzaffarpur', '+910974499289', 'CLC', 'TGMT', 54, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21000275', 'Saksham Ben', 'Nam', to_date('1930-12-19', 'YYYY-MM-DD'), 'H.No. 827 Ahluwalia Street Madanapalle', '+914314477349', 'CTTT', 'KHMT', 71, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21000276', 'Amani Dora', 'N?', to_date('1968-09-12', 'YYYY-MM-DD'), '986 Kadakia Zila Katni', '+911593081065', 'CTTT', 'TGMT', 109, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21000277', 'Saanvi Chaudry', 'N?', to_date('1953-02-01', 'YYYY-MM-DD'), '10 Kalita Chowk Farrukhabad', '06946922012', 'CQ', 'MMT', 114, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21000278', 'Samar Vig', 'N?', to_date('1990-12-16', 'YYYY-MM-DD'), 'H.No. 87 Suresh Marg Panihati', '00586799694', 'CQ', 'MMT', 109, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21000279', 'Myra Chadha', 'Nam', to_date('1947-04-04', 'YYYY-MM-DD'), '898 Dave Marg Kolhapur', '9146469073', 'CQ', 'HTTT', 127, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21000280', 'Vritika Chaudhuri', 'Nam', to_date('1910-01-21', 'YYYY-MM-DD'), '84/16 Setty Path Eluru', '09635001986', 'CTTT', 'CNTT', 23, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21000281', 'Zeeshan Ganguly', 'N?', to_date('1993-09-06', 'YYYY-MM-DD'), '555 Borah Path Satara', '01454426963', 'VP', 'HTTT', 130, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21000282', 'Manikya Yohannan', 'N?', to_date('1944-11-15', 'YYYY-MM-DD'), '24 Devi Street Nashik', '+913551704273', 'CLC', 'TGMT', 62, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21000283', 'Shamik Bath', 'Nam', to_date('1922-09-24', 'YYYY-MM-DD'), 'H.No. 77 Kade Road Bharatpur', '8211264189', 'CQ', 'HTTT', 67, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21000284', 'Elakshi Chacko', 'Nam', to_date('2004-01-29', 'YYYY-MM-DD'), '63 Devan Path Gopalpur', '02431466571', 'CTTT', 'KHMT', 120, 4.32);

INSERT INTO SINHVIEN
VALUES ('SV21000285', 'Jhanvi Dara', 'Nam', to_date('1930-09-29', 'YYYY-MM-DD'), '39 Shukla Path Shimoga', '+912057494520', 'CLC', 'KHMT', 35, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21000286', 'Ishaan Arya', 'Nam', to_date('1968-03-04', 'YYYY-MM-DD'), '16 Sinha Chowk Gwalior', '+917634297715', 'VP', 'CNTT', 57, 9.61);

INSERT INTO SINHVIEN
VALUES ('SV21000287', 'Hrishita Dubey', 'N?', to_date('1975-10-23', 'YYYY-MM-DD'), '75 Dubey Gwalior', '+911136719708', 'CTTT', 'CNTT', 82, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21000288', 'Hridaan Sinha', 'N?', to_date('2016-07-11', 'YYYY-MM-DD'), '68/525 Dara Street Ongole', '02152712501', 'VP', 'KHMT', 34, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21000289', 'Sahil Tak', 'N?', to_date('1945-08-06', 'YYYY-MM-DD'), '936 Sawhney Chowk Proddatur', '+914691458864', 'VP', 'MMT', 12, 6.12);

INSERT INTO SINHVIEN
VALUES ('SV21000290', 'Dhanush Kapur', 'Nam', to_date('2003-02-09', 'YYYY-MM-DD'), '470 Swamy Ganj Surat', '+910562401147', 'CQ', 'KHMT', 72, 5.6);

INSERT INTO SINHVIEN
VALUES ('SV21000291', 'Sara Boase', 'Nam', to_date('1966-07-27', 'YYYY-MM-DD'), 'H.No. 54 Kade Marg Adoni', '4976327421', 'CQ', 'KHMT', 103, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21000292', 'Hansh Dass', 'Nam', to_date('2014-07-30', 'YYYY-MM-DD'), 'H.No. 41 Bhalla Path Kolkata', '+911958049761', 'CLC', 'CNTT', 103, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21000293', 'Onkar Sani', 'N?', to_date('2004-03-30', 'YYYY-MM-DD'), '395 Thaker Street Agra', '+910310714385', 'CLC', 'KHMT', 55, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21000294', 'Indranil Verma', 'N?', to_date('2013-06-10', 'YYYY-MM-DD'), '889 Karan Street Yamunanagar', '+910899697269', 'VP', 'CNTT', 72, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21000295', 'Jayant Mani', 'N?', to_date('2020-01-04', 'YYYY-MM-DD'), '592 Jha Karimnagar', '9664366968', 'CLC', 'KHMT', 112, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21000296', 'Samaira Karpe', 'N?', to_date('1919-12-05', 'YYYY-MM-DD'), 'H.No. 978 Gaba Nagar Naihati', '07949810142', 'VP', 'CNPM', 26, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21000297', 'Shanaya Dara', 'Nam', to_date('1998-11-24', 'YYYY-MM-DD'), 'H.No. 193 Doshi Nagar Junagadh', '01890023162', 'CTTT', 'CNPM', 30, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21000298', 'Dhanuk Chauhan', 'N?', to_date('2015-05-24', 'YYYY-MM-DD'), '791 Choudhury Circle Danapur', '02795321478', 'CQ', 'CNPM', 10, 6.17);

INSERT INTO SINHVIEN
VALUES ('SV21000299', 'Yuvaan Chopra', 'N?', to_date('1967-01-07', 'YYYY-MM-DD'), '92 Bahri Marg Karaikudi', '+918389502181', 'CTTT', 'CNPM', 11, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21000300', 'Rati Sarraf', 'N?', to_date('1930-08-27', 'YYYY-MM-DD'), '53 Jayaraman Zila Davanagere', '2379645244', 'CTTT', 'TGMT', 98, 6.38);

INSERT INTO SINHVIEN
VALUES ('SV21000301', 'Umang Dar', 'N?', to_date('1941-05-20', 'YYYY-MM-DD'), '36/264 Chad Ganj Kalyan-Dombivli', '05904372028', 'CLC', 'KHMT', 122, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21000302', 'Tushar Karpe', 'Nam', to_date('1965-12-02', 'YYYY-MM-DD'), '822 Lala Chowk Tadepalligudem', '+910906203963', 'CLC', 'CNPM', 117, 9.17);

INSERT INTO SINHVIEN
VALUES ('SV21000303', 'Aarav Sood', 'Nam', to_date('1963-02-18', 'YYYY-MM-DD'), '81/47 Thaker Nagar Satna', '00722957501', 'CLC', 'CNPM', 6, 6.19);

INSERT INTO SINHVIEN
VALUES ('SV21000304', 'Khushi Sami', 'Nam', to_date('2008-08-26', 'YYYY-MM-DD'), '01/643 Ganguly Zila Noida', '07868336177', 'CLC', 'KHMT', 106, 4.17);

INSERT INTO SINHVIEN
VALUES ('SV21000305', 'Advika Chaudhari', 'N?', to_date('1908-06-27', 'YYYY-MM-DD'), '349 Chacko Circle Mysore', '09662001179', 'CTTT', 'CNPM', 44, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21000306', 'Devansh Chaudry', 'N?', to_date('1961-08-29', 'YYYY-MM-DD'), 'H.No. 40 Ravel Orai', '7885154040', 'CQ', 'HTTT', 125, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21000307', 'Yuvaan Ghosh', 'N?', to_date('1908-12-28', 'YYYY-MM-DD'), '95 Das Street Udaipur', '9924772342', 'CLC', 'CNPM', 98, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21000308', 'Nitara Choudhry', 'Nam', to_date('1927-04-01', 'YYYY-MM-DD'), 'H.No. 477 Sachar Path Bangalore', '+913530042907', 'CLC', 'CNPM', 135, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21000309', 'Taimur Walia', 'N?', to_date('1987-04-28', 'YYYY-MM-DD'), 'H.No. 645 Garde Marg Gandhinagar', '05384730045', 'VP', 'CNPM', 108, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21000310', 'Misha Shenoy', 'Nam', to_date('1987-06-23', 'YYYY-MM-DD'), '46 Uppal Ganj Nagpur', '+918426494051', 'VP', 'CNTT', 126, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21000311', 'Piya Garg', 'N?', to_date('2020-04-27', 'YYYY-MM-DD'), '59/38 Date Ganj Surat', '2583945365', 'CTTT', 'HTTT', 55, 6.71);

INSERT INTO SINHVIEN
VALUES ('SV21000312', 'Samarth Gandhi', 'N?', to_date('1998-08-20', 'YYYY-MM-DD'), '64 Sabharwal Ganj Jorhat', '1415728781', 'CLC', 'CNTT', 93, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21000313', 'Lakshit Bumb', 'N?', to_date('1924-05-09', 'YYYY-MM-DD'), 'H.No. 58 Garde Nagar Guna', '+912571936340', 'VP', 'HTTT', 93, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21000314', 'Lavanya Tella', 'N?', to_date('1955-04-06', 'YYYY-MM-DD'), '94/50 Solanki Circle Narasaraopet', '+919637742603', 'CTTT', 'CNTT', 63, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21000315', 'Aarna Sibal', 'N?', to_date('1997-11-20', 'YYYY-MM-DD'), 'H.No. 141 Sunder Path Mira-Bhayandar', '01131233851', 'CQ', 'HTTT', 39, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21000316', 'Nirvi Srinivas', 'N?', to_date('2000-02-11', 'YYYY-MM-DD'), 'H.No. 38 Devan Ganj Vijayawada', '+919731950942', 'CQ', 'MMT', 73, 8.74);

INSERT INTO SINHVIEN
VALUES ('SV21000317', 'Advik Loke', 'Nam', to_date('1996-07-19', 'YYYY-MM-DD'), '79/859 Iyer Ganj Kolhapur', '5882713757', 'CLC', 'TGMT', 54, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21000318', 'Onkar Chahal', 'Nam', to_date('2008-10-11', 'YYYY-MM-DD'), 'H.No. 740 Rama Zila Patna', '08769713056', 'CTTT', 'HTTT', 44, 7.16);

INSERT INTO SINHVIEN
VALUES ('SV21000319', 'Shray Lalla', 'Nam', to_date('1989-06-21', 'YYYY-MM-DD'), 'H.No. 25 Bhat Street Raurkela Industrial Township', '+914561592684', 'CQ', 'KHMT', 119, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000320', 'Taimur Yohannan', 'Nam', to_date('1930-05-04', 'YYYY-MM-DD'), '01/37 Dugar Zila Korba', '07263888727', 'CQ', 'HTTT', 34, 7.83);

INSERT INTO SINHVIEN
VALUES ('SV21000321', 'Anika Khosla', 'N?', to_date('1984-03-15', 'YYYY-MM-DD'), '59/803 Bali Street Satara', '07698609522', 'CLC', 'CNPM', 129, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21000322', 'Navya Sarna', 'N?', to_date('1930-06-11', 'YYYY-MM-DD'), '27/19 Tata Path Srikakulam', '3896529897', 'CQ', 'CNPM', 104, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21000323', 'Vivaan Tripathi', 'Nam', to_date('1959-04-24', 'YYYY-MM-DD'), 'H.No. 57 Sahni Imphal', '07127772321', 'VP', 'CNPM', 20, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21000324', 'Gokul Srinivasan', 'N?', to_date('2021-03-23', 'YYYY-MM-DD'), '82/98 Choudhry Chowk Rajahmundry', '6720984481', 'CQ', 'KHMT', 58, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21000325', 'Ayesha Devi', 'N?', to_date('1966-04-26', 'YYYY-MM-DD'), 'H.No. 470 Thaman Circle Bhalswa Jahangir Pur', '09857684901', 'CLC', 'HTTT', 71, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21000326', 'Manikya Chandra', 'N?', to_date('1937-08-19', 'YYYY-MM-DD'), 'H.No. 58 Magar Street Machilipatnam', '+913810502467', 'CQ', 'HTTT', 62, 6.48);

INSERT INTO SINHVIEN
VALUES ('SV21000327', 'Hunar Sampath', 'Nam', to_date('2002-01-24', 'YYYY-MM-DD'), 'H.No. 91 Bora Road Yamunanagar', '6775923559', 'CLC', 'HTTT', 67, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21000328', 'Kashvi Jani', 'N?', to_date('2009-04-19', 'YYYY-MM-DD'), '55 Tandon Circle Vellore', '+917146308734', 'CTTT', 'HTTT', 20, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21000329', 'Nitara Agrawal', 'N?', to_date('2018-07-17', 'YYYY-MM-DD'), 'H.No. 90 Rama Nagar New Delhi', '5551894020', 'CTTT', 'MMT', 44, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21000330', 'Ishita Ganesan', 'Nam', to_date('1918-08-21', 'YYYY-MM-DD'), '42/59 Rajan Ganj Chennai', '08566671807', 'CQ', 'CNPM', 38, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21000331', 'Parinaaz Bhandari', 'N?', to_date('1957-02-08', 'YYYY-MM-DD'), 'H.No. 758 Zachariah Marg Burhanpur', '+918902665009', 'CQ', 'CNTT', 22, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21000332', 'Sumer Chakraborty', 'N?', to_date('2015-10-31', 'YYYY-MM-DD'), '49 Sachdeva Chowk Satara', '01527076453', 'VP', 'TGMT', 48, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21000333', 'Umang Dasgupta', 'Nam', to_date('1991-04-03', 'YYYY-MM-DD'), '13/64 Aurora Street Gurgaon', '5972964384', 'CTTT', 'CNTT', 46, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21000334', 'Navya Raman', 'N?', to_date('1950-10-14', 'YYYY-MM-DD'), '99 Kadakia Gorakhpur', '03037583837', 'CLC', 'MMT', 54, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21000335', 'Nishith Singh', 'N?', to_date('1923-03-02', 'YYYY-MM-DD'), '245 Sood Street Kalyan-Dombivli', '9862670475', 'CLC', 'CNPM', 87, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21000336', 'Vidur Ramesh', 'N?', to_date('1967-01-24', 'YYYY-MM-DD'), '16/74 Andra Ganj Erode', '09799765592', 'CQ', 'CNTT', 20, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21000337', 'Ryan Mani', 'N?', to_date('1970-12-22', 'YYYY-MM-DD'), '834 Karnik Zila Kolhapur', '01258790892', 'VP', 'CNTT', 58, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21000338', 'Myra Chaudhry', 'N?', to_date('1944-10-04', 'YYYY-MM-DD'), 'H.No. 950 Vasa Path Ozhukarai', '+913186069432', 'CQ', 'TGMT', 118, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21000339', 'Shray Suresh', 'N?', to_date('1984-03-04', 'YYYY-MM-DD'), '386 Kamdar Street Surat', '04107445060', 'CTTT', 'CNPM', 138, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21000340', 'Kiaan Ramanathan', 'N?', to_date('1908-06-26', 'YYYY-MM-DD'), '138 Zachariah Marg Vellore', '5113512283', 'CQ', 'MMT', 9, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21000341', 'Eshani Ramaswamy', 'Nam', to_date('1990-04-15', 'YYYY-MM-DD'), 'H.No. 698 Kumar Ganj Thanjavur', '08671906154', 'VP', 'MMT', 46, 5.9);

INSERT INTO SINHVIEN
VALUES ('SV21000342', 'Badal Grewal', 'N?', to_date('1933-02-06', 'YYYY-MM-DD'), 'H.No. 358 Shetty Nagar Bathinda', '3935110157', 'CLC', 'TGMT', 104, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21000343', 'Mishti Sankaran', 'Nam', to_date('1963-03-24', 'YYYY-MM-DD'), '55 Som Nagar Mira-Bhayandar', '01852650769', 'CQ', 'HTTT', 28, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21000344', 'Taimur Kaul', 'Nam', to_date('2017-10-07', 'YYYY-MM-DD'), '35 Rastogi Ahmedabad', '9381319267', 'CQ', 'CNTT', 84, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21000345', 'Vanya Sandal', 'N?', to_date('1949-03-30', 'YYYY-MM-DD'), '91/07 Anand Nagar Bhatpara', '0723620328', 'CTTT', 'CNPM', 70, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21000346', 'Lakshay Bandi', 'N?', to_date('1929-03-25', 'YYYY-MM-DD'), '03/68 Saran Chowk Bangalore', '7864072731', 'CLC', 'HTTT', 62, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21000347', 'Anahi Aurora', 'N?', to_date('1952-05-20', 'YYYY-MM-DD'), '16 Hans Street Phagwara', '8642684816', 'CQ', 'HTTT', 129, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21000348', 'Stuvan Ray', 'Nam', to_date('1909-07-03', 'YYYY-MM-DD'), '74/69 Ravel Chowk Shimla', '07883053344', 'CTTT', 'CNTT', 48, 9.56);

INSERT INTO SINHVIEN
VALUES ('SV21000349', 'Adira Dewan', 'N?', to_date('1946-08-11', 'YYYY-MM-DD'), '032 Kothari Kurnool', '8770987009', 'VP', 'KHMT', 84, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21000350', 'Piya Uppal', 'Nam', to_date('1939-04-22', 'YYYY-MM-DD'), '18/32 Mane Marg Avadi', '+913499744243', 'CQ', 'CNPM', 103, 7.53);

INSERT INTO SINHVIEN
VALUES ('SV21000351', 'Lagan Das', 'Nam', to_date('2021-11-29', 'YYYY-MM-DD'), '08/249 Choudhry Path Bilaspur', '+910891748305', 'CTTT', 'MMT', 71, 5.88);

INSERT INTO SINHVIEN
VALUES ('SV21000352', 'Aaina Kannan', 'N?', to_date('1983-10-24', 'YYYY-MM-DD'), 'H.No. 64 Madan Road Ramagundam', '5940051659', 'CLC', 'KHMT', 81, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21000353', 'Vardaniya Khatri', 'N?', to_date('2003-12-20', 'YYYY-MM-DD'), 'H.No. 82 Andra Street Tenali', '3123447943', 'CLC', 'KHMT', 70, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21000354', 'Biju Lad', 'N?', to_date('1927-12-03', 'YYYY-MM-DD'), '955 Chaudhry Karawal Nagar', '+917436606061', 'CLC', 'HTTT', 77, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21000355', 'Zoya Chawla', 'N?', to_date('1995-11-08', 'YYYY-MM-DD'), '50/278 Sane Chowk Bidar', '0223710180', 'CTTT', 'MMT', 39, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21000356', 'Inaaya  Gaba', 'Nam', to_date('1998-07-22', 'YYYY-MM-DD'), 'H.No. 503 Mahal Chowk Madurai', '3440372350', 'CTTT', 'KHMT', 98, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21000357', 'Neelofar Kara', 'Nam', to_date('1951-05-17', 'YYYY-MM-DD'), '60/08 Chanda Nagar Suryapet', '+913788830370', 'VP', 'TGMT', 53, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21000358', 'Suhana Bains', 'Nam', to_date('1931-03-13', 'YYYY-MM-DD'), '37 Sama Zila Imphal', '8697933146', 'VP', 'HTTT', 89, 4.96);

INSERT INTO SINHVIEN
VALUES ('SV21000359', 'Vihaan Sahota', 'N?', to_date('1932-10-16', 'YYYY-MM-DD'), 'H.No. 49 Agate Road Rajpur Sonarpur', '+913701651705', 'CQ', 'CNTT', 53, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21000360', 'Nirvi Kota', 'N?', to_date('1915-01-01', 'YYYY-MM-DD'), 'H.No. 94 Chadha Ganj Ghaziabad', '4481166815', 'CLC', 'CNTT', 52, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21000361', 'Prerak Kala', 'N?', to_date('1968-12-08', 'YYYY-MM-DD'), '66 Date Marg Kota', '+918889960526', 'VP', 'CNPM', 70, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21000362', 'Armaan Sarkar', 'N?', to_date('2018-10-31', 'YYYY-MM-DD'), 'H.No. 00 Dasgupta Nagar Ambarnath', '+911303992588', 'VP', 'CNPM', 106, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21000363', 'Aaina Sur', 'Nam', to_date('1922-04-29', 'YYYY-MM-DD'), '72/690 Chakrabarti Path Dharmavaram', '05004389826', 'CQ', 'TGMT', 84, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21000364', 'Jivika Vala', 'N?', to_date('1975-01-23', 'YYYY-MM-DD'), '357 Golla Bongaigaon', '08464479100', 'VP', 'CNPM', 83, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21000365', 'Vidur Lal', 'N?', to_date('1996-09-07', 'YYYY-MM-DD'), '63/069 Saha Circle Lucknow', '5735859900', 'CQ', 'KHMT', 72, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21000366', 'Advika Jayaraman', 'N?', to_date('1975-11-17', 'YYYY-MM-DD'), '44/910 Bath Road Aligarh', '+918953276150', 'VP', 'CNPM', 10, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21000367', 'Indrans Viswanathan', 'N?', to_date('2024-01-27', 'YYYY-MM-DD'), 'H.No. 167 Chahal Marg Imphal', '00834593268', 'VP', 'KHMT', 44, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21000368', 'Priyansh Ben', 'Nam', to_date('1961-04-26', 'YYYY-MM-DD'), '51/45 Rajagopalan Ganj Chinsurah', '5107031419', 'CLC', 'HTTT', 35, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21000369', 'Adah Bal', 'Nam', to_date('1942-08-21', 'YYYY-MM-DD'), 'H.No. 963 Grover Circle Bhagalpur', '+917186182817', 'CTTT', 'CNTT', 66, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21000370', 'Jayant Setty', 'Nam', to_date('2009-05-15', 'YYYY-MM-DD'), 'H.No. 29 Sarin Nagar Dewas', '06038172377', 'CQ', 'CNPM', 104, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21000371', 'Vihaan Bhalla', 'Nam', to_date('1943-12-07', 'YYYY-MM-DD'), '963 Bedi Zila Jamshedpur', '03401583906', 'CTTT', 'MMT', 100, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21000372', 'Hiran Ben', 'Nam', to_date('1926-12-22', 'YYYY-MM-DD'), '17/539 Saraf Street Agartala', '+916545981336', 'CQ', 'HTTT', 38, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21000373', 'Hridaan Raju', 'Nam', to_date('1918-09-25', 'YYYY-MM-DD'), '33/464 Bakshi Marg Ghaziabad', '06406101904', 'CLC', 'KHMT', 92, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21000374', 'Advik Handa', 'Nam', to_date('1983-06-15', 'YYYY-MM-DD'), '82/71 Mangat Zila Dhanbad', '03330113375', 'CTTT', 'CNTT', 52, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21000375', 'Renee Ghosh', 'Nam', to_date('2007-03-25', 'YYYY-MM-DD'), '90/666 Khurana Erode', '02033662748', 'CQ', 'TGMT', 130, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21000376', 'Zeeshan Tak', 'N?', to_date('1952-06-02', 'YYYY-MM-DD'), '065 Bhardwaj Street New Delhi', '5655239361', 'CQ', 'TGMT', 27, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21000377', 'Trisha Suri', 'Nam', to_date('1988-09-17', 'YYYY-MM-DD'), '93/40 Raj Street Barasat', '05859672513', 'CTTT', 'MMT', 87, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21000378', 'Pari Golla', 'Nam', to_date('1935-06-20', 'YYYY-MM-DD'), 'H.No. 581 Varughese Path Chandrapur', '0142744181', 'CLC', 'MMT', 121, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21000379', 'Khushi Bhasin', 'N?', to_date('1917-02-27', 'YYYY-MM-DD'), '39/02 Zacharia Circle Naihati', '1129252487', 'CLC', 'TGMT', 91, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21000380', 'Nirvaan Sarma', 'N?', to_date('1981-06-23', 'YYYY-MM-DD'), 'H.No. 435 Halder Ganj Kumbakonam', '04092434423', 'VP', 'MMT', 94, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21000381', 'Indrajit Mand', 'N?', to_date('1920-01-07', 'YYYY-MM-DD'), 'H.No. 759 Swaminathan Zila Muzaffarpur', '4204001445', 'CTTT', 'MMT', 15, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21000382', 'Aaina Bir', 'N?', to_date('1996-07-04', 'YYYY-MM-DD'), '98/196 Gola Chowk Barasat', '7176161474', 'CQ', 'CNPM', 79, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21000383', 'Vihaan Ramachandran', 'Nam', to_date('1926-02-26', 'YYYY-MM-DD'), '63/22 Batra Circle Berhampur', '+915447789054', 'VP', 'TGMT', 86, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21000384', 'Adah Sarraf', 'N?', to_date('1983-10-14', 'YYYY-MM-DD'), '90 Kala Road Surat', '+911348306198', 'VP', 'MMT', 57, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21000385', 'Dharmajan Deep', 'N?', to_date('1998-09-24', 'YYYY-MM-DD'), 'H.No. 966 Kapoor Zila Chandigarh', '+914257334532', 'CTTT', 'CNTT', 12, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21000386', 'Neysa Kothari', 'N?', to_date('1937-03-21', 'YYYY-MM-DD'), '22 Devan Path Kanpur', '+914178836378', 'CTTT', 'TGMT', 5, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21000387', 'Pihu Gour', 'Nam', to_date('1922-09-03', 'YYYY-MM-DD'), '49 Bali Panchkula', '03121061595', 'CLC', 'KHMT', 11, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21000388', 'Piya Brar', 'Nam', to_date('1953-04-27', 'YYYY-MM-DD'), 'H.No. 81 Bir Circle Tiruvottiyur', '02205433470', 'CQ', 'TGMT', 48, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21000389', 'Hazel Sridhar', 'N?', to_date('1924-10-10', 'YYYY-MM-DD'), '03/29 Arora Marg Bikaner', '06787587714', 'CTTT', 'TGMT', 89, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21000390', 'Aaryahi Reddy', 'N?', to_date('1934-12-02', 'YYYY-MM-DD'), '11/516 Venkataraman Marg Erode', '+915705824490', 'CQ', 'TGMT', 113, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000391', 'Bhavin Varkey', 'Nam', to_date('1931-01-27', 'YYYY-MM-DD'), '45/69 Jaggi Road Berhampur', '+915752042438', 'VP', 'MMT', 96, 4.2);

INSERT INTO SINHVIEN
VALUES ('SV21000392', 'Oorja Uppal', 'N?', to_date('1924-12-27', 'YYYY-MM-DD'), '77 Sama Marg Haridwar', '+910340392262', 'CLC', 'CNTT', 65, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21000393', 'Aarna Walia', 'Nam', to_date('2006-12-15', 'YYYY-MM-DD'), '80/20 Ramakrishnan Nagar Guntur', '04496311043', 'CTTT', 'CNPM', 113, 4.92);

INSERT INTO SINHVIEN
VALUES ('SV21000394', 'Nitya Gaba', 'Nam', to_date('2003-08-20', 'YYYY-MM-DD'), '18/53 Madan Madurai', '07789979973', 'VP', 'HTTT', 58, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21000395', 'Inaaya  Mahal', 'Nam', to_date('1914-10-08', 'YYYY-MM-DD'), '00/69 Zachariah Marg Nangloi Jat', '+910506937919', 'CQ', 'CNPM', 122, 7.22);

INSERT INTO SINHVIEN
VALUES ('SV21000396', 'Ranbir Vohra', 'N?', to_date('1992-06-19', 'YYYY-MM-DD'), '24 Saraf Ganj Ludhiana', '2683502676', 'CTTT', 'HTTT', 59, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21000397', 'Veer Sur', 'Nam', to_date('1949-03-08', 'YYYY-MM-DD'), 'H.No. 432 Mani Marg Malegaon', '03805660315', 'VP', 'TGMT', 100, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21000398', 'Ayesha Tiwari', 'Nam', to_date('2008-12-08', 'YYYY-MM-DD'), '18/17 Golla Circle Nandyal', '0282737264', 'CQ', 'KHMT', 72, 7.52);

INSERT INTO SINHVIEN
VALUES ('SV21000399', 'Zara Kaul', 'N?', to_date('1930-08-12', 'YYYY-MM-DD'), '712 Mangat Marg Moradabad', '+916744811766', 'CLC', 'HTTT', 78, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21000400', 'Hiran Gill', 'Nam', to_date('1918-06-08', 'YYYY-MM-DD'), 'H.No. 435 Swamy Zila Ulhasnagar', '3860401969', 'CTTT', 'MMT', 113, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21000401', 'Vaibhav Lall', 'Nam', to_date('1983-11-07', 'YYYY-MM-DD'), '09/11 Balay Ganj Vijayanagaram', '9990659607', 'VP', 'TGMT', 39, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21000402', 'Umang Keer', 'Nam', to_date('2005-02-11', 'YYYY-MM-DD'), 'H.No. 404 Dash Road Belgaum', '4381337610', 'CLC', 'CNPM', 37, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21000403', 'Jayan Bava', 'Nam', to_date('2018-01-02', 'YYYY-MM-DD'), '688 Kannan Ganj Morena', '+913142906448', 'CQ', 'CNPM', 15, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21000404', 'Ira Ranganathan', 'Nam', to_date('2000-06-03', 'YYYY-MM-DD'), '64 Ganguly Circle Burhanpur', '1917125516', 'CTTT', 'HTTT', 28, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21000405', 'Samaira Iyengar', 'Nam', to_date('1932-09-22', 'YYYY-MM-DD'), 'H.No. 84 Toor Howrah', '4827360349', 'VP', 'CNPM', 52, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21000406', 'Devansh Sethi', 'Nam', to_date('1995-03-14', 'YYYY-MM-DD'), '72/94 Dyal Zila Howrah', '+912655012556', 'VP', 'KHMT', 65, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21000407', 'Taran Sarma', 'Nam', to_date('1916-10-25', 'YYYY-MM-DD'), '95/95 Karpe Street Moradabad', '9872767847', 'VP', 'HTTT', 119, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21000408', 'Aarna Dugar', 'Nam', to_date('1911-07-23', 'YYYY-MM-DD'), '62 Din Satara', '+911329607545', 'CLC', 'KHMT', 19, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21000409', 'Emir Agarwal', 'N?', to_date('2013-02-15', 'YYYY-MM-DD'), 'H.No. 546 D��Alia Munger', '+919191490645', 'CTTT', 'KHMT', 83, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21000410', 'Kabir Gole', 'N?', to_date('1959-07-13', 'YYYY-MM-DD'), '91/86 Dayal Path Thanjavur', '+919273317209', 'CLC', 'CNTT', 28, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21000411', 'Taimur Sur', 'Nam', to_date('2009-03-21', 'YYYY-MM-DD'), 'H.No. 432 Luthra Zila Khammam', '09199500511', 'CLC', 'HTTT', 56, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21000412', 'Anvi Thakkar', 'N?', to_date('2023-10-30', 'YYYY-MM-DD'), '95 Ramachandran Road Chapra', '0343808708', 'CLC', 'MMT', 94, 5.73);

INSERT INTO SINHVIEN
VALUES ('SV21000413', 'Aarush Barad', 'N?', to_date('1932-03-13', 'YYYY-MM-DD'), '57/781 Buch Marg Jamalpur', '7257217076', 'CTTT', 'CNPM', 24, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21000414', 'Baiju Som', 'Nam', to_date('1971-03-22', 'YYYY-MM-DD'), '11/92 Brar Chowk Tezpur', '+911065515679', 'CQ', 'TGMT', 16, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21000415', 'Biju Char', 'N?', to_date('1925-04-01', 'YYYY-MM-DD'), '707 Madan Marg Bhavnagar', '0261188339', 'CTTT', 'MMT', 40, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21000416', 'Farhan Salvi', 'N?', to_date('2023-01-20', 'YYYY-MM-DD'), 'H.No. 095 Gopal Ganj Raipur', '02539088719', 'CQ', 'CNTT', 63, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21000417', 'Nitara Sani', 'N?', to_date('1988-04-16', 'YYYY-MM-DD'), 'H.No. 72 Chakraborty Circle Morbi', '5202455349', 'CLC', 'TGMT', 79, 6.47);

INSERT INTO SINHVIEN
VALUES ('SV21000418', 'Reyansh Sabharwal', 'Nam', to_date('1951-07-23', 'YYYY-MM-DD'), '07/42 Chatterjee Road Pune', '04701539836', 'CLC', 'CNTT', 96, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21000419', 'Neysa Sood', 'Nam', to_date('1960-09-15', 'YYYY-MM-DD'), 'H.No. 241 Chad Road Karaikudi', '+919766638116', 'CLC', 'TGMT', 98, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21000420', 'Ryan Krish', 'Nam', to_date('1964-10-15', 'YYYY-MM-DD'), '56 Issac Chowk Kulti', '+911458054571', 'CTTT', 'HTTT', 22, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21000421', 'Arhaan Ramaswamy', 'Nam', to_date('2004-05-12', 'YYYY-MM-DD'), 'H.No. 630 D��Alia Road Bijapur', '+916641034801', 'VP', 'HTTT', 54, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21000422', 'Indrans Chowdhury', 'N?', to_date('1935-12-19', 'YYYY-MM-DD'), '411 Kata Ganj Jabalpur', '+917256657299', 'VP', 'TGMT', 67, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21000423', 'Tarini Chaudhari', 'N?', to_date('2020-03-29', 'YYYY-MM-DD'), '31 Lal Road Bhiwandi', '4763631601', 'VP', 'CNTT', 26, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21000424', 'Shamik Dube', 'N?', to_date('2000-12-29', 'YYYY-MM-DD'), '290 Ratti Ganj Mysore', '00326965179', 'CQ', 'HTTT', 124, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21000425', 'Nitara Gulati', 'N?', to_date('1995-11-19', 'YYYY-MM-DD'), '90 Chad Zila Bhalswa Jahangir Pur', '6436421170', 'CLC', 'CNPM', 84, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21000426', 'Rati Bumb', 'N?', to_date('2019-06-06', 'YYYY-MM-DD'), '26/231 Borde Marg Jammu', '+917599106064', 'CTTT', 'KHMT', 96, 9.69);

INSERT INTO SINHVIEN
VALUES ('SV21000427', 'Shaan Som', 'Nam', to_date('2005-05-27', 'YYYY-MM-DD'), '88/13 Shan Path Jabalpur', '00386191819', 'CQ', 'MMT', 63, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21000428', 'Armaan Hari', 'Nam', to_date('1912-01-10', 'YYYY-MM-DD'), '86/61 Thaman Path Kakinada', '7201382849', 'VP', 'HTTT', 32, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21000429', 'Manikya Chanda', 'N?', to_date('1961-11-10', 'YYYY-MM-DD'), '14 Vaidya Road Vijayanagaram', '+918865911243', 'VP', 'MMT', 51, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21000430', 'Vritika Rajagopal', 'N?', to_date('2000-09-28', 'YYYY-MM-DD'), '373 Chaudhuri Thiruvananthapuram', '06488349799', 'CQ', 'CNTT', 106, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21000431', 'Nitara Singh', 'Nam', to_date('2001-03-20', 'YYYY-MM-DD'), '30 Barad Path Ongole', '02700733983', 'CQ', 'CNPM', 19, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21000432', 'Aarush Uppal', 'N?', to_date('1995-11-28', 'YYYY-MM-DD'), '738 Sankaran Circle Sasaram', '6587107313', 'CLC', 'CNPM', 94, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21000433', 'Gokul Dixit', 'Nam', to_date('1998-11-02', 'YYYY-MM-DD'), 'H.No. 988 Sami Nagar Bathinda', '+914291856879', 'CQ', 'CNTT', 111, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21000434', 'Devansh Behl', 'Nam', to_date('1972-08-04', 'YYYY-MM-DD'), 'H.No. 30 Tripathi Zila Anand', '08939567546', 'CQ', 'MMT', 12, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21000435', 'Trisha Setty', 'Nam', to_date('1919-01-13', 'YYYY-MM-DD'), '84 Chandran Ganj Warangal', '+915757440755', 'CLC', 'CNPM', 90, 6.37);

INSERT INTO SINHVIEN
VALUES ('SV21000436', 'Taimur Anand', 'Nam', to_date('1994-09-25', 'YYYY-MM-DD'), '315 Chada Marg Nellore', '+916954952609', 'CLC', 'KHMT', 138, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21000437', 'Vedika Vig', 'N?', to_date('1921-02-14', 'YYYY-MM-DD'), 'H.No. 703 Sunder Circle Kamarhati', '7556855931', 'CTTT', 'CNTT', 0, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21000438', 'Sahil Shroff', 'Nam', to_date('1997-10-22', 'YYYY-MM-DD'), '035 Samra Road Jaunpur', '+912189812666', 'CQ', 'TGMT', 42, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21000439', 'Amira Saini', 'N?', to_date('2020-08-31', 'YYYY-MM-DD'), '46/12 Vasa Ganj Proddatur', '06928459686', 'CTTT', 'CNTT', 5, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21000440', 'Vardaniya Srivastava', 'Nam', to_date('1954-04-01', 'YYYY-MM-DD'), '90/604 Karan Vijayanagaram', '3213624987', 'CTTT', 'TGMT', 78, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21000441', 'Priyansh Dubey', 'Nam', to_date('1936-08-01', 'YYYY-MM-DD'), '853 Sha Nagar Srikakulam', '04978486651', 'CQ', 'HTTT', 22, 6.97);

INSERT INTO SINHVIEN
VALUES ('SV21000442', 'Seher Bhatt', 'Nam', to_date('1955-02-20', 'YYYY-MM-DD'), 'H.No. 134 Rajan Marg Unnao', '+916051743576', 'VP', 'KHMT', 46, 5.32);

INSERT INTO SINHVIEN
VALUES ('SV21000443', 'Abram Datta', 'Nam', to_date('1957-12-22', 'YYYY-MM-DD'), 'H.No. 759 Shetty Road Tadipatri', '+919391354037', 'CTTT', 'CNPM', 3, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21000444', 'Adira Ganguly', 'Nam', to_date('1979-05-29', 'YYYY-MM-DD'), '27/218 Date Thiruvananthapuram', '5541681863', 'CTTT', 'CNPM', 45, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21000445', 'Ishaan Bir', 'N?', to_date('1940-05-22', 'YYYY-MM-DD'), '134 Bahl Road Kishanganj', '+916499511618', 'CQ', 'TGMT', 59, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21000446', 'Nitara Anne', 'Nam', to_date('1998-10-14', 'YYYY-MM-DD'), '93 Kala Street Bhusawal', '09667124117', 'CLC', 'CNPM', 87, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21000447', 'Saanvi Dhar', 'Nam', to_date('1970-11-05', 'YYYY-MM-DD'), '95/834 Khanna Street Bangalore', '01230778558', 'CQ', 'TGMT', 75, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21000448', 'Vanya Dutta', 'N?', to_date('1996-01-14', 'YYYY-MM-DD'), 'H.No. 30 Tara Circle Tadepalligudem', '01275298671', 'CQ', 'CNTT', 135, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21000449', 'Anaya Borah', 'N?', to_date('1917-08-09', 'YYYY-MM-DD'), '47 Thakkar Nagar Tinsukia', '08608494909', 'CLC', 'MMT', 14, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21000450', 'Ojas Sampath', 'Nam', to_date('1927-10-09', 'YYYY-MM-DD'), '47/797 Ahuja Road Kumbakonam', '+912210360363', 'CQ', 'HTTT', 6, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21000451', 'Damini Chhabra', 'Nam', to_date('1947-06-25', 'YYYY-MM-DD'), '89/83 Shah Machilipatnam', '2119693490', 'VP', 'CNPM', 3, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21000452', 'Zoya Karpe', 'N?', to_date('2000-06-29', 'YYYY-MM-DD'), '75/96 Bains Nagar Jhansi', '1802553034', 'CQ', 'CNTT', 81, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21000453', 'Ehsaan Borde', 'Nam', to_date('1956-07-19', 'YYYY-MM-DD'), 'H.No. 009 Devan Zila Darbhanga', '09752519833', 'CTTT', 'MMT', 7, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21000454', 'Gokul Suri', 'Nam', to_date('1986-02-14', 'YYYY-MM-DD'), '42/249 Chandran Nagar Kakinada', '2644830223', 'CTTT', 'KHMT', 94, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21000455', 'Anay Mann', 'N?', to_date('2023-01-20', 'YYYY-MM-DD'), '16 Sastry Zila Karaikudi', '0563118722', 'VP', 'CNPM', 112, 4.69);

INSERT INTO SINHVIEN
VALUES ('SV21000456', 'Amani Sha', 'Nam', to_date('1945-03-17', 'YYYY-MM-DD'), '09/56 Ganesh Maheshtala', '05867375966', 'CTTT', 'KHMT', 125, 9.31);

INSERT INTO SINHVIEN
VALUES ('SV21000457', 'Hunar Hora', 'N?', to_date('1938-03-28', 'YYYY-MM-DD'), '340 Kala Nagar Suryapet', '01504933314', 'CLC', 'TGMT', 124, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21000458', 'Trisha Vaidya', 'Nam', to_date('1918-10-08', 'YYYY-MM-DD'), 'H.No. 246 Kalita Zila Ahmednagar', '00284992430', 'CQ', 'HTTT', 42, 8.89);

INSERT INTO SINHVIEN
VALUES ('SV21000459', 'Alisha Aurora', 'N?', to_date('1923-09-24', 'YYYY-MM-DD'), 'H.No. 951 Grover Circle Panchkula', '06446390726', 'CTTT', 'CNPM', 30, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21000460', 'Nehmat Venkatesh', 'N?', to_date('1949-01-05', 'YYYY-MM-DD'), '49/26 Shan Circle Coimbatore', '0574317829', 'VP', 'CNTT', 89, 9.84);

INSERT INTO SINHVIEN
VALUES ('SV21000461', 'Ishaan Suri', 'Nam', to_date('1955-09-22', 'YYYY-MM-DD'), '50/773 Ravi Zila Mangalore', '3627062398', 'CTTT', 'HTTT', 7, 6.27);

INSERT INTO SINHVIEN
VALUES ('SV21000462', 'Yashvi Hora', 'Nam', to_date('1916-03-07', 'YYYY-MM-DD'), '90/28 Dua Chowk Jalna', '8719003950', 'CQ', 'HTTT', 72, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21000463', 'Tara Lala', 'Nam', to_date('2015-12-05', 'YYYY-MM-DD'), '79/18 Dutta Path Orai', '5549578360', 'CTTT', 'MMT', 34, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21000464', 'Tejas Sahota', 'Nam', to_date('1964-12-10', 'YYYY-MM-DD'), 'H.No. 327 Vyas Circle Hospet', '08582034517', 'CTTT', 'MMT', 37, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21000465', 'Aaryahi Som', 'Nam', to_date('1976-10-23', 'YYYY-MM-DD'), 'H.No. 318 Taneja Street Madurai', '06388151092', 'CTTT', 'HTTT', 64, 4.22);

INSERT INTO SINHVIEN
VALUES ('SV21000466', 'Abram Bhatt', 'Nam', to_date('2022-07-30', 'YYYY-MM-DD'), '242 Mangat Ganj Narasaraopet', '+919255689829', 'VP', 'TGMT', 90, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21000467', 'Ela Thaman', 'N?', to_date('1948-01-30', 'YYYY-MM-DD'), '671 Dayal Street Sangli-Miraj', '5743076043', 'VP', 'CNTT', 133, 8.77);

INSERT INTO SINHVIEN
VALUES ('SV21000468', 'Kimaya Das', 'N?', to_date('1956-01-21', 'YYYY-MM-DD'), '241 Chada Path Ballia', '9111819363', 'CQ', 'CNTT', 1, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21000469', 'Nitya Bera', 'N?', to_date('1919-05-21', 'YYYY-MM-DD'), '85/85 Kala Guntakal', '03701107951', 'CLC', 'TGMT', 113, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21000470', 'Farhan Sandal', 'N?', to_date('2016-05-25', 'YYYY-MM-DD'), 'H.No. 233 Bahri Circle Morbi', '+913373923332', 'CQ', 'MMT', 119, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21000471', 'Dhanush Dalal', 'N?', to_date('1929-09-27', 'YYYY-MM-DD'), '18 Karpe Road Raurkela Industrial Township', '+912244948432', 'VP', 'CNTT', 14, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21000472', 'Advik Balakrishnan', 'N?', to_date('1969-10-06', 'YYYY-MM-DD'), '721 Goyal Path Junagadh', '+911432871797', 'CQ', 'KHMT', 4, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21000473', 'Arhaan Hora', 'N?', to_date('1956-10-17', 'YYYY-MM-DD'), 'H.No. 433 Dani Zila Bhatpara', '07119649849', 'CLC', 'TGMT', 108, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21000474', 'Adira Setty', 'Nam', to_date('1975-03-25', 'YYYY-MM-DD'), '92/370 Saran Zila Ghaziabad', '02161726208', 'CTTT', 'MMT', 76, 5.92);

INSERT INTO SINHVIEN
VALUES ('SV21000475', 'Damini Chana', 'N?', to_date('1918-11-30', 'YYYY-MM-DD'), '62/25 Goel Road Bhiwani', '+914289961323', 'CTTT', 'MMT', 71, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21000476', 'Riaan Anne', 'N?', to_date('1999-09-21', 'YYYY-MM-DD'), '63/45 Keer Gaya', '3801898604', 'CLC', 'HTTT', 79, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21000477', 'Armaan Anne', 'Nam', to_date('2016-06-20', 'YYYY-MM-DD'), '66 Jayaraman Ganj Phagwara', '02645515215', 'CTTT', 'CNTT', 57, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21000478', 'Piya Gupta', 'Nam', to_date('1914-05-15', 'YYYY-MM-DD'), 'H.No. 326 Chhabra Street Bhubaneswar', '03362068090', 'CLC', 'CNPM', 17, 4.4);

INSERT INTO SINHVIEN
VALUES ('SV21000479', 'Anaya Seth', 'Nam', to_date('1932-01-06', 'YYYY-MM-DD'), '97/02 Wable Road Bhalswa Jahangir Pur', '4835968119', 'CTTT', 'MMT', 122, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21000480', 'Aaryahi Reddy', 'N?', to_date('1958-10-09', 'YYYY-MM-DD'), '83/01 Hari Chowk Nandyal', '4942202240', 'CLC', 'HTTT', 3, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21000481', 'Jiya Hegde', 'Nam', to_date('2014-09-23', 'YYYY-MM-DD'), '20 Kalita Street Jabalpur', '5879582207', 'CQ', 'CNPM', 53, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21000482', 'Miraan Sundaram', 'Nam', to_date('1908-06-15', 'YYYY-MM-DD'), '53/789 Dhar Circle Medininagar', '+911343280417', 'VP', 'KHMT', 129, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21000483', 'Kimaya Raj', 'N?', to_date('1952-11-15', 'YYYY-MM-DD'), '93/08 Devi Road Moradabad', '06086123325', 'CQ', 'KHMT', 130, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000484', 'Mehul Jaggi', 'Nam', to_date('2013-12-14', 'YYYY-MM-DD'), '55 Sagar Ganj Anantapuram', '05201673359', 'CQ', 'MMT', 11, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21000485', 'Indrajit Goswami', 'N?', to_date('1931-11-30', 'YYYY-MM-DD'), 'H.No. 93 Salvi Marg Sambalpur', '+917060580514', 'CLC', 'CNTT', 111, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21000486', 'Suhana Ramesh', 'Nam', to_date('2004-09-06', 'YYYY-MM-DD'), 'H.No. 477 Bala Ganj Dindigul', '08611613286', 'CQ', 'CNTT', 120, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21000487', 'Advik Sengupta', 'N?', to_date('2013-06-19', 'YYYY-MM-DD'), '41/92 Desai Road Ujjain', '+911631367006', 'CQ', 'KHMT', 101, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21000488', 'Lakshit Vig', 'Nam', to_date('1916-11-20', 'YYYY-MM-DD'), '19/84 Kashyap Zila Bhiwani', '03865060688', 'CLC', 'CNPM', 80, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21000489', 'Baiju Agrawal', 'N?', to_date('1939-07-31', 'YYYY-MM-DD'), 'H.No. 30 Bhakta Road Rajahmundry', '09348576950', 'CTTT', 'KHMT', 13, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21000490', 'Devansh Ramakrishnan', 'Nam', to_date('2012-10-01', 'YYYY-MM-DD'), 'H.No. 94 Upadhyay Marg Nagaon', '2766494045', 'CQ', 'MMT', 109, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21000491', 'Shalv Ganesh', 'Nam', to_date('1971-01-26', 'YYYY-MM-DD'), 'H.No. 78 Chand Marg Unnao', '04239972600', 'CTTT', 'KHMT', 88, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21000492', 'Indranil Dara', 'N?', to_date('1980-09-11', 'YYYY-MM-DD'), '779 Bhatti Marg Vellore', '+918085488526', 'CTTT', 'CNPM', 8, 9.14);

INSERT INTO SINHVIEN
VALUES ('SV21000493', 'Nishith Seshadri', 'N?', to_date('1919-11-17', 'YYYY-MM-DD'), '01 Thakkar Path Varanasi', '06192168616', 'CTTT', 'MMT', 20, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21000494', 'Kabir Hora', 'Nam', to_date('1918-09-01', 'YYYY-MM-DD'), '59 Borah Marg Ratlam', '+916863135076', 'CTTT', 'HTTT', 109, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21000495', 'Pari Hayre', 'Nam', to_date('1977-08-27', 'YYYY-MM-DD'), '62 Gaba Chowk Shimoga', '+919832162723', 'CTTT', 'KHMT', 133, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21000496', 'Sara Sahota', 'Nam', to_date('1961-02-28', 'YYYY-MM-DD'), '202 Bhalla Ganj Coimbatore', '05728179366', 'CTTT', 'KHMT', 31, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21000497', 'Gokul Rajan', 'N?', to_date('1978-08-11', 'YYYY-MM-DD'), '61/23 Kamdar Chowk Pali', '+914268721884', 'CQ', 'TGMT', 35, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21000498', 'Ela Kala', 'N?', to_date('1992-07-28', 'YYYY-MM-DD'), 'H.No. 24 Iyer Circle Kharagpur', '+914809843078', 'CLC', 'KHMT', 58, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21000499', 'Kiara Rajagopal', 'Nam', to_date('1985-07-31', 'YYYY-MM-DD'), 'H.No. 08 Buch Muzaffarnagar', '+916540398413', 'CLC', 'KHMT', 88, 4.0);

INSERT INTO SINHVIEN
VALUES ('SV21000500', 'Kabir Jaggi', 'N?', to_date('1951-02-17', 'YYYY-MM-DD'), 'H.No. 445 Lata Zila Anantapur', '+919847717700', 'CTTT', 'CNPM', 22, 6.19);

INSERT INTO SINHVIEN
VALUES ('SV21000501', 'Zain Chakrabarti', 'Nam', to_date('2019-01-06', 'YYYY-MM-DD'), 'H.No. 036 Rattan Marg Katihar', '+915988986270', 'CQ', 'KHMT', 71, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21000502', 'Mishti Gupta', 'Nam', to_date('1987-10-11', 'YYYY-MM-DD'), 'H.No. 26 Babu Chowk Madhyamgram', '01089525575', 'CQ', 'CNTT', 71, 8.39);

INSERT INTO SINHVIEN
VALUES ('SV21000503', 'Yashvi Srinivas', 'N?', to_date('1962-07-19', 'YYYY-MM-DD'), '20 Dutta Marg Howrah', '9878721261', 'CLC', 'TGMT', 8, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21000504', 'Kiara Choudhry', 'N?', to_date('1909-11-27', 'YYYY-MM-DD'), 'H.No. 01 Sarraf Circle Katihar', '08508645961', 'CTTT', 'MMT', 50, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21000505', 'Indranil Ghose', 'N?', to_date('1991-01-17', 'YYYY-MM-DD'), 'H.No. 61 Bhardwaj Marg Miryalaguda', '1428626342', 'CLC', 'MMT', 10, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21000506', 'Ela Sankaran', 'Nam', to_date('1949-07-28', 'YYYY-MM-DD'), '80/66 Vala Zila Berhampur', '+915123758747', 'CQ', 'CNPM', 16, 9.31);

INSERT INTO SINHVIEN
VALUES ('SV21000507', 'Alisha Anne', 'Nam', to_date('1910-05-13', 'YYYY-MM-DD'), 'H.No. 749 Kalla Road Khora ', '+915336465950', 'CLC', 'KHMT', 63, 8.84);

INSERT INTO SINHVIEN
VALUES ('SV21000508', 'Ahana  Roy', 'N?', to_date('1933-03-16', 'YYYY-MM-DD'), 'H.No. 34 Sane Path Sikar', '5447879561', 'CLC', 'MMT', 133, 6.72);

INSERT INTO SINHVIEN
VALUES ('SV21000509', 'Advik Dugal', 'Nam', to_date('2021-09-18', 'YYYY-MM-DD'), '398 Uppal Street Mangalore', '+917856955577', 'CLC', 'MMT', 44, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21000510', 'Samaira Gour', 'Nam', to_date('1912-12-06', 'YYYY-MM-DD'), '00 Gaba Circle Bellary', '8266264223', 'CTTT', 'KHMT', 106, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21000511', 'Kismat Trivedi', 'Nam', to_date('1934-09-26', 'YYYY-MM-DD'), '98 Amble Circle Aligarh', '07643220554', 'CLC', 'HTTT', 7, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21000512', 'Vedika Bali', 'Nam', to_date('1909-11-27', 'YYYY-MM-DD'), 'H.No. 10 Cherian Nagar Warangal', '+916149826083', 'CLC', 'HTTT', 35, 7.11);

INSERT INTO SINHVIEN
VALUES ('SV21000513', 'Anvi Acharya', 'N?', to_date('1927-07-15', 'YYYY-MM-DD'), 'H.No. 56 Sankar Path Sirsa', '5580898336', 'CQ', 'KHMT', 57, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21000514', 'Hansh Hora', 'N?', to_date('1913-04-14', 'YYYY-MM-DD'), 'H.No. 964 Dani Chowk Dhanbad', '06706366073', 'CTTT', 'HTTT', 118, 7.68);

INSERT INTO SINHVIEN
VALUES ('SV21000515', 'Neelofar Vyas', 'Nam', to_date('1996-09-02', 'YYYY-MM-DD'), 'H.No. 115 Sethi Zila Kalyan-Dombivli', '+918242733359', 'CTTT', 'MMT', 104, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21000516', 'Riya Barad', 'N?', to_date('1942-10-06', 'YYYY-MM-DD'), '98/711 Hayre Zila Shahjahanpur', '08247637976', 'CTTT', 'CNPM', 40, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21000517', 'Zara Bora', 'Nam', to_date('1957-12-16', 'YYYY-MM-DD'), '94/13 Dass Nagar South Dumdum', '9423540178', 'CLC', 'CNTT', 36, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21000518', 'Abram Bassi', 'N?', to_date('2011-09-10', 'YYYY-MM-DD'), '03/29 Gokhale Nagar Tirunelveli', '+911951828853', 'CTTT', 'CNPM', 67, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21000519', 'Urvi Vora', 'N?', to_date('2020-06-14', 'YYYY-MM-DD'), '04/770 Wadhwa Nagar Khandwa', '5621383728', 'CTTT', 'MMT', 50, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21000520', 'Divyansh Wable', 'N?', to_date('1967-10-20', 'YYYY-MM-DD'), '092 Varty Ganj Nizamabad', '4379542160', 'CTTT', 'CNPM', 14, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21000521', 'Mehul Sinha', 'Nam', to_date('1916-04-29', 'YYYY-MM-DD'), 'H.No. 619 Koshy Dibrugarh', '09755300355', 'CTTT', 'CNTT', 111, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21000522', 'Ira Kaul', 'Nam', to_date('1954-03-31', 'YYYY-MM-DD'), 'H.No. 22 Borra Phagwara', '03656555000', 'CLC', 'CNTT', 126, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21000523', 'Kavya Kumer', 'N?', to_date('1960-05-28', 'YYYY-MM-DD'), '88/233 Chaudry Road Kochi', '0774646665', 'VP', 'TGMT', 99, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21000524', 'Eva Bajaj', 'N?', to_date('1944-04-03', 'YYYY-MM-DD'), 'H.No. 19 Ranganathan Marg Sirsa', '08884869317', 'CLC', 'TGMT', 39, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21000525', 'Vardaniya Dugal', 'Nam', to_date('1975-10-21', 'YYYY-MM-DD'), '254 Toor Path Bijapur', '3396231019', 'VP', 'TGMT', 85, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21000526', 'Dhanush Chakraborty', 'N?', to_date('1975-04-04', 'YYYY-MM-DD'), '40/926 Barman Street Avadi', '09973191614', 'VP', 'KHMT', 6, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21000527', 'Inaaya  Chaudhuri', 'N?', to_date('1963-12-20', 'YYYY-MM-DD'), '391 Manne Chowk Tiruppur', '9381969615', 'VP', 'MMT', 13, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21000528', 'Zoya Hayre', 'Nam', to_date('1911-06-27', 'YYYY-MM-DD'), '210 Wali Marg Mehsana', '6859231969', 'VP', 'CNTT', 48, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21000529', 'Kavya Sibal', 'Nam', to_date('1953-01-30', 'YYYY-MM-DD'), '19 Dora Mirzapur', '+912104985198', 'CLC', 'HTTT', 116, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21000530', 'Divyansh Savant', 'N?', to_date('1971-10-20', 'YYYY-MM-DD'), '77/308 Dhar Ganj Tiruvottiyur', '+915613288969', 'CTTT', 'KHMT', 123, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21000531', 'Yuvraj  Karan', 'N?', to_date('1912-01-21', 'YYYY-MM-DD'), '028 Sami Zila Orai', '7957403965', 'CLC', 'CNPM', 0, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21000532', 'Kaira Dass', 'Nam', to_date('2021-01-14', 'YYYY-MM-DD'), '78/36 Wagle Marg Firozabad', '6953137203', 'CTTT', 'TGMT', 67, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21000533', 'Trisha Kade', 'Nam', to_date('1984-05-23', 'YYYY-MM-DD'), '610 Jain Marg Fatehpur', '+919962922110', 'CQ', 'HTTT', 7, 6.19);

INSERT INTO SINHVIEN
VALUES ('SV21000534', 'Ishita Chandran', 'Nam', to_date('1916-03-13', 'YYYY-MM-DD'), 'H.No. 09 Sharma Road Surat', '02469404372', 'CLC', 'HTTT', 46, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21000535', 'Neysa Bahl', 'Nam', to_date('1960-04-03', 'YYYY-MM-DD'), '71/45 Keer Nagar Barasat', '9021373248', 'CTTT', 'TGMT', 48, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21000536', 'Baiju Chahal', 'N?', to_date('1945-08-13', 'YYYY-MM-DD'), '07 Lanka Marg Dewas', '+919435988828', 'CQ', 'KHMT', 67, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21000537', 'Jayant Ramakrishnan', 'N?', to_date('1968-04-27', 'YYYY-MM-DD'), '55/988 Sharaf Path Karimnagar', '5529919060', 'CLC', 'MMT', 0, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21000538', 'Jivika Dada', 'N?', to_date('2004-07-27', 'YYYY-MM-DD'), '66/46 Mannan Ganj North Dumdum', '7097410786', 'CLC', 'CNTT', 124, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21000539', 'Rhea Deol', 'Nam', to_date('1910-12-30', 'YYYY-MM-DD'), '18 Gokhale Marg Delhi', '7518804918', 'CQ', 'TGMT', 110, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21000540', 'Anay Tak', 'Nam', to_date('2014-07-09', 'YYYY-MM-DD'), '83/35 Loke Chowk Meerut', '+910466683403', 'VP', 'TGMT', 82, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21000541', 'Anahi Goel', 'N?', to_date('1973-11-10', 'YYYY-MM-DD'), '36/513 Seth Nagar Udupi', '+917315227485', 'CLC', 'TGMT', 72, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21000542', 'Farhan Dalal', 'N?', to_date('1971-09-29', 'YYYY-MM-DD'), '79 Bajaj Chowk Yamunanagar', '+917915622256', 'VP', 'KHMT', 77, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21000543', 'Divit Jayaraman', 'Nam', to_date('1949-04-15', 'YYYY-MM-DD'), '63/031 Mani Nagar Raichur', '09350422940', 'CLC', 'CNPM', 129, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21000544', 'Ranbir Bal', 'Nam', to_date('1946-09-12', 'YYYY-MM-DD'), '41/91 Jha Marg Panvel', '05941929490', 'VP', 'HTTT', 67, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21000545', 'Ishita Issac', 'N?', to_date('2017-12-24', 'YYYY-MM-DD'), '83/626 Ranganathan Street Kochi', '7588942009', 'CTTT', 'TGMT', 46, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21000546', 'Yuvraj  Srinivas', 'N?', to_date('1952-11-04', 'YYYY-MM-DD'), '47/591 Hans Path Panihati', '+915095583935', 'VP', 'KHMT', 62, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21000547', 'Rasha Sastry', 'N?', to_date('1980-07-23', 'YYYY-MM-DD'), '16 Wali Chowk Maheshtala', '07694029619', 'CTTT', 'KHMT', 133, 5.32);

INSERT INTO SINHVIEN
VALUES ('SV21000548', 'Kaira Choudhry', 'Nam', to_date('1932-05-25', 'YYYY-MM-DD'), '57 Atwal Dehradun', '08515309406', 'CQ', 'HTTT', 46, 6.83);

INSERT INTO SINHVIEN
VALUES ('SV21000549', 'Kiara Gole', 'Nam', to_date('1982-01-14', 'YYYY-MM-DD'), 'H.No. 518 Vasa Circle Agra', '6167835086', 'VP', 'MMT', 102, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000550', 'Eshani Kumer', 'N?', to_date('1993-02-12', 'YYYY-MM-DD'), '63/03 Dhingra Nagar Baranagar', '6756616747', 'CLC', 'TGMT', 101, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21000551', 'Aarush Mandal', 'N?', to_date('2017-10-26', 'YYYY-MM-DD'), 'H.No. 68 Rege Ganj Haldia', '+915678067302', 'VP', 'MMT', 135, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21000552', 'Eshani Cheema', 'N?', to_date('1974-10-19', 'YYYY-MM-DD'), 'H.No. 87 Batta Ganj Nellore', '8353878542', 'CQ', 'HTTT', 66, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21000553', 'Romil Vyas', 'N?', to_date('1984-09-08', 'YYYY-MM-DD'), 'H.No. 46 Khurana Zila Kirari Suleman Nagar', '6599816941', 'VP', 'KHMT', 106, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21000554', 'Azad Sen', 'Nam', to_date('2002-04-14', 'YYYY-MM-DD'), 'H.No. 81 Chowdhury Zila Hospet', '+916357452724', 'CTTT', 'CNTT', 87, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21000555', 'Akarsh Raju', 'Nam', to_date('1946-01-07', 'YYYY-MM-DD'), '82 Talwar Nagar Hazaribagh', '06803556654', 'CQ', 'TGMT', 86, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21000556', 'Renee Shanker', 'N?', to_date('1975-02-21', 'YYYY-MM-DD'), 'H.No. 49 Chand Path Tadepalligudem', '+910420169229', 'VP', 'HTTT', 112, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21000557', 'Farhan Raval', 'Nam', to_date('1947-06-24', 'YYYY-MM-DD'), '425 Magar Ganj Bikaner', '+919036049775', 'VP', 'CNPM', 33, 9.33);

INSERT INTO SINHVIEN
VALUES ('SV21000558', 'Prisha Khatri', 'Nam', to_date('1973-01-04', 'YYYY-MM-DD'), '14/91 Bajaj Road Bhiwandi', '0091757857', 'CQ', 'CNPM', 33, 7.16);

INSERT INTO SINHVIEN
VALUES ('SV21000559', 'Ahana  Mani', 'Nam', to_date('1952-09-11', 'YYYY-MM-DD'), 'H.No. 660 Seth Street Nangloi Jat', '9348943755', 'CQ', 'KHMT', 90, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21000560', 'Zeeshan Chanda', 'Nam', to_date('1984-04-29', 'YYYY-MM-DD'), '18/67 Mani Zila Kollam', '09631693798', 'VP', 'HTTT', 94, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21000561', 'Kavya Datta', 'N?', to_date('1910-10-02', 'YYYY-MM-DD'), '46/654 Dada Nagar Bhilwara', '03150275088', 'CQ', 'MMT', 114, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21000562', 'Bhavin Setty', 'N?', to_date('2008-08-03', 'YYYY-MM-DD'), 'H.No. 67 Tella Marg Tinsukia', '02109965384', 'CQ', 'TGMT', 73, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21000563', 'Vedika Kunda', 'Nam', to_date('1952-01-07', 'YYYY-MM-DD'), '78/20 Walla Chowk Bihar Sharif', '+915375970597', 'VP', 'TGMT', 45, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21000564', 'Ojas Ramesh', 'N?', to_date('1998-01-29', 'YYYY-MM-DD'), 'H.No. 79 Lata Path Dehri', '1182949741', 'CTTT', 'TGMT', 18, 4.46);

INSERT INTO SINHVIEN
VALUES ('SV21000565', 'Jivin Chaudhary', 'Nam', to_date('2021-09-05', 'YYYY-MM-DD'), '52/384 Char Marg Nagaon', '+914708522873', 'CTTT', 'HTTT', 83, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000566', 'Rania Jhaveri', 'Nam', to_date('1911-04-05', 'YYYY-MM-DD'), '241 Majumdar Nagar Alwar', '00002330487', 'CTTT', 'TGMT', 99, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21000567', 'Advik Sagar', 'Nam', to_date('1978-02-02', 'YYYY-MM-DD'), '19/593 Ranganathan Street Noida', '+911750526233', 'CQ', 'TGMT', 9, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21000568', 'Eva Dubey', 'N?', to_date('1997-10-11', 'YYYY-MM-DD'), '70/78 Mammen Marg Durg', '03949164001', 'VP', 'KHMT', 93, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21000569', 'Divit Varkey', 'N?', to_date('1928-03-25', 'YYYY-MM-DD'), '04/209 Kumar Ganj Asansol', '00547385695', 'VP', 'MMT', 91, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21000570', 'Devansh Reddy', 'N?', to_date('1940-09-29', 'YYYY-MM-DD'), '17/03 Sekhon Road Navi Mumbai', '05864951988', 'VP', 'CNTT', 18, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21000571', 'Mishti Basu', 'Nam', to_date('2000-02-02', 'YYYY-MM-DD'), '706 Chauhan Berhampur', '4505105283', 'VP', 'MMT', 98, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21000572', 'Sahil Babu', 'Nam', to_date('1941-11-09', 'YYYY-MM-DD'), '39/71 Kaul Circle Alwar', '8549930756', 'CLC', 'CNPM', 48, 6.66);

INSERT INTO SINHVIEN
VALUES ('SV21000573', 'Ivan Kibe', 'N?', to_date('2015-03-28', 'YYYY-MM-DD'), '13/58 Grewal Path Guntakal', '05881884253', 'VP', 'TGMT', 30, 5.77);

INSERT INTO SINHVIEN
VALUES ('SV21000574', 'Myra Boase', 'Nam', to_date('1996-11-27', 'YYYY-MM-DD'), 'H.No. 12 Batra Path Bally', '0071058068', 'CQ', 'CNTT', 91, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21000575', 'Aniruddh Keer', 'Nam', to_date('1939-06-25', 'YYYY-MM-DD'), '18/035 Shenoy Path Nanded', '8260719795', 'CTTT', 'TGMT', 3, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21000576', 'Jayan Sen', 'Nam', to_date('1946-09-10', 'YYYY-MM-DD'), '833 Jain Siliguri', '+915970256119', 'CLC', 'CNTT', 130, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21000577', 'Tushar Kaur', 'N?', to_date('1983-01-13', 'YYYY-MM-DD'), '51/50 Tripathi Chowk Uluberia', '08241618192', 'VP', 'MMT', 33, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21000578', 'Piya Sarna', 'N?', to_date('2002-08-16', 'YYYY-MM-DD'), '239 Doctor Marg Farrukhabad', '0703770128', 'VP', 'KHMT', 29, 7.31);

INSERT INTO SINHVIEN
VALUES ('SV21000579', 'Kaira Johal', 'Nam', to_date('2021-03-14', 'YYYY-MM-DD'), 'H.No. 29 Bala Circle Satara', '04242852370', 'CQ', 'TGMT', 60, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21000580', 'Ivan Sengupta', 'Nam', to_date('1942-08-13', 'YYYY-MM-DD'), '09 Saran Circle Alappuzha', '+912611364247', 'CQ', 'CNPM', 38, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21000581', 'Yakshit Chaudhuri', 'N?', to_date('2018-02-20', 'YYYY-MM-DD'), 'H.No. 68 Arya Ganj Rajkot', '05366015838', 'CQ', 'KHMT', 39, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21000582', 'Umang Kaur', 'Nam', to_date('1938-07-29', 'YYYY-MM-DD'), '13 Raval Path Ambarnath', '07382816649', 'CLC', 'HTTT', 125, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21000583', 'Ahana  Kulkarni', 'Nam', to_date('1983-07-16', 'YYYY-MM-DD'), '455 Tak Ganj Vijayawada', '09214310685', 'CLC', 'HTTT', 102, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000584', 'Jayant Lad', 'Nam', to_date('1930-10-13', 'YYYY-MM-DD'), 'H.No. 03 Khanna Circle Hyderabad', '01833673252', 'CLC', 'HTTT', 30, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21000585', 'Shamik Chada', 'Nam', to_date('1960-08-04', 'YYYY-MM-DD'), '85/556 Kannan Street Pali', '+917529007431', 'VP', 'KHMT', 137, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21000586', 'Kismat Khanna', 'N?', to_date('2020-11-28', 'YYYY-MM-DD'), '33 Bhattacharyya Jehanabad', '3480608876', 'VP', 'CNTT', 19, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21000587', 'Riya Bassi', 'Nam', to_date('2016-08-06', 'YYYY-MM-DD'), '59/539 Maharaj Ganj Berhampore', '+911028858767', 'VP', 'KHMT', 80, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21000588', 'Darshit Doctor', 'Nam', to_date('2022-04-12', 'YYYY-MM-DD'), '94/728 Ramachandran Street Khora ', '04868757897', 'CLC', 'MMT', 69, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21000589', 'Alia Joshi', 'N?', to_date('1988-03-11', 'YYYY-MM-DD'), 'H.No. 692 Sheth Lucknow', '+913238785239', 'CLC', 'TGMT', 112, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21000590', 'Parinaaz Handa', 'Nam', to_date('1952-03-13', 'YYYY-MM-DD'), '869 Char Zila Arrah', '09860307545', 'CLC', 'HTTT', 125, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21000591', 'Adah Deshpande', 'N?', to_date('1964-02-18', 'YYYY-MM-DD'), '22/69 Kaul Nagar Berhampur', '4942316316', 'VP', 'MMT', 31, 4.76);

INSERT INTO SINHVIEN
VALUES ('SV21000592', 'Sara Wagle', 'N?', to_date('1938-03-11', 'YYYY-MM-DD'), 'H.No. 89 Halder Circle Udaipur', '+917896172882', 'CQ', 'KHMT', 58, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21000593', 'Yuvraj  Subramaniam', 'Nam', to_date('1909-02-28', 'YYYY-MM-DD'), '04/55 Shukla Path Tiruchirappalli', '+914542293247', 'VP', 'KHMT', 8, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21000594', 'Alia Bose', 'N?', to_date('1915-03-11', 'YYYY-MM-DD'), '50/513 Sibal Bhopal', '+914038901020', 'CLC', 'CNPM', 65, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21000595', 'Kismat Yohannan', 'N?', to_date('1932-01-05', 'YYYY-MM-DD'), '443 Kulkarni Path Bareilly', '5059105447', 'CQ', 'CNPM', 88, 5.56);

INSERT INTO SINHVIEN
VALUES ('SV21000596', 'Jivin Krishna', 'N?', to_date('2002-10-16', 'YYYY-MM-DD'), 'H.No. 71 Kashyap Zila Nagercoil', '02451455602', 'VP', 'KHMT', 18, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21000597', 'Jiya Guha', 'N?', to_date('1914-05-10', 'YYYY-MM-DD'), 'H.No. 06 Cheema Path Bhiwani', '03273560036', 'CQ', 'TGMT', 9, 5.84);

INSERT INTO SINHVIEN
VALUES ('SV21000598', 'Urvi Dasgupta', 'N?', to_date('1954-05-13', 'YYYY-MM-DD'), '35/494 Venkatesh Marg Bijapur', '+911860648118', 'CLC', 'CNPM', 69, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21000599', 'Ishaan Gala', 'N?', to_date('2004-02-27', 'YYYY-MM-DD'), '59/99 Kamdar Nagar Malda', '1270383827', 'CQ', 'CNTT', 107, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21000600', 'Dhanush Saraf', 'N?', to_date('1946-01-19', 'YYYY-MM-DD'), '27/19 Vyas Bhiwandi', '8887285885', 'VP', 'TGMT', 85, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21000601', 'Fateh Thakur', 'N?', to_date('1925-06-05', 'YYYY-MM-DD'), 'H.No. 73 Kapadia Marg Kadapa', '+919026289626', 'CLC', 'HTTT', 67, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21000602', 'Raghav Comar', 'N?', to_date('1928-01-28', 'YYYY-MM-DD'), '37/273 Sha Nagar Dhule', '0408058378', 'CQ', 'KHMT', 41, 5.84);

INSERT INTO SINHVIEN
VALUES ('SV21000603', 'Rania Bhalla', 'N?', to_date('2019-02-11', 'YYYY-MM-DD'), 'H.No. 43 Chad Ganj Jalandhar', '05974420908', 'CTTT', 'TGMT', 80, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21000604', 'Aarna Grewal', 'N?', to_date('1969-12-28', 'YYYY-MM-DD'), '06/462 Kar Ganj Visakhapatnam', '+912847957413', 'CTTT', 'CNPM', 89, 5.79);

INSERT INTO SINHVIEN
VALUES ('SV21000605', 'Vaibhav Shanker', 'Nam', to_date('1953-05-24', 'YYYY-MM-DD'), 'H.No. 62 Karnik Marg Singrauli', '4343020568', 'VP', 'MMT', 28, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21000606', 'Nehmat Chokshi', 'Nam', to_date('1980-12-20', 'YYYY-MM-DD'), '63/011 Bhasin Ganj Allahabad', '04992229357', 'VP', 'CNTT', 114, 5.2);

INSERT INTO SINHVIEN
VALUES ('SV21000607', 'Sumer Kara', 'Nam', to_date('1958-11-03', 'YYYY-MM-DD'), '435 Soman Circle Ahmedabad', '7329618091', 'CLC', 'CNPM', 5, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21000608', 'Reyansh Garde', 'N?', to_date('1983-11-04', 'YYYY-MM-DD'), 'H.No. 81 Batta Marg Rourkela', '7435919601', 'CQ', 'KHMT', 61, 9.83);

INSERT INTO SINHVIEN
VALUES ('SV21000609', 'Rati Sathe', 'N?', to_date('1989-04-17', 'YYYY-MM-DD'), '26 Desai Zila Khora ', '00258549739', 'CLC', 'TGMT', 8, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21000610', 'Jiya Chaudhari', 'N?', to_date('1976-04-08', 'YYYY-MM-DD'), 'H.No. 143 Sur Chowk Sri Ganganagar', '+911957258937', 'VP', 'HTTT', 123, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21000611', 'Shayak Chhabra', 'N?', to_date('1995-02-28', 'YYYY-MM-DD'), 'H.No. 367 Keer Street Bhilwara', '0032395337', 'CLC', 'CNTT', 12, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21000612', 'Anika Krishna', 'N?', to_date('2011-11-04', 'YYYY-MM-DD'), '34 Virk Ganj Gandhinagar', '+912165100264', 'CTTT', 'KHMT', 124, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21000613', 'Zara Chaudhari', 'N?', to_date('1977-12-10', 'YYYY-MM-DD'), '11 Bumb Circle Bhiwandi', '03945306247', 'CLC', 'KHMT', 66, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21000614', 'Zeeshan Ratti', 'Nam', to_date('1944-01-26', 'YYYY-MM-DD'), 'H.No. 994 Bhattacharyya Street Gulbarga', '00649165880', 'CLC', 'KHMT', 0, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21000615', 'Jivin Badal', 'N?', to_date('2014-01-05', 'YYYY-MM-DD'), '08/54 Kota Ongole', '+911848990477', 'CTTT', 'CNPM', 27, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21000616', 'Saanvi Dasgupta', 'Nam', to_date('1910-01-09', 'YYYY-MM-DD'), '05 Brahmbhatt Chowk Kochi', '+912620663252', 'CLC', 'TGMT', 14, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21000617', 'Myra Balasubramanian', 'N?', to_date('1925-12-28', 'YYYY-MM-DD'), '29/43 Som Circle Gaya', '03006198533', 'CQ', 'MMT', 55, 5.84);

INSERT INTO SINHVIEN
VALUES ('SV21000618', 'Ira Apte', 'N?', to_date('1946-08-12', 'YYYY-MM-DD'), '15/951 Gaba Ganj Gangtok', '3445709845', 'CTTT', 'HTTT', 100, 9.83);

INSERT INTO SINHVIEN
VALUES ('SV21000619', 'Zaina Thaman', 'N?', to_date('1984-08-27', 'YYYY-MM-DD'), '069 Bhatnagar Nagar Durg', '7048113700', 'CLC', 'TGMT', 98, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21000620', 'Kanav Dugar', 'N?', to_date('1965-03-20', 'YYYY-MM-DD'), '61 Bobal Chowk Karaikudi', '8108407151', 'CQ', 'MMT', 13, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21000621', 'Bhavin Chauhan', 'Nam', to_date('1913-03-25', 'YYYY-MM-DD'), '187 Samra Sambhal', '02589399377', 'CTTT', 'CNTT', 130, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21000622', 'Abram Agate', 'N?', to_date('2023-03-07', 'YYYY-MM-DD'), '80/360 Babu Street Udaipur', '05307579938', 'CQ', 'TGMT', 12, 9.25);

INSERT INTO SINHVIEN
VALUES ('SV21000623', 'Saksham Deshmukh', 'N?', to_date('1957-04-18', 'YYYY-MM-DD'), '910 Bajwa Chowk Ozhukarai', '1322991815', 'CQ', 'TGMT', 75, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21000624', 'Hiran Mandal', 'Nam', to_date('1945-11-29', 'YYYY-MM-DD'), '40/567 Bose Path Akola', '8826331899', 'CTTT', 'CNPM', 79, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21000625', 'Anika Kulkarni', 'Nam', to_date('2001-04-06', 'YYYY-MM-DD'), 'H.No. 12 Arora Saharanpur', '07329958038', 'CQ', 'MMT', 53, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21000626', 'Inaaya  Koshy', 'N?', to_date('1912-06-28', 'YYYY-MM-DD'), '90/130 Gole Nagar Thrissur', '+917083425437', 'CQ', 'KHMT', 107, 6.36);

INSERT INTO SINHVIEN
VALUES ('SV21000627', 'Aayush Mander', 'Nam', to_date('1987-02-01', 'YYYY-MM-DD'), 'H.No. 75 Johal Marg Khammam', '00105772311', 'VP', 'CNTT', 62, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21000628', 'Onkar Kala', 'Nam', to_date('2003-08-19', 'YYYY-MM-DD'), 'H.No. 187 Majumdar Road Giridih', '4312290219', 'CQ', 'TGMT', 127, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000629', 'Zara Rege', 'Nam', to_date('1996-05-12', 'YYYY-MM-DD'), '84/87 Ahluwalia Marg Guntur', '+919376996439', 'CTTT', 'MMT', 59, 4.32);

INSERT INTO SINHVIEN
VALUES ('SV21000630', 'Neelofar Sibal', 'Nam', to_date('1962-09-29', 'YYYY-MM-DD'), '25 Dasgupta Zila Solapur', '+915622117051', 'CQ', 'MMT', 28, 8.71);

INSERT INTO SINHVIEN
VALUES ('SV21000631', 'Divij Warrior', 'Nam', to_date('1963-05-31', 'YYYY-MM-DD'), '13/15 Lad Circle Ichalkaranji', '6442065159', 'CLC', 'CNTT', 16, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21000632', 'Yakshit Chaudhry', 'N?', to_date('1919-04-18', 'YYYY-MM-DD'), '528 Sane Vadodara', '01688062817', 'CLC', 'CNPM', 127, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21000633', 'Nitara Goswami', 'N?', to_date('1947-03-21', 'YYYY-MM-DD'), 'H.No. 760 Gulati Nagar Mahbubnagar', '+913484741361', 'VP', 'TGMT', 61, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21000634', 'Shanaya Sawhney', 'N?', to_date('2002-02-16', 'YYYY-MM-DD'), 'H.No. 27 Bali Road Ratlam', '08381431700', 'CLC', 'HTTT', 37, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21000635', 'Vedika Chandra', 'N?', to_date('2006-07-28', 'YYYY-MM-DD'), '16/471 Dhaliwal Circle Belgaum', '00107395630', 'CLC', 'HTTT', 90, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21000636', 'Miraan Kohli', 'Nam', to_date('2010-04-27', 'YYYY-MM-DD'), '58 Chanda Anantapur', '+917095990050', 'CTTT', 'TGMT', 23, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21000637', 'Nitya Loke', 'N?', to_date('1981-09-23', 'YYYY-MM-DD'), '68/840 Malhotra Zila Guwahati', '6084003050', 'CQ', 'TGMT', 86, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21000638', 'Bhamini Ramaswamy', 'N?', to_date('1998-12-03', 'YYYY-MM-DD'), '49 Sridhar Nagar Shivpuri', '4687766883', 'VP', 'TGMT', 109, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21000639', 'Anika Gokhale', 'Nam', to_date('1956-11-16', 'YYYY-MM-DD'), '29/53 Bhargava Nagar Gangtok', '+915258846777', 'CTTT', 'KHMT', 134, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000640', 'Mohanlal Krishnan', 'N?', to_date('2004-05-10', 'YYYY-MM-DD'), 'H.No. 609 Goyal Circle Farrukhabad', '06004247539', 'CQ', 'TGMT', 85, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21000641', 'Kaira Mangal', 'Nam', to_date('1914-03-05', 'YYYY-MM-DD'), 'H.No. 888 Madan Path Asansol', '8768883269', 'CQ', 'MMT', 10, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21000642', 'Rhea Agate', 'N?', to_date('1939-05-09', 'YYYY-MM-DD'), '08 Som Ganj Latur', '5718982847', 'CLC', 'MMT', 131, 6.84);

INSERT INTO SINHVIEN
VALUES ('SV21000643', 'Shaan Dhillon', 'N?', to_date('1966-12-13', 'YYYY-MM-DD'), '52/975 Bhalla Path Panchkula', '2249462336', 'VP', 'HTTT', 106, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21000644', 'Samaira Soni', 'N?', to_date('1928-11-16', 'YYYY-MM-DD'), '00/89 Sarma Nagar Chennai', '08637810627', 'CTTT', 'KHMT', 53, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21000645', 'Tarini Kunda', 'Nam', to_date('1977-01-27', 'YYYY-MM-DD'), 'H.No. 74 Rao Marg Hyderabad', '1572671131', 'CTTT', 'CNPM', 121, 4.44);

INSERT INTO SINHVIEN
VALUES ('SV21000646', 'Diya Bhalla', 'N?', to_date('1929-01-04', 'YYYY-MM-DD'), 'H.No. 031 Bassi Zila Kolhapur', '+913849979299', 'CTTT', 'KHMT', 61, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21000647', 'Kabir Chaudhary', 'N?', to_date('1910-05-27', 'YYYY-MM-DD'), '59/375 Khanna Zila Sirsa', '00831372178', 'CQ', 'CNPM', 28, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21000648', 'Piya Ahuja', 'N?', to_date('1923-06-27', 'YYYY-MM-DD'), '160 Grewal Street Jalna', '+910153349695', 'CLC', 'CNTT', 61, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21000649', 'Mamooty Bhargava', 'Nam', to_date('2019-07-21', 'YYYY-MM-DD'), '99/82 Rastogi Road Khora ', '05573556902', 'VP', 'KHMT', 10, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21000650', 'Nayantara Saran', 'N?', to_date('1971-07-05', 'YYYY-MM-DD'), 'H.No. 74 Mahajan Zila Aligarh', '5289056523', 'CQ', 'CNPM', 110, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21000651', 'Khushi Lata', 'N?', to_date('1973-06-18', 'YYYY-MM-DD'), '29/638 Deshpande Jamnagar', '+919877096286', 'CTTT', 'HTTT', 83, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21000652', 'Baiju Ahluwalia', 'N?', to_date('1918-09-30', 'YYYY-MM-DD'), '32/985 Kara Road Ulhasnagar', '4553451068', 'CQ', 'CNTT', 126, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21000653', 'Amira Mangal', 'N?', to_date('1935-04-19', 'YYYY-MM-DD'), '17/14 Talwar Chowk Ghaziabad', '+919685698401', 'CLC', 'MMT', 137, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21000654', 'Gokul Kuruvilla', 'N?', to_date('2000-03-08', 'YYYY-MM-DD'), '013 Madan Ganj Bongaigaon', '8778151537', 'VP', 'HTTT', 122, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21000655', 'Divij Bhasin', 'Nam', to_date('1994-08-05', 'YYYY-MM-DD'), '27 Sheth Road Hubli�CDharwad', '02984829310', 'CLC', 'HTTT', 7, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21000656', 'Sahil Dewan', 'Nam', to_date('2007-04-01', 'YYYY-MM-DD'), '37 Rastogi Circle Panihati', '06368921936', 'VP', 'KHMT', 59, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21000657', 'Lagan Dhingra', 'N?', to_date('1928-06-08', 'YYYY-MM-DD'), '451 Gour Street Jamalpur', '01356226492', 'CQ', 'KHMT', 44, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21000658', 'Taran Sha', 'Nam', to_date('2000-02-15', 'YYYY-MM-DD'), 'H.No. 475 Sodhi Tirunelveli', '9310307956', 'CQ', 'TGMT', 136, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21000659', 'Chirag Viswanathan', 'Nam', to_date('1920-06-01', 'YYYY-MM-DD'), 'H.No. 313 Thakur Marg Kakinada', '+917303206208', 'CQ', 'MMT', 12, 7.29);

INSERT INTO SINHVIEN
VALUES ('SV21000660', 'Adah Banerjee', 'Nam', to_date('1957-06-15', 'YYYY-MM-DD'), '06 Talwar Marg Etawah', '05655651888', 'CLC', 'HTTT', 115, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21000661', 'Mannat Seshadri', 'N?', to_date('1982-02-07', 'YYYY-MM-DD'), '13 Dua Zila Solapur', '04379240974', 'CLC', 'HTTT', 57, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21000662', 'Ehsaan Sahota', 'Nam', to_date('1949-04-26', 'YYYY-MM-DD'), 'H.No. 343 Raj Path Jalna', '3918877526', 'VP', 'HTTT', 130, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21000663', 'Vidur Jha', 'N?', to_date('1999-07-09', 'YYYY-MM-DD'), 'H.No. 037 Thaman Path Hosur', '06700903553', 'CLC', 'TGMT', 129, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21000664', 'Anahita Keer', 'N?', to_date('2009-04-24', 'YYYY-MM-DD'), 'H.No. 840 Upadhyay Nagar Bihar Sharif', '2168656334', 'CQ', 'TGMT', 59, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21000665', 'Nayantara Viswanathan', 'Nam', to_date('1946-05-16', 'YYYY-MM-DD'), '22 Wali Street Dharmavaram', '+914456421573', 'CTTT', 'HTTT', 9, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21000666', 'Anahi Keer', 'Nam', to_date('2017-03-20', 'YYYY-MM-DD'), '34/10 Walla Path Imphal', '3027587351', 'CTTT', 'HTTT', 11, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21000667', 'Emir Vaidya', 'N?', to_date('1992-10-23', 'YYYY-MM-DD'), 'H.No. 12 Raman Circle Bhimavaram', '+917277329392', 'CLC', 'CNTT', 129, 8.46);

INSERT INTO SINHVIEN
VALUES ('SV21000668', 'Akarsh Mandal', 'Nam', to_date('2011-04-19', 'YYYY-MM-DD'), '23/765 Sangha Shimla', '+918985137107', 'CQ', 'CNTT', 52, 6.21);

INSERT INTO SINHVIEN
VALUES ('SV21000669', 'Hunar Koshy', 'Nam', to_date('1936-02-17', 'YYYY-MM-DD'), 'H.No. 269 Kurian Surat', '+916559950342', 'CLC', 'CNTT', 48, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21000670', 'Indranil Divan', 'N?', to_date('1948-06-17', 'YYYY-MM-DD'), '80 Garg Nagar Alappuzha', '9093535884', 'CLC', 'MMT', 56, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000671', 'Kashvi Batra', 'N?', to_date('1928-01-26', 'YYYY-MM-DD'), 'H.No. 82 Mani Path Guntur', '+914955215140', 'CQ', 'CNTT', 64, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21000672', 'Eshani Sachdeva', 'N?', to_date('1974-07-02', 'YYYY-MM-DD'), 'H.No. 599 Virk Zila Parbhani', '05992124405', 'CQ', 'CNPM', 9, 9.88);

INSERT INTO SINHVIEN
VALUES ('SV21000673', 'Ayesha Mallick', 'Nam', to_date('2001-08-14', 'YYYY-MM-DD'), 'H.No. 82 Sundaram Ganj Berhampore', '+915901116837', 'CQ', 'TGMT', 27, 8.56);

INSERT INTO SINHVIEN
VALUES ('SV21000674', 'Yuvaan Korpal', 'Nam', to_date('1939-05-11', 'YYYY-MM-DD'), 'H.No. 962 Thaman Circle Gangtok', '05340915702', 'CQ', 'KHMT', 67, 4.92);

INSERT INTO SINHVIEN
VALUES ('SV21000675', 'Darshit Sur', 'N?', to_date('1960-06-20', 'YYYY-MM-DD'), '29 Hans Road Ulhasnagar', '0242603791', 'CTTT', 'TGMT', 119, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21000676', 'Kaira Chawla', 'N?', to_date('1988-04-25', 'YYYY-MM-DD'), '988 Zacharia Path Dehradun', '3078978595', 'CLC', 'TGMT', 120, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21000677', 'Chirag Kalla', 'N?', to_date('2023-05-29', 'YYYY-MM-DD'), '79 Jaggi Chowk Tadipatri', '+916606404309', 'CTTT', 'CNTT', 6, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21000678', 'Romil Grover', 'Nam', to_date('1992-12-27', 'YYYY-MM-DD'), 'H.No. 33 Deol Street Phusro', '6116274085', 'CTTT', 'MMT', 104, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21000679', 'Anahita Balasubramanian', 'N?', to_date('2016-03-04', 'YYYY-MM-DD'), 'H.No. 550 Bhatti Road Rampur', '+914456725329', 'CTTT', 'KHMT', 37, 5.59);

INSERT INTO SINHVIEN
VALUES ('SV21000680', 'Nitara Soman', 'N?', to_date('1915-06-13', 'YYYY-MM-DD'), '464 Gala Nagar Rajahmundry', '01718593215', 'CQ', 'TGMT', 87, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21000681', 'Ranbir Raj', 'N?', to_date('2011-11-10', 'YYYY-MM-DD'), 'H.No. 103 Subramanian Ganj Vasai-Virar', '+911909970816', 'CLC', 'CNPM', 82, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21000682', 'Yashvi Kant', 'N?', to_date('1919-07-29', 'YYYY-MM-DD'), '37 Ratti Nagar Guna', '05478095977', 'CLC', 'CNTT', 132, 9.17);

INSERT INTO SINHVIEN
VALUES ('SV21000683', 'Mannat Rattan', 'N?', to_date('1937-03-23', 'YYYY-MM-DD'), '14/405 Ganesh Zila Pallavaram', '2238062458', 'VP', 'CNPM', 118, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21000684', 'Madhup Savant', 'Nam', to_date('1979-07-12', 'YYYY-MM-DD'), '13/93 Bora Bikaner', '+912836868430', 'CLC', 'HTTT', 114, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21000685', 'Himmat Ghosh', 'Nam', to_date('2001-01-11', 'YYYY-MM-DD'), 'H.No. 618 Barad Aurangabad', '9538310046', 'CQ', 'HTTT', 95, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21000686', 'Divit Upadhyay', 'Nam', to_date('1911-04-03', 'YYYY-MM-DD'), 'H.No. 104 Wali Path Nagaon', '5411344980', 'CTTT', 'TGMT', 46, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21000687', 'Mishti Lala', 'N?', to_date('1926-05-23', 'YYYY-MM-DD'), 'H.No. 401 Rout Ganj Phusro', '+910715155061', 'CQ', 'KHMT', 83, 8.25);

INSERT INTO SINHVIEN
VALUES ('SV21000688', 'Jhanvi Hari', 'Nam', to_date('1943-06-13', 'YYYY-MM-DD'), '18 Grewal Circle Karnal', '05683267777', 'VP', 'HTTT', 78, 9.83);

INSERT INTO SINHVIEN
VALUES ('SV21000689', 'Mahika Tank', 'Nam', to_date('1916-07-10', 'YYYY-MM-DD'), '228 Mahal Nagar Bahraich', '09633454278', 'VP', 'CNPM', 111, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21000690', 'Samarth Chadha', 'Nam', to_date('1921-12-19', 'YYYY-MM-DD'), 'H.No. 10 Dave Street Jehanabad', '8200201075', 'CTTT', 'CNPM', 138, 4.96);

INSERT INTO SINHVIEN
VALUES ('SV21000691', 'Aayush Sheth', 'Nam', to_date('1946-02-25', 'YYYY-MM-DD'), 'H.No. 60 Mane Street Eluru', '01941723747', 'CLC', 'CNTT', 55, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21000692', 'Farhan Tiwari', 'Nam', to_date('1963-05-24', 'YYYY-MM-DD'), '596 Tailor Ganj Secunderabad', '5073840104', 'CLC', 'MMT', 8, 6.64);

INSERT INTO SINHVIEN
VALUES ('SV21000693', 'Reyansh Lall', 'Nam', to_date('1965-02-08', 'YYYY-MM-DD'), '18 Zachariah Circle Chennai', '+919706829301', 'VP', 'TGMT', 106, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21000694', 'Mehul Hora', 'Nam', to_date('1957-12-18', 'YYYY-MM-DD'), 'H.No. 48 Kaur Nagar Mangalore', '01398251771', 'CQ', 'MMT', 96, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21000695', 'Pari Salvi', 'N?', to_date('1955-10-11', 'YYYY-MM-DD'), 'H.No. 12 Dixit Street Patiala', '9068152259', 'CTTT', 'KHMT', 27, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21000696', 'Aaina Grewal', 'N?', to_date('1908-08-17', 'YYYY-MM-DD'), '27/304 Chada Street Ajmer', '+913381177819', 'CLC', 'CNTT', 31, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21000697', 'Jivika Gulati', 'Nam', to_date('1966-06-18', 'YYYY-MM-DD'), '22/39 Malhotra Marg Bhagalpur', '+919977659613', 'CLC', 'TGMT', 137, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21000698', 'Saksham Basak', 'N?', to_date('1921-11-16', 'YYYY-MM-DD'), 'H.No. 54 Bali Street Bharatpur', '+919963625489', 'VP', 'MMT', 72, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21000699', 'Diya Buch', 'N?', to_date('1942-01-16', 'YYYY-MM-DD'), 'H.No. 338 Kanda Ganj Guntur', '06609181844', 'CQ', 'HTTT', 82, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21000700', 'Indrajit Kaur', 'Nam', to_date('1948-03-09', 'YYYY-MM-DD'), '70/121 Venkataraman Dhule', '+910010307174', 'CTTT', 'TGMT', 44, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21000701', 'Ranbir Brar', 'Nam', to_date('1926-08-20', 'YYYY-MM-DD'), 'H.No. 60 Golla Nagar Kakinada', '7874312144', 'CQ', 'CNPM', 86, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21000702', 'Anahita Mane', 'N?', to_date('1974-11-07', 'YYYY-MM-DD'), '468 Gole Katihar', '1376689448', 'CTTT', 'CNPM', 12, 5.19);

INSERT INTO SINHVIEN
VALUES ('SV21000703', 'Nehmat D��Alia', 'Nam', to_date('2020-04-07', 'YYYY-MM-DD'), 'H.No. 435 Kothari Path Chandrapur', '+919326840180', 'CTTT', 'TGMT', 26, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21000704', 'Taran Kade', 'N?', to_date('1935-03-17', 'YYYY-MM-DD'), 'H.No. 629 Vala Street Dibrugarh', '+914867631085', 'CLC', 'TGMT', 96, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21000705', 'Abram Tata', 'N?', to_date('2003-08-24', 'YYYY-MM-DD'), '69 Ramanathan Road Sambalpur', '7992399582', 'CTTT', 'MMT', 48, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21000706', 'Seher Gade', 'N?', to_date('1983-06-26', 'YYYY-MM-DD'), '56/69 Golla Chowk Indore', '+911743879878', 'CLC', 'CNPM', 71, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21000707', 'Elakshi Sengupta', 'Nam', to_date('1936-03-22', 'YYYY-MM-DD'), '19 Chopra Berhampore', '0315549653', 'CLC', 'KHMT', 109, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21000708', 'Indrans Bath', 'Nam', to_date('1935-06-18', 'YYYY-MM-DD'), '83/733 Luthra Street Chinsurah', '+913271354802', 'CTTT', 'MMT', 126, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21000709', 'Jivin Bansal', 'N?', to_date('1991-03-05', 'YYYY-MM-DD'), 'H.No. 357 Sankar Marg Unnao', '02477793488', 'VP', 'CNPM', 84, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21000710', 'Misha Cheema', 'Nam', to_date('1932-08-29', 'YYYY-MM-DD'), 'H.No. 16 Mannan Path Chittoor', '09981649260', 'CTTT', 'TGMT', 17, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21000711', 'Prerak Kumar', 'Nam', to_date('1953-07-29', 'YYYY-MM-DD'), '497 Venkataraman Hapur', '08869612231', 'CQ', 'CNTT', 99, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21000712', 'Nishith Bali', 'N?', to_date('1972-09-24', 'YYYY-MM-DD'), '04 Andra Street Shimla', '1264937596', 'CTTT', 'MMT', 131, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21000713', 'Diya Bahri', 'Nam', to_date('1914-01-26', 'YYYY-MM-DD'), 'H.No. 512 Solanki Road Kolkata', '00660168433', 'VP', 'CNPM', 130, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21000714', 'Faiyaz Bansal', 'N?', to_date('1958-04-09', 'YYYY-MM-DD'), '80 D��Alia Path Baranagar', '6079521068', 'CLC', 'CNPM', 116, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21000715', 'Mishti Sekhon', 'Nam', to_date('2006-01-22', 'YYYY-MM-DD'), 'H.No. 05 Raju Road Madanapalle', '02149828740', 'VP', 'HTTT', 83, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21000716', 'Jhanvi Dani', 'N?', to_date('1966-10-26', 'YYYY-MM-DD'), '69/06 Balay Path Nagercoil', '3885267307', 'VP', 'HTTT', 84, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21000717', 'Anika Vaidya', 'Nam', to_date('1941-09-23', 'YYYY-MM-DD'), 'H.No. 42 Buch Nagar Gulbarga', '2593407925', 'CQ', 'HTTT', 7, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21000718', 'Saira Madan', 'Nam', to_date('1977-11-14', 'YYYY-MM-DD'), '26/837 Jha Jhansi', '05949689365', 'VP', 'CNPM', 126, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21000719', 'Hiran Chahal', 'N?', to_date('2012-08-02', 'YYYY-MM-DD'), 'H.No. 673 Sarraf Nagar Phagwara', '01974217565', 'CLC', 'MMT', 110, 8.38);

INSERT INTO SINHVIEN
VALUES ('SV21000720', 'Ehsaan Rattan', 'N?', to_date('1912-02-15', 'YYYY-MM-DD'), '88/77 Bath Nagar Hyderabad', '+919164424777', 'VP', 'CNPM', 82, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21000721', 'Zara Gola', 'N?', to_date('1985-08-24', 'YYYY-MM-DD'), 'H.No. 58 Hegde Street Aurangabad', '8757113154', 'CLC', 'CNTT', 107, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21000722', 'Jivika Chaudhari', 'N?', to_date('1996-11-12', 'YYYY-MM-DD'), '61/968 Chatterjee Nagar Anantapur', '+910168051992', 'CQ', 'CNPM', 97, 7.32);

INSERT INTO SINHVIEN
VALUES ('SV21000723', 'Reyansh Ramanathan', 'N?', to_date('1984-07-27', 'YYYY-MM-DD'), '08 Wason Aligarh', '+910341525309', 'CQ', 'TGMT', 57, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000724', 'Nirvi Vig', 'N?', to_date('2008-04-13', 'YYYY-MM-DD'), '61/169 Tella Circle Kadapa', '+910898715369', 'CTTT', 'CNPM', 30, 7.29);

INSERT INTO SINHVIEN
VALUES ('SV21000725', 'Drishya Ramanathan', 'Nam', to_date('1914-07-14', 'YYYY-MM-DD'), 'H.No. 269 Uppal Ganj Mango', '+919544001398', 'CLC', 'TGMT', 60, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21000726', 'Aaryahi Balasubramanian', 'N?', to_date('1953-12-18', 'YYYY-MM-DD'), 'H.No. 545 Sane Chowk Lucknow', '4958551922', 'CLC', 'MMT', 96, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21000727', 'Saksham Bhatti', 'N?', to_date('1965-06-29', 'YYYY-MM-DD'), 'H.No. 17 Bose Marg Dehri', '08376325987', 'VP', 'TGMT', 49, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21000728', 'Dhruv Chander', 'N?', to_date('1940-10-21', 'YYYY-MM-DD'), '53/038 Saxena Zila Aurangabad', '1057909227', 'VP', 'CNPM', 21, 6.71);

INSERT INTO SINHVIEN
VALUES ('SV21000729', 'Keya Ganesh', 'N?', to_date('1980-12-05', 'YYYY-MM-DD'), 'H.No. 438 Sekhon Nagar Vadodara', '2137221289', 'CLC', 'TGMT', 26, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21000730', 'Anay Soni', 'N?', to_date('1988-05-17', 'YYYY-MM-DD'), 'H.No. 94 Tak Ganj Phagwara', '+919125191612', 'VP', 'KHMT', 110, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21000731', 'Drishya Rajagopalan', 'N?', to_date('2012-02-07', 'YYYY-MM-DD'), '13/22 Sura Road Hosur', '09930564477', 'CTTT', 'TGMT', 131, 9.88);

INSERT INTO SINHVIEN
VALUES ('SV21000732', 'Vidur Bandi', 'Nam', to_date('1919-07-31', 'YYYY-MM-DD'), '813 Lanka Nagar Ghaziabad', '+911651579673', 'CLC', 'KHMT', 46, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21000733', 'Saanvi Sethi', 'N?', to_date('1961-10-21', 'YYYY-MM-DD'), '34 Sachdeva Chowk Orai', '05063048296', 'CTTT', 'TGMT', 64, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21000734', 'Taimur Dhar', 'N?', to_date('1922-07-21', 'YYYY-MM-DD'), 'H.No. 43 Goswami Marg Nagercoil', '07372641752', 'CQ', 'CNTT', 87, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21000735', 'Raghav Varghese', 'N?', to_date('1928-12-30', 'YYYY-MM-DD'), '42/53 Kar Chowk Rohtak', '+914500907506', 'CLC', 'TGMT', 33, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21000736', 'Azad Bala', 'N?', to_date('1918-04-05', 'YYYY-MM-DD'), 'H.No. 450 Sankaran Path Katihar', '+915362588804', 'VP', 'KHMT', 102, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21000737', 'Sumer Kant', 'N?', to_date('1979-11-23', 'YYYY-MM-DD'), 'H.No. 973 Shan Path Sambalpur', '06415975789', 'CLC', 'MMT', 98, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21000738', 'Misha Aurora', 'Nam', to_date('1967-09-12', 'YYYY-MM-DD'), 'H.No. 75 Datta Marg New Delhi', '00453252653', 'CLC', 'CNTT', 100, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21000739', 'Ahana  Kothari', 'Nam', to_date('2006-03-30', 'YYYY-MM-DD'), '70 Shroff Road Kishanganj', '8300424282', 'CQ', 'MMT', 109, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21000740', 'Diya Goda', 'Nam', to_date('1937-09-30', 'YYYY-MM-DD'), '80/27 Mallick Nagar Mumbai', '+910968156152', 'CTTT', 'MMT', 36, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21000741', 'Nehmat Mangal', 'N?', to_date('2001-01-07', 'YYYY-MM-DD'), 'H.No. 696 Rout Circle Bellary', '0287340955', 'CTTT', 'CNTT', 10, 8.74);

INSERT INTO SINHVIEN
VALUES ('SV21000742', 'Elakshi Ramaswamy', 'N?', to_date('1987-11-02', 'YYYY-MM-DD'), '572 Mahajan Zila Kalyan-Dombivli', '4893778820', 'CLC', 'HTTT', 17, 5.73);

INSERT INTO SINHVIEN
VALUES ('SV21000743', 'Jayesh Subramanian', 'N?', to_date('1924-01-12', 'YYYY-MM-DD'), '76 Venkatesh Zila Amravati', '02139420942', 'CLC', 'TGMT', 129, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21000744', 'Krish Sawhney', 'N?', to_date('1941-08-30', 'YYYY-MM-DD'), '91/680 Agarwal Path Deoghar', '05374667109', 'VP', 'HTTT', 38, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21000745', 'Rati Seth', 'N?', to_date('1909-05-07', 'YYYY-MM-DD'), '73/97 Sami Ganj Arrah', '07391005303', 'VP', 'TGMT', 61, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21000746', 'Charvi Bajwa', 'Nam', to_date('1919-03-16', 'YYYY-MM-DD'), '04/225 Rau Jodhpur', '+915951183362', 'CTTT', 'CNTT', 47, 7.35);

INSERT INTO SINHVIEN
VALUES ('SV21000747', 'Raunak Ahluwalia', 'Nam', to_date('1968-06-18', 'YYYY-MM-DD'), 'H.No. 698 Jani Nagar South Dumdum', '+915051813575', 'VP', 'HTTT', 34, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21000748', 'Hunar Cherian', 'Nam', to_date('1948-10-26', 'YYYY-MM-DD'), '85/84 Goyal Zila Hyderabad', '7841415701', 'VP', 'MMT', 89, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21000749', 'Sana Chad', 'N?', to_date('1910-05-05', 'YYYY-MM-DD'), '57/784 Mangal Street Jehanabad', '0251538421', 'CTTT', 'CNPM', 81, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21000750', 'Ishaan Master', 'N?', to_date('1928-08-08', 'YYYY-MM-DD'), '99 Deo Street Jaunpur', '09762696311', 'CQ', 'MMT', 137, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21000751', 'Piya Atwal', 'N?', to_date('1961-05-16', 'YYYY-MM-DD'), 'H.No. 35 Sengupta Chowk Gulbarga', '+915530868800', 'VP', 'HTTT', 31, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21000752', 'Madhav Sengupta', 'N?', to_date('1916-08-31', 'YYYY-MM-DD'), '67/40 Kothari Zila Aurangabad', '+912188740655', 'CTTT', 'TGMT', 100, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21000753', 'Raghav Gupta', 'N?', to_date('1971-09-16', 'YYYY-MM-DD'), '739 Lata Road Bulandshahr', '02110083984', 'CQ', 'MMT', 69, 4.22);

INSERT INTO SINHVIEN
VALUES ('SV21000754', 'Khushi Varkey', 'Nam', to_date('1940-06-24', 'YYYY-MM-DD'), '92/614 Bhat Ganj Moradabad', '08027495569', 'CLC', 'CNTT', 45, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21000755', 'Hunar Rajagopalan', 'N?', to_date('1976-05-11', 'YYYY-MM-DD'), 'H.No. 20 Thaman Path Guntakal', '04126358202', 'CTTT', 'MMT', 14, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21000756', 'Badal Desai', 'N?', to_date('1981-09-01', 'YYYY-MM-DD'), '66/984 Buch Chowk Sirsa', '07339218053', 'CTTT', 'CNPM', 87, 7.33);

INSERT INTO SINHVIEN
VALUES ('SV21000757', 'Ishita Randhawa', 'Nam', to_date('1933-08-22', 'YYYY-MM-DD'), 'H.No. 06 Brahmbhatt Street Alappuzha', '07163249679', 'VP', 'CNPM', 64, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21000758', 'Vritika Chahal', 'N?', to_date('1954-01-13', 'YYYY-MM-DD'), '75 Mandal Nagar Kishanganj', '8758541129', 'CQ', 'TGMT', 61, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21000759', 'Ehsaan Rout', 'N?', to_date('2003-04-01', 'YYYY-MM-DD'), 'H.No. 52 Sarkar Marg Gaya', '+917436938284', 'VP', 'CNTT', 124, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21000760', 'Amira Dash', 'N?', to_date('1995-06-24', 'YYYY-MM-DD'), 'H.No. 538 Tank Ganj Karawal Nagar', '00013027888', 'CTTT', 'HTTT', 112, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21000761', 'Aayush Baria', 'N?', to_date('1933-08-08', 'YYYY-MM-DD'), '32/452 Sangha Zila Gudivada', '+911034346244', 'CTTT', 'CNPM', 72, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21000762', 'Ojas Cherian', 'Nam', to_date('1912-11-01', 'YYYY-MM-DD'), '87/10 Yogi Hapur', '8170989534', 'CTTT', 'CNPM', 127, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21000763', 'Charvi Bobal', 'Nam', to_date('1910-01-31', 'YYYY-MM-DD'), '336 Ghose Street Kishanganj', '+911399058640', 'CLC', 'CNPM', 14, 7.52);

INSERT INTO SINHVIEN
VALUES ('SV21000764', 'Anahi Balay', 'N?', to_date('1924-05-08', 'YYYY-MM-DD'), '10/90 Das Chowk Panipat', '03121676719', 'VP', 'KHMT', 110, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21000765', 'Riaan De', 'Nam', to_date('1915-09-22', 'YYYY-MM-DD'), '349 Manne Imphal', '04716414083', 'CTTT', 'KHMT', 86, 6.39);

INSERT INTO SINHVIEN
VALUES ('SV21000766', 'Mannat Amble', 'N?', to_date('1959-05-10', 'YYYY-MM-DD'), '73/544 Banik Nagar Bharatpur', '+917601158006', 'CTTT', 'MMT', 37, 5.84);

INSERT INTO SINHVIEN
VALUES ('SV21000767', 'Ranbir Ratti', 'N?', to_date('1938-11-12', 'YYYY-MM-DD'), 'H.No. 750 Saxena Path Ramgarh', '+911618299277', 'CLC', 'CNPM', 109, 6.71);

INSERT INTO SINHVIEN
VALUES ('SV21000768', 'Ela Sarin', 'N?', to_date('1918-05-25', 'YYYY-MM-DD'), '95 Kakar Road Deoghar', '7587578058', 'VP', 'CNPM', 97, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21000769', 'Advika Bhat', 'N?', to_date('1980-12-08', 'YYYY-MM-DD'), '29/681 Lanka Ganj Silchar', '4979513718', 'CTTT', 'CNPM', 70, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21000770', 'Lakshay Dhillon', 'N?', to_date('1930-11-21', 'YYYY-MM-DD'), 'H.No. 900 Barad Path Nagaon', '3156396000', 'CQ', 'CNTT', 123, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21000771', 'Aarav Halder', 'Nam', to_date('1982-01-06', 'YYYY-MM-DD'), 'H.No. 623 Sunder Nagar Tiruppur', '+911055941620', 'CQ', 'TGMT', 118, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21000772', 'Yuvraj  Ganguly', 'N?', to_date('1951-02-23', 'YYYY-MM-DD'), 'H.No. 39 Guha Ganj Amravati', '9984717539', 'CLC', 'MMT', 74, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21000773', 'Zara Choudhary', 'Nam', to_date('1911-11-23', 'YYYY-MM-DD'), '102 Randhawa Path Tinsukia', '+918272583529', 'CQ', 'MMT', 95, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21000774', 'Tejas Subramaniam', 'Nam', to_date('1986-02-23', 'YYYY-MM-DD'), '52/84 Sawhney Ganj Naihati', '03165029620', 'VP', 'MMT', 136, 6.2);

INSERT INTO SINHVIEN
VALUES ('SV21000775', 'Mishti Badal', 'Nam', to_date('1941-08-23', 'YYYY-MM-DD'), '20 Lall Raichur', '00892840753', 'CQ', 'HTTT', 67, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21000776', 'Siya Atwal', 'N?', to_date('1976-06-28', 'YYYY-MM-DD'), '70/543 Anne Street Khora ', '+914422697169', 'CTTT', 'HTTT', 132, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21000777', 'Shayak Kar', 'N?', to_date('1984-03-06', 'YYYY-MM-DD'), '568 Balan Ganj Kharagpur', '05718484785', 'CLC', 'KHMT', 100, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21000778', 'Vardaniya Deep', 'Nam', to_date('1955-02-12', 'YYYY-MM-DD'), '507 Sarna Chowk Etawah', '3258789753', 'CLC', 'KHMT', 5, 8.58);

INSERT INTO SINHVIEN
VALUES ('SV21000779', 'Badal Choudhury', 'N?', to_date('1971-07-09', 'YYYY-MM-DD'), '61 Tata Zila Udaipur', '04121906683', 'CQ', 'KHMT', 40, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21000780', 'Azad Goswami', 'N?', to_date('1981-12-22', 'YYYY-MM-DD'), 'H.No. 103 Vig Zila Tadipatri', '+919763378508', 'CTTT', 'KHMT', 43, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21000781', 'Raghav Bahri', 'Nam', to_date('1912-12-06', 'YYYY-MM-DD'), '07/957 Suri Circle Ramagundam', '+919947537701', 'VP', 'CNPM', 83, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21000782', 'Tiya Venkatesh', 'Nam', to_date('2024-02-19', 'YYYY-MM-DD'), 'H.No. 119 Krishnamurthy Kakinada', '8250913156', 'CTTT', 'CNPM', 81, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21000783', 'Eshani Goda', 'N?', to_date('1967-06-15', 'YYYY-MM-DD'), '45 Arora Nagar Visakhapatnam', '+911831222876', 'CQ', 'HTTT', 132, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21000784', 'Hunar Chauhan', 'N?', to_date('1948-11-07', 'YYYY-MM-DD'), 'H.No. 181 Bawa Street Miryalaguda', '08450887388', 'CQ', 'TGMT', 40, 9.87);

INSERT INTO SINHVIEN
VALUES ('SV21000785', 'Shlok Sarma', 'N?', to_date('1929-06-23', 'YYYY-MM-DD'), '090 Krish Marg Kozhikode', '05392117556', 'CLC', 'KHMT', 107, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21000786', 'Siya Dash', 'Nam', to_date('1955-09-13', 'YYYY-MM-DD'), '09 Agate Marg Srikakulam', '+919266273291', 'VP', 'TGMT', 77, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21000787', 'Adira Tandon', 'Nam', to_date('1985-04-04', 'YYYY-MM-DD'), 'H.No. 11 Khatri Chowk Sasaram', '+910622367932', 'CQ', 'TGMT', 61, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21000788', 'Riaan Sangha', 'N?', to_date('1952-03-19', 'YYYY-MM-DD'), '27/938 Sekhon Street Karaikudi', '+911820674324', 'CLC', 'CNPM', 122, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21000789', 'Dhruv Mammen', 'N?', to_date('1993-10-28', 'YYYY-MM-DD'), 'H.No. 67 Basak Zila Bhopal', '+919585069838', 'VP', 'HTTT', 56, 5.31);

INSERT INTO SINHVIEN
VALUES ('SV21000790', 'Aarush Aurora', 'N?', to_date('2003-01-23', 'YYYY-MM-DD'), '30/69 Mani Marg Kamarhati', '+910215364810', 'VP', 'TGMT', 48, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21000791', 'Farhan Walla', 'N?', to_date('2006-01-05', 'YYYY-MM-DD'), 'H.No. 688 Agrawal Circle Guntakal', '09493285302', 'VP', 'HTTT', 34, 8.89);

INSERT INTO SINHVIEN
VALUES ('SV21000792', 'Mamooty Trivedi', 'Nam', to_date('1953-02-13', 'YYYY-MM-DD'), 'H.No. 49 Bhasin Jamalpur', '00159369234', 'VP', 'KHMT', 48, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21000793', 'Sara Chacko', 'Nam', to_date('1946-07-12', 'YYYY-MM-DD'), 'H.No. 35 Krishna Tirupati', '1703722587', 'CLC', 'HTTT', 7, 5.24);

INSERT INTO SINHVIEN
VALUES ('SV21000794', 'Arnav Jhaveri', 'N?', to_date('1974-12-05', 'YYYY-MM-DD'), '99/482 Chana Road Satara', '8571349437', 'CTTT', 'CNPM', 37, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21000795', 'Armaan Ghosh', 'Nam', to_date('1944-07-25', 'YYYY-MM-DD'), '63 Arya Zila Khora ', '2181787114', 'CTTT', 'HTTT', 111, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21000796', 'Romil Lata', 'N?', to_date('1924-09-21', 'YYYY-MM-DD'), 'H.No. 412 Sachdev Ganj Karawal Nagar', '+912950573738', 'CQ', 'CNPM', 138, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21000797', 'Jayan Kumer', 'N?', to_date('1936-07-08', 'YYYY-MM-DD'), 'H.No. 008 Balan Ganj Kulti', '04739354670', 'VP', 'KHMT', 94, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21000798', 'Drishya Shankar', 'N?', to_date('1939-08-24', 'YYYY-MM-DD'), '60/999 Sabharwal Street Panvel', '+912429169868', 'CTTT', 'CNTT', 84, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21000799', 'Indranil Bansal', 'N?', to_date('1975-04-08', 'YYYY-MM-DD'), '209 Sharaf Path Bhalswa Jahangir Pur', '+916060781600', 'CTTT', 'HTTT', 72, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21000800', 'Faiyaz Hans', 'N?', to_date('1967-02-13', 'YYYY-MM-DD'), '96 Thakkar Nagar Vasai-Virar', '2611970695', 'CLC', 'TGMT', 30, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21000801', 'Vihaan Dass', 'N?', to_date('1934-08-15', 'YYYY-MM-DD'), '348 Mander Nagar Delhi', '+910500667669', 'CLC', 'TGMT', 19, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21000802', 'Renee Devan', 'Nam', to_date('2004-08-12', 'YYYY-MM-DD'), '448 Din Ganj Motihari', '+917411330150', 'CTTT', 'KHMT', 32, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21000803', 'Ritvik Dua', 'N?', to_date('2021-08-17', 'YYYY-MM-DD'), '43 Mani Nagar Nellore', '+918096278566', 'CTTT', 'HTTT', 92, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21000804', 'Rhea Varkey', 'Nam', to_date('2005-10-24', 'YYYY-MM-DD'), '04/60 Srinivasan Ganj Saharanpur', '0549843326', 'CQ', 'MMT', 92, 8.71);

INSERT INTO SINHVIEN
VALUES ('SV21000805', 'Shanaya Gill', 'Nam', to_date('2012-04-29', 'YYYY-MM-DD'), 'H.No. 882 Mani Nagar Jaunpur', '+912268699622', 'VP', 'KHMT', 52, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21000806', 'Aaina Vohra', 'Nam', to_date('2012-05-02', 'YYYY-MM-DD'), 'H.No. 321 Butala Nagar Bidar', '08567731057', 'CQ', 'CNTT', 65, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21000807', 'Vivaan Hans', 'Nam', to_date('1934-05-23', 'YYYY-MM-DD'), '56 Sarkar Kakinada', '8066965816', 'CQ', 'HTTT', 101, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21000808', 'Aarav Hegde', 'N?', to_date('1928-01-08', 'YYYY-MM-DD'), 'H.No. 160 Singh Circle Thrissur', '2357767549', 'CTTT', 'HTTT', 11, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21000809', 'Bhavin Ratti', 'Nam', to_date('1942-01-15', 'YYYY-MM-DD'), 'H.No. 266 Chand Chowk Visakhapatnam', '+912485023404', 'CQ', 'CNTT', 21, 5.75);

INSERT INTO SINHVIEN
VALUES ('SV21000810', 'Shray Dhar', 'N?', to_date('2013-10-02', 'YYYY-MM-DD'), '21/791 Chanda Ganj Bally', '+917568904211', 'CLC', 'MMT', 128, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21000811', 'Reyansh Varghese', 'N?', to_date('1973-01-29', 'YYYY-MM-DD'), '64/636 Chaudhuri Nagpur', '+911159338352', 'CLC', 'KHMT', 24, 6.21);

INSERT INTO SINHVIEN
VALUES ('SV21000812', 'Dhanuk Ravel', 'Nam', to_date('1996-07-30', 'YYYY-MM-DD'), '30/66 Babu Nagar Sambhal', '+911635674898', 'CTTT', 'KHMT', 95, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21000813', 'Tiya Raval', 'N?', to_date('1934-07-21', 'YYYY-MM-DD'), '43 Devan Nagar Allahabad', '3080500197', 'CQ', 'HTTT', 113, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21000814', 'Purab Chadha', 'Nam', to_date('1936-08-12', 'YYYY-MM-DD'), '88 Dhawan Zila Darbhanga', '9493099816', 'CQ', 'CNPM', 80, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21000815', 'Oorja Loke', 'N?', to_date('1993-10-02', 'YYYY-MM-DD'), '29 Arora Nagar Meerut', '02697480620', 'CTTT', 'TGMT', 81, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21000816', 'Alisha Sodhi', 'N?', to_date('1947-09-21', 'YYYY-MM-DD'), '45/17 Venkataraman Circle Sirsa', '04454055748', 'CQ', 'HTTT', 26, 9.33);

INSERT INTO SINHVIEN
VALUES ('SV21000817', 'Nirvi Dani', 'Nam', to_date('1973-07-11', 'YYYY-MM-DD'), '148 Bhat South Dumdum', '00364495611', 'CQ', 'MMT', 52, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21000818', 'Bhamini Khanna', 'Nam', to_date('1949-02-18', 'YYYY-MM-DD'), '48 Solanki Ganj Anand', '2350301807', 'CTTT', 'TGMT', 127, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21000819', 'Neelofar Khosla', 'N?', to_date('1968-04-05', 'YYYY-MM-DD'), '62/33 Devan Road Amravati', '02446126717', 'VP', 'CNTT', 5, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21000820', 'Diya Koshy', 'N?', to_date('1919-03-20', 'YYYY-MM-DD'), '09/55 Lall Chowk Karimnagar', '8482587398', 'CLC', 'CNTT', 59, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21000821', 'Sana Chad', 'Nam', to_date('1938-12-27', 'YYYY-MM-DD'), '47/778 Gaba Zila Tinsukia', '+910381084987', 'CLC', 'CNPM', 0, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21000822', 'Kavya Sood', 'N?', to_date('1915-03-13', 'YYYY-MM-DD'), '27/92 Ganesan Marg Bhimavaram', '+915450476469', 'CLC', 'TGMT', 55, 4.21);

INSERT INTO SINHVIEN
VALUES ('SV21000823', 'Zoya De', 'N?', to_date('1992-06-13', 'YYYY-MM-DD'), 'H.No. 04 Chatterjee Zila Siwan', '+913335460605', 'CQ', 'CNTT', 72, 5.35);

INSERT INTO SINHVIEN
VALUES ('SV21000824', 'Neysa Raju', 'Nam', to_date('2011-05-24', 'YYYY-MM-DD'), '902 Goda Path Jaipur', '+918818132193', 'CLC', 'MMT', 102, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21000825', 'Eva Guha', 'Nam', to_date('1994-09-24', 'YYYY-MM-DD'), '32 Warrior Thoothukudi', '04978115522', 'VP', 'HTTT', 79, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000826', 'Tara Chacko', 'N?', to_date('2023-05-27', 'YYYY-MM-DD'), '35/719 Dugar Path Tenali', '02460180871', 'VP', 'HTTT', 7, 4.67);

INSERT INTO SINHVIEN
VALUES ('SV21000827', 'Advik Shetty', 'Nam', to_date('2008-11-29', 'YYYY-MM-DD'), '79/51 De Street Machilipatnam', '+918461225257', 'VP', 'MMT', 36, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21000828', 'Ranbir Kumer', 'N?', to_date('1919-07-24', 'YYYY-MM-DD'), 'H.No. 211 Sastry Nagar Sambhal', '+911184395555', 'CLC', 'HTTT', 12, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21000829', 'Vritika Dani', 'Nam', to_date('1948-09-05', 'YYYY-MM-DD'), '49/859 Krishnan Nagar Morena', '8255845610', 'CQ', 'KHMT', 33, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21000830', 'Hrishita Shanker', 'Nam', to_date('1983-10-24', 'YYYY-MM-DD'), '671 Dave Zila Baranagar', '9488503323', 'CLC', 'TGMT', 92, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21000831', 'Shalv Sood', 'N?', to_date('1919-06-22', 'YYYY-MM-DD'), 'H.No. 75 Sarna Circle Shahjahanpur', '2522933132', 'VP', 'TGMT', 26, 5.9);

INSERT INTO SINHVIEN
VALUES ('SV21000832', 'Renee Thakkar', 'N?', to_date('2018-12-11', 'YYYY-MM-DD'), '078 Raman Ganj Gaya', '8623878387', 'VP', 'MMT', 133, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21000833', 'Pari Wadhwa', 'N?', to_date('1936-11-21', 'YYYY-MM-DD'), '22/831 Solanki Road Pondicherry', '05410131149', 'VP', 'HTTT', 30, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21000834', 'Tushar Gara', 'Nam', to_date('2006-06-27', 'YYYY-MM-DD'), '31/652 Choudhury Sirsa', '+910283909384', 'CLC', 'MMT', 21, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21000835', 'Ritvik Borah', 'Nam', to_date('1977-12-06', 'YYYY-MM-DD'), '38 Thaker Muzaffarnagar', '00588426354', 'VP', 'CNPM', 45, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21000836', 'Chirag Dhawan', 'N?', to_date('1990-08-31', 'YYYY-MM-DD'), '19/50 Kata Nagar Faridabad', '00484253066', 'VP', 'HTTT', 61, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21000837', 'Lagan Dave', 'Nam', to_date('1983-03-15', 'YYYY-MM-DD'), 'H.No. 31 Saxena Panvel', '+918273906100', 'CQ', 'MMT', 23, 7.66);

INSERT INTO SINHVIEN
VALUES ('SV21000838', 'Stuvan Buch', 'N?', to_date('1953-02-26', 'YYYY-MM-DD'), '93/63 Sethi Street Kollam', '07907039661', 'CTTT', 'MMT', 5, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21000839', 'Hrishita Subramanian', 'Nam', to_date('1943-04-10', 'YYYY-MM-DD'), 'H.No. 062 Krishnan Nagar Madanapalle', '05752760128', 'VP', 'KHMT', 122, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21000840', 'Indrajit Ranganathan', 'Nam', to_date('1937-05-26', 'YYYY-MM-DD'), '15 Kapadia Nagar Kharagpur', '7736932051', 'CTTT', 'CNTT', 73, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21000841', 'Raghav Bains', 'N?', to_date('1920-02-17', 'YYYY-MM-DD'), '073 Tailor Kishanganj', '06748361506', 'CQ', 'CNPM', 75, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21000842', 'Eshani Shukla', 'Nam', to_date('1912-04-29', 'YYYY-MM-DD'), '85/12 Krish Ganj Mirzapur', '9996102286', 'CTTT', 'CNTT', 11, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21000843', 'Ela Rajagopalan', 'N?', to_date('1931-05-27', 'YYYY-MM-DD'), '87/177 Vora Road Muzaffarnagar', '+917412221774', 'CTTT', 'HTTT', 127, 8.25);

INSERT INTO SINHVIEN
VALUES ('SV21000844', 'Aayush Ratti', 'Nam', to_date('2007-02-22', 'YYYY-MM-DD'), '96/30 Maharaj Zila Bhavnagar', '03391115178', 'CLC', 'CNPM', 103, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21000845', 'Riya Deol', 'Nam', to_date('1930-04-08', 'YYYY-MM-DD'), 'H.No. 764 Anand Circle Delhi', '+913850573123', 'CTTT', 'HTTT', 56, 4.85);

INSERT INTO SINHVIEN
VALUES ('SV21000846', 'Kartik Virk', 'Nam', to_date('1943-04-27', 'YYYY-MM-DD'), 'H.No. 110 Kulkarni Street Panihati', '03911184621', 'VP', 'KHMT', 32, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21000847', 'Vanya Salvi', 'Nam', to_date('1956-05-09', 'YYYY-MM-DD'), '56/86 Bali Nagar Udaipur', '00277152153', 'VP', 'CNTT', 32, 6.97);

INSERT INTO SINHVIEN
VALUES ('SV21000848', 'Saanvi Dixit', 'N?', to_date('1923-08-20', 'YYYY-MM-DD'), '149 Sarna Circle Pune', '7539026395', 'CQ', 'HTTT', 54, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21000849', 'Shray Ravel', 'N?', to_date('1972-01-13', 'YYYY-MM-DD'), '70/35 Chand Zila Guwahati', '00535307847', 'VP', 'KHMT', 106, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21000850', 'Saksham Babu', 'Nam', to_date('1997-03-21', 'YYYY-MM-DD'), '08/34 Dugar Road Naihati', '1305390506', 'CLC', 'MMT', 4, 4.22);

INSERT INTO SINHVIEN
VALUES ('SV21000851', 'Nayantara Konda', 'Nam', to_date('1936-03-01', 'YYYY-MM-DD'), '12/184 Magar Street Kurnool', '02174726601', 'CQ', 'MMT', 2, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21000852', 'Armaan Dara', 'Nam', to_date('2022-10-17', 'YYYY-MM-DD'), '877 Jain Ganj Kadapa', '3863485206', 'CQ', 'KHMT', 20, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21000853', 'Mehul Wagle', 'Nam', to_date('1995-01-20', 'YYYY-MM-DD'), 'H.No. 81 Mani Road Kishanganj', '+914077499662', 'CQ', 'TGMT', 13, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21000854', 'Yashvi Shenoy', 'N?', to_date('1939-08-13', 'YYYY-MM-DD'), '63/40 Sarin Nagar Mau', '02942344756', 'CQ', 'CNTT', 93, 5.2);

INSERT INTO SINHVIEN
VALUES ('SV21000855', 'Ranbir Chakraborty', 'Nam', to_date('1981-10-10', 'YYYY-MM-DD'), 'H.No. 09 Bhandari Zila Secunderabad', '3787119935', 'VP', 'CNPM', 62, 7.74);

INSERT INTO SINHVIEN
VALUES ('SV21000856', 'Ira Bir', 'Nam', to_date('1945-10-02', 'YYYY-MM-DD'), '17/500 Korpal Ganj Saharanpur', '3177213794', 'CLC', 'HTTT', 84, 7.97);

INSERT INTO SINHVIEN
VALUES ('SV21000857', 'Prisha Varghese', 'Nam', to_date('2008-11-25', 'YYYY-MM-DD'), '97/19 Shenoy Marg Gorakhpur', '+911198056920', 'CLC', 'CNPM', 106, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21000858', 'Anay Wagle', 'Nam', to_date('1997-10-17', 'YYYY-MM-DD'), '95 Gaba Marg Gwalior', '6447959785', 'VP', 'CNPM', 101, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21000859', 'Adah Venkatesh', 'N?', to_date('1956-04-06', 'YYYY-MM-DD'), 'H.No. 15 Bora Ganj Hospet', '8194391507', 'VP', 'HTTT', 135, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21000860', 'Nehmat Chaudhary', 'Nam', to_date('1999-01-03', 'YYYY-MM-DD'), '885 Tripathi Road Bhind', '+917168542824', 'CLC', 'MMT', 40, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21000861', 'Zaina Chanda', 'N?', to_date('1918-12-15', 'YYYY-MM-DD'), '41/69 Dar Path Tiruchirappalli', '+910190575391', 'CQ', 'KHMT', 98, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21000862', 'Rati Kakar', 'N?', to_date('2008-07-01', 'YYYY-MM-DD'), '07/279 Kala Chowk Etawah', '02256030302', 'CTTT', 'CNPM', 60, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21000863', 'Lagan Bhagat', 'Nam', to_date('1992-01-13', 'YYYY-MM-DD'), '38/733 Verma Coimbatore', '+911217015244', 'VP', 'MMT', 136, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21000864', 'Ira Saini', 'N?', to_date('1923-01-12', 'YYYY-MM-DD'), '61/515 Kata Path Bhiwani', '02490780311', 'VP', 'CNPM', 18, 5.86);

INSERT INTO SINHVIEN
VALUES ('SV21000865', 'Suhana Sridhar', 'N?', to_date('1990-08-28', 'YYYY-MM-DD'), '57/768 Comar Street Berhampore', '09495226302', 'CQ', 'MMT', 45, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21000866', 'Manikya Kakar', 'N?', to_date('2023-12-08', 'YYYY-MM-DD'), '20 Chada Path Gurgaon', '3554241092', 'VP', 'MMT', 30, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21000867', 'Jayesh Gour', 'Nam', to_date('1952-06-03', 'YYYY-MM-DD'), 'H.No. 17 Borde Nagar Mahbubnagar', '7583627656', 'CLC', 'CNTT', 104, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21000868', 'Prisha Chana', 'Nam', to_date('1978-08-30', 'YYYY-MM-DD'), 'H.No. 453 Chatterjee Zila Amravati', '+910084861711', 'VP', 'CNPM', 1, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21000869', 'Aarav Grover', 'N?', to_date('1972-01-18', 'YYYY-MM-DD'), '21 Chandran Road Purnia', '08108697483', 'CQ', 'HTTT', 135, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21000870', 'Jivika Bandi', 'N?', to_date('2000-11-18', 'YYYY-MM-DD'), '24 Bawa Nagar Panchkula', '+918440482452', 'CQ', 'KHMT', 57, 4.44);

INSERT INTO SINHVIEN
VALUES ('SV21000871', 'Badal Buch', 'Nam', to_date('1956-03-01', 'YYYY-MM-DD'), '065 Talwar Rampur', '04004274992', 'CLC', 'CNTT', 85, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21000872', 'Romil Khare', 'Nam', to_date('1909-11-30', 'YYYY-MM-DD'), '14/14 Shroff Path Panihati', '+911756894272', 'CQ', 'KHMT', 17, 7.17);

INSERT INTO SINHVIEN
VALUES ('SV21000873', 'Jayesh Lad', 'Nam', to_date('1931-04-19', 'YYYY-MM-DD'), '90/53 Salvi Road Haldia', '08823249931', 'CQ', 'MMT', 135, 8.86);

INSERT INTO SINHVIEN
VALUES ('SV21000874', 'Mohanlal Goswami', 'Nam', to_date('1972-06-23', 'YYYY-MM-DD'), '13/24 Sodhi Thoothukudi', '4692555186', 'CQ', 'TGMT', 84, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21000875', 'Farhan Ramachandran', 'Nam', to_date('1999-06-29', 'YYYY-MM-DD'), '78 Balan Nagar Sikar', '8433630852', 'CQ', 'HTTT', 57, 4.67);

INSERT INTO SINHVIEN
VALUES ('SV21000876', 'Kartik Sur', 'Nam', to_date('1985-04-30', 'YYYY-MM-DD'), 'H.No. 390 Loke Zila Amritsar', '01715796975', 'CQ', 'CNPM', 103, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21000877', 'Vihaan Mane', 'Nam', to_date('1932-04-03', 'YYYY-MM-DD'), '83/832 Ratta Zila Salem', '8078064783', 'CLC', 'TGMT', 100, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21000878', 'Yasmin Korpal', 'N?', to_date('1933-12-16', 'YYYY-MM-DD'), '655 Luthra Nagar Yamunanagar', '3472642394', 'CQ', 'MMT', 17, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21000879', 'Amani Shankar', 'N?', to_date('1970-12-29', 'YYYY-MM-DD'), 'H.No. 101 Kibe Street Satna', '+919351073021', 'CTTT', 'KHMT', 95, 8.19);

INSERT INTO SINHVIEN
VALUES ('SV21000880', 'Jivika Bassi', 'N?', to_date('1925-11-27', 'YYYY-MM-DD'), 'H.No. 495 Boase Zila Darbhanga', '3449430241', 'CTTT', 'MMT', 94, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21000881', 'Damini Loyal', 'Nam', to_date('1956-10-23', 'YYYY-MM-DD'), 'H.No. 95 Yohannan Marg Kirari Suleman Nagar', '+918103929995', 'CTTT', 'MMT', 83, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21000882', 'Jhanvi Bhargava', 'Nam', to_date('1927-01-03', 'YYYY-MM-DD'), 'H.No. 37 Rajagopal Chittoor', '03751181627', 'CQ', 'HTTT', 38, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21000883', 'Divyansh Dash', 'N?', to_date('1969-10-26', 'YYYY-MM-DD'), '63/960 Chakraborty Ganj Bhatpara', '02195152594', 'CLC', 'TGMT', 56, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21000884', 'Ahana  Seth', 'Nam', to_date('1946-09-16', 'YYYY-MM-DD'), '07 Golla Nagar Bhalswa Jahangir Pur', '2666015140', 'VP', 'HTTT', 127, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21000885', 'Dhanush Malhotra', 'N?', to_date('1987-07-05', 'YYYY-MM-DD'), '06/82 Dasgupta Street Munger', '08464672858', 'CQ', 'TGMT', 7, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21000886', 'Tarini Devi', 'Nam', to_date('1951-06-28', 'YYYY-MM-DD'), '86/53 Arora Ganj Jodhpur', '00984777124', 'VP', 'CNPM', 98, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21000887', 'Madhav Choudhry', 'Nam', to_date('1929-03-31', 'YYYY-MM-DD'), '60/41 Kibe Marg Munger', '+917404916845', 'CTTT', 'MMT', 41, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21000888', 'Riya Sampath', 'N?', to_date('1912-06-23', 'YYYY-MM-DD'), '35 Vora Chowk Miryalaguda', '02761882592', 'CQ', 'TGMT', 35, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21000889', 'Siya Kala', 'N?', to_date('1912-07-08', 'YYYY-MM-DD'), '602 Soman Marg Muzaffarpur', '+918075963707', 'VP', 'MMT', 98, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21000890', 'Pihu Sharaf', 'N?', to_date('1974-04-30', 'YYYY-MM-DD'), '25/32 Aggarwal Chowk Loni', '9296959214', 'VP', 'KHMT', 23, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21000891', 'Kiara Koshy', 'Nam', to_date('1976-06-03', 'YYYY-MM-DD'), '294 Khalsa Zila Amaravati', '02516988015', 'CTTT', 'KHMT', 119, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21000892', 'Ishaan Sachar', 'Nam', to_date('1948-03-21', 'YYYY-MM-DD'), 'H.No. 29 Golla Zila Bhiwani', '6240408693', 'CQ', 'CNTT', 41, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21000893', 'Ishita Devan', 'N?', to_date('1993-02-11', 'YYYY-MM-DD'), 'H.No. 00 Kade Path Srikakulam', '+910397288025', 'CLC', 'MMT', 42, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21000894', 'Aradhya Contractor', 'Nam', to_date('1929-03-26', 'YYYY-MM-DD'), 'H.No. 508 Kapoor Zila Jalna', '09694432547', 'CTTT', 'KHMT', 77, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21000895', 'Siya Das', 'N?', to_date('2011-06-14', 'YYYY-MM-DD'), '73 Jayaraman Ganj Baranagar', '+914514782172', 'CLC', 'KHMT', 68, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21000896', 'Lakshay Sathe', 'N?', to_date('1995-04-12', 'YYYY-MM-DD'), '02 Ramachandran Marg Malegaon', '5588398639', 'CTTT', 'MMT', 72, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21000897', 'Ritvik Vig', 'N?', to_date('2003-05-10', 'YYYY-MM-DD'), '09/00 Gupta Zila Satna', '01402995421', 'CQ', 'CNTT', 113, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21000898', 'Saira Rege', 'N?', to_date('1935-10-06', 'YYYY-MM-DD'), 'H.No. 47 Subramaniam Nagar Danapur', '07235120034', 'CQ', 'CNTT', 51, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21000899', 'Taran Sha', 'N?', to_date('1921-01-04', 'YYYY-MM-DD'), '52/513 Koshy Nagar Proddatur', '+912131235258', 'CTTT', 'HTTT', 40, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21000900', 'Prerak Upadhyay', 'N?', to_date('1983-02-17', 'YYYY-MM-DD'), '32/093 Thakur Zila Siwan', '4842916665', 'CQ', 'KHMT', 128, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21000901', 'Pari Vaidya', 'Nam', to_date('1980-09-01', 'YYYY-MM-DD'), '25/95 Deo Circle Jalna', '9438223661', 'CQ', 'CNTT', 67, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21000902', 'Chirag Garde', 'N?', to_date('1972-08-17', 'YYYY-MM-DD'), 'H.No. 514 Mani Marg Raebareli', '1403979793', 'CLC', 'CNTT', 96, 5.05);

INSERT INTO SINHVIEN
VALUES ('SV21000903', 'Myra Lanka', 'Nam', to_date('1925-05-23', 'YYYY-MM-DD'), '38 Roy Ganj Udaipur', '7708160000', 'CTTT', 'CNTT', 84, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21000904', 'Sana Kade', 'Nam', to_date('1945-11-15', 'YYYY-MM-DD'), '93/58 Din Chinsurah', '+914032247339', 'CTTT', 'KHMT', 80, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21000905', 'Darshit Rama', 'Nam', to_date('1997-12-19', 'YYYY-MM-DD'), 'H.No. 01 Korpal Street Ghaziabad', '+912603819562', 'CLC', 'HTTT', 100, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21000906', 'Yuvraj  Lad', 'Nam', to_date('1908-12-19', 'YYYY-MM-DD'), 'H.No. 409 Acharya Nagar Mangalore', '4097804800', 'CQ', 'CNPM', 136, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21000907', 'Sara Sant', 'N?', to_date('2016-06-26', 'YYYY-MM-DD'), '23 Garde Circle Sambalpur', '+919843911864', 'VP', 'CNPM', 90, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21000908', 'Umang Ghosh', 'N?', to_date('2016-08-18', 'YYYY-MM-DD'), 'H.No. 614 Sunder Marg Mira-Bhayandar', '06048725522', 'CTTT', 'TGMT', 110, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21000909', 'Pihu Tripathi', 'Nam', to_date('2016-09-25', 'YYYY-MM-DD'), '507 Guha Zila Silchar', '+917882080682', 'CQ', 'CNTT', 3, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000910', 'Shayak Kothari', 'N?', to_date('1918-03-22', 'YYYY-MM-DD'), '07/139 Dasgupta Road Faridabad', '02252532431', 'CQ', 'KHMT', 31, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21000911', 'Bhavin Edwin', 'N?', to_date('1982-05-04', 'YYYY-MM-DD'), 'H.No. 588 Mahal Road Bhopal', '9694177755', 'CTTT', 'KHMT', 132, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21000912', 'Yakshit Bhasin', 'Nam', to_date('2014-03-29', 'YYYY-MM-DD'), 'H.No. 92 Baral Chowk Ramgarh', '05004191174', 'VP', 'KHMT', 3, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21000913', 'Saanvi Ray', 'Nam', to_date('2021-05-20', 'YYYY-MM-DD'), 'H.No. 35 Subramaniam Road Jamshedpur', '+915460446246', 'CQ', 'HTTT', 119, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21000914', 'Trisha Anne', 'N?', to_date('1957-02-03', 'YYYY-MM-DD'), '64/40 Sunder Ganj Karimnagar', '01673064898', 'CLC', 'TGMT', 93, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21000915', 'Kanav Ram', 'N?', to_date('1941-07-03', 'YYYY-MM-DD'), '88/19 Bhandari Zila Gorakhpur', '4268032786', 'CLC', 'KHMT', 127, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21000916', 'Madhup Wali', 'Nam', to_date('1930-12-06', 'YYYY-MM-DD'), '82/089 Goswami Path Kanpur', '+911952211957', 'CLC', 'TGMT', 108, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21000917', 'Diya Tripathi', 'N?', to_date('1991-07-13', 'YYYY-MM-DD'), 'H.No. 98 Chander Marg Hazaribagh', '5568867971', 'CQ', 'MMT', 49, 4.52);

INSERT INTO SINHVIEN
VALUES ('SV21000918', 'Anya Kala', 'N?', to_date('1916-02-20', 'YYYY-MM-DD'), '62/783 Tripathi Nagar Karaikudi', '9118030513', 'VP', 'KHMT', 17, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21000919', 'Amani Lata', 'Nam', to_date('1972-11-06', 'YYYY-MM-DD'), '301 Baria Street Madanapalle', '+911661961487', 'CTTT', 'HTTT', 127, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21000920', 'Veer Khare', 'Nam', to_date('1999-06-19', 'YYYY-MM-DD'), 'H.No. 83 Bahri Miryalaguda', '08897364924', 'CTTT', 'KHMT', 81, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21000921', 'Rania Ramaswamy', 'Nam', to_date('1953-11-23', 'YYYY-MM-DD'), '76/07 Mane Zila Kumbakonam', '+914949584953', 'CLC', 'KHMT', 29, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21000922', 'Aaina Kashyap', 'Nam', to_date('1956-07-08', 'YYYY-MM-DD'), 'H.No. 83 Singh Marg Hapur', '04247291157', 'VP', 'CNTT', 28, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21000923', 'Sara Andra', 'Nam', to_date('1954-08-26', 'YYYY-MM-DD'), '36 Tailor Circle Bijapur', '01376039449', 'CTTT', 'TGMT', 112, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21000924', 'Saira Solanki', 'N?', to_date('1984-07-20', 'YYYY-MM-DD'), '21/40 Goel Zila Sangli-Miraj', '+911488266857', 'CLC', 'CNPM', 86, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21000925', 'Dishani Din', 'Nam', to_date('1995-06-30', 'YYYY-MM-DD'), '746 Uppal Nagar Khammam', '7471417031', 'CQ', 'TGMT', 33, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21000926', 'Kavya Chander', 'N?', to_date('1914-07-16', 'YYYY-MM-DD'), '84/90 Rama Street Srinagar', '7359662793', 'VP', 'KHMT', 92, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21000927', 'Eva Kala', 'N?', to_date('1972-01-31', 'YYYY-MM-DD'), '35 Srinivasan Road Tirunelveli', '03654686997', 'CTTT', 'HTTT', 76, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21000928', 'Myra Mandal', 'Nam', to_date('2016-04-29', 'YYYY-MM-DD'), '383 Bhatti Path Thrissur', '7994089037', 'CTTT', 'CNPM', 29, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21000929', 'Urvi Acharya', 'Nam', to_date('1939-02-13', 'YYYY-MM-DD'), '75 Arora Chowk Madurai', '+910202461516', 'CQ', 'TGMT', 73, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21000930', 'Ivan Dyal', 'Nam', to_date('1910-11-19', 'YYYY-MM-DD'), 'H.No. 349 Jaggi Path Chapra', '+914402943018', 'CLC', 'CNTT', 99, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21000931', 'Umang Singh', 'N?', to_date('1926-09-19', 'YYYY-MM-DD'), '28/576 Chakraborty Road Mirzapur', '2983898348', 'CTTT', 'TGMT', 82, 9.84);

INSERT INTO SINHVIEN
VALUES ('SV21000932', 'Farhan Soman', 'Nam', to_date('2023-05-11', 'YYYY-MM-DD'), '645 Mani Circle Erode', '1090769424', 'CLC', 'TGMT', 108, 8.32);

INSERT INTO SINHVIEN
VALUES ('SV21000933', 'Samarth Kohli', 'N?', to_date('2014-09-16', 'YYYY-MM-DD'), '30/442 Talwar Circle Kavali', '+917853656343', 'CLC', 'CNTT', 107, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21000934', 'Shanaya Dey', 'Nam', to_date('1962-08-06', 'YYYY-MM-DD'), '21 Jani Marg Secunderabad', '01949420285', 'CQ', 'TGMT', 47, 5.24);

INSERT INTO SINHVIEN
VALUES ('SV21000935', 'Ishaan Soman', 'N?', to_date('1922-03-14', 'YYYY-MM-DD'), '97/27 Subramaniam Road Chinsurah', '4635031429', 'CQ', 'HTTT', 37, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21000936', 'Yuvaan Tiwari', 'N?', to_date('1976-09-07', 'YYYY-MM-DD'), '073 Barman Ganj Gandhinagar', '3744938825', 'CTTT', 'CNPM', 103, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21000937', 'Armaan Shenoy', 'Nam', to_date('1938-01-01', 'YYYY-MM-DD'), '46/66 Hayre Road Surendranagar Dudhrej', '7976756673', 'CLC', 'KHMT', 33, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21000938', 'Rania Doctor', 'N?', to_date('2002-04-28', 'YYYY-MM-DD'), '95/337 Mammen Zila Ghaziabad', '3152639248', 'CLC', 'CNTT', 70, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21000939', 'Baiju Din', 'Nam', to_date('1997-12-09', 'YYYY-MM-DD'), '838 Raja Nagar Khandwa', '03590026272', 'CLC', 'CNPM', 129, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21000940', 'Manjari Sangha', 'Nam', to_date('1992-12-08', 'YYYY-MM-DD'), 'H.No. 525 Wadhwa Path Tiruppur', '00598854323', 'VP', 'HTTT', 134, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21000941', 'Sumer Gupta', 'Nam', to_date('2016-06-12', 'YYYY-MM-DD'), '44 Golla Ganj Tinsukia', '08858524022', 'CTTT', 'KHMT', 131, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21000942', 'Ahana  Shankar', 'N?', to_date('1963-01-07', 'YYYY-MM-DD'), 'H.No. 48 Korpal Circle Thiruvananthapuram', '03236115572', 'CLC', 'CNTT', 111, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21000943', 'Taran Mani', 'Nam', to_date('2017-05-27', 'YYYY-MM-DD'), 'H.No. 03 Wali Nagar Berhampur', '+919657327091', 'CQ', 'CNPM', 32, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21000944', 'Lavanya Rao', 'N?', to_date('1992-05-06', 'YYYY-MM-DD'), 'H.No. 010 Deshmukh Marg Loni', '09152883908', 'VP', 'MMT', 123, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21000945', 'Vanya Sandal', 'N?', to_date('2010-08-11', 'YYYY-MM-DD'), '94/86 Bhatti Ganj Avadi', '08344159580', 'CLC', 'KHMT', 70, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21000946', 'Riaan Sani', 'Nam', to_date('2013-03-21', 'YYYY-MM-DD'), '66/580 Aurora Chowk Gwalior', '+916236437554', 'CTTT', 'CNTT', 91, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21000947', 'Romil Mannan', 'Nam', to_date('1933-05-07', 'YYYY-MM-DD'), '34 Bhavsar Ganj Alappuzha', '00571229235', 'CLC', 'KHMT', 15, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21000948', 'Aarush Chander', 'N?', to_date('2023-11-20', 'YYYY-MM-DD'), 'H.No. 099 Jaggi Zila Jehanabad', '5418363834', 'VP', 'CNPM', 70, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21000949', 'Shayak Setty', 'N?', to_date('1925-01-08', 'YYYY-MM-DD'), 'H.No. 38 Sachdeva Nagar Ahmednagar', '+913922531836', 'VP', 'CNTT', 85, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21000950', 'Indrans Salvi', 'Nam', to_date('2001-11-14', 'YYYY-MM-DD'), 'H.No. 33 Sani Path Sambhal', '+914033855602', 'CQ', 'CNPM', 68, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21000951', 'Saksham Bava', 'N?', to_date('1915-03-13', 'YYYY-MM-DD'), 'H.No. 074 Singh Marg Karaikudi', '+919982987932', 'CTTT', 'TGMT', 8, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21000952', 'Shray Sane', 'Nam', to_date('1998-07-09', 'YYYY-MM-DD'), 'H.No. 87 Dyal Circle Motihari', '07410095055', 'CLC', 'HTTT', 75, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21000953', 'Rohan Setty', 'Nam', to_date('1968-11-05', 'YYYY-MM-DD'), 'H.No. 35 Chaudhary Path Allahabad', '02878117495', 'CQ', 'TGMT', 122, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21000954', 'Taimur Rout', 'N?', to_date('1944-09-13', 'YYYY-MM-DD'), 'H.No. 65 Bhalla Zila New Delhi', '+916209094673', 'CTTT', 'KHMT', 65, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21000955', 'Aayush Deep', 'N?', to_date('1960-04-23', 'YYYY-MM-DD'), '36/81 Thaman Nagar Surendranagar Dudhrej', '+919931241914', 'CTTT', 'HTTT', 21, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21000956', 'Adira Rana', 'Nam', to_date('1925-12-01', 'YYYY-MM-DD'), '50 Andra Zila Asansol', '8932678144', 'VP', 'KHMT', 33, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21000957', 'Yuvaan Dayal', 'N?', to_date('1918-09-25', 'YYYY-MM-DD'), '20 Batta Circle Nagpur', '3260638297', 'CTTT', 'CNPM', 16, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21000958', 'Bhamini Kunda', 'Nam', to_date('1939-07-14', 'YYYY-MM-DD'), '47/19 Saran Zila Mango', '+916719947694', 'VP', 'HTTT', 125, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21000959', 'Rohan Goda', 'N?', to_date('1970-11-27', 'YYYY-MM-DD'), '319 Kanda Zila Kakinada', '+918412903560', 'CQ', 'CNTT', 43, 7.32);

INSERT INTO SINHVIEN
VALUES ('SV21000960', 'Aayush Sandal', 'Nam', to_date('1916-01-10', 'YYYY-MM-DD'), 'H.No. 497 Dara Nagar Vijayawada', '+916475346137', 'VP', 'TGMT', 8, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21000961', 'Darshit Sachdev', 'Nam', to_date('1918-07-22', 'YYYY-MM-DD'), 'H.No. 955 Chowdhury Path Shimla', '+913213247745', 'CTTT', 'CNPM', 81, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21000962', 'Zeeshan Tara', 'Nam', to_date('1950-09-08', 'YYYY-MM-DD'), 'H.No. 387 Sathe Ganj Bihar Sharif', '7690776257', 'CLC', 'HTTT', 13, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21000963', 'Onkar Rajan', 'Nam', to_date('1934-04-06', 'YYYY-MM-DD'), '12/064 Dalal Erode', '+913376994003', 'CTTT', 'HTTT', 42, 6.65);

INSERT INTO SINHVIEN
VALUES ('SV21000964', 'Ehsaan Deol', 'N?', to_date('1986-04-09', 'YYYY-MM-DD'), '484 Mangal Street Mangalore', '5525794995', 'CQ', 'CNPM', 5, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21000965', 'Navya Dhingra', 'Nam', to_date('1981-12-01', 'YYYY-MM-DD'), '81/590 Butala Parbhani', '8094609201', 'VP', 'KHMT', 91, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21000966', 'Ryan Sandal', 'Nam', to_date('1925-03-08', 'YYYY-MM-DD'), '33/246 Rajagopal Farrukhabad', '6252592477', 'CLC', 'CNTT', 97, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21000967', 'Miraya Bhasin', 'N?', to_date('1934-05-03', 'YYYY-MM-DD'), '22 Lall Zila Patiala', '09933848925', 'CLC', 'MMT', 44, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21000968', 'Dhruv Gandhi', 'Nam', to_date('2014-11-07', 'YYYY-MM-DD'), '90 Jha Street Bahraich', '06909524672', 'CTTT', 'HTTT', 120, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21000969', 'Ira Wadhwa', 'N?', to_date('2018-10-11', 'YYYY-MM-DD'), 'H.No. 57 Bose Circle Naihati', '4136268533', 'CTTT', 'TGMT', 68, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21000970', 'Heer Sura', 'N?', to_date('1950-02-14', 'YYYY-MM-DD'), '28/07 Dube Serampore', '+919934313519', 'CLC', 'CNPM', 66, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21000971', 'Jayan Krish', 'N?', to_date('1962-12-11', 'YYYY-MM-DD'), '117 Batta Ganj Rourkela', '0941911725', 'CLC', 'HTTT', 15, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21000972', 'Krish Bora', 'Nam', to_date('1925-08-08', 'YYYY-MM-DD'), 'H.No. 33 Butala Zila Warangal', '+914842021338', 'CTTT', 'MMT', 60, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21000973', 'Rohan Saraf', 'N?', to_date('1999-08-20', 'YYYY-MM-DD'), 'H.No. 87 Doctor Hosur', '1037528764', 'CQ', 'TGMT', 104, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21000974', 'Kabir Bajwa', 'Nam', to_date('1983-04-23', 'YYYY-MM-DD'), '180 Saha Ganj North Dumdum', '09323734619', 'CQ', 'HTTT', 23, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21000975', 'Eshani Hegde', 'N?', to_date('2015-03-30', 'YYYY-MM-DD'), 'H.No. 20 Sachar Tirunelveli', '3282285234', 'CQ', 'TGMT', 87, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21000976', 'Ivan Ganguly', 'N?', to_date('1952-09-23', 'YYYY-MM-DD'), '04 Jayaraman Marg Hospet', '6646903963', 'VP', 'CNTT', 85, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21000977', 'Diya Randhawa', 'Nam', to_date('2023-11-18', 'YYYY-MM-DD'), '10/063 Goda Street Anantapuram', '+914066649667', 'CLC', 'CNTT', 78, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21000978', 'Shanaya Bandi', 'N?', to_date('1976-08-11', 'YYYY-MM-DD'), '72/93 Raval Chowk Agartala', '1601877759', 'CLC', 'MMT', 79, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21000979', 'Rohan Lanka', 'Nam', to_date('1945-02-07', 'YYYY-MM-DD'), '70 Kant Marg Guna', '3060775907', 'CLC', 'HTTT', 32, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21000980', 'Dishani Tara', 'N?', to_date('1921-12-29', 'YYYY-MM-DD'), '58/83 Saran Zila Bhusawal', '01556674018', 'CLC', 'MMT', 64, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21000981', 'Rania Mann', 'Nam', to_date('1977-04-19', 'YYYY-MM-DD'), 'H.No. 059 Deol Path Ajmer', '9512745539', 'CTTT', 'HTTT', 13, 7.97);

INSERT INTO SINHVIEN
VALUES ('SV21000982', 'Rohan Barad', 'Nam', to_date('1910-03-19', 'YYYY-MM-DD'), '39 Uppal Road Mehsana', '08179206078', 'VP', 'TGMT', 132, 9.84);

INSERT INTO SINHVIEN
VALUES ('SV21000983', 'Chirag Solanki', 'Nam', to_date('1914-03-22', 'YYYY-MM-DD'), 'H.No. 26 Aggarwal Street Khandwa', '+914508328203', 'CTTT', 'MMT', 57, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21000984', 'Sumer Hans', 'N?', to_date('1928-07-10', 'YYYY-MM-DD'), '74/04 Sachdeva Path Cuttack', '9536161691', 'VP', 'CNPM', 114, 8.46);

INSERT INTO SINHVIEN
VALUES ('SV21000985', 'Rasha Bhavsar', 'N?', to_date('1928-04-12', 'YYYY-MM-DD'), '62/56 Goel Marg Dhule', '02302482355', 'CLC', 'CNTT', 47, 8.02);

INSERT INTO SINHVIEN
VALUES ('SV21000986', 'Prisha Din', 'N?', to_date('1927-09-21', 'YYYY-MM-DD'), '988 Choudhary Zila Mathura', '+913144074876', 'VP', 'HTTT', 109, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21000987', 'Zeeshan Mannan', 'Nam', to_date('2016-04-05', 'YYYY-MM-DD'), '11/29 Srinivas Road Varanasi', '03525914827', 'CQ', 'MMT', 127, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21000988', 'Faiyaz Uppal', 'N?', to_date('2013-08-06', 'YYYY-MM-DD'), '88/949 Tank Marg Thrissur', '+919846220822', 'VP', 'TGMT', 3, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21000989', 'Dhanush Shroff', 'N?', to_date('1909-12-14', 'YYYY-MM-DD'), '337 Bera Path Ambarnath', '+912763075706', 'CQ', 'HTTT', 53, 6.81);

INSERT INTO SINHVIEN
VALUES ('SV21000990', 'Mishti Mangat', 'Nam', to_date('1926-01-08', 'YYYY-MM-DD'), '20/272 Kalla Chowk Motihari', '+917774941788', 'CQ', 'KHMT', 15, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21000991', 'Urvi Srinivasan', 'Nam', to_date('1962-03-26', 'YYYY-MM-DD'), '11/45 Gera Circle Karnal', '+912999142826', 'CTTT', 'MMT', 14, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21000992', 'Onkar Chopra', 'N?', to_date('1950-08-21', 'YYYY-MM-DD'), '742 Apte Zila Kumbakonam', '+911124802420', 'CQ', 'HTTT', 63, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21000993', 'Aayush Varughese', 'Nam', to_date('1912-02-04', 'YYYY-MM-DD'), '06/788 Mangal Path Tirupati', '05821927514', 'CQ', 'CNPM', 103, 6.6);

INSERT INTO SINHVIEN
VALUES ('SV21000994', 'Anika Venkataraman', 'Nam', to_date('1981-09-24', 'YYYY-MM-DD'), '58/56 Bhatti Chowk Khora ', '+919625445329', 'CLC', 'TGMT', 91, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21000995', 'Kaira Toor', 'N?', to_date('2016-03-14', 'YYYY-MM-DD'), '01 Karpe Marg Aizawl', '9131427277', 'CTTT', 'CNPM', 121, 5.59);

INSERT INTO SINHVIEN
VALUES ('SV21000996', 'Tarini Garde', 'Nam', to_date('1956-03-16', 'YYYY-MM-DD'), 'H.No. 682 Lall Mangalore', '9236494233', 'CLC', 'CNPM', 115, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21000997', 'Inaaya  Vaidya', 'Nam', to_date('1998-11-04', 'YYYY-MM-DD'), '44 Chatterjee Path Saharsa', '08916430666', 'CQ', 'HTTT', 104, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21000998', 'Dishani Cheema', 'Nam', to_date('1968-03-24', 'YYYY-MM-DD'), 'H.No. 709 Bansal Nagar Ghaziabad', '+911428418860', 'VP', 'MMT', 41, 4.82);

INSERT INTO SINHVIEN
VALUES ('SV21000999', 'Mishti Dutta', 'N?', to_date('1986-07-11', 'YYYY-MM-DD'), '66/243 Dhar Marg Cuttack', '03094337729', 'CTTT', 'CNTT', 19, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21001000', 'Navya Mall', 'Nam', to_date('1973-12-14', 'YYYY-MM-DD'), '49/933 Contractor Hospet', '06245887199', 'CQ', 'KHMT', 125, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21001001', 'Hunar Doctor', 'Nam', to_date('2018-10-07', 'YYYY-MM-DD'), '14 Sheth Chowk Pudukkottai', '4515198525', 'CLC', 'KHMT', 57, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21001002', 'Pihu Hayer', 'Nam', to_date('2009-09-08', 'YYYY-MM-DD'), '70 Dara Zila Jorhat', '01882700714', 'CTTT', 'MMT', 4, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21001003', 'Vihaan Karnik', 'Nam', to_date('1958-06-23', 'YYYY-MM-DD'), 'H.No. 831 Atwal Circle Tirupati', '05044543688', 'CQ', 'CNPM', 51, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21001004', 'Ahana  Som', 'N?', to_date('2023-10-29', 'YYYY-MM-DD'), 'H.No. 494 Gour Chowk Guna', '+919774016625', 'CLC', 'CNPM', 103, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21001005', 'Ranbir Desai', 'N?', to_date('1994-08-21', 'YYYY-MM-DD'), 'H.No. 80 Apte Nagar Nizamabad', '+912225558865', 'CLC', 'HTTT', 65, 9.26);

INSERT INTO SINHVIEN
VALUES ('SV21001006', 'Kimaya Rao', 'N?', to_date('2017-03-09', 'YYYY-MM-DD'), 'H.No. 19 D��Alia Zila Chennai', '02651062402', 'CQ', 'MMT', 18, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21001007', 'Ryan Dalal', 'Nam', to_date('2012-08-23', 'YYYY-MM-DD'), 'H.No. 18 Badami Ganj Patna', '+911678777077', 'CLC', 'MMT', 40, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21001008', 'Keya Chhabra', 'Nam', to_date('1980-01-10', 'YYYY-MM-DD'), '66/640 Manda Road Tiruchirappalli', '08046239476', 'CLC', 'CNTT', 118, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21001009', 'Oorja Din', 'N?', to_date('1977-07-31', 'YYYY-MM-DD'), '75/89 Chokshi Mau', '+910712087442', 'VP', 'CNTT', 39, 7.19);

INSERT INTO SINHVIEN
VALUES ('SV21001010', 'Ryan Balan', 'Nam', to_date('1985-10-12', 'YYYY-MM-DD'), '95/648 Mall Street Moradabad', '2188657927', 'CLC', 'CNTT', 126, 9.43);

INSERT INTO SINHVIEN
VALUES ('SV21001011', 'Neelofar Shenoy', 'Nam', to_date('1914-05-26', 'YYYY-MM-DD'), 'H.No. 00 Shetty Circle Etawah', '+913188666530', 'CTTT', 'TGMT', 62, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21001012', 'Pihu Gaba', 'Nam', to_date('1931-06-11', 'YYYY-MM-DD'), '37/576 Ramesh Ganj Mathura', '+917913183517', 'CLC', 'CNPM', 70, 8.65);

INSERT INTO SINHVIEN
VALUES ('SV21001013', 'Stuvan Warrior', 'N?', to_date('2009-06-02', 'YYYY-MM-DD'), '02/361 Hans Ganj Shimoga', '9364948333', 'CLC', 'TGMT', 51, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21001014', 'Riya Kar', 'Nam', to_date('1965-07-15', 'YYYY-MM-DD'), 'H.No. 211 Krishna Nagar Thane', '01863961296', 'CTTT', 'TGMT', 108, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21001015', 'Rasha Chadha', 'N?', to_date('2011-06-11', 'YYYY-MM-DD'), 'H.No. 18 Buch Zila Amritsar', '+910078648674', 'CQ', 'HTTT', 68, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21001016', 'Gatik Karnik', 'Nam', to_date('1963-09-30', 'YYYY-MM-DD'), 'H.No. 542 Goyal Chowk Adoni', '4144570732', 'CQ', 'CNPM', 33, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21001017', 'Rati Balakrishnan', 'Nam', to_date('1966-03-06', 'YYYY-MM-DD'), 'H.No. 30 Gole Ganj Hospet', '+919547654791', 'CTTT', 'TGMT', 99, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21001018', 'Parinaaz Samra', 'Nam', to_date('1911-11-26', 'YYYY-MM-DD'), '91 Majumdar Marg Hapur', '2322159235', 'CLC', 'CNTT', 126, 9.38);

INSERT INTO SINHVIEN
VALUES ('SV21001019', 'Nitya Khosla', 'N?', to_date('2011-01-04', 'YYYY-MM-DD'), '265 Sant Kurnool', '+914752147293', 'CTTT', 'CNTT', 130, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21001020', 'Diya Guha', 'N?', to_date('1922-07-11', 'YYYY-MM-DD'), '72/707 Samra Zila Durgapur', '+911821615881', 'CTTT', 'HTTT', 73, 5.4);

INSERT INTO SINHVIEN
VALUES ('SV21001021', 'Yuvaan Sawhney', 'N?', to_date('2013-04-13', 'YYYY-MM-DD'), '62 Gera Ganj Malda', '+913978168035', 'VP', 'KHMT', 73, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21001022', 'Yuvaan Dalal', 'N?', to_date('2008-03-30', 'YYYY-MM-DD'), '47 Chand Path Indore', '5544541307', 'CTTT', 'CNTT', 39, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21001023', 'Kismat Ahluwalia', 'N?', to_date('1913-06-13', 'YYYY-MM-DD'), 'H.No. 614 Sur Path Ratlam', '5859054322', 'CQ', 'MMT', 47, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001024', 'Nitara Lal', 'Nam', to_date('1965-09-17', 'YYYY-MM-DD'), '68/98 Thakur Street Guntur', '01210210869', 'CLC', 'HTTT', 131, 5.12);

INSERT INTO SINHVIEN
VALUES ('SV21001025', 'Amani Krishnan', 'N?', to_date('1983-10-31', 'YYYY-MM-DD'), 'H.No. 921 Chhabra Ganj Kharagpur', '4832669625', 'CLC', 'HTTT', 125, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21001026', 'Samar Dubey', 'N?', to_date('1969-10-29', 'YYYY-MM-DD'), '49 Shukla Path Nellore', '05932500717', 'CTTT', 'TGMT', 18, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21001027', 'Vivaan Vaidya', 'Nam', to_date('2003-03-04', 'YYYY-MM-DD'), 'H.No. 567 Thakur Zila Khandwa', '0615728319', 'CQ', 'TGMT', 42, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21001028', 'Stuvan Rama', 'N?', to_date('1934-09-24', 'YYYY-MM-DD'), 'H.No. 927 Kara Nagar Mangalore', '7141229578', 'CLC', 'CNTT', 23, 7.22);

INSERT INTO SINHVIEN
VALUES ('SV21001029', 'Kimaya Iyer', 'N?', to_date('1975-01-27', 'YYYY-MM-DD'), '82 Sane Ganj Durgapur', '5092652542', 'VP', 'KHMT', 7, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21001030', 'Ivana Shukla', 'Nam', to_date('1998-08-06', 'YYYY-MM-DD'), '95/77 Bhatia Road Bahraich', '08888996408', 'CQ', 'KHMT', 95, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21001031', 'Vardaniya Rama', 'N?', to_date('1966-01-01', 'YYYY-MM-DD'), '73/95 Srinivasan Zila Bhopal', '2137628800', 'CLC', 'CNTT', 42, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21001032', 'Anahita Chandran', 'N?', to_date('1912-12-22', 'YYYY-MM-DD'), '80/20 Varghese Zila Varanasi', '+915257049423', 'CLC', 'HTTT', 81, 7.24);

INSERT INTO SINHVIEN
VALUES ('SV21001033', 'Kabir Ramachandran', 'N?', to_date('2005-12-31', 'YYYY-MM-DD'), '30/75 Venkatesh Marg Chandrapur', '01683279117', 'CLC', 'TGMT', 24, 6.6);

INSERT INTO SINHVIEN
VALUES ('SV21001034', 'Pranay Wable', 'Nam', to_date('1962-12-12', 'YYYY-MM-DD'), '72/67 Issac Street Jaunpur', '+914158286534', 'CLC', 'TGMT', 118, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21001035', 'Armaan Sura', 'N?', to_date('2014-06-19', 'YYYY-MM-DD'), 'H.No. 852 Basu Street Karnal', '+914065880085', 'VP', 'MMT', 58, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21001036', 'Samiha Agate', 'Nam', to_date('1942-08-05', 'YYYY-MM-DD'), 'H.No. 182 Venkataraman Ganj Nandyal', '3660878913', 'VP', 'KHMT', 133, 9.41);

INSERT INTO SINHVIEN
VALUES ('SV21001037', 'Nehmat Desai', 'N?', to_date('1954-01-28', 'YYYY-MM-DD'), '834 Sankar Road Adoni', '08788542819', 'CQ', 'KHMT', 43, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21001038', 'Adira Dyal', 'N?', to_date('1944-05-27', 'YYYY-MM-DD'), '97 Dutt Marg Nagpur', '07459657825', 'CTTT', 'CNTT', 42, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21001039', 'Tejas Virk', 'Nam', to_date('2009-03-01', 'YYYY-MM-DD'), '591 Rout Chowk Firozabad', '3418146069', 'CTTT', 'CNTT', 101, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21001040', 'Kabir Bala', 'Nam', to_date('1947-05-22', 'YYYY-MM-DD'), '37 Handa Thane', '+914037008735', 'CLC', 'KHMT', 60, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21001041', 'Parinaaz Mangal', 'Nam', to_date('1943-03-31', 'YYYY-MM-DD'), 'H.No. 910 Lad Tadipatri', '01868790483', 'VP', 'MMT', 76, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21001042', 'Tarini Bajwa', 'N?', to_date('2008-05-03', 'YYYY-MM-DD'), '13 Randhawa Marg Dindigul', '06915153890', 'CQ', 'TGMT', 79, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21001043', 'Vihaan Iyer', 'N?', to_date('1986-04-02', 'YYYY-MM-DD'), '25/93 Hayer Circle Pallavaram', '07326065982', 'CLC', 'HTTT', 59, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21001044', 'Tiya Grewal', 'Nam', to_date('1921-10-05', 'YYYY-MM-DD'), 'H.No. 61 Babu Road Gangtok', '3608765908', 'CQ', 'TGMT', 73, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21001045', 'Ishita Wason', 'N?', to_date('1946-05-18', 'YYYY-MM-DD'), '27/743 Mani Road Kolkata', '3374837072', 'CQ', 'CNPM', 31, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21001046', 'Lakshay Singh', 'N?', to_date('2015-04-22', 'YYYY-MM-DD'), '15 Mangat Chowk Hazaribagh', '09447240249', 'CLC', 'MMT', 65, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21001047', 'Alia Shroff', 'N?', to_date('2017-07-11', 'YYYY-MM-DD'), '99/925 Lad Marg Aizawl', '6864442910', 'CTTT', 'CNTT', 56, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21001048', 'Samarth Goel', 'N?', to_date('1948-02-19', 'YYYY-MM-DD'), '73/27 Atwal Road South Dumdum', '+915607416294', 'CTTT', 'MMT', 80, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21001049', 'Shaan Rajan', 'N?', to_date('1972-06-16', 'YYYY-MM-DD'), 'H.No. 186 Shetty Path Mangalore', '7085591200', 'CLC', 'TGMT', 87, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21001050', 'Shayak Gaba', 'N?', to_date('1977-12-30', 'YYYY-MM-DD'), '38/277 Grewal Circle Phagwara', '+918749670708', 'CTTT', 'CNTT', 19, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21001051', 'Rasha Loke', 'Nam', to_date('1932-03-12', 'YYYY-MM-DD'), 'H.No. 646 Sekhon Zila Bhatpara', '+919348241594', 'CTTT', 'HTTT', 84, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21001052', 'Dishani Dhar', 'Nam', to_date('2002-05-24', 'YYYY-MM-DD'), '69/841 Shroff Zila Thane', '8424825592', 'CQ', 'HTTT', 66, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21001053', 'Suhana Shankar', 'N?', to_date('1924-09-11', 'YYYY-MM-DD'), '839 Sur Ganj Moradabad', '6656296860', 'CQ', 'HTTT', 130, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21001054', 'Miraya Bal', 'N?', to_date('1959-03-30', 'YYYY-MM-DD'), 'H.No. 57 Anand Panvel', '+912683564956', 'CTTT', 'HTTT', 41, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21001055', 'Vivaan Mammen', 'N?', to_date('2008-05-17', 'YYYY-MM-DD'), 'H.No. 79 Kohli Ganj Bhagalpur', '+915036952100', 'CTTT', 'TGMT', 49, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21001056', 'Nayantara Thakur', 'N?', to_date('1953-05-29', 'YYYY-MM-DD'), '56/24 Ranganathan Naihati', '06419942933', 'CLC', 'CNTT', 36, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21001057', 'Drishya Sarma', 'N?', to_date('2016-12-26', 'YYYY-MM-DD'), '99/46 Sura Marg Pallavaram', '+910188567696', 'CTTT', 'TGMT', 11, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21001058', 'Baiju Mani', 'Nam', to_date('1980-01-31', 'YYYY-MM-DD'), '042 Badami Street Singrauli', '9793305484', 'CQ', 'CNTT', 123, 8.65);

INSERT INTO SINHVIEN
VALUES ('SV21001059', 'Prisha Reddy', 'N?', to_date('1910-04-18', 'YYYY-MM-DD'), '85/08 Cherian Ganj Bongaigaon', '03810618532', 'CQ', 'TGMT', 111, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21001060', 'Aarush Sama', 'N?', to_date('2010-02-15', 'YYYY-MM-DD'), 'H.No. 01 Bala Zila Motihari', '+913499271969', 'CTTT', 'CNTT', 66, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21001061', 'Yuvaan Talwar', 'N?', to_date('1985-07-01', 'YYYY-MM-DD'), 'H.No. 38 Shanker Ganj Avadi', '+917974814289', 'CLC', 'KHMT', 4, 7.19);

INSERT INTO SINHVIEN
VALUES ('SV21001062', 'Jayesh Mann', 'Nam', to_date('1915-03-22', 'YYYY-MM-DD'), '49 Wason Nagar Bhiwandi', '08702650600', 'CLC', 'HTTT', 125, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21001063', 'Kismat Thaker', 'Nam', to_date('1958-08-25', 'YYYY-MM-DD'), '296 Batra Nagar Kadapa', '+910210764099', 'VP', 'CNTT', 116, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21001064', 'Baiju Shetty', 'N?', to_date('2004-10-14', 'YYYY-MM-DD'), '818 Dey Marg Kharagpur', '4011286823', 'CQ', 'CNPM', 53, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21001065', 'Kiaan Sagar', 'Nam', to_date('1997-02-24', 'YYYY-MM-DD'), '59/859 Hegde Nagar Bidhannagar', '+913278539944', 'CLC', 'CNPM', 66, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21001066', 'Shayak Krish', 'Nam', to_date('1984-10-10', 'YYYY-MM-DD'), '51/18 Chada Ganj Satna', '07974077129', 'CLC', 'CNTT', 49, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21001067', 'Hiran Guha', 'Nam', to_date('2011-02-01', 'YYYY-MM-DD'), '47/13 Kala Street Bahraich', '1005550397', 'CTTT', 'KHMT', 124, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21001068', 'Miraya Mander', 'Nam', to_date('1953-02-11', 'YYYY-MM-DD'), 'H.No. 79 Sani Marg Vadodara', '7591047067', 'CLC', 'MMT', 74, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001069', 'Arnav Ratta', 'N?', to_date('1938-07-28', 'YYYY-MM-DD'), '04 Devan Ganj Bulandshahr', '04327838140', 'CTTT', 'CNPM', 48, 6.24);

INSERT INTO SINHVIEN
VALUES ('SV21001070', 'Lakshit Dara', 'Nam', to_date('1973-04-28', 'YYYY-MM-DD'), '22/074 Cherian Path Bidar', '3311559073', 'CLC', 'MMT', 4, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21001071', 'Elakshi Tailor', 'Nam', to_date('1935-01-19', 'YYYY-MM-DD'), '26/92 Rout Nagar Hosur', '3491589165', 'CTTT', 'TGMT', 1, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21001072', 'Mahika Mall', 'Nam', to_date('2014-11-23', 'YYYY-MM-DD'), '43/47 Savant Road Bally', '0207916862', 'VP', 'CNTT', 125, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21001073', 'Keya Aurora', 'Nam', to_date('1963-01-13', 'YYYY-MM-DD'), 'H.No. 725 Agate Hindupur', '+917468829959', 'CQ', 'CNTT', 76, 5.16);

INSERT INTO SINHVIEN
VALUES ('SV21001074', 'Romil Shroff', 'N?', to_date('2008-10-03', 'YYYY-MM-DD'), 'H.No. 515 Varkey Chowk Warangal', '+917666931560', 'CQ', 'TGMT', 103, 7.7);

INSERT INTO SINHVIEN
VALUES ('SV21001075', 'Mamooty Sastry', 'N?', to_date('2020-12-13', 'YYYY-MM-DD'), 'H.No. 34 Sahota Circle Guna', '5174150196', 'VP', 'KHMT', 36, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21001076', 'Yakshit Deep', 'Nam', to_date('1975-08-18', 'YYYY-MM-DD'), '27 Rajagopalan Kolkata', '2262163156', 'VP', 'KHMT', 117, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21001077', 'Samarth De', 'N?', to_date('2002-11-08', 'YYYY-MM-DD'), '70/05 Baria Circle Gudivada', '+910224341453', 'CQ', 'TGMT', 20, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21001078', 'Ehsaan Bhalla', 'Nam', to_date('1940-03-10', 'YYYY-MM-DD'), 'H.No. 524 Rege Marg Bhopal', '+911250700154', 'CTTT', 'MMT', 52, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21001079', 'Stuvan Cherian', 'Nam', to_date('2022-05-11', 'YYYY-MM-DD'), 'H.No. 665 Behl Street Rewa', '3091401552', 'VP', 'CNTT', 107, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21001080', 'Hansh Vaidya', 'Nam', to_date('1988-05-06', 'YYYY-MM-DD'), '57 Sekhon Chowk Chinsurah', '00750476180', 'CQ', 'KHMT', 88, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21001081', 'Anvi Gill', 'Nam', to_date('1995-03-09', 'YYYY-MM-DD'), '54/86 Halder Circle Ramagundam', '09377139706', 'CQ', 'CNTT', 48, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21001082', 'Rania Dhar', 'Nam', to_date('1952-11-23', 'YYYY-MM-DD'), '23/452 Date Nagar Hindupur', '+916865045748', 'CLC', 'MMT', 86, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21001083', 'Indrajit Khare', 'N?', to_date('1914-05-19', 'YYYY-MM-DD'), '178 Sama Nagar Rajahmundry', '9559724959', 'CTTT', 'TGMT', 123, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21001084', 'Rati Bakshi', 'N?', to_date('1955-06-15', 'YYYY-MM-DD'), '54/822 Yadav Ganj Kulti', '+910934347115', 'CTTT', 'TGMT', 14, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21001085', 'Kavya Banerjee', 'Nam', to_date('2015-10-16', 'YYYY-MM-DD'), '99/940 Dave Circle Madanapalle', '+912603988971', 'CQ', 'TGMT', 123, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21001086', 'Abram Sibal', 'Nam', to_date('2017-02-22', 'YYYY-MM-DD'), '44 Varughese Ganj Saharsa', '9697692831', 'CTTT', 'CNTT', 136, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21001087', 'Diya Devi', 'N?', to_date('1953-12-30', 'YYYY-MM-DD'), '48 Karan Marg Bhatpara', '0928573070', 'VP', 'KHMT', 6, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21001088', 'Saira Dugar', 'Nam', to_date('2018-03-31', 'YYYY-MM-DD'), '89/207 Sengupta Zila Chinsurah', '+918762874107', 'CTTT', 'KHMT', 112, 4.97);

INSERT INTO SINHVIEN
VALUES ('SV21001089', 'Urvi Sagar', 'N?', to_date('2004-04-10', 'YYYY-MM-DD'), '64/422 Batta Marg Begusarai', '+919008275408', 'CLC', 'CNPM', 102, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21001090', 'Piya Buch', 'Nam', to_date('1931-11-17', 'YYYY-MM-DD'), '11 Doctor Circle Ballia', '06431993470', 'VP', 'MMT', 52, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21001091', 'Ivan Sura', 'N?', to_date('1918-05-17', 'YYYY-MM-DD'), '74/73 Sastry Ganj Amaravati', '4063221820', 'VP', 'TGMT', 56, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21001092', 'Pihu Ravi', 'N?', to_date('1935-04-29', 'YYYY-MM-DD'), 'H.No. 16 Hans Nagar Satara', '+915769151554', 'CTTT', 'MMT', 30, 6.91);

INSERT INTO SINHVIEN
VALUES ('SV21001093', 'Amani Date', 'Nam', to_date('1914-05-19', 'YYYY-MM-DD'), 'H.No. 91 Varty Marg Khora ', '6857942938', 'VP', 'TGMT', 71, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21001094', 'Lakshit Chad', 'N?', to_date('2011-08-14', 'YYYY-MM-DD'), '63 Edwin Road Kolhapur', '+912018185396', 'CTTT', 'CNPM', 54, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21001095', 'Nitara Mahal', 'N?', to_date('1974-04-17', 'YYYY-MM-DD'), '40 Sandhu Path Ambattur', '09381868413', 'VP', 'KHMT', 115, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21001096', 'Dharmajan Bumb', 'N?', to_date('1932-06-04', 'YYYY-MM-DD'), '19 Jayaraman Circle Malda', '+910206371450', 'CQ', 'HTTT', 129, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21001097', 'Tarini D��Alia', 'Nam', to_date('1922-05-28', 'YYYY-MM-DD'), '542 Ratta Chowk Varanasi', '+912260992772', 'VP', 'TGMT', 52, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21001098', 'Siya Dua', 'Nam', to_date('1937-06-12', 'YYYY-MM-DD'), '91 Comar Street Chinsurah', '+918423343612', 'CTTT', 'TGMT', 136, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21001099', 'Prerak Chander', 'N?', to_date('1985-04-18', 'YYYY-MM-DD'), 'H.No. 83 Majumdar Road Jaunpur', '09458615963', 'CTTT', 'HTTT', 100, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21001100', 'Gatik Majumdar', 'Nam', to_date('1988-02-03', 'YYYY-MM-DD'), '89 Varughese Path Madanapalle', '+912239135281', 'VP', 'HTTT', 110, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21001101', 'Ojas Vora', 'N?', to_date('1953-04-08', 'YYYY-MM-DD'), 'H.No. 02 Karpe Zila Chennai', '+914951206972', 'CQ', 'MMT', 1, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21001102', 'Urvi Bal', 'N?', to_date('1974-07-20', 'YYYY-MM-DD'), '536 Amble Road Kulti', '+918210943944', 'CLC', 'TGMT', 70, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21001103', 'Umang Raval', 'N?', to_date('1997-02-19', 'YYYY-MM-DD'), '59 Deshmukh Road Kadapa', '6560210142', 'CQ', 'TGMT', 54, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21001104', 'Tiya Dayal', 'Nam', to_date('2009-12-17', 'YYYY-MM-DD'), 'H.No. 061 Chandran Jamnagar', '4954543048', 'CLC', 'CNPM', 20, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21001105', 'Devansh Deshpande', 'Nam', to_date('1987-04-06', 'YYYY-MM-DD'), 'H.No. 384 Barman Gaya', '07544671687', 'CQ', 'MMT', 13, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21001106', 'Faiyaz Mangal', 'N?', to_date('2004-09-29', 'YYYY-MM-DD'), '50/412 Chokshi Chowk Parbhani', '+910743168587', 'CLC', 'TGMT', 43, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21001107', 'Yakshit Varghese', 'Nam', to_date('1974-10-04', 'YYYY-MM-DD'), 'H.No. 496 Kashyap Street Singrauli', '9653247172', 'CLC', 'CNTT', 55, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21001108', 'Miraya Anand', 'Nam', to_date('1997-10-17', 'YYYY-MM-DD'), '58/05 Chanda Street Durgapur', '+911854240025', 'CQ', 'TGMT', 63, 8.15);

INSERT INTO SINHVIEN
VALUES ('SV21001109', 'Oorja Deol', 'Nam', to_date('1912-08-04', 'YYYY-MM-DD'), 'H.No. 174 Jaggi Nagar Kollam', '04072237251', 'CQ', 'MMT', 92, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21001110', 'Shayak Tripathi', 'N?', to_date('1931-12-10', 'YYYY-MM-DD'), '53 Chaudhry Chowk Vijayawada', '0317732848', 'VP', 'KHMT', 115, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21001111', 'Mannat Chana', 'Nam', to_date('2011-02-20', 'YYYY-MM-DD'), '34/40 Lata Path Ahmednagar', '+910229048568', 'CQ', 'TGMT', 21, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21001112', 'Nitara Issac', 'Nam', to_date('2018-11-12', 'YYYY-MM-DD'), 'H.No. 37 Dugal Path Ulhasnagar', '+915792038718', 'VP', 'MMT', 39, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21001113', 'Uthkarsh Wable', 'N?', to_date('1968-12-13', 'YYYY-MM-DD'), 'H.No. 11 Sehgal Zila Gangtok', '8472149089', 'VP', 'KHMT', 72, 6.2);

INSERT INTO SINHVIEN
VALUES ('SV21001114', 'Manjari Sharaf', 'N?', to_date('1924-04-22', 'YYYY-MM-DD'), 'H.No. 415 Sandal Zila Jamnagar', '09366911102', 'CQ', 'TGMT', 53, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21001115', 'Aarna Sem', 'N?', to_date('2021-01-19', 'YYYY-MM-DD'), '47/262 Chawla Road Erode', '+910652607113', 'VP', 'KHMT', 13, 9.58);

INSERT INTO SINHVIEN
VALUES ('SV21001116', 'Mahika Halder', 'Nam', to_date('1966-04-26', 'YYYY-MM-DD'), 'H.No. 922 Iyer Chowk Gorakhpur', '+919449452649', 'CTTT', 'MMT', 1, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21001117', 'Riaan Gera', 'Nam', to_date('2019-01-15', 'YYYY-MM-DD'), '53/915 Shenoy Marg Nagaon', '5321317727', 'CQ', 'KHMT', 34, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21001118', 'Saksham Sabharwal', 'N?', to_date('1927-09-06', 'YYYY-MM-DD'), '88/74 Hegde Nagar Guna', '06413286722', 'VP', 'CNPM', 52, 7.31);

INSERT INTO SINHVIEN
VALUES ('SV21001119', 'Nitara Chada', 'Nam', to_date('2009-08-27', 'YYYY-MM-DD'), '90/715 Dani Zila Karimnagar', '2179608522', 'CQ', 'HTTT', 80, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21001120', 'Jiya Bansal', 'N?', to_date('2011-09-06', 'YYYY-MM-DD'), '86/415 Bose Zila Tenali', '04241607636', 'CQ', 'HTTT', 60, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21001121', 'Jhanvi Bhatti', 'Nam', to_date('1913-07-26', 'YYYY-MM-DD'), '42 Ganesan Road Giridih', '6875879525', 'CTTT', 'MMT', 51, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21001122', 'Yuvraj  Barad', 'N?', to_date('1933-10-11', 'YYYY-MM-DD'), 'H.No. 09 Thakkar Street Gopalpur', '+916382965134', 'CTTT', 'TGMT', 70, 5.99);

INSERT INTO SINHVIEN
VALUES ('SV21001123', 'Kimaya Wable', 'Nam', to_date('1942-07-23', 'YYYY-MM-DD'), '33/00 Sem Ganj Erode', '02492653564', 'VP', 'CNTT', 96, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21001124', 'Pihu Sunder', 'N?', to_date('1959-07-01', 'YYYY-MM-DD'), '639 Kashyap Street Durg', '8353435795', 'VP', 'HTTT', 110, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21001125', 'Azad Deep', 'N?', to_date('1953-12-06', 'YYYY-MM-DD'), '81 Din Marg Miryalaguda', '09552999749', 'CQ', 'MMT', 63, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21001126', 'Aniruddh Tella', 'N?', to_date('1954-10-13', 'YYYY-MM-DD'), 'H.No. 68 Keer Ganj Muzaffarnagar', '+916847638163', 'CQ', 'CNPM', 16, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21001127', 'Aniruddh Dhillon', 'Nam', to_date('1963-05-26', 'YYYY-MM-DD'), '51 Gupta Circle Tinsukia', '08597573290', 'CTTT', 'HTTT', 21, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21001128', 'Vivaan Dewan', 'Nam', to_date('1949-01-29', 'YYYY-MM-DD'), 'H.No. 139 De Road Raurkela Industrial Township', '0400856372', 'CLC', 'CNTT', 6, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21001129', 'Tushar Saini', 'Nam', to_date('1980-06-16', 'YYYY-MM-DD'), 'H.No. 412 Arora Chowk Kharagpur', '06505163944', 'VP', 'KHMT', 117, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21001130', 'Alia Sarna', 'Nam', to_date('1914-09-15', 'YYYY-MM-DD'), '04 Bobal Bhind', '03420066278', 'CQ', 'TGMT', 21, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21001131', 'Armaan Sarkar', 'Nam', to_date('1990-10-28', 'YYYY-MM-DD'), '79/051 Mahal Path Davanagere', '+919954183390', 'CLC', 'CNPM', 125, 8.46);

INSERT INTO SINHVIEN
VALUES ('SV21001132', 'Arhaan Dhaliwal', 'N?', to_date('1919-05-13', 'YYYY-MM-DD'), 'H.No. 51 Bahri Giridih', '+916783273483', 'VP', 'KHMT', 11, 4.97);

INSERT INTO SINHVIEN
VALUES ('SV21001133', 'Anahita Varghese', 'Nam', to_date('1981-03-25', 'YYYY-MM-DD'), '92/719 Hayer Marg Hajipur', '8613414233', 'CQ', 'KHMT', 70, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21001134', 'Romil Lad', 'N?', to_date('1990-07-10', 'YYYY-MM-DD'), '878 Rama Marg Indore', '3732346747', 'VP', 'CNTT', 19, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21001135', 'Reyansh Sami', 'Nam', to_date('1987-03-31', 'YYYY-MM-DD'), '05 Virk Guntur', '+911601596729', 'CQ', 'CNPM', 16, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21001136', 'Jayesh Khare', 'N?', to_date('2004-10-02', 'YYYY-MM-DD'), 'H.No. 743 Bawa Path Lucknow', '0331090340', 'VP', 'HTTT', 60, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21001137', 'Ehsaan Kala', 'Nam', to_date('1928-07-17', 'YYYY-MM-DD'), '87/293 Savant Road Tiruvottiyur', '+910256853289', 'CQ', 'MMT', 131, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21001138', 'Aayush Vaidya', 'Nam', to_date('1959-06-04', 'YYYY-MM-DD'), '33 Sankar Street Bellary', '6387956094', 'CTTT', 'KHMT', 101, 6.28);

INSERT INTO SINHVIEN
VALUES ('SV21001139', 'Seher Maharaj', 'N?', to_date('2013-03-11', 'YYYY-MM-DD'), '11/797 Bains Street Kakinada', '+913454306729', 'CLC', 'KHMT', 21, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21001140', 'Aayush Dayal', 'N?', to_date('1988-04-01', 'YYYY-MM-DD'), '151 Karnik Marg Adoni', '03551877512', 'CLC', 'CNPM', 137, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21001141', 'Anahita Vaidya', 'N?', to_date('1953-12-22', 'YYYY-MM-DD'), 'H.No. 25 Bhatnagar Marg Amravati', '+918625607792', 'CQ', 'TGMT', 101, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21001142', 'Jiya Warrior', 'N?', to_date('1978-05-25', 'YYYY-MM-DD'), 'H.No. 027 Ravel Circle Hapur', '02893939354', 'VP', 'TGMT', 24, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21001143', 'Umang Sehgal', 'Nam', to_date('1980-02-14', 'YYYY-MM-DD'), '00/73 Sagar Nagar Chennai', '+913917903770', 'VP', 'TGMT', 120, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21001144', 'Myra Kalita', 'N?', to_date('1925-12-17', 'YYYY-MM-DD'), 'H.No. 987 Boase Zila Durgapur', '09739792124', 'CLC', 'KHMT', 33, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21001145', 'Jivika Randhawa', 'N?', to_date('1955-07-02', 'YYYY-MM-DD'), '81/233 Sur Patiala', '00690631751', 'CQ', 'CNPM', 4, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21001146', 'Vivaan Kapadia', 'N?', to_date('1944-01-17', 'YYYY-MM-DD'), 'H.No. 533 Gokhale Chowk Tumkur', '0447210137', 'CQ', 'HTTT', 69, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21001147', 'Anay Sachar', 'N?', to_date('1979-03-17', 'YYYY-MM-DD'), '62/26 Krishnamurthy Korba', '3948044531', 'CTTT', 'HTTT', 72, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21001148', 'Rati Joshi', 'N?', to_date('1958-12-31', 'YYYY-MM-DD'), '10 Kannan Circle Tinsukia', '06223679122', 'CLC', 'KHMT', 120, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21001149', 'Ivan Badal', 'Nam', to_date('1928-05-22', 'YYYY-MM-DD'), 'H.No. 88 Sridhar Ganj Ramagundam', '+916282207475', 'CLC', 'CNPM', 37, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21001150', 'Himmat Keer', 'N?', to_date('2010-11-19', 'YYYY-MM-DD'), '81 Kibe Street Nellore', '08921314750', 'CTTT', 'TGMT', 28, 4.02);

INSERT INTO SINHVIEN
VALUES ('SV21001151', 'Rasha Sethi', 'N?', to_date('1966-11-15', 'YYYY-MM-DD'), 'H.No. 76 Varughese Nagar Saharanpur', '08154579235', 'CLC', 'TGMT', 123, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21001152', 'Drishya Ravi', 'Nam', to_date('1948-04-17', 'YYYY-MM-DD'), '40 Shan Zila Sasaram', '05163443825', 'CLC', 'KHMT', 35, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21001153', 'Rati Khosla', 'N?', to_date('1952-05-03', 'YYYY-MM-DD'), 'H.No. 493 Karan Street Pimpri-Chinchwad', '06639157384', 'CQ', 'CNTT', 12, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21001154', 'Anahi Bahl', 'N?', to_date('2011-06-20', 'YYYY-MM-DD'), '545 Dhar Chowk Dindigul', '2490690090', 'CQ', 'CNPM', 76, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21001155', 'Mishti Hari', 'N?', to_date('1991-11-24', 'YYYY-MM-DD'), '024 Guha Path Bhalswa Jahangir Pur', '03891995309', 'CLC', 'MMT', 20, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21001156', 'Mehul Brar', 'N?', to_date('1973-11-23', 'YYYY-MM-DD'), '710 Kalla Ganj Tenali', '00358024920', 'CTTT', 'MMT', 90, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21001157', 'Aaina Gera', 'Nam', to_date('2011-04-06', 'YYYY-MM-DD'), '04/20 Kulkarni Path Bilaspur', '+919895154136', 'CLC', 'TGMT', 72, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21001158', 'Misha Chhabra', 'Nam', to_date('1943-02-06', 'YYYY-MM-DD'), '69/501 Kale Zila Loni', '+917923012969', 'CTTT', 'CNTT', 85, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21001159', 'Oorja Chaudhary', 'N?', to_date('1928-02-07', 'YYYY-MM-DD'), 'H.No. 06 Behl Road Bhind', '06566532371', 'VP', 'MMT', 7, 5.14);

INSERT INTO SINHVIEN
VALUES ('SV21001160', 'Aarna Baria', 'Nam', to_date('1993-02-13', 'YYYY-MM-DD'), '05/695 Bedi Nagar Bidhannagar', '9324816573', 'CTTT', 'MMT', 60, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21001161', 'Piya Dayal', 'Nam', to_date('1972-04-11', 'YYYY-MM-DD'), 'H.No. 218 Shetty Nagar Sambalpur', '+914048958686', 'CQ', 'CNPM', 112, 4.08);

INSERT INTO SINHVIEN
VALUES ('SV21001162', 'Jayan Ram', 'N?', to_date('1942-01-16', 'YYYY-MM-DD'), 'H.No. 590 Kamdar Nagar Kumbakonam', '+917468469740', 'CTTT', 'TGMT', 85, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21001163', 'Jivin Varughese', 'N?', to_date('2020-01-07', 'YYYY-MM-DD'), '59 Upadhyay Ganj Naihati', '00476362221', 'CQ', 'TGMT', 20, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21001164', 'Shamik Master', 'Nam', to_date('1994-11-04', 'YYYY-MM-DD'), '606 Dyal Road Hosur', '04098477091', 'VP', 'CNTT', 119, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21001165', 'Vivaan Sani', 'Nam', to_date('1942-08-25', 'YYYY-MM-DD'), '191 Sarna Circle Kozhikode', '6199267192', 'CLC', 'CNPM', 40, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21001166', 'Pihu Roy', 'Nam', to_date('1924-09-07', 'YYYY-MM-DD'), '285 Handa Street Karaikudi', '04414810102', 'CQ', 'KHMT', 132, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21001167', 'Eshani Yogi', 'Nam', to_date('1973-03-02', 'YYYY-MM-DD'), '76/92 Deep Marg Rajpur Sonarpur', '0937813897', 'VP', 'CNTT', 26, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21001168', 'Eshani D��Alia', 'N?', to_date('2016-01-24', 'YYYY-MM-DD'), 'H.No. 448 Raja Nagar Saharanpur', '+919649510227', 'VP', 'MMT', 35, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21001169', 'Jhanvi Kashyap', 'Nam', to_date('1958-07-30', 'YYYY-MM-DD'), 'H.No. 63 Buch Circle Kulti', '7638910839', 'VP', 'MMT', 111, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001170', 'Gatik Swamy', 'Nam', to_date('2021-12-12', 'YYYY-MM-DD'), '22/033 Dewan Zila Vijayawada', '09017479820', 'CTTT', 'KHMT', 55, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001171', 'Tushar Acharya', 'N?', to_date('1961-02-10', 'YYYY-MM-DD'), '785 Chatterjee Road Uluberia', '5257652646', 'CTTT', 'KHMT', 129, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21001172', 'Sana Khare', 'N?', to_date('2023-04-23', 'YYYY-MM-DD'), '86/11 Taneja Path Rajkot', '+910935869769', 'CTTT', 'CNPM', 135, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21001173', 'Lavanya Khare', 'Nam', to_date('1991-02-06', 'YYYY-MM-DD'), 'H.No. 61 Saraf Nagar Darbhanga', '02943299622', 'CLC', 'CNTT', 98, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21001174', 'Anya Rattan', 'N?', to_date('1942-03-12', 'YYYY-MM-DD'), 'H.No. 25 Raman Ganj Surendranagar Dudhrej', '+919161408012', 'VP', 'MMT', 114, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21001175', 'Zara Bhatti', 'Nam', to_date('1933-07-13', 'YYYY-MM-DD'), 'H.No. 309 Bassi Purnia', '3272204666', 'CLC', 'TGMT', 11, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21001176', 'Akarsh Lala', 'N?', to_date('1982-05-13', 'YYYY-MM-DD'), '00/741 Maharaj Zila Tiruchirappalli', '02269178992', 'VP', 'CNPM', 54, 6.56);

INSERT INTO SINHVIEN
VALUES ('SV21001177', 'Anahita Subramanian', 'N?', to_date('1912-06-14', 'YYYY-MM-DD'), '319 Saini Durg', '+913402482473', 'CLC', 'MMT', 64, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21001178', 'Suhana Chana', 'Nam', to_date('1918-07-31', 'YYYY-MM-DD'), '975 Bawa Circle Muzaffarpur', '9460809485', 'CQ', 'HTTT', 137, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21001179', 'Miraya Sandhu', 'Nam', to_date('1998-06-19', 'YYYY-MM-DD'), '944 Brahmbhatt Jhansi', '0190634118', 'CTTT', 'MMT', 85, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21001180', 'Dishani Thaman', 'Nam', to_date('1913-10-18', 'YYYY-MM-DD'), 'H.No. 55 Venkataraman Nagar Saharsa', '+911872154538', 'VP', 'HTTT', 19, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21001181', 'Abram Kapur', 'N?', to_date('1921-03-03', 'YYYY-MM-DD'), 'H.No. 73 Kurian Zila Erode', '4215181225', 'VP', 'TGMT', 39, 8.02);

INSERT INTO SINHVIEN
VALUES ('SV21001182', 'Anya Suresh', 'N?', to_date('1931-06-06', 'YYYY-MM-DD'), '43 Kala Nagar Baranagar', '+913185012802', 'CTTT', 'KHMT', 55, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21001183', 'Vritika Choudhury', 'N?', to_date('1960-02-21', 'YYYY-MM-DD'), 'H.No. 50 Tiwari Marg Imphal', '9583468352', 'CQ', 'CNPM', 27, 9.12);

INSERT INTO SINHVIEN
VALUES ('SV21001184', 'Pihu Bhattacharyya', 'Nam', to_date('1953-11-04', 'YYYY-MM-DD'), '70/32 Sinha Zila Jamalpur', '04231708149', 'VP', 'TGMT', 51, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21001185', 'Mannat Khurana', 'Nam', to_date('2018-03-24', 'YYYY-MM-DD'), '76/00 Subramanian Ghaziabad', '3358836369', 'CLC', 'TGMT', 77, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21001186', 'Azad Sarkar', 'N?', to_date('1996-07-17', 'YYYY-MM-DD'), '139 Ganesan Pune', '7031875722', 'CTTT', 'CNPM', 99, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21001187', 'Priyansh Maharaj', 'Nam', to_date('1939-08-19', 'YYYY-MM-DD'), '689 Sankar Warangal', '01665902342', 'CLC', 'KHMT', 93, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21001188', 'Manjari Basu', 'N?', to_date('1999-09-30', 'YYYY-MM-DD'), 'H.No. 003 Tata Zila Jhansi', '+912909941843', 'CTTT', 'KHMT', 87, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21001189', 'Yuvraj  Chacko', 'N?', to_date('2002-01-16', 'YYYY-MM-DD'), 'H.No. 21 Kadakia Circle Mathura', '+914722871810', 'CQ', 'CNPM', 129, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21001190', 'Shaan Ramesh', 'N?', to_date('1948-11-22', 'YYYY-MM-DD'), 'H.No. 208 Hegde Path Nangloi Jat', '2736239349', 'CTTT', 'TGMT', 138, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001191', 'Miraan Ratti', 'Nam', to_date('1977-09-11', 'YYYY-MM-DD'), 'H.No. 165 Issac Path Thrissur', '+919373914062', 'CQ', 'MMT', 19, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21001192', 'Divit Kalla', 'N?', to_date('1967-01-01', 'YYYY-MM-DD'), '554 Sarna Path Sambhal', '7493182894', 'CTTT', 'MMT', 18, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21001193', 'Akarsh Gulati', 'N?', to_date('1920-06-20', 'YYYY-MM-DD'), '49/87 Hari Road Silchar', '+915564581042', 'CQ', 'CNTT', 56, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21001194', 'Dishani Kala', 'Nam', to_date('2000-09-19', 'YYYY-MM-DD'), 'H.No. 372 Garde Marg Amroha', '00529491130', 'CLC', 'CNTT', 31, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21001195', 'Onkar Chaudhari', 'N?', to_date('1937-11-04', 'YYYY-MM-DD'), '33/360 Majumdar Road Raiganj', '04320246874', 'CQ', 'HTTT', 45, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21001196', 'Shayak Dey', 'Nam', to_date('1936-08-05', 'YYYY-MM-DD'), 'H.No. 259 Kala Zila Rourkela', '5072069152', 'CTTT', 'CNPM', 135, 9.57);

INSERT INTO SINHVIEN
VALUES ('SV21001197', 'Misha Verma', 'Nam', to_date('1991-06-19', 'YYYY-MM-DD'), '19/45 Shah Zila Jorhat', '1688172285', 'CLC', 'HTTT', 89, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21001198', 'Indranil Goswami', 'Nam', to_date('1978-06-16', 'YYYY-MM-DD'), '182 Kalita Marg Farrukhabad', '7514532414', 'CTTT', 'CNTT', 39, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21001199', 'Ritvik Guha', 'Nam', to_date('1987-08-31', 'YYYY-MM-DD'), '38/385 Bhargava Path Ramgarh', '5398934265', 'CLC', 'HTTT', 24, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21001200', 'Kabir Datta', 'Nam', to_date('1911-10-09', 'YYYY-MM-DD'), '592 Borde Zila Tumkur', '+914835528519', 'CQ', 'CNTT', 76, 5.32);

INSERT INTO SINHVIEN
VALUES ('SV21001201', 'Bhavin Goda', 'Nam', to_date('1941-03-08', 'YYYY-MM-DD'), '86/901 Wali Ganj Buxar', '07471031076', 'VP', 'CNPM', 137, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21001202', 'Samarth Lata', 'N?', to_date('1925-08-20', 'YYYY-MM-DD'), 'H.No. 20 Kant Nagar Guntur', '3094772349', 'CTTT', 'CNTT', 45, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21001203', 'Elakshi Kaur', 'Nam', to_date('1951-02-13', 'YYYY-MM-DD'), '30/358 Balan Chowk Vasai-Virar', '+912443648639', 'VP', 'KHMT', 57, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21001204', 'Anya Tella', 'Nam', to_date('1938-11-16', 'YYYY-MM-DD'), '15 Baral Circle Kavali', '+912230564271', 'CTTT', 'TGMT', 33, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21001205', 'Kanav Samra', 'Nam', to_date('1963-04-22', 'YYYY-MM-DD'), 'H.No. 12 Rattan Road Muzaffarpur', '3696463719', 'VP', 'KHMT', 124, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21001206', 'Charvi Warrior', 'Nam', to_date('1940-03-12', 'YYYY-MM-DD'), '95/071 Malhotra Gopalpur', '4108654519', 'CTTT', 'KHMT', 6, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21001207', 'Nitya Tak', 'Nam', to_date('1954-08-17', 'YYYY-MM-DD'), 'H.No. 344 Sule Dhanbad', '00011216084', 'CQ', 'MMT', 116, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21001208', 'Biju Gole', 'N?', to_date('1943-11-20', 'YYYY-MM-DD'), '57 Bhattacharyya Street Bhopal', '+915274094961', 'CQ', 'KHMT', 49, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21001209', 'Pari Karnik', 'N?', to_date('1918-07-09', 'YYYY-MM-DD'), '002 Kapadia Nagar Guna', '2128044152', 'CLC', 'MMT', 73, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21001210', 'Shanaya Mangat', 'N?', to_date('1939-01-18', 'YYYY-MM-DD'), '09 Raja Anantapuram', '07176165007', 'CLC', 'CNPM', 85, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21001211', 'Zara Lalla', 'Nam', to_date('1968-10-29', 'YYYY-MM-DD'), 'H.No. 95 Devan Sasaram', '08263126066', 'CLC', 'TGMT', 103, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21001212', 'Faiyaz Sachar', 'Nam', to_date('1920-07-30', 'YYYY-MM-DD'), 'H.No. 313 Handa Road Thane', '5581565322', 'CQ', 'TGMT', 73, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21001213', 'Uthkarsh Gandhi', 'Nam', to_date('1928-06-09', 'YYYY-MM-DD'), '758 Desai Path Sasaram', '+913980266176', 'VP', 'CNTT', 58, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21001214', 'Piya Wagle', 'Nam', to_date('1915-07-10', 'YYYY-MM-DD'), '09/952 Kapadia Path Saharanpur', '9947185152', 'CQ', 'MMT', 104, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21001215', 'Hansh Iyengar', 'N?', to_date('2003-11-13', 'YYYY-MM-DD'), 'H.No. 415 Walla Ganj New Delhi', '7828080034', 'CTTT', 'HTTT', 103, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21001216', 'Lakshit Malhotra', 'N?', to_date('1926-01-25', 'YYYY-MM-DD'), '01/035 Chhabra Nagar Amroha', '02654495023', 'CQ', 'KHMT', 96, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21001217', 'Umang Kala', 'N?', to_date('2009-11-22', 'YYYY-MM-DD'), 'H.No. 422 Chaudhari Street Chapra', '0410927446', 'CTTT', 'MMT', 110, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21001218', 'Chirag Sama', 'Nam', to_date('1927-04-18', 'YYYY-MM-DD'), '023 Bajaj Street Kollam', '9598531102', 'CTTT', 'HTTT', 110, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21001219', 'Hazel Virk', 'N?', to_date('1999-11-26', 'YYYY-MM-DD'), 'H.No. 167 Loke Ganj Dehri', '+912845993260', 'CQ', 'CNTT', 84, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21001220', 'Miraan Bhat', 'Nam', to_date('2008-01-12', 'YYYY-MM-DD'), '48 Gill Road Bhiwani', '02996208187', 'CQ', 'MMT', 43, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21001221', 'Rania Kashyap', 'N?', to_date('2016-04-03', 'YYYY-MM-DD'), 'H.No. 00 Chakrabarti Ganj Kochi', '06019018225', 'CTTT', 'CNPM', 63, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21001222', 'Ryan Hayre', 'Nam', to_date('1949-08-12', 'YYYY-MM-DD'), '95/52 Ganesan Path Bhiwandi', '04079854722', 'CQ', 'TGMT', 33, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21001223', 'Manjari Chand', 'N?', to_date('1915-12-20', 'YYYY-MM-DD'), 'H.No. 85 Chaudhuri Nagar Khammam', '+915798589775', 'CLC', 'TGMT', 47, 5.35);

INSERT INTO SINHVIEN
VALUES ('SV21001224', 'Krish Basak', 'N?', to_date('1985-12-27', 'YYYY-MM-DD'), '41 Krishnan Road Aurangabad', '+916735624713', 'VP', 'CNTT', 20, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21001225', 'Elakshi Sidhu', 'N?', to_date('1910-06-29', 'YYYY-MM-DD'), '29/94 Sodhi Street Chittoor', '5036977198', 'CLC', 'TGMT', 80, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21001226', 'Divyansh Bobal', 'Nam', to_date('1955-11-19', 'YYYY-MM-DD'), '57/765 Tripathi Zila Mango', '1632019514', 'CLC', 'CNPM', 82, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21001227', 'Mamooty Grover', 'Nam', to_date('1960-11-28', 'YYYY-MM-DD'), 'H.No. 184 Tandon Circle South Dumdum', '8893838903', 'CLC', 'MMT', 5, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21001228', 'Kismat Behl', 'N?', to_date('1947-02-25', 'YYYY-MM-DD'), '21/11 Dash Ganj Shimoga', '06420545664', 'CQ', 'TGMT', 138, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21001229', 'Aaryahi Som', 'N?', to_date('1918-08-06', 'YYYY-MM-DD'), '68/834 Bumb Zila Maheshtala', '+919944684098', 'VP', 'MMT', 135, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21001230', 'Ahana  Dhawan', 'Nam', to_date('1943-08-14', 'YYYY-MM-DD'), '914 Chokshi Zila Hindupur', '01750200466', 'CTTT', 'CNTT', 89, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21001231', 'Eshani Swaminathan', 'N?', to_date('1914-02-15', 'YYYY-MM-DD'), '37/811 Yadav Pudukkottai', '6481893054', 'CLC', 'CNTT', 115, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001232', 'Manjari Rao', 'Nam', to_date('1927-12-14', 'YYYY-MM-DD'), '56/32 Vaidya Marg Chapra', '+919453538336', 'CTTT', 'TGMT', 20, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21001233', 'Kimaya Keer', 'N?', to_date('1942-10-06', 'YYYY-MM-DD'), '39/856 Yogi Nagar Maheshtala', '+919836087412', 'CTTT', 'MMT', 115, 5.58);

INSERT INTO SINHVIEN
VALUES ('SV21001234', 'Inaaya  Seshadri', 'N?', to_date('1983-12-20', 'YYYY-MM-DD'), 'H.No. 897 Chaudry Circle Khammam', '+916825870276', 'VP', 'KHMT', 80, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21001235', 'Saanvi Chaudhari', 'Nam', to_date('2008-09-19', 'YYYY-MM-DD'), '08/317 Raja Path Saharanpur', '04287336773', 'CQ', 'MMT', 70, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21001236', 'Anaya Chhabra', 'N?', to_date('1994-04-12', 'YYYY-MM-DD'), '32 Bahl Zila Mango', '05817518126', 'CLC', 'CNPM', 89, 9.77);

INSERT INTO SINHVIEN
VALUES ('SV21001237', 'Mohanlal Bhasin', 'N?', to_date('2002-05-11', 'YYYY-MM-DD'), '38 Dora Nagar Jamshedpur', '03275067973', 'CQ', 'KHMT', 4, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21001238', 'Krish Randhawa', 'Nam', to_date('1988-08-07', 'YYYY-MM-DD'), 'H.No. 52 Yadav Circle Etawah', '9449297009', 'VP', 'KHMT', 120, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21001239', 'Miraan Karnik', 'Nam', to_date('2021-06-26', 'YYYY-MM-DD'), 'H.No. 95 Thakur Path Thane', '06411008026', 'CTTT', 'TGMT', 80, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21001240', 'Baiju Shan', 'N?', to_date('1973-06-13', 'YYYY-MM-DD'), '63 Iyengar Path Giridih', '05020653006', 'CLC', 'MMT', 90, 4.44);

INSERT INTO SINHVIEN
VALUES ('SV21001241', 'Mahika Mani', 'N?', to_date('1939-03-16', 'YYYY-MM-DD'), 'H.No. 09 Kamdar Chowk Salem', '+918749073535', 'CTTT', 'KHMT', 76, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21001242', 'Yuvaan Guha', 'Nam', to_date('1927-11-16', 'YYYY-MM-DD'), '61/69 Mani Zila Jalandhar', '+910279875145', 'CTTT', 'MMT', 68, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21001243', 'Baiju Goyal', 'Nam', to_date('1911-07-10', 'YYYY-MM-DD'), 'H.No. 50 Sane Path Kozhikode', '06618348720', 'VP', 'MMT', 112, 5.63);

INSERT INTO SINHVIEN
VALUES ('SV21001244', 'Shaan Varkey', 'Nam', to_date('1929-01-24', 'YYYY-MM-DD'), '26/157 Dar Street Satna', '0713231993', 'VP', 'KHMT', 68, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21001245', 'Armaan Dugal', 'N?', to_date('1984-01-29', 'YYYY-MM-DD'), '26/65 Rajagopalan Circle Shimla', '05009707602', 'CTTT', 'KHMT', 100, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21001246', 'Misha Rau', 'N?', to_date('2009-11-03', 'YYYY-MM-DD'), '14/922 Gour Street Bathinda', '08581978958', 'CQ', 'CNPM', 84, 9.58);

INSERT INTO SINHVIEN
VALUES ('SV21001247', 'Arnav Vig', 'N?', to_date('1981-08-10', 'YYYY-MM-DD'), '57/738 Choudhury Nagar Ahmednagar', '08532879984', 'VP', 'TGMT', 62, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21001248', 'Fateh Buch', 'N?', to_date('1919-12-16', 'YYYY-MM-DD'), '36 Khurana Street Saharanpur', '+915201995722', 'CTTT', 'MMT', 110, 8.34);

INSERT INTO SINHVIEN
VALUES ('SV21001249', 'Shlok Shah', 'N?', to_date('1914-09-21', 'YYYY-MM-DD'), 'H.No. 63 Ramanathan Dharmavaram', '+912942417346', 'VP', 'KHMT', 70, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21001250', 'Drishya Kapoor', 'Nam', to_date('1978-02-25', 'YYYY-MM-DD'), 'H.No. 48 Sem Circle Eluru', '+919085697099', 'CTTT', 'CNTT', 26, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21001251', 'Prerak Tripathi', 'N?', to_date('1914-05-18', 'YYYY-MM-DD'), 'H.No. 33 Konda Ganj Gangtok', '9742599548', 'CTTT', 'KHMT', 123, 9.12);

INSERT INTO SINHVIEN
VALUES ('SV21001252', 'Anya Shah', 'N?', to_date('1922-08-03', 'YYYY-MM-DD'), '17 Sharaf Nagar Pondicherry', '5573720709', 'CTTT', 'CNTT', 44, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21001253', 'Dhanush Zachariah', 'Nam', to_date('1931-07-17', 'YYYY-MM-DD'), '14/66 Datta Circle Dhanbad', '6985479725', 'CLC', 'HTTT', 51, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21001254', 'Samarth Ramachandran', 'Nam', to_date('1910-11-18', 'YYYY-MM-DD'), '185 Ray Ganj Raichur', '05098704549', 'VP', 'HTTT', 39, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21001255', 'Mohanlal Saraf', 'Nam', to_date('1918-03-18', 'YYYY-MM-DD'), '858 Tiwari Circle Danapur', '+911710935429', 'VP', 'KHMT', 103, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21001256', 'Alisha Bandi', 'Nam', to_date('1989-03-14', 'YYYY-MM-DD'), '53/64 Ahluwalia Nagar Durgapur', '05725903527', 'VP', 'MMT', 105, 9.38);

INSERT INTO SINHVIEN
VALUES ('SV21001257', 'Seher Chokshi', 'Nam', to_date('1915-05-16', 'YYYY-MM-DD'), '14 Bhakta Marg Mangalore', '08955737883', 'VP', 'CNTT', 49, 6.48);

INSERT INTO SINHVIEN
VALUES ('SV21001258', 'Arnav Mander', 'Nam', to_date('1945-06-09', 'YYYY-MM-DD'), '02 Saran Nagar Amritsar', '+916863103028', 'CTTT', 'HTTT', 36, 5.19);

INSERT INTO SINHVIEN
VALUES ('SV21001259', 'Jayesh Dhingra', 'Nam', to_date('1949-04-15', 'YYYY-MM-DD'), '68 Banerjee Path Bihar Sharif', '03187547446', 'CQ', 'CNTT', 106, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21001260', 'Kanav Khatri', 'N?', to_date('1917-08-13', 'YYYY-MM-DD'), 'H.No. 776 Gulati Nagar Begusarai', '+915048622180', 'CTTT', 'HTTT', 108, 4.55);

INSERT INTO SINHVIEN
VALUES ('SV21001261', 'Saksham Doctor', 'N?', to_date('1992-03-26', 'YYYY-MM-DD'), 'H.No. 738 Thakkar Street Morbi', '+917052139605', 'VP', 'TGMT', 98, 4.82);

INSERT INTO SINHVIEN
VALUES ('SV21001262', 'Vivaan Kumer', 'Nam', to_date('1966-11-16', 'YYYY-MM-DD'), 'H.No. 46 Jha Circle Bhiwandi', '00013581081', 'VP', 'HTTT', 125, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21001263', 'Yuvaan Buch', 'N?', to_date('1915-11-12', 'YYYY-MM-DD'), '87/888 Reddy Nagar Kollam', '1083393053', 'CLC', 'KHMT', 62, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21001264', 'Vivaan Gara', 'N?', to_date('1992-11-11', 'YYYY-MM-DD'), 'H.No. 51 Chand Path Anantapur', '+916770496032', 'CTTT', 'CNPM', 59, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21001265', 'Mamooty Shan', 'N?', to_date('1919-08-27', 'YYYY-MM-DD'), '940 Bhatia Circle Bhilai', '1572945484', 'CLC', 'CNTT', 86, 6.01);

INSERT INTO SINHVIEN
VALUES ('SV21001266', 'Indrans Sunder', 'Nam', to_date('1916-12-30', 'YYYY-MM-DD'), '39/243 Cherian Path Akola', '+910452244284', 'CQ', 'MMT', 37, 4.32);

INSERT INTO SINHVIEN
VALUES ('SV21001267', 'Vaibhav Butala', 'N?', to_date('1940-06-09', 'YYYY-MM-DD'), '82/74 Madan Malegaon', '8740570695', 'VP', 'MMT', 117, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21001268', 'Raunak Singh', 'N?', to_date('1911-05-18', 'YYYY-MM-DD'), 'H.No. 01 Gara Circle Kolkata', '02192691522', 'CLC', 'CNTT', 24, 4.69);

INSERT INTO SINHVIEN
VALUES ('SV21001269', 'Zoya Deol', 'Nam', to_date('1981-05-25', 'YYYY-MM-DD'), '01/17 Kamdar Chowk Bokaro', '03469724510', 'CLC', 'TGMT', 58, 7.43);

INSERT INTO SINHVIEN
VALUES ('SV21001270', 'Parinaaz Chawla', 'Nam', to_date('1916-09-13', 'YYYY-MM-DD'), 'H.No. 06 Rama Chowk Varanasi', '+918325752627', 'CTTT', 'TGMT', 76, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21001271', 'Azad Verma', 'Nam', to_date('1971-04-06', 'YYYY-MM-DD'), '39/282 Choudhry Circle Gangtok', '+915972606441', 'VP', 'KHMT', 131, 6.89);

INSERT INTO SINHVIEN
VALUES ('SV21001272', 'Hridaan Agate', 'Nam', to_date('1964-06-26', 'YYYY-MM-DD'), 'H.No. 64 Hora Marg Gaya', '06926667388', 'CTTT', 'CNTT', 0, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21001273', 'Aradhya Talwar', 'Nam', to_date('1999-11-02', 'YYYY-MM-DD'), 'H.No. 244 Chawla Street Davanagere', '+918273045914', 'CTTT', 'MMT', 132, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21001274', 'Gokul Rout', 'N?', to_date('1922-01-18', 'YYYY-MM-DD'), '67/90 Sood Zila South Dumdum', '7776523082', 'CLC', 'TGMT', 102, 6.06);

INSERT INTO SINHVIEN
VALUES ('SV21001275', 'Renee Golla', 'N?', to_date('1979-10-27', 'YYYY-MM-DD'), '901 Choudhary Thanjavur', '01053175889', 'CLC', 'MMT', 101, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21001276', 'Tanya Reddy', 'Nam', to_date('1995-11-25', 'YYYY-MM-DD'), '272 Aggarwal Road Dehradun', '+911468947498', 'CLC', 'CNPM', 126, 7.57);

INSERT INTO SINHVIEN
VALUES ('SV21001277', 'Anaya Chatterjee', 'Nam', to_date('1956-02-14', 'YYYY-MM-DD'), '203 Kota Nagar Bhilwara', '03260139318', 'CLC', 'MMT', 61, 6.89);

INSERT INTO SINHVIEN
VALUES ('SV21001278', 'Taran Samra', 'N?', to_date('2020-06-21', 'YYYY-MM-DD'), '78/54 Choudhury Zila Chittoor', '08965995631', 'VP', 'MMT', 44, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21001279', 'Kismat Saha', 'Nam', to_date('1912-09-08', 'YYYY-MM-DD'), 'H.No. 097 Garde Ganj Chinsurah', '+915228461445', 'VP', 'HTTT', 91, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21001280', 'Baiju Bala', 'N?', to_date('1966-05-14', 'YYYY-MM-DD'), '48/152 Apte Path Ludhiana', '09315352389', 'VP', 'TGMT', 8, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21001281', 'Nirvaan Walia', 'Nam', to_date('1951-10-27', 'YYYY-MM-DD'), 'H.No. 968 Agate Street Baranagar', '01091295760', 'VP', 'TGMT', 34, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21001282', 'Kavya Sethi', 'N?', to_date('1942-02-15', 'YYYY-MM-DD'), '51 Solanki Chowk Katni', '07883923641', 'CLC', 'CNPM', 109, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21001283', 'Kashvi Talwar', 'N?', to_date('2008-05-27', 'YYYY-MM-DD'), 'H.No. 451 Dugal Circle Proddatur', '+919001043722', 'CLC', 'CNTT', 113, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21001284', 'Abram Mahajan', 'Nam', to_date('1970-04-02', 'YYYY-MM-DD'), 'H.No. 18 Bal Path Bhiwandi', '0463241502', 'CLC', 'CNPM', 31, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21001285', 'Abram Sathe', 'Nam', to_date('2020-10-15', 'YYYY-MM-DD'), '756 Kara Circle Sultan Pur Majra', '6548397685', 'CQ', 'MMT', 13, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21001286', 'Vanya Dixit', 'N?', to_date('2023-08-23', 'YYYY-MM-DD'), 'H.No. 38 Bose Path Barasat', '05642158748', 'CTTT', 'CNTT', 62, 7.52);

INSERT INTO SINHVIEN
VALUES ('SV21001287', 'Miraan Ramachandran', 'Nam', to_date('1963-03-10', 'YYYY-MM-DD'), '00 Jain Ganj Sagar', '04436546645', 'CTTT', 'MMT', 111, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21001288', 'Suhana Kant', 'Nam', to_date('1950-01-14', 'YYYY-MM-DD'), 'H.No. 93 Kota Road Ramgarh', '+917222984625', 'CLC', 'KHMT', 16, 8.0);

INSERT INTO SINHVIEN
VALUES ('SV21001289', 'Yuvaan Gala', 'N?', to_date('2023-03-23', 'YYYY-MM-DD'), '52/08 Rege Mahbubnagar', '+914444470309', 'CTTT', 'CNPM', 113, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21001290', 'Parinaaz Dhingra', 'Nam', to_date('1992-08-16', 'YYYY-MM-DD'), '973 Behl Marg Chandrapur', '08426538781', 'VP', 'CNPM', 73, 4.92);

INSERT INTO SINHVIEN
VALUES ('SV21001291', 'Shalv Kala', 'N?', to_date('1987-05-27', 'YYYY-MM-DD'), '335 Kuruvilla Road Bharatpur', '3167398668', 'CQ', 'HTTT', 21, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21001292', 'Shray Badami', 'Nam', to_date('1917-09-10', 'YYYY-MM-DD'), '61 Tandon Chowk Alwar', '2631287773', 'CQ', 'KHMT', 2, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21001293', 'Aayush Basu', 'Nam', to_date('1982-10-25', 'YYYY-MM-DD'), '280 Brahmbhatt Road Gangtok', '9837154465', 'CQ', 'HTTT', 22, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21001294', 'Samarth Comar', 'N?', to_date('1952-12-11', 'YYYY-MM-DD'), '69 Sura Haridwar', '09521276120', 'CQ', 'CNTT', 113, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21001295', 'Vaibhav Varghese', 'Nam', to_date('1935-08-17', 'YYYY-MM-DD'), '28/060 Dhar Road Pudukkottai', '+918536861761', 'CLC', 'KHMT', 127, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21001296', 'Kismat Mahajan', 'Nam', to_date('1996-05-25', 'YYYY-MM-DD'), '69/69 Biswas Street Bareilly', '6364847262', 'CLC', 'CNTT', 2, 7.22);

INSERT INTO SINHVIEN
VALUES ('SV21001297', 'Zara Bora', 'N?', to_date('1922-09-28', 'YYYY-MM-DD'), '06 Sani Zila Firozabad', '07437275221', 'CLC', 'HTTT', 28, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21001298', 'Divyansh Yohannan', 'N?', to_date('1992-09-04', 'YYYY-MM-DD'), 'H.No. 904 Aggarwal Agra', '02500017776', 'VP', 'TGMT', 120, 6.38);

INSERT INTO SINHVIEN
VALUES ('SV21001299', 'Hiran Venkataraman', 'Nam', to_date('1978-06-28', 'YYYY-MM-DD'), '77/34 Sidhu Road Amroha', '8380918276', 'CQ', 'KHMT', 34, 5.11);

INSERT INTO SINHVIEN
VALUES ('SV21001300', 'Drishya Kuruvilla', 'N?', to_date('2003-08-15', 'YYYY-MM-DD'), '15/559 Subramanian Marg Asansol', '01150477938', 'CLC', 'TGMT', 19, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21001301', 'Raghav Dugar', 'N?', to_date('2017-03-31', 'YYYY-MM-DD'), '820 Kamdar Road Panihati', '0205367568', 'CTTT', 'KHMT', 122, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21001302', 'Ahana  Chhabra', 'N?', to_date('1931-09-21', 'YYYY-MM-DD'), 'H.No. 099 Iyer Road Jaunpur', '08029668491', 'CQ', 'CNPM', 117, 6.72);

INSERT INTO SINHVIEN
VALUES ('SV21001303', 'Lavanya Kaur', 'N?', to_date('1919-11-14', 'YYYY-MM-DD'), '12 Raj Nagar Thoothukudi', '+919820081336', 'CTTT', 'HTTT', 57, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21001304', 'Ahana  Kalita', 'Nam', to_date('1909-04-19', 'YYYY-MM-DD'), 'H.No. 310 Mani Zila Howrah', '06803487165', 'CTTT', 'MMT', 116, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21001305', 'Neysa Kade', 'N?', to_date('1980-02-07', 'YYYY-MM-DD'), '38 Mall Ganj Medininagar', '+912145426624', 'CLC', 'MMT', 3, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21001306', 'Arnav Sridhar', 'Nam', to_date('1996-06-24', 'YYYY-MM-DD'), '50/81 Choudhury Path Kolkata', '1123499944', 'VP', 'KHMT', 4, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21001307', 'Shayak Grewal', 'N?', to_date('1940-02-07', 'YYYY-MM-DD'), 'H.No. 454 Acharya Path Nashik', '9537744157', 'CTTT', 'MMT', 67, 6.36);

INSERT INTO SINHVIEN
VALUES ('SV21001308', 'Saksham Sharma', 'Nam', to_date('1936-05-26', 'YYYY-MM-DD'), '00/555 Deshpande Path Mirzapur', '+914922155168', 'CQ', 'HTTT', 10, 5.99);

INSERT INTO SINHVIEN
VALUES ('SV21001309', 'Advika Dua', 'Nam', to_date('1995-10-02', 'YYYY-MM-DD'), 'H.No. 255 Datta Marg Chittoor', '+911657273064', 'VP', 'CNTT', 50, 9.93);

INSERT INTO SINHVIEN
VALUES ('SV21001310', 'Aayush Dugar', 'Nam', to_date('1944-06-25', 'YYYY-MM-DD'), '66/526 Luthra Circle Shimla', '0260786973', 'CLC', 'CNTT', 102, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21001311', 'Rhea Kari', 'N?', to_date('1966-12-16', 'YYYY-MM-DD'), '35 Sama Path Berhampur', '+916432639251', 'VP', 'CNTT', 53, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21001312', 'Aaryahi Ahuja', 'Nam', to_date('1939-09-18', 'YYYY-MM-DD'), '68 Yohannan Nagar Shimoga', '+911526042623', 'CLC', 'CNTT', 126, 5.92);

INSERT INTO SINHVIEN
VALUES ('SV21001313', 'Jhanvi Ratti', 'Nam', to_date('1941-10-23', 'YYYY-MM-DD'), '88/61 Sethi Marg Sagar', '1278107440', 'VP', 'HTTT', 91, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21001314', 'Jiya Dhar', 'N?', to_date('1910-03-10', 'YYYY-MM-DD'), 'H.No. 06 Bhakta Marg Mira-Bhayandar', '+914719227179', 'CTTT', 'HTTT', 87, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21001315', 'Khushi Gill', 'Nam', to_date('1990-12-12', 'YYYY-MM-DD'), '982 Magar Path Bhiwani', '08463655257', 'CLC', 'MMT', 96, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001316', 'Saksham Chakrabarti', 'N?', to_date('1993-10-22', 'YYYY-MM-DD'), '40/62 Sankaran Street Singrauli', '+911736875079', 'CLC', 'MMT', 29, 9.21);

INSERT INTO SINHVIEN
VALUES ('SV21001317', 'Veer Rana', 'N?', to_date('1940-11-22', 'YYYY-MM-DD'), 'H.No. 65 Shere Road Kottayam', '+917293941935', 'CQ', 'MMT', 133, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21001318', 'Fateh Ratta', 'N?', to_date('1966-01-22', 'YYYY-MM-DD'), '06/215 Balakrishnan Katihar', '06975061914', 'VP', 'MMT', 88, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21001319', 'Mehul Ramaswamy', 'Nam', to_date('1949-12-10', 'YYYY-MM-DD'), '42 Shenoy Road Mehsana', '7768205567', 'CQ', 'HTTT', 36, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21001320', 'Mishti Mallick', 'Nam', to_date('1982-02-04', 'YYYY-MM-DD'), '55/80 Ray Zila Bhilwara', '+911642646733', 'VP', 'KHMT', 52, 5.05);

INSERT INTO SINHVIEN
VALUES ('SV21001321', 'Seher Aurora', 'N?', to_date('1922-11-16', 'YYYY-MM-DD'), 'H.No. 970 Sachar Shimla', '+914137096473', 'CTTT', 'KHMT', 130, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21001322', 'Samaira Bhatnagar', 'N?', to_date('1982-04-10', 'YYYY-MM-DD'), '37/29 Wagle Zila Solapur', '04340684465', 'VP', 'KHMT', 132, 5.23);

INSERT INTO SINHVIEN
VALUES ('SV21001323', 'Vivaan Tailor', 'Nam', to_date('1931-02-20', 'YYYY-MM-DD'), '36 Guha Path Bhavnagar', '+917657170675', 'CTTT', 'MMT', 14, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21001324', 'Saanvi Master', 'N?', to_date('1920-02-26', 'YYYY-MM-DD'), 'H.No. 907 Zacharia Path Guntur', '+912794401762', 'CQ', 'HTTT', 123, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21001325', 'Bhavin Basu', 'N?', to_date('1923-07-30', 'YYYY-MM-DD'), 'H.No. 086 Basak Path Hyderabad', '+911164942726', 'CQ', 'CNPM', 83, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21001326', 'Miraan Sandal', 'Nam', to_date('1934-06-28', 'YYYY-MM-DD'), '11 Raju Street Bijapur', '+916423728106', 'CQ', 'HTTT', 112, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21001327', 'Saira Singh', 'Nam', to_date('1909-05-25', 'YYYY-MM-DD'), 'H.No. 95 Dar Ganj Nagercoil', '09224444362', 'CLC', 'TGMT', 93, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21001328', 'Yasmin Ranganathan', 'N?', to_date('2021-01-05', 'YYYY-MM-DD'), 'H.No. 90 Datta Zila Etawah', '8378841625', 'CQ', 'MMT', 1, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21001329', 'Kiara Sandhu', 'N?', to_date('1940-03-27', 'YYYY-MM-DD'), '56/19 Bera Nagar Dharmavaram', '08274672355', 'CLC', 'CNPM', 113, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21001330', 'Shray Batra', 'N?', to_date('1972-03-03', 'YYYY-MM-DD'), 'H.No. 788 Sathe Bikaner', '4227264361', 'CQ', 'HTTT', 43, 6.81);

INSERT INTO SINHVIEN
VALUES ('SV21001331', 'Prerak Khalsa', 'N?', to_date('2018-08-21', 'YYYY-MM-DD'), '47/116 Wali Tiruppur', '07879461346', 'CLC', 'CNTT', 92, 4.3);

INSERT INTO SINHVIEN
VALUES ('SV21001332', 'Nayantara Sethi', 'N?', to_date('1962-12-19', 'YYYY-MM-DD'), '23/164 Setty Nagar Jabalpur', '+914984675507', 'VP', 'KHMT', 18, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21001333', 'Miraan Trivedi', 'N?', to_date('1922-07-27', 'YYYY-MM-DD'), '92/102 Cheema Ghaziabad', '+919194377899', 'VP', 'KHMT', 125, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21001334', 'Purab Deshmukh', 'Nam', to_date('1957-02-20', 'YYYY-MM-DD'), 'H.No. 90 Sami Marg Etawah', '5080921443', 'VP', 'TGMT', 94, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21001335', 'Kiaan Raja', 'N?', to_date('2013-12-29', 'YYYY-MM-DD'), '029 Johal Street Bhiwandi', '+917546549835', 'CLC', 'MMT', 98, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21001336', 'Nishith Choudhary', 'N?', to_date('1970-02-19', 'YYYY-MM-DD'), 'H.No. 892 Mani Zila Mehsana', '+918092408501', 'CQ', 'HTTT', 63, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21001337', 'Advik Borah', 'Nam', to_date('1976-03-01', 'YYYY-MM-DD'), 'H.No. 96 Tandon Ganj Dharmavaram', '06407557750', 'CQ', 'CNTT', 40, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21001338', 'Suhana Tripathi', 'Nam', to_date('2021-08-29', 'YYYY-MM-DD'), '75 Gade Road Bilaspur', '1269668393', 'CTTT', 'HTTT', 83, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21001339', 'Kismat Mahajan', 'Nam', to_date('1941-04-21', 'YYYY-MM-DD'), '603 Kothari Road Kakinada', '8835560075', 'CQ', 'CNPM', 124, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21001340', 'Aaina Hayre', 'Nam', to_date('1954-01-24', 'YYYY-MM-DD'), '70/22 Guha Street Begusarai', '9055411914', 'CQ', 'MMT', 54, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21001341', 'Elakshi Rastogi', 'N?', to_date('1967-09-25', 'YYYY-MM-DD'), '19 Dixit Zila Karimnagar', '+915763862626', 'VP', 'HTTT', 39, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21001342', 'Ojas Sama', 'N?', to_date('1943-07-05', 'YYYY-MM-DD'), 'H.No. 630 Chakrabarti Marg Yamunanagar', '03130473192', 'VP', 'HTTT', 2, 4.52);

INSERT INTO SINHVIEN
VALUES ('SV21001343', 'Arnav Mangat', 'Nam', to_date('2000-02-13', 'YYYY-MM-DD'), 'H.No. 01 Arya Road Gulbarga', '+915335139042', 'CQ', 'KHMT', 47, 5.45);

INSERT INTO SINHVIEN
VALUES ('SV21001344', 'Mishti Hari', 'Nam', to_date('1918-02-24', 'YYYY-MM-DD'), '86/60 Cheema Ganj South Dumdum', '5661410865', 'CLC', 'MMT', 53, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21001345', 'Arhaan Kamdar', 'Nam', to_date('1922-06-24', 'YYYY-MM-DD'), '40 Kunda Road Coimbatore', '6475121405', 'VP', 'KHMT', 52, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21001346', 'Tara Hayer', 'Nam', to_date('1992-03-11', 'YYYY-MM-DD'), '04 Kant Nagar Nizamabad', '+911989938666', 'VP', 'CNTT', 48, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21001347', 'Advik Verma', 'N?', to_date('2019-03-05', 'YYYY-MM-DD'), '727 Gola Street Vasai-Virar', '03423556780', 'CTTT', 'MMT', 43, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21001348', 'Anaya Raju', 'N?', to_date('1984-09-21', 'YYYY-MM-DD'), '427 Brahmbhatt Marg Panipat', '+910064357627', 'CQ', 'HTTT', 43, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21001349', 'Kaira Konda', 'Nam', to_date('1921-04-09', 'YYYY-MM-DD'), 'H.No. 962 Boase Nagar Adoni', '3083076076', 'CQ', 'CNPM', 76, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21001350', 'Mishti Shenoy', 'Nam', to_date('1978-11-22', 'YYYY-MM-DD'), '32/351 Deep Chowk Arrah', '+918205888019', 'CTTT', 'TGMT', 91, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21001351', 'Samarth Anne', 'Nam', to_date('1915-10-25', 'YYYY-MM-DD'), '53 Hegde Path Delhi', '3752577572', 'CQ', 'CNPM', 96, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21001352', 'Siya Sampath', 'Nam', to_date('1996-10-10', 'YYYY-MM-DD'), '95/87 Saraf Street Jaunpur', '7830060273', 'CTTT', 'CNPM', 136, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21001353', 'Ahana  Vyas', 'Nam', to_date('1908-08-10', 'YYYY-MM-DD'), '555 Khosla Path Bhind', '3008987611', 'VP', 'KHMT', 129, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21001354', 'Neysa Savant', 'N?', to_date('2017-01-04', 'YYYY-MM-DD'), 'H.No. 34 Tella Zila Karimnagar', '5562952194', 'VP', 'MMT', 107, 5.12);

INSERT INTO SINHVIEN
VALUES ('SV21001355', 'Ojas Warrior', 'N?', to_date('1928-07-13', 'YYYY-MM-DD'), '430 Comar Zila Sikar', '+919799139180', 'CQ', 'MMT', 118, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21001356', 'Tarini Kurian', 'N?', to_date('1959-08-21', 'YYYY-MM-DD'), '36/26 Keer Ganj Kishanganj', '09012886439', 'VP', 'CNTT', 23, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21001357', 'Aradhya Wagle', 'Nam', to_date('1946-05-20', 'YYYY-MM-DD'), '54 Kakar Nagar Katihar', '+913189622062', 'CQ', 'TGMT', 72, 7.51);

INSERT INTO SINHVIEN
VALUES ('SV21001358', 'Pranay Mane', 'Nam', to_date('1924-07-30', 'YYYY-MM-DD'), 'H.No. 53 Agate Zila Rajpur Sonarpur', '2574420269', 'CLC', 'HTTT', 93, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21001359', 'Hiran Chaudhary', 'N?', to_date('1921-02-25', 'YYYY-MM-DD'), '99 Yadav Path Jalandhar', '+912538499852', 'CLC', 'TGMT', 73, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21001360', 'Tushar Kant', 'Nam', to_date('1941-08-02', 'YYYY-MM-DD'), '198 Contractor Marg Tirunelveli', '8461713255', 'CLC', 'MMT', 78, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21001361', 'Sahil Iyengar', 'Nam', to_date('1971-11-16', 'YYYY-MM-DD'), '730 Borra Path Mysore', '1903285123', 'VP', 'HTTT', 129, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21001362', 'Purab Dhaliwal', 'N?', to_date('1990-03-29', 'YYYY-MM-DD'), '60 Cheema Circle Moradabad', '07833462047', 'CLC', 'MMT', 35, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21001363', 'Vanya Johal', 'N?', to_date('1933-09-03', 'YYYY-MM-DD'), '60 Mallick Nagar Agra', '3154464585', 'VP', 'HTTT', 36, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21001364', 'Bhamini Swaminathan', 'N?', to_date('1968-01-18', 'YYYY-MM-DD'), 'H.No. 57 Mandal Circle Jalandhar', '07309157656', 'CLC', 'CNTT', 10, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001365', 'Nirvi Tank', 'Nam', to_date('1920-06-25', 'YYYY-MM-DD'), 'H.No. 504 Chaudhry Street Darbhanga', '05218048358', 'CQ', 'MMT', 57, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21001366', 'Veer Sanghvi', 'Nam', to_date('1991-01-08', 'YYYY-MM-DD'), 'H.No. 627 Srinivas Circle Bhatpara', '+913213348091', 'VP', 'CNTT', 119, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21001367', 'Anika Vohra', 'N?', to_date('1943-11-14', 'YYYY-MM-DD'), '19/207 Bala Path Rajkot', '02388787561', 'CLC', 'HTTT', 24, 9.06);

INSERT INTO SINHVIEN
VALUES ('SV21001368', 'Vivaan Sanghvi', 'Nam', to_date('2010-05-30', 'YYYY-MM-DD'), '05/55 Jhaveri Circle Akola', '4409745250', 'VP', 'CNTT', 67, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21001369', 'Biju Apte', 'N?', to_date('1912-09-24', 'YYYY-MM-DD'), '20 Andra Chowk Malda', '+912632866577', 'CLC', 'KHMT', 11, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21001370', 'Purab Bala', 'Nam', to_date('1979-01-22', 'YYYY-MM-DD'), '13/62 Vasa Ganj Davanagere', '2556662602', 'VP', 'CNPM', 35, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21001371', 'Riya Sem', 'N?', to_date('1928-11-30', 'YYYY-MM-DD'), 'H.No. 381 Sandal Nizamabad', '3026168156', 'CQ', 'HTTT', 84, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21001372', 'Renee Deshmukh', 'N?', to_date('2004-06-10', 'YYYY-MM-DD'), 'H.No. 895 Sama Nizamabad', '4820977790', 'CQ', 'TGMT', 35, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21001373', 'Aarna Iyer', 'N?', to_date('1955-08-18', 'YYYY-MM-DD'), '30/037 Sha Street Pali', '09308286318', 'VP', 'HTTT', 17, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21001374', 'Aarna Kala', 'Nam', to_date('1955-02-14', 'YYYY-MM-DD'), '45 Batra Chandigarh', '08151849376', 'CQ', 'CNTT', 57, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21001375', 'Dharmajan Goel', 'Nam', to_date('1933-06-30', 'YYYY-MM-DD'), '10/89 Grewal Zila Dhanbad', '02071103060', 'VP', 'CNTT', 54, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21001376', 'Kismat Varty', 'N?', to_date('1955-11-16', 'YYYY-MM-DD'), 'H.No. 170 Mallick Street Lucknow', '7558590575', 'CLC', 'CNPM', 46, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21001377', 'Gokul Srinivas', 'Nam', to_date('1984-02-25', 'YYYY-MM-DD'), 'H.No. 311 Barad Road Sambalpur', '05349732683', 'VP', 'MMT', 53, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21001378', 'Jayan Bakshi', 'N?', to_date('1999-04-30', 'YYYY-MM-DD'), '431 Dass Street Hazaribagh', '09958457955', 'CTTT', 'TGMT', 1, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21001379', 'Divyansh Loyal', 'N?', to_date('1999-08-15', 'YYYY-MM-DD'), 'H.No. 544 Jani Zila Vadodara', '+916519204151', 'VP', 'HTTT', 16, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21001380', 'Suhana Chahal', 'N?', to_date('2005-03-21', 'YYYY-MM-DD'), 'H.No. 149 Vora Road Karawal Nagar', '+916337119933', 'CTTT', 'TGMT', 8, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21001381', 'Miraan Sura', 'N?', to_date('1965-12-01', 'YYYY-MM-DD'), '17/246 Bassi Path Ahmedabad', '04127128120', 'VP', 'CNPM', 51, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21001382', 'Elakshi Dey', 'N?', to_date('1947-04-21', 'YYYY-MM-DD'), '38/455 Dey Marg Srinagar', '2217465716', 'VP', 'MMT', 129, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21001383', 'Rania Arya', 'Nam', to_date('1920-10-05', 'YYYY-MM-DD'), '63/337 Thakkar Chowk Mysore', '04686639299', 'VP', 'CNPM', 110, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21001384', 'Manjari Dara', 'Nam', to_date('1933-12-09', 'YYYY-MM-DD'), 'H.No. 57 Saha Ganj Nanded', '+913104308494', 'CLC', 'TGMT', 50, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21001385', 'Kabir Khurana', 'Nam', to_date('1923-08-25', 'YYYY-MM-DD'), 'H.No. 013 Bhatia Road Avadi', '0313880158', 'CQ', 'MMT', 63, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21001386', 'Himmat Das', 'Nam', to_date('1984-07-12', 'YYYY-MM-DD'), 'H.No. 89 Rana Marg Ulhasnagar', '07596777343', 'CQ', 'CNPM', 98, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21001387', 'Miraya Krishna', 'N?', to_date('2022-05-05', 'YYYY-MM-DD'), 'H.No. 64 Chowdhury Ganj Chittoor', '+913099905841', 'CLC', 'HTTT', 65, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21001388', 'Miraya Ben', 'Nam', to_date('1922-07-05', 'YYYY-MM-DD'), '155 Cheema Path Bokaro', '7383214360', 'CLC', 'CNPM', 22, 6.33);

INSERT INTO SINHVIEN
VALUES ('SV21001389', 'Ryan Yogi', 'Nam', to_date('1908-11-07', 'YYYY-MM-DD'), '87 Sood Road Pimpri-Chinchwad', '6040872262', 'VP', 'MMT', 115, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21001390', 'Misha Sane', 'Nam', to_date('1985-02-06', 'YYYY-MM-DD'), '453 Sani Nagar Lucknow', '7555929467', 'VP', 'MMT', 45, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21001391', 'Nishith Goda', 'N?', to_date('1974-08-23', 'YYYY-MM-DD'), '92/862 Comar Ganj Rohtak', '04457656511', 'VP', 'CNTT', 77, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21001392', 'Dishani Hegde', 'Nam', to_date('1930-11-21', 'YYYY-MM-DD'), '568 Shah Road Moradabad', '00997641729', 'CTTT', 'HTTT', 45, 7.53);

INSERT INTO SINHVIEN
VALUES ('SV21001393', 'Divyansh Anne', 'N?', to_date('1908-10-23', 'YYYY-MM-DD'), '234 Edwin Nagercoil', '2627886589', 'CQ', 'HTTT', 124, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21001394', 'Zain Wable', 'N?', to_date('1987-08-04', 'YYYY-MM-DD'), '20 Singh Silchar', '1189059979', 'VP', 'MMT', 31, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21001395', 'Indrans Varty', 'N?', to_date('1987-07-05', 'YYYY-MM-DD'), '67/60 Krishnan Zila Raipur', '04325619933', 'CTTT', 'CNTT', 28, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21001396', 'Gokul Ravi', 'N?', to_date('1909-01-26', 'YYYY-MM-DD'), 'H.No. 44 Chowdhury Road Mumbai', '+912620592240', 'CQ', 'HTTT', 76, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21001397', 'Amira Mandal', 'N?', to_date('1926-08-19', 'YYYY-MM-DD'), '44/64 Luthra Road Siwan', '06818223168', 'CLC', 'MMT', 6, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21001398', 'Pranay Upadhyay', 'N?', to_date('1972-07-08', 'YYYY-MM-DD'), '496 Contractor Marg Bhiwandi', '4711933575', 'VP', 'CNPM', 96, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21001399', 'Kismat Krishnan', 'N?', to_date('1992-02-14', 'YYYY-MM-DD'), '307 Madan Nagar Nagpur', '03756604543', 'CTTT', 'HTTT', 30, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21001400', 'Emir Kulkarni', 'N?', to_date('1937-06-07', 'YYYY-MM-DD'), 'H.No. 56 Ganguly Chowk Chittoor', '5029646850', 'VP', 'TGMT', 80, 6.17);

INSERT INTO SINHVIEN
VALUES ('SV21001401', 'Pranay Sagar', 'N?', to_date('1933-11-26', 'YYYY-MM-DD'), '31/089 Sidhu Marg Sri Ganganagar', '5050039409', 'VP', 'CNPM', 108, 7.32);

INSERT INTO SINHVIEN
VALUES ('SV21001402', 'Mannat Saha', 'Nam', to_date('1919-06-14', 'YYYY-MM-DD'), '14/46 Saraf Marg Tiruvottiyur', '08194817781', 'CTTT', 'CNPM', 51, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21001403', 'Piya Uppal', 'N?', to_date('1998-02-22', 'YYYY-MM-DD'), 'H.No. 36 Kibe Rajahmundry', '7189087492', 'CTTT', 'MMT', 30, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21001404', 'Saksham Sachar', 'Nam', to_date('2009-06-03', 'YYYY-MM-DD'), 'H.No. 992 Chaudry Path Serampore', '01283556881', 'CLC', 'MMT', 34, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21001405', 'Inaaya  Brar', 'N?', to_date('2014-12-11', 'YYYY-MM-DD'), '93 Krishnamurthy Path Asansol', '+913682052065', 'VP', 'KHMT', 106, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21001406', 'Charvi Randhawa', 'N?', to_date('2019-01-26', 'YYYY-MM-DD'), '12/400 Datta Road Kirari Suleman Nagar', '00502107076', 'CLC', 'KHMT', 43, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21001407', 'Pari Thaman', 'N?', to_date('1977-11-19', 'YYYY-MM-DD'), '51 Trivedi Arrah', '05756277267', 'VP', 'MMT', 136, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21001408', 'Mehul Vala', 'Nam', to_date('1978-06-30', 'YYYY-MM-DD'), '24/097 Balay Nagar Bellary', '08748186956', 'CQ', 'CNTT', 133, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21001409', 'Seher Tak', 'N?', to_date('1998-07-15', 'YYYY-MM-DD'), 'H.No. 432 Khare Circle Sasaram', '4789877807', 'CLC', 'KHMT', 10, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21001410', 'Purab Vala', 'Nam', to_date('2013-08-27', 'YYYY-MM-DD'), '55/467 Sridhar Path Vijayanagaram', '4108003279', 'CQ', 'KHMT', 58, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21001411', 'Zoya Wason', 'Nam', to_date('1970-06-17', 'YYYY-MM-DD'), '21/38 Zacharia Ganj Nellore', '+918080530791', 'VP', 'CNTT', 60, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21001412', 'Kaira Sidhu', 'N?', to_date('1917-09-14', 'YYYY-MM-DD'), 'H.No. 47 Chandran Path Bihar Sharif', '02164770532', 'CQ', 'KHMT', 118, 7.43);

INSERT INTO SINHVIEN
VALUES ('SV21001413', 'Shalv Sabharwal', 'N?', to_date('1949-12-07', 'YYYY-MM-DD'), '14/261 Jani Marg Bijapur', '+911601682762', 'CLC', 'HTTT', 110, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21001414', 'Yuvraj  Kade', 'Nam', to_date('1955-08-26', 'YYYY-MM-DD'), '49/199 Chandra Path Berhampur', '1129249909', 'CTTT', 'CNTT', 70, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21001415', 'Urvi Bhardwaj', 'N?', to_date('1995-06-27', 'YYYY-MM-DD'), 'H.No. 679 Sama Road Nizamabad', '6423311571', 'VP', 'CNTT', 129, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21001416', 'Shamik Mander', 'N?', to_date('2000-08-15', 'YYYY-MM-DD'), 'H.No. 015 Shah Marg Jodhpur', '+910020133403', 'VP', 'CNPM', 24, 6.72);

INSERT INTO SINHVIEN
VALUES ('SV21001417', 'Hazel Saran', 'Nam', to_date('1954-06-05', 'YYYY-MM-DD'), 'H.No. 48 Rajagopal Marg Jamshedpur', '03493632043', 'CQ', 'KHMT', 128, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21001418', 'Mahika Sur', 'N?', to_date('1967-12-06', 'YYYY-MM-DD'), '30/035 Datta Road Pimpri-Chinchwad', '04204048876', 'VP', 'CNPM', 48, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21001419', 'Vanya Kade', 'Nam', to_date('1937-01-17', 'YYYY-MM-DD'), 'H.No. 34 Banerjee Nagaon', '+915261847380', 'CLC', 'HTTT', 68, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21001420', 'Aarav Saran', 'Nam', to_date('1962-07-07', 'YYYY-MM-DD'), '70/86 Varughese Ganj Arrah', '2321994755', 'CQ', 'MMT', 56, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21001421', 'Ivan Master', 'N?', to_date('2018-01-26', 'YYYY-MM-DD'), '232 Karnik Path Gwalior', '3563095376', 'VP', 'MMT', 102, 6.52);

INSERT INTO SINHVIEN
VALUES ('SV21001422', 'Kashvi Devi', 'Nam', to_date('1968-01-03', 'YYYY-MM-DD'), 'H.No. 427 Sarkar Road Yamunanagar', '7816465755', 'CQ', 'CNPM', 63, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21001423', 'Zara Gokhale', 'N?', to_date('2015-08-02', 'YYYY-MM-DD'), '29/55 Viswanathan Path Raipur', '4222274399', 'VP', 'CNPM', 18, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21001424', 'Shray Chaudhari', 'N?', to_date('1935-05-27', 'YYYY-MM-DD'), '250 Shan Path Visakhapatnam', '3440257822', 'CTTT', 'CNPM', 108, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21001425', 'Oorja Karan', 'Nam', to_date('1983-08-29', 'YYYY-MM-DD'), '39/868 Doshi Circle Visakhapatnam', '04937512539', 'VP', 'CNPM', 57, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21001426', 'Amira Chaudhry', 'N?', to_date('1943-11-26', 'YYYY-MM-DD'), '44/888 Dada Nagar Proddatur', '+913156395128', 'CQ', 'CNPM', 21, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21001427', 'Myra Bala', 'N?', to_date('1928-05-07', 'YYYY-MM-DD'), '18 Balan Ramgarh', '+917602815357', 'CLC', 'HTTT', 133, 5.59);

INSERT INTO SINHVIEN
VALUES ('SV21001428', 'Kismat Shanker', 'N?', to_date('1985-04-15', 'YYYY-MM-DD'), '804 Datta Nagar Noida', '2009138593', 'VP', 'CNPM', 22, 9.58);

INSERT INTO SINHVIEN
VALUES ('SV21001429', 'Inaaya  Ravel', 'Nam', to_date('2002-10-10', 'YYYY-MM-DD'), '38/34 Verma Road Hosur', '3580639333', 'CLC', 'HTTT', 26, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21001430', 'Madhup Bala', 'Nam', to_date('1990-07-16', 'YYYY-MM-DD'), '306 Goda Marg Kumbakonam', '02118702432', 'CTTT', 'KHMT', 18, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21001431', 'Zain Sampath', 'N?', to_date('1920-02-23', 'YYYY-MM-DD'), 'H.No. 872 Raman Zila Akola', '+913481410802', 'CQ', 'MMT', 137, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21001432', 'Shayak Vala', 'Nam', to_date('1949-10-05', 'YYYY-MM-DD'), '107 Wadhwa Dhule', '09278592294', 'CTTT', 'HTTT', 118, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21001433', 'Kavya Walia', 'Nam', to_date('1908-09-08', 'YYYY-MM-DD'), '37/770 Joshi Street Rajkot', '1496083024', 'CLC', 'MMT', 79, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21001434', 'Raghav Wali', 'N?', to_date('1913-03-18', 'YYYY-MM-DD'), 'H.No. 26 Vala Bellary', '+911525775096', 'CTTT', 'MMT', 22, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21001435', 'Indrajit Soman', 'Nam', to_date('1981-05-07', 'YYYY-MM-DD'), '00/54 Arya Nagar Kollam', '1245587867', 'CQ', 'CNTT', 57, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21001436', 'Ivana Ratta', 'Nam', to_date('1935-02-10', 'YYYY-MM-DD'), '76/886 Zacharia Circle Suryapet', '08385778731', 'CLC', 'CNTT', 56, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21001437', 'Eshani Dyal', 'N?', to_date('1935-08-31', 'YYYY-MM-DD'), '50/23 Loyal Zila Gopalpur', '01398006844', 'CQ', 'HTTT', 105, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21001438', 'Nayantara Kant', 'Nam', to_date('1929-07-28', 'YYYY-MM-DD'), '68 Bhatnagar Circle Varanasi', '4239787807', 'VP', 'TGMT', 34, 7.22);

INSERT INTO SINHVIEN
VALUES ('SV21001439', 'Lakshay Sangha', 'Nam', to_date('1979-11-20', 'YYYY-MM-DD'), 'H.No. 73 Biswas Zila Ghaziabad', '5769921793', 'CTTT', 'CNPM', 68, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21001440', 'Ishaan Srinivasan', 'Nam', to_date('2017-11-25', 'YYYY-MM-DD'), '48/11 Chana Marg Raipur', '8326993675', 'CTTT', 'TGMT', 124, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21001441', 'Dharmajan Sarin', 'Nam', to_date('1973-10-17', 'YYYY-MM-DD'), '07 Sanghvi Circle Munger', '07181305300', 'CLC', 'TGMT', 133, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21001442', 'Ahana  Raja', 'Nam', to_date('1991-08-17', 'YYYY-MM-DD'), '37 Borra Chowk Bijapur', '1134929201', 'CLC', 'KHMT', 97, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21001443', 'Anay Goswami', 'Nam', to_date('2009-06-07', 'YYYY-MM-DD'), '985 Mani Chowk Bidhannagar', '3291650270', 'CTTT', 'MMT', 98, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21001444', 'Lakshay Shroff', 'N?', to_date('1937-11-26', 'YYYY-MM-DD'), '37/65 Dua Panvel', '07108768591', 'VP', 'CNTT', 106, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001445', 'Dhanush Kothari', 'Nam', to_date('1960-09-07', 'YYYY-MM-DD'), 'H.No. 004 Sood Path Junagadh', '+911888045699', 'CLC', 'KHMT', 123, 7.16);

INSERT INTO SINHVIEN
VALUES ('SV21001446', 'Aaryahi Deo', 'N?', to_date('1985-11-05', 'YYYY-MM-DD'), '650 Vasa Road Orai', '09262647858', 'CLC', 'MMT', 79, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21001447', 'Eva Balasubramanian', 'N?', to_date('1909-04-22', 'YYYY-MM-DD'), 'H.No. 15 Sibal Ganj Loni', '02449078137', 'CTTT', 'CNTT', 20, 5.53);

INSERT INTO SINHVIEN
VALUES ('SV21001448', 'Indrans Bhatia', 'N?', to_date('1908-10-22', 'YYYY-MM-DD'), '29/61 Bora Nagar Rohtak', '+919284188409', 'CLC', 'KHMT', 49, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21001449', 'Zaina Goswami', 'Nam', to_date('1976-11-13', 'YYYY-MM-DD'), '60 Samra Ganj Ludhiana', '+918816420785', 'CLC', 'TGMT', 60, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21001450', 'Hazel De', 'Nam', to_date('1930-01-20', 'YYYY-MM-DD'), '56 Devan Zila Kavali', '+912478553300', 'CTTT', 'CNTT', 69, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21001451', 'Misha Kara', 'Nam', to_date('1965-05-30', 'YYYY-MM-DD'), '18/25 Loke Chowk Madhyamgram', '+918704087821', 'CLC', 'MMT', 61, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21001452', 'Divit Saran', 'N?', to_date('1924-10-05', 'YYYY-MM-DD'), '151 Gupta Marg Chinsurah', '02526425127', 'CTTT', 'KHMT', 107, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21001453', 'Pari Barad', 'N?', to_date('1965-08-11', 'YYYY-MM-DD'), 'H.No. 80 Sarraf Street Jaipur', '+911063877871', 'CLC', 'MMT', 56, 4.76);

INSERT INTO SINHVIEN
VALUES ('SV21001454', 'Azad Basu', 'N?', to_date('1969-01-30', 'YYYY-MM-DD'), '882 Sankar Srikakulam', '01831873354', 'CQ', 'TGMT', 68, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001455', 'Nishith D��Alia', 'N?', to_date('1983-06-17', 'YYYY-MM-DD'), '541 Swaminathan Zila Nashik', '5312860870', 'CTTT', 'TGMT', 19, 8.54);

INSERT INTO SINHVIEN
VALUES ('SV21001456', 'Bhavin Chopra', 'N?', to_date('1998-04-13', 'YYYY-MM-DD'), '54/54 Vohra Ganj Malegaon', '+912954493615', 'VP', 'CNTT', 104, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21001457', 'Adah Dugar', 'N?', to_date('1922-06-21', 'YYYY-MM-DD'), '76 Khosla Path Dewas', '+910556259425', 'VP', 'MMT', 120, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21001458', 'Pari Zacharia', 'Nam', to_date('1962-10-06', 'YYYY-MM-DD'), 'H.No. 84 Karpe Gulbarga', '+912161244968', 'CTTT', 'CNPM', 65, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21001459', 'Ira Sahni', 'N?', to_date('1932-04-24', 'YYYY-MM-DD'), '46/296 Kala Zila Saharsa', '0711917321', 'CLC', 'HTTT', 129, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001460', 'Ishaan Salvi', 'Nam', to_date('1985-04-06', 'YYYY-MM-DD'), 'H.No. 133 Chakrabarti Chowk Mumbai', '03755604877', 'VP', 'KHMT', 27, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21001461', 'Lakshay Madan', 'Nam', to_date('1970-04-11', 'YYYY-MM-DD'), 'H.No. 021 Wason Marg Fatehpur', '08425795175', 'CTTT', 'CNTT', 108, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21001462', 'Damini Bhatnagar', 'N?', to_date('1951-05-06', 'YYYY-MM-DD'), '36 Mall Road Korba', '+916967620537', 'VP', 'HTTT', 81, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21001463', 'Saira Bora', 'N?', to_date('1939-01-15', 'YYYY-MM-DD'), '79 Badami Nagar Gudivada', '+914601568400', 'VP', 'TGMT', 110, 8.05);

INSERT INTO SINHVIEN
VALUES ('SV21001464', 'Biju Brar', 'N?', to_date('2013-01-31', 'YYYY-MM-DD'), '58/758 Chad Path Bellary', '+915669159030', 'VP', 'CNPM', 23, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21001465', 'Miraan Toor', 'N?', to_date('1961-12-19', 'YYYY-MM-DD'), 'H.No. 54 Wadhwa Path Noida', '2679151346', 'VP', 'KHMT', 129, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21001466', 'Abram Doctor', 'N?', to_date('1982-04-21', 'YYYY-MM-DD'), '26 Doshi Chowk Secunderabad', '+916814958217', 'CQ', 'TGMT', 73, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21001467', 'Saksham Kala', 'Nam', to_date('2017-03-28', 'YYYY-MM-DD'), '686 Jha Ganj Vijayanagaram', '06753146380', 'CLC', 'CNPM', 135, 5.11);

INSERT INTO SINHVIEN
VALUES ('SV21001468', 'Mehul Wadhwa', 'Nam', to_date('1971-04-04', 'YYYY-MM-DD'), '81/17 Dhillon Street Bhind', '+912935455262', 'VP', 'TGMT', 39, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21001469', 'Damini Doctor', 'N?', to_date('1998-04-08', 'YYYY-MM-DD'), '22/42 Subramaniam Road Bathinda', '+918414851246', 'CTTT', 'CNTT', 110, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21001470', 'Gokul Karpe', 'Nam', to_date('1940-12-22', 'YYYY-MM-DD'), '03 Sura Nagar Ozhukarai', '04511533180', 'CLC', 'HTTT', 92, 7.68);

INSERT INTO SINHVIEN
VALUES ('SV21001471', 'Vanya Choudhry', 'N?', to_date('1945-10-11', 'YYYY-MM-DD'), 'H.No. 165 Kapadia Zila Khora ', '+915974507343', 'CTTT', 'MMT', 117, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21001472', 'Tiya Khurana', 'Nam', to_date('1944-07-23', 'YYYY-MM-DD'), '39/144 Majumdar Nagar Udaipur', '2909303242', 'VP', 'CNPM', 72, 9.52);

INSERT INTO SINHVIEN
VALUES ('SV21001473', 'Lavanya Ratti', 'Nam', to_date('1990-12-03', 'YYYY-MM-DD'), '60/11 Goyal Road Raurkela Industrial Township', '+918147727905', 'CQ', 'CNTT', 67, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21001474', 'Kabir Kannan', 'Nam', to_date('1992-08-15', 'YYYY-MM-DD'), '58/471 Bose Zila Kollam', '03200451076', 'CTTT', 'MMT', 29, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21001475', 'Romil Ranganathan', 'N?', to_date('1945-06-13', 'YYYY-MM-DD'), '41 Khurana Circle Anantapuram', '04200670027', 'CQ', 'HTTT', 57, 9.06);

INSERT INTO SINHVIEN
VALUES ('SV21001476', 'Hansh Sharma', 'Nam', to_date('1965-09-30', 'YYYY-MM-DD'), '67 Borde Rajkot', '02450843473', 'VP', 'CNTT', 86, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21001477', 'Ritvik Shere', 'N?', to_date('1949-11-14', 'YYYY-MM-DD'), '66 Kumer Street Purnia', '01065069871', 'CTTT', 'TGMT', 109, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21001478', 'Madhav Rao', 'N?', to_date('2016-11-26', 'YYYY-MM-DD'), '436 Bhatnagar Marg Munger', '3879091052', 'CQ', 'CNPM', 6, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21001479', 'Farhan Sha', 'Nam', to_date('2002-07-20', 'YYYY-MM-DD'), 'H.No. 443 Sinha Path Jamalpur', '09616496960', 'CLC', 'CNTT', 103, 7.11);

INSERT INTO SINHVIEN
VALUES ('SV21001480', 'Aarav Verma', 'N?', to_date('1987-06-27', 'YYYY-MM-DD'), '92 Tripathi Ganj Saharsa', '01935096054', 'CLC', 'KHMT', 73, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21001481', 'Anya Datta', 'N?', to_date('1981-04-07', 'YYYY-MM-DD'), '45/04 Bassi Circle Gaya', '2647459684', 'CTTT', 'HTTT', 126, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001482', 'Nakul Bhandari', 'Nam', to_date('1940-04-06', 'YYYY-MM-DD'), 'H.No. 434 Atwal Chowk Parbhani', '09938142426', 'VP', 'TGMT', 2, 6.47);

INSERT INTO SINHVIEN
VALUES ('SV21001483', 'Alisha Dixit', 'N?', to_date('1993-05-21', 'YYYY-MM-DD'), 'H.No. 04 Dey Street Howrah', '9304753326', 'CLC', 'HTTT', 41, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21001484', 'Yuvaan Hans', 'N?', to_date('1994-04-09', 'YYYY-MM-DD'), 'H.No. 783 Jain Ganj Jaipur', '+913172112076', 'CLC', 'CNTT', 21, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21001485', 'Miraya Kadakia', 'Nam', to_date('1982-10-31', 'YYYY-MM-DD'), '89/596 Kalita Ganj Mumbai', '6352805609', 'VP', 'CNPM', 86, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21001486', 'Veer Sidhu', 'Nam', to_date('2017-10-01', 'YYYY-MM-DD'), '97 Tata Chowk Karnal', '04248900798', 'VP', 'CNPM', 104, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21001487', 'Shalv Yadav', 'N?', to_date('2018-04-03', 'YYYY-MM-DD'), '61/789 Jain Road Ballia', '0326721642', 'CLC', 'HTTT', 53, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21001488', 'Madhup Suresh', 'N?', to_date('2004-12-06', 'YYYY-MM-DD'), '22/58 Kamdar Nagar Hindupur', '02792661250', 'CTTT', 'CNPM', 24, 7.74);

INSERT INTO SINHVIEN
VALUES ('SV21001489', 'Mamooty Talwar', 'N?', to_date('1955-07-20', 'YYYY-MM-DD'), '55/660 Khosla Chowk Begusarai', '08620921329', 'CQ', 'CNPM', 93, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21001490', 'Aarna Sankar', 'Nam', to_date('1992-06-11', 'YYYY-MM-DD'), '61 Dey Street Bhatpara', '04457950228', 'VP', 'CNTT', 130, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21001491', 'Krish Samra', 'Nam', to_date('2005-10-30', 'YYYY-MM-DD'), '67 Wable Ganj Machilipatnam', '+915387692807', 'VP', 'TGMT', 1, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21001492', 'Siya Mahal', 'N?', to_date('1987-02-06', 'YYYY-MM-DD'), '612 Sheth Zila Ozhukarai', '05849087473', 'CQ', 'HTTT', 129, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21001493', 'Zoya Tank', 'N?', to_date('1921-11-10', 'YYYY-MM-DD'), '38/71 Sen Path Jamalpur', '+914500785852', 'CLC', 'TGMT', 129, 8.84);

INSERT INTO SINHVIEN
VALUES ('SV21001494', 'Kimaya Sridhar', 'N?', to_date('2011-08-28', 'YYYY-MM-DD'), '29 Apte Zila Ambarnath', '+912143389860', 'CLC', 'MMT', 51, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21001495', 'Shanaya Talwar', 'Nam', to_date('1978-01-15', 'YYYY-MM-DD'), '74/25 Kadakia Ganj Jhansi', '7850459499', 'CQ', 'TGMT', 96, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21001496', 'Veer Mannan', 'Nam', to_date('1988-03-07', 'YYYY-MM-DD'), '16 Bhardwaj Zila Bhatpara', '03749754165', 'CLC', 'KHMT', 92, 6.17);

INSERT INTO SINHVIEN
VALUES ('SV21001497', 'Bhamini Ratti', 'Nam', to_date('1947-02-16', 'YYYY-MM-DD'), '87/839 Lall Ganj Khora ', '+914215184741', 'CQ', 'HTTT', 54, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21001498', 'Darshit Johal', 'N?', to_date('1923-08-21', 'YYYY-MM-DD'), 'H.No. 77 Dhingra Patiala', '09151779625', 'CQ', 'CNPM', 3, 5.25);

INSERT INTO SINHVIEN
VALUES ('SV21001499', 'Jiya Sami', 'N?', to_date('1932-11-23', 'YYYY-MM-DD'), '32 Tak Zila Coimbatore', '2508710105', 'VP', 'CNTT', 24, 5.48);

INSERT INTO SINHVIEN
VALUES ('SV21001500', 'Vritika Mall', 'N?', to_date('2005-10-21', 'YYYY-MM-DD'), '983 Hayer Marg Delhi', '+911725218626', 'CTTT', 'CNTT', 101, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21001501', 'Nitara Shere', 'N?', to_date('1930-12-22', 'YYYY-MM-DD'), 'H.No. 223 Dewan Circle Jalgaon', '05219174347', 'CQ', 'HTTT', 128, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21001502', 'Nitara Mani', 'Nam', to_date('2009-05-22', 'YYYY-MM-DD'), '70 Sura Zila Madurai', '06713587772', 'VP', 'HTTT', 137, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21001503', 'Indranil Sane', 'Nam', to_date('2015-12-23', 'YYYY-MM-DD'), '119 Ghosh Nagar Proddatur', '09213541915', 'CLC', 'TGMT', 32, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21001504', 'Eva Sarma', 'N?', to_date('1945-09-16', 'YYYY-MM-DD'), '13 Rama Street Hajipur', '+910846339768', 'VP', 'CNTT', 67, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21001505', 'Kartik Khosla', 'N?', to_date('1925-08-04', 'YYYY-MM-DD'), 'H.No. 03 Dara Road Motihari', '00617230378', 'VP', 'MMT', 126, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21001506', 'Rania Virk', 'N?', to_date('1939-06-11', 'YYYY-MM-DD'), '74/35 Master Street Shivpuri', '09529749305', 'VP', 'CNTT', 112, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21001507', 'Manjari Yohannan', 'N?', to_date('1950-06-01', 'YYYY-MM-DD'), '62/23 Garde Nagar Haldia', '07475300584', 'CQ', 'CNPM', 51, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21001508', 'Mehul Baria', 'Nam', to_date('1955-05-01', 'YYYY-MM-DD'), '51/942 Tiwari Circle Chinsurah', '02627665998', 'CTTT', 'TGMT', 12, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21001509', 'Navya Ahuja', 'N?', to_date('1910-07-07', 'YYYY-MM-DD'), '146 Koshy Nagar Sasaram', '6721386164', 'CLC', 'TGMT', 72, 7.21);

INSERT INTO SINHVIEN
VALUES ('SV21001510', 'Yakshit Ghose', 'Nam', to_date('1970-04-06', 'YYYY-MM-DD'), '61/22 Kalla Path Varanasi', '04689119412', 'VP', 'HTTT', 88, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21001511', 'Dhruv Bains', 'Nam', to_date('1981-06-10', 'YYYY-MM-DD'), 'H.No. 93 Contractor Path Maheshtala', '+919700066366', 'CTTT', 'KHMT', 94, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21001512', 'Farhan Baria', 'Nam', to_date('1967-01-03', 'YYYY-MM-DD'), 'H.No. 75 Garg Street Danapur', '2808648937', 'VP', 'KHMT', 39, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21001513', 'Zaina Yohannan', 'Nam', to_date('2016-07-25', 'YYYY-MM-DD'), '33 Hora Chowk Rohtak', '+915642299229', 'VP', 'KHMT', 90, 9.12);

INSERT INTO SINHVIEN
VALUES ('SV21001514', 'Ranbir Borra', 'Nam', to_date('1995-05-29', 'YYYY-MM-DD'), 'H.No. 897 Wadhwa Ganj Kolhapur', '02859849982', 'CTTT', 'MMT', 96, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21001515', 'Manikya Varma', 'Nam', to_date('1936-01-05', 'YYYY-MM-DD'), 'H.No. 602 Sem Zila Ghaziabad', '01438996519', 'CLC', 'CNTT', 36, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21001516', 'Miraan Salvi', 'Nam', to_date('1999-08-09', 'YYYY-MM-DD'), 'H.No. 538 Sen Street Mathura', '+910284256991', 'CLC', 'HTTT', 48, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21001517', 'Dharmajan Dugal', 'N?', to_date('1948-12-02', 'YYYY-MM-DD'), '51/90 Gola Street Guna', '5033364287', 'CTTT', 'CNPM', 100, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21001518', 'Nirvaan Aurora', 'N?', to_date('2017-03-16', 'YYYY-MM-DD'), '33/64 Bava Street Panipat', '+914165164438', 'CTTT', 'CNTT', 45, 7.24);

INSERT INTO SINHVIEN
VALUES ('SV21001519', 'Hrishita Chahal', 'Nam', to_date('1984-10-25', 'YYYY-MM-DD'), 'H.No. 094 Choudhary Zila Sambalpur', '03432576383', 'CTTT', 'MMT', 68, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21001520', 'Rohan Venkataraman', 'Nam', to_date('1968-09-28', 'YYYY-MM-DD'), '56/36 D��Alia Path Adoni', '07213139419', 'CTTT', 'TGMT', 137, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21001521', 'Ryan Dash', 'Nam', to_date('1947-07-11', 'YYYY-MM-DD'), '72/912 Sarna Nagar Mysore', '1446010214', 'CLC', 'TGMT', 28, 8.25);

INSERT INTO SINHVIEN
VALUES ('SV21001522', 'Ojas Arya', 'Nam', to_date('1910-08-20', 'YYYY-MM-DD'), 'H.No. 90 Rattan Nagar Udupi', '02082523004', 'VP', 'TGMT', 25, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21001523', 'Veer Kala', 'N?', to_date('2003-06-28', 'YYYY-MM-DD'), '52/100 Shukla Ganj Sirsa', '07260188857', 'CQ', 'MMT', 100, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21001524', 'Raghav Karpe', 'Nam', to_date('1949-01-13', 'YYYY-MM-DD'), '99/18 Dubey Street Naihati', '04609272462', 'VP', 'TGMT', 76, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21001525', 'Sana Aurora', 'N?', to_date('1917-04-30', 'YYYY-MM-DD'), '15/982 Rattan Nagar Gwalior', '5967248644', 'CQ', 'KHMT', 94, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21001526', 'Nehmat Dash', 'N?', to_date('1915-05-10', 'YYYY-MM-DD'), '533 Soni Path Ratlam', '1518758468', 'CTTT', 'KHMT', 131, 5.4);

INSERT INTO SINHVIEN
VALUES ('SV21001527', 'Rati Shankar', 'Nam', to_date('2009-08-13', 'YYYY-MM-DD'), '23/975 Deep Path Unnao', '2633356851', 'CTTT', 'TGMT', 132, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21001528', 'Bhavin Dugar', 'Nam', to_date('1996-11-13', 'YYYY-MM-DD'), '246 Barman Anantapur', '0802015075', 'CQ', 'HTTT', 91, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21001529', 'Elakshi Choudhary', 'N?', to_date('1929-12-21', 'YYYY-MM-DD'), '824 Kapadia Marg Dhanbad', '4099255869', 'CLC', 'TGMT', 32, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21001530', 'Oorja Sule', 'Nam', to_date('1970-03-05', 'YYYY-MM-DD'), '26/15 Tara Chowk Khora ', '07143626615', 'CTTT', 'CNTT', 5, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21001531', 'Aniruddh Bhat', 'Nam', to_date('1990-08-10', 'YYYY-MM-DD'), '65/377 Batta Varanasi', '01638692027', 'CTTT', 'HTTT', 119, 9.43);

INSERT INTO SINHVIEN
VALUES ('SV21001532', 'Drishya Dua', 'N?', to_date('1942-09-09', 'YYYY-MM-DD'), '70 Dhingra Path Tiruvottiyur', '7010165774', 'CTTT', 'CNTT', 73, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21001533', 'Manjari Mani', 'Nam', to_date('1911-02-06', 'YYYY-MM-DD'), '96 Sandal Marg Unnao', '+918686371472', 'CLC', 'CNTT', 1, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21001534', 'Anay Doshi', 'N?', to_date('2016-08-25', 'YYYY-MM-DD'), '07 Reddy Circle New Delhi', '00777638333', 'CQ', 'MMT', 46, 8.24);

INSERT INTO SINHVIEN
VALUES ('SV21001535', 'Ira Shan', 'Nam', to_date('1978-10-05', 'YYYY-MM-DD'), 'H.No. 31 Ratta Marg Pune', '+913428547620', 'CTTT', 'MMT', 136, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21001536', 'Alisha Bhatt', 'Nam', to_date('1913-01-15', 'YYYY-MM-DD'), '44 Sahni Road Munger', '0979552715', 'CQ', 'KHMT', 39, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21001537', 'Yuvaan Aurora', 'N?', to_date('1937-08-15', 'YYYY-MM-DD'), '16/637 Brar Pondicherry', '+916527409187', 'VP', 'KHMT', 127, 4.67);

INSERT INTO SINHVIEN
VALUES ('SV21001538', 'Shayak Bhatt', 'Nam', to_date('1948-01-14', 'YYYY-MM-DD'), '64 Swamy Path Singrauli', '08518833266', 'CTTT', 'MMT', 67, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21001539', 'Drishya Mammen', 'Nam', to_date('1942-05-30', 'YYYY-MM-DD'), 'H.No. 016 Khalsa Karaikudi', '5958230788', 'VP', 'TGMT', 43, 5.79);

INSERT INTO SINHVIEN
VALUES ('SV21001540', 'Parinaaz Rout', 'N?', to_date('2013-05-10', 'YYYY-MM-DD'), 'H.No. 88 Dani Ganj Bijapur', '+919828316771', 'CLC', 'KHMT', 20, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21001541', 'Miraya Divan', 'Nam', to_date('1943-06-09', 'YYYY-MM-DD'), 'H.No. 89 Chanda Chowk Haldia', '5159842471', 'CLC', 'CNPM', 6, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21001542', 'Jayesh Krishnan', 'N?', to_date('1930-06-18', 'YYYY-MM-DD'), 'H.No. 87 Dhingra Chowk Machilipatnam', '8996280288', 'VP', 'CNPM', 96, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21001543', 'Raghav Roy', 'N?', to_date('1938-06-06', 'YYYY-MM-DD'), 'H.No. 763 Ganesh Panchkula', '08686329581', 'CLC', 'CNTT', 29, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21001544', 'Rati Sarin', 'N?', to_date('1984-12-12', 'YYYY-MM-DD'), '38/37 Bhatia Nagar Faridabad', '+911167541649', 'CQ', 'KHMT', 102, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21001545', 'Tara Keer', 'Nam', to_date('2004-04-21', 'YYYY-MM-DD'), '346 Balay Nagar Karimnagar', '+912642739675', 'VP', 'MMT', 56, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21001546', 'Mahika Bahl', 'N?', to_date('1923-12-22', 'YYYY-MM-DD'), '725 Master Nagar Kavali', '01406402329', 'CLC', 'TGMT', 40, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21001547', 'Hunar Varkey', 'Nam', to_date('1934-07-30', 'YYYY-MM-DD'), '598 Kashyap Road Aurangabad', '07963384421', 'CLC', 'MMT', 85, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21001548', 'Diya Sandhu', 'Nam', to_date('1950-02-07', 'YYYY-MM-DD'), '091 Bath Ganj Hindupur', '4393935551', 'CTTT', 'CNPM', 4, 9.38);

INSERT INTO SINHVIEN
VALUES ('SV21001549', 'Kartik Ahuja', 'Nam', to_date('1996-02-14', 'YYYY-MM-DD'), 'H.No. 42 Dey Zila Bally', '+918416401735', 'CLC', 'CNPM', 4, 9.41);

INSERT INTO SINHVIEN
VALUES ('SV21001550', 'Eva Dhillon', 'N?', to_date('1919-06-09', 'YYYY-MM-DD'), '96/935 Dixit Road Chinsurah', '06674674825', 'CLC', 'TGMT', 3, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21001551', 'Aradhya Sekhon', 'N?', to_date('2008-05-14', 'YYYY-MM-DD'), '13 Sachdev Road Jammu', '08229571194', 'CQ', 'MMT', 40, 5.86);

INSERT INTO SINHVIEN
VALUES ('SV21001552', 'Indranil Chander', 'N?', to_date('1922-12-30', 'YYYY-MM-DD'), 'H.No. 99 Ganguly Zila Kalyan-Dombivli', '+911140663566', 'CTTT', 'CNTT', 34, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21001553', 'Nirvi Rau', 'N?', to_date('1916-10-18', 'YYYY-MM-DD'), 'H.No. 702 Varghese Road Coimbatore', '01115152826', 'CTTT', 'HTTT', 90, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21001554', 'Madhup Golla', 'N?', to_date('1962-08-01', 'YYYY-MM-DD'), '91/451 Biswas Nagar Bhavnagar', '9578129132', 'VP', 'CNTT', 100, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21001555', 'Neelofar Chhabra', 'N?', to_date('2014-01-18', 'YYYY-MM-DD'), 'H.No. 81 Tata Marg Kottayam', '+912245837324', 'VP', 'CNPM', 5, 6.06);

INSERT INTO SINHVIEN
VALUES ('SV21001556', 'Sumer Bajaj', 'Nam', to_date('1983-07-21', 'YYYY-MM-DD'), 'H.No. 21 Brahmbhatt Chowk Deoghar', '+911234268647', 'CQ', 'CNPM', 93, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21001557', 'Shamik Mandal', 'Nam', to_date('1944-02-27', 'YYYY-MM-DD'), '55 Babu Road Malda', '5899282507', 'CTTT', 'HTTT', 116, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21001558', 'Jhanvi Bajwa', 'Nam', to_date('2022-09-17', 'YYYY-MM-DD'), 'H.No. 03 Varughese Marg Patiala', '+913987763754', 'CQ', 'KHMT', 137, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21001559', 'Taimur Amble', 'N?', to_date('1981-12-17', 'YYYY-MM-DD'), '85/61 Dara Ganj Farrukhabad', '7039653551', 'CQ', 'CNPM', 85, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21001560', 'Vanya Garde', 'N?', to_date('2016-07-19', 'YYYY-MM-DD'), 'H.No. 623 Kalla Ganj Gaya', '3069626545', 'CLC', 'CNPM', 0, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21001561', 'Amani Buch', 'N?', to_date('1935-06-05', 'YYYY-MM-DD'), '54/06 Goyal Nagar Motihari', '4800487324', 'CLC', 'CNPM', 13, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21001562', 'Adah Bhat', 'Nam', to_date('2004-03-30', 'YYYY-MM-DD'), '217 Gera Bhiwandi', '3984908441', 'VP', 'KHMT', 34, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001563', 'Mishti Sharma', 'Nam', to_date('1976-09-06', 'YYYY-MM-DD'), 'H.No. 322 Ghose Street Dharmavaram', '1771696472', 'VP', 'KHMT', 101, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21001564', 'Vivaan Rastogi', 'N?', to_date('1958-04-30', 'YYYY-MM-DD'), '858 Sheth Chowk Secunderabad', '9152071859', 'CTTT', 'CNTT', 116, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21001565', 'Tejas Sur', 'Nam', to_date('1967-08-01', 'YYYY-MM-DD'), '78/19 Sarkar Zila Ghaziabad', '2629013789', 'CTTT', 'TGMT', 88, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21001566', 'Himmat Deshpande', 'N?', to_date('2006-05-17', 'YYYY-MM-DD'), 'H.No. 631 Cheema Gandhidham', '+910793017746', 'CTTT', 'CNPM', 119, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21001567', 'Navya Kuruvilla', 'N?', to_date('2000-10-24', 'YYYY-MM-DD'), '94/77 Majumdar Mahbubnagar', '3849935508', 'CTTT', 'TGMT', 138, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21001568', 'Umang Sinha', 'N?', to_date('1916-06-12', 'YYYY-MM-DD'), '54/917 Banik Circle Bettiah', '05184009476', 'VP', 'TGMT', 129, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21001569', 'Priyansh Sami', 'N?', to_date('1912-03-30', 'YYYY-MM-DD'), '26/782 Khatri Street Mumbai', '00841579526', 'CTTT', 'KHMT', 63, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21001570', 'Krish Dutta', 'N?', to_date('2010-05-30', 'YYYY-MM-DD'), '72 Badami Circle Loni', '5383692033', 'CTTT', 'CNPM', 77, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21001571', 'Ishita Yohannan', 'N?', to_date('1978-04-30', 'YYYY-MM-DD'), '87/60 Goda Path Bhiwani', '+919300700995', 'CTTT', 'MMT', 119, 6.27);

INSERT INTO SINHVIEN
VALUES ('SV21001572', 'Sahil Gupta', 'N?', to_date('1987-09-07', 'YYYY-MM-DD'), '66/12 Chandran Road Suryapet', '06095775525', 'VP', 'CNTT', 125, 6.91);

INSERT INTO SINHVIEN
VALUES ('SV21001573', 'Piya Varughese', 'Nam', to_date('1933-10-07', 'YYYY-MM-DD'), '80 Shah Ganj Thane', '8191742830', 'CLC', 'KHMT', 38, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21001574', 'Eva Kakar', 'Nam', to_date('1981-06-27', 'YYYY-MM-DD'), 'H.No. 56 Jhaveri Marg Kulti', '+917561258045', 'CTTT', 'TGMT', 121, 7.11);

INSERT INTO SINHVIEN
VALUES ('SV21001575', 'Divij Amble', 'N?', to_date('1988-02-01', 'YYYY-MM-DD'), '29/994 Bala Circle Alwar', '09585248582', 'CLC', 'HTTT', 127, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21001576', 'Nehmat Bassi', 'N?', to_date('1912-05-09', 'YYYY-MM-DD'), 'H.No. 587 Rau Road Lucknow', '5174425369', 'CQ', 'TGMT', 72, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21001577', 'Ivan Krishnamurthy', 'Nam', to_date('1946-12-10', 'YYYY-MM-DD'), 'H.No. 279 Chopra Road Chittoor', '2475873500', 'CLC', 'CNPM', 82, 4.08);

INSERT INTO SINHVIEN
VALUES ('SV21001578', 'Kiara Kuruvilla', 'N?', to_date('1934-11-15', 'YYYY-MM-DD'), '968 Sani Nagar Chennai', '5943095394', 'VP', 'CNTT', 90, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21001579', 'Baiju Rout', 'N?', to_date('1923-04-20', 'YYYY-MM-DD'), '75 Warrior Agra', '+917065604210', 'VP', 'MMT', 50, 5.23);

INSERT INTO SINHVIEN
VALUES ('SV21001580', 'Amani Samra', 'N?', to_date('1932-10-03', 'YYYY-MM-DD'), '604 Khatri Street Asansol', '+911144018062', 'CQ', 'KHMT', 61, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21001581', 'Seher Rajagopalan', 'Nam', to_date('1954-01-06', 'YYYY-MM-DD'), '25/69 Upadhyay Mysore', '02575726805', 'CTTT', 'HTTT', 137, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21001582', 'Bhamini Chaudhry', 'Nam', to_date('1944-01-25', 'YYYY-MM-DD'), 'H.No. 083 Madan Nagar Ujjain', '04521147284', 'CQ', 'HTTT', 15, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21001583', 'Kashvi Rastogi', 'Nam', to_date('1988-11-13', 'YYYY-MM-DD'), 'H.No. 936 Shenoy Nagar Shahjahanpur', '+919326271061', 'VP', 'HTTT', 85, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21001584', 'Sumer Kade', 'Nam', to_date('2018-04-03', 'YYYY-MM-DD'), '694 Lall Maheshtala', '01858116703', 'CTTT', 'CNPM', 65, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21001585', 'Dhruv Sarraf', 'Nam', to_date('1975-08-22', 'YYYY-MM-DD'), '90 Kala Circle Bangalore', '2254958845', 'CQ', 'HTTT', 60, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21001586', 'Krish Buch', 'N?', to_date('2014-04-24', 'YYYY-MM-DD'), '490 Arya Road Solapur', '+910034084803', 'CQ', 'CNPM', 133, 9.28);

INSERT INTO SINHVIEN
VALUES ('SV21001587', 'Shray Sarna', 'N?', to_date('1951-04-20', 'YYYY-MM-DD'), '02/88 Chatterjee Nagar Saharsa', '06594032748', 'VP', 'CNTT', 118, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21001588', 'Eva Venkataraman', 'N?', to_date('1986-07-18', 'YYYY-MM-DD'), '51/60 Rastogi North Dumdum', '+913703302396', 'CLC', 'CNTT', 95, 8.49);

INSERT INTO SINHVIEN
VALUES ('SV21001589', 'Ela Dara', 'Nam', to_date('1960-05-14', 'YYYY-MM-DD'), '74/49 Gade Imphal', '5947917786', 'CTTT', 'CNPM', 92, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21001590', 'Nitara Dugar', 'N?', to_date('1986-04-08', 'YYYY-MM-DD'), 'H.No. 632 Gandhi Path Patna', '1419839001', 'CTTT', 'HTTT', 116, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21001591', 'Mehul Khurana', 'Nam', to_date('1978-12-02', 'YYYY-MM-DD'), '63/268 Sinha Marg Bettiah', '9649635173', 'CQ', 'KHMT', 31, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21001592', 'Ritvik Ben', 'N?', to_date('1985-03-08', 'YYYY-MM-DD'), '99/37 Ratti Path Kakinada', '07752262633', 'CLC', 'HTTT', 102, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21001593', 'Abram Wali', 'Nam', to_date('2022-10-29', 'YYYY-MM-DD'), '683 Roy Uluberia', '1725353529', 'CQ', 'CNPM', 51, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21001594', 'Akarsh Saha', 'N?', to_date('2019-10-19', 'YYYY-MM-DD'), '29/684 Sha Chowk Bidar', '5642238513', 'CLC', 'TGMT', 25, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21001595', 'Shanaya Sachdeva', 'Nam', to_date('1916-09-24', 'YYYY-MM-DD'), 'H.No. 90 Chokshi Marg Nanded', '06949178828', 'VP', 'CNTT', 119, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21001596', 'Zeeshan Arya', 'Nam', to_date('1916-06-18', 'YYYY-MM-DD'), '175 Contractor Nagar Tadipatri', '02387444266', 'CTTT', 'CNTT', 26, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21001597', 'Ivana Gala', 'Nam', to_date('1977-02-28', 'YYYY-MM-DD'), '17 Kumar Ganj Warangal', '5384272086', 'CQ', 'KHMT', 22, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21001598', 'Aarav Rau', 'N?', to_date('1976-11-07', 'YYYY-MM-DD'), '56/519 Mahajan Path Srikakulam', '+919813539398', 'CTTT', 'KHMT', 100, 6.52);

INSERT INTO SINHVIEN
VALUES ('SV21001599', 'Ivana Sanghvi', 'N?', to_date('2004-03-30', 'YYYY-MM-DD'), 'H.No. 240 Sankar Circle Belgaum', '0470745478', 'VP', 'HTTT', 120, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21001600', 'Advik Bava', 'Nam', to_date('1963-06-01', 'YYYY-MM-DD'), '53/772 Kapoor Chowk Dindigul', '+910322871728', 'CQ', 'CNPM', 122, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21001601', 'Hrishita Manda', 'Nam', to_date('1930-02-05', 'YYYY-MM-DD'), 'H.No. 069 Chada Path Bhatpara', '+910254705443', 'VP', 'TGMT', 24, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21001602', 'Stuvan Sodhi', 'N?', to_date('1961-08-08', 'YYYY-MM-DD'), 'H.No. 97 Sodhi Chowk Kurnool', '02982997114', 'VP', 'KHMT', 30, 7.2);

INSERT INTO SINHVIEN
VALUES ('SV21001603', 'Ishaan Dhingra', 'N?', to_date('2019-04-02', 'YYYY-MM-DD'), 'H.No. 96 Korpal Amravati', '05671354273', 'CLC', 'MMT', 90, 8.24);

INSERT INTO SINHVIEN
VALUES ('SV21001604', 'Jhanvi Venkataraman', 'N?', to_date('2019-03-20', 'YYYY-MM-DD'), 'H.No. 220 Hegde Chowk Jehanabad', '+918719267519', 'CLC', 'TGMT', 112, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21001605', 'Ahana  Ganesan', 'Nam', to_date('1949-05-29', 'YYYY-MM-DD'), '264 Khare Ganj Khandwa', '+919928118123', 'CTTT', 'CNTT', 8, 9.43);

INSERT INTO SINHVIEN
VALUES ('SV21001606', 'Advik Mandal', 'N?', to_date('1999-06-08', 'YYYY-MM-DD'), 'H.No. 038 Barman Road Raichur', '+914890435888', 'CLC', 'KHMT', 65, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21001607', 'Kaira Dhawan', 'Nam', to_date('1994-05-23', 'YYYY-MM-DD'), '48 Walla Chowk Amroha', '07324007266', 'CTTT', 'CNPM', 114, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21001608', 'Hunar Doctor', 'Nam', to_date('1998-06-07', 'YYYY-MM-DD'), '293 Wason Circle Dhule', '8535875376', 'CLC', 'HTTT', 67, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21001609', 'Onkar Banik', 'N?', to_date('1985-08-04', 'YYYY-MM-DD'), '822 Sarna Jamnagar', '8714866363', 'CTTT', 'TGMT', 11, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21001610', 'Yakshit Bhandari', 'Nam', to_date('1976-09-12', 'YYYY-MM-DD'), '351 Bhagat Ganj Naihati', '5567543893', 'VP', 'TGMT', 78, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21001611', 'Anaya Ben', 'N?', to_date('1958-03-02', 'YYYY-MM-DD'), '18/94 Gola Zila Kumbakonam', '01946883421', 'CQ', 'CNPM', 44, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21001612', 'Divyansh Gole', 'N?', to_date('1971-08-21', 'YYYY-MM-DD'), '28/68 Bora Path Ozhukarai', '01132751167', 'VP', 'TGMT', 63, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21001613', 'Aarav Kade', 'N?', to_date('1983-05-08', 'YYYY-MM-DD'), '62/28 Mander Junagadh', '7919516983', 'CQ', 'CNPM', 37, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21001614', 'Dishani Jaggi', 'N?', to_date('1998-08-21', 'YYYY-MM-DD'), '59 Kala Circle Ongole', '07286491420', 'CLC', 'MMT', 86, 6.83);

INSERT INTO SINHVIEN
VALUES ('SV21001615', 'Reyansh Rau', 'Nam', to_date('1963-09-08', 'YYYY-MM-DD'), 'H.No. 546 Raja Ganj Rohtak', '0675346551', 'VP', 'KHMT', 69, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21001616', 'Nehmat Warrior', 'N?', to_date('1952-12-18', 'YYYY-MM-DD'), '849 Aurora Path Bharatpur', '04445872748', 'CLC', 'KHMT', 52, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21001617', 'Seher Kanda', 'Nam', to_date('1964-12-21', 'YYYY-MM-DD'), '03 Dhar Road Sasaram', '5446143782', 'CQ', 'CNTT', 137, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21001618', 'Nehmat Salvi', 'N?', to_date('2005-02-11', 'YYYY-MM-DD'), 'H.No. 57 Chopra Chowk Ludhiana', '+919630468936', 'CLC', 'KHMT', 57, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21001619', 'Ivana Hari', 'N?', to_date('1985-04-13', 'YYYY-MM-DD'), 'H.No. 53 Jhaveri Marg Indore', '3658857847', 'CLC', 'CNTT', 45, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21001620', 'Veer Kaur', 'N?', to_date('2006-01-13', 'YYYY-MM-DD'), '193 Kohli Street Kottayam', '+919948502646', 'CLC', 'TGMT', 75, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21001621', 'Hridaan Sangha', 'Nam', to_date('1963-07-26', 'YYYY-MM-DD'), 'H.No. 23 Ramachandran Path Malegaon', '02868051621', 'CTTT', 'TGMT', 89, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21001622', 'Aarav Barad', 'N?', to_date('2005-12-15', 'YYYY-MM-DD'), 'H.No. 518 Sengupta Path Siliguri', '03108678044', 'CLC', 'CNTT', 136, 9.97);

INSERT INTO SINHVIEN
VALUES ('SV21001623', 'Krish Kuruvilla', 'Nam', to_date('1939-07-30', 'YYYY-MM-DD'), '57/811 Jani Ganj Hajipur', '04056062129', 'VP', 'MMT', 130, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21001624', 'Ivana Deo', 'N?', to_date('1982-09-24', 'YYYY-MM-DD'), '93/65 Sachdeva Nagar Chennai', '06707571783', 'CLC', 'TGMT', 30, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21001625', 'Mohanlal Kannan', 'N?', to_date('1993-11-27', 'YYYY-MM-DD'), '216 Raval Nagar Ongole', '7714816434', 'CTTT', 'KHMT', 37, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21001626', 'Amira Kade', 'N?', to_date('2009-05-30', 'YYYY-MM-DD'), '81/63 Varma Karaikudi', '05138071349', 'VP', 'CNTT', 22, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21001627', 'Yuvaan Desai', 'Nam', to_date('1928-09-08', 'YYYY-MM-DD'), 'H.No. 281 Vyas Marg Karawal Nagar', '+912999485699', 'CLC', 'TGMT', 133, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21001628', 'Madhav Sarraf', 'N?', to_date('1969-08-03', 'YYYY-MM-DD'), '92/937 Sankaran Path Nagaon', '02374181824', 'CLC', 'KHMT', 138, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21001629', 'Alia Saraf', 'Nam', to_date('1996-03-08', 'YYYY-MM-DD'), 'H.No. 05 Shan Path Bareilly', '0610101210', 'CLC', 'HTTT', 44, 9.65);

INSERT INTO SINHVIEN
VALUES ('SV21001630', 'Nayantara Rajan', 'N?', to_date('1968-01-23', 'YYYY-MM-DD'), '62/560 Khurana Zila South Dumdum', '+916906052850', 'CLC', 'TGMT', 99, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21001631', 'Shray Kala', 'N?', to_date('1973-07-02', 'YYYY-MM-DD'), 'H.No. 92 Srinivas Road Raiganj', '1562250410', 'CQ', 'CNTT', 69, 4.82);

INSERT INTO SINHVIEN
VALUES ('SV21001632', 'Heer Choudhry', 'N?', to_date('2012-01-25', 'YYYY-MM-DD'), 'H.No. 221 Arora Street Mathura', '+916629324888', 'CTTT', 'HTTT', 28, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21001633', 'Darshit Bhavsar', 'Nam', to_date('1998-12-12', 'YYYY-MM-DD'), '340 Sridhar Zila Bhatpara', '7438398261', 'CTTT', 'CNPM', 118, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21001634', 'Ivana Goda', 'N?', to_date('2012-08-07', 'YYYY-MM-DD'), '20/65 Savant Chowk Tiruchirappalli', '8765026109', 'VP', 'MMT', 119, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21001635', 'Kiaan Krishnamurthy', 'N?', to_date('1939-04-25', 'YYYY-MM-DD'), 'H.No. 144 Ghosh Path Berhampur', '+918781617156', 'CQ', 'CNPM', 115, 9.46);

INSERT INTO SINHVIEN
VALUES ('SV21001636', 'Rhea Agarwal', 'N?', to_date('1953-09-23', 'YYYY-MM-DD'), '693 Issac Nagar Muzaffarpur', '+919505453363', 'CQ', 'HTTT', 111, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21001637', 'Piya Vohra', 'N?', to_date('1939-02-25', 'YYYY-MM-DD'), '98/93 Kala Nagar Thiruvananthapuram', '9972891668', 'CLC', 'CNPM', 101, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21001638', 'Jiya Tata', 'Nam', to_date('1915-12-10', 'YYYY-MM-DD'), '325 Chawla Zila Anantapur', '5172726062', 'CQ', 'CNPM', 114, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21001639', 'Kanav Shankar', 'N?', to_date('1937-12-11', 'YYYY-MM-DD'), 'H.No. 58 Khalsa Circle Rajahmundry', '3983676818', 'VP', 'MMT', 38, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21001640', 'Heer Kale', 'Nam', to_date('1911-09-21', 'YYYY-MM-DD'), 'H.No. 580 Chaudhary Path Kamarhati', '5917578180', 'CQ', 'TGMT', 99, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21001641', 'Lakshay Shroff', 'Nam', to_date('2015-01-10', 'YYYY-MM-DD'), '149 Comar Circle Kumbakonam', '02974771739', 'VP', 'TGMT', 132, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21001642', 'Onkar Das', 'Nam', to_date('1935-12-09', 'YYYY-MM-DD'), '04/147 Soman Zila Hosur', '+919736631005', 'VP', 'CNTT', 34, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21001643', 'Tiya Zachariah', 'Nam', to_date('2015-04-07', 'YYYY-MM-DD'), '19/98 Choudhury Path Ghaziabad', '3527952241', 'CTTT', 'MMT', 83, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21001644', 'Charvi Gole', 'Nam', to_date('1972-03-09', 'YYYY-MM-DD'), '09/396 Srinivas Nagar Silchar', '1744319012', 'VP', 'CNPM', 37, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21001645', 'Fateh Datta', 'N?', to_date('1921-12-30', 'YYYY-MM-DD'), '32/361 Kulkarni Zila Haldia', '+910356840871', 'CQ', 'MMT', 39, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21001646', 'Emir Aggarwal', 'Nam', to_date('1996-09-30', 'YYYY-MM-DD'), 'H.No. 76 Kashyap Road Bhimavaram', '+913920887358', 'CQ', 'KHMT', 19, 6.84);

INSERT INTO SINHVIEN
VALUES ('SV21001647', 'Manjari Ghosh', 'N?', to_date('1947-08-09', 'YYYY-MM-DD'), '36 Gala Zila Danapur', '+916295242339', 'VP', 'HTTT', 3, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21001648', 'Ryan Chawla', 'Nam', to_date('1975-04-08', 'YYYY-MM-DD'), '25/633 Bhatnagar Ganj New Delhi', '9214402836', 'CTTT', 'HTTT', 12, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21001649', 'Anahi Virk', 'N?', to_date('2013-12-11', 'YYYY-MM-DD'), '349 Gara Street Indore', '+910655362254', 'CLC', 'CNPM', 5, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21001650', 'Aarna Bhardwaj', 'N?', to_date('1948-01-26', 'YYYY-MM-DD'), '153 Hayer Path Bally', '+914647489832', 'CLC', 'MMT', 47, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21001651', 'Eshani Mannan', 'N?', to_date('1972-12-31', 'YYYY-MM-DD'), 'H.No. 34 Golla Path Ujjain', '+910771765762', 'CTTT', 'MMT', 12, 8.29);

INSERT INTO SINHVIEN
VALUES ('SV21001652', 'Mohanlal Sama', 'Nam', to_date('1959-06-04', 'YYYY-MM-DD'), 'H.No. 001 Goyal Zila Chapra', '+918782068965', 'CLC', 'TGMT', 18, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21001653', 'Tara Issac', 'N?', to_date('1920-07-23', 'YYYY-MM-DD'), '45/028 Ravi Marg Warangal', '+915901533674', 'CQ', 'HTTT', 109, 6.65);

INSERT INTO SINHVIEN
VALUES ('SV21001654', 'Shalv Mander', 'Nam', to_date('1994-10-12', 'YYYY-MM-DD'), '162 Basu Path Tenali', '+916454327322', 'VP', 'TGMT', 97, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21001655', 'Tanya Master', 'N?', to_date('1952-07-27', 'YYYY-MM-DD'), '416 Balasubramanian Path Thoothukudi', '+910040210960', 'CLC', 'CNPM', 12, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21001656', 'Misha Doctor', 'N?', to_date('1948-08-10', 'YYYY-MM-DD'), 'H.No. 303 Singh Road Bettiah', '+915196203686', 'CQ', 'HTTT', 125, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21001657', 'Mishti Sinha', 'Nam', to_date('1954-05-22', 'YYYY-MM-DD'), '34/27 Khurana Gudivada', '4746353040', 'VP', 'KHMT', 63, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21001658', 'Dishani Kara', 'Nam', to_date('1989-10-12', 'YYYY-MM-DD'), '04/90 Sarkar Chowk Kamarhati', '3005967236', 'CLC', 'TGMT', 12, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21001659', 'Mehul Solanki', 'Nam', to_date('2007-12-22', 'YYYY-MM-DD'), '02 Kala Street Srikakulam', '+919712187022', 'CQ', 'TGMT', 50, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21001660', 'Yashvi Gola', 'Nam', to_date('1999-12-02', 'YYYY-MM-DD'), '076 Arora Street Junagadh', '05867290875', 'CTTT', 'CNTT', 12, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21001661', 'Alisha Grewal', 'N?', to_date('1989-03-11', 'YYYY-MM-DD'), 'H.No. 83 Deshpande Marg Allahabad', '04759717836', 'VP', 'MMT', 115, 7.52);

INSERT INTO SINHVIEN
VALUES ('SV21001662', 'Priyansh Agrawal', 'N?', to_date('1976-04-13', 'YYYY-MM-DD'), '63/94 Ramanathan Bhagalpur', '+916069272590', 'CLC', 'KHMT', 61, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21001663', 'Hansh Shanker', 'Nam', to_date('1978-08-16', 'YYYY-MM-DD'), '43/95 Wadhwa Nagar Jorhat', '1690059411', 'CTTT', 'KHMT', 12, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21001664', 'Vivaan Joshi', 'Nam', to_date('1939-10-28', 'YYYY-MM-DD'), '10/967 Lalla Marg Sri Ganganagar', '7376653436', 'CTTT', 'CNPM', 123, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21001665', 'Biju Kakar', 'N?', to_date('1973-09-28', 'YYYY-MM-DD'), '13/55 Sampath Marg Nizamabad', '04983479485', 'CTTT', 'KHMT', 29, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21001666', 'Divit Ahuja', 'N?', to_date('1926-10-17', 'YYYY-MM-DD'), 'H.No. 66 Kumer Circle Karaikudi', '+911027183057', 'VP', 'TGMT', 77, 7.5);

INSERT INTO SINHVIEN
VALUES ('SV21001667', 'Abram Sengupta', 'N?', to_date('1923-05-11', 'YYYY-MM-DD'), '13/82 Sheth Street Raichur', '09926679330', 'CLC', 'CNPM', 91, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21001668', 'Hiran Chhabra', 'Nam', to_date('1938-08-26', 'YYYY-MM-DD'), '49 Chaudhuri Nagar Ujjain', '+910508934133', 'VP', 'HTTT', 46, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21001669', 'Miraan Dey', 'N?', to_date('2006-05-03', 'YYYY-MM-DD'), 'H.No. 41 Lala Nagar Mysore', '8720891989', 'CQ', 'KHMT', 101, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21001670', 'Kiaan Venkatesh', 'N?', to_date('1939-04-19', 'YYYY-MM-DD'), 'H.No. 91 Saxena Street Sambalpur', '+915020900167', 'VP', 'TGMT', 101, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21001671', 'Inaaya  Dar', 'Nam', to_date('1980-01-16', 'YYYY-MM-DD'), '303 Saraf Nashik', '2688508978', 'CTTT', 'KHMT', 62, 6.27);

INSERT INTO SINHVIEN
VALUES ('SV21001672', 'Ishaan Upadhyay', 'N?', to_date('1920-11-16', 'YYYY-MM-DD'), '906 Bala Zila South Dumdum', '+914056379318', 'CLC', 'KHMT', 130, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21001673', 'Hiran Vig', 'Nam', to_date('1922-11-22', 'YYYY-MM-DD'), '81/02 Kari Zila Bidhannagar', '3850420619', 'CQ', 'TGMT', 40, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21001674', 'Damini Rastogi', 'Nam', to_date('1938-11-12', 'YYYY-MM-DD'), 'H.No. 75 Tailor Nagar Madanapalle', '+912869307185', 'CLC', 'CNPM', 56, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21001675', 'Dishani Tara', 'Nam', to_date('1956-01-04', 'YYYY-MM-DD'), '17 Balasubramanian Road Hubli�CDharwad', '00712621249', 'CLC', 'KHMT', 81, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21001676', 'Rohan Kashyap', 'Nam', to_date('1926-11-11', 'YYYY-MM-DD'), 'H.No. 08 Kata Ganj Sasaram', '06739681704', 'VP', 'KHMT', 10, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21001677', 'Arnav Goel', 'Nam', to_date('1961-09-27', 'YYYY-MM-DD'), '76 Dani Ganj Uluberia', '05504526568', 'VP', 'HTTT', 96, 8.56);

INSERT INTO SINHVIEN
VALUES ('SV21001678', 'Badal Virk', 'Nam', to_date('1916-08-04', 'YYYY-MM-DD'), '71/366 Kapadia Tadepalligudem', '9334504777', 'CLC', 'CNPM', 100, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21001679', 'Anya Chaudry', 'Nam', to_date('1988-09-24', 'YYYY-MM-DD'), 'H.No. 91 Sura Road Darbhanga', '+919699196911', 'CTTT', 'TGMT', 4, 9.28);

INSERT INTO SINHVIEN
VALUES ('SV21001680', 'Anay Dasgupta', 'N?', to_date('1982-01-16', 'YYYY-MM-DD'), '81/96 Verma Path Navi Mumbai', '9272696767', 'CQ', 'TGMT', 116, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21001681', 'Heer Hari', 'N?', to_date('2005-06-12', 'YYYY-MM-DD'), '63/77 Bhat Nagar Vijayawada', '06527391678', 'CQ', 'TGMT', 41, 6.33);

INSERT INTO SINHVIEN
VALUES ('SV21001682', 'Yashvi Gopal', 'Nam', to_date('1985-12-27', 'YYYY-MM-DD'), '60/08 Cherian Nagar Gopalpur', '05959921274', 'CLC', 'CNPM', 138, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21001683', 'Reyansh Ravi', 'N?', to_date('1999-02-01', 'YYYY-MM-DD'), '53 Bumb Street Ratlam', '09038727867', 'CLC', 'CNTT', 76, 4.51);

INSERT INTO SINHVIEN
VALUES ('SV21001684', 'Anahita Dara', 'Nam', to_date('1924-04-25', 'YYYY-MM-DD'), '21 Gokhale Path Jodhpur', '+911743499807', 'VP', 'TGMT', 127, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21001685', 'Riaan Saraf', 'N?', to_date('1977-12-21', 'YYYY-MM-DD'), 'H.No. 70 Chaudhuri Road Rajkot', '+911999902956', 'CLC', 'TGMT', 61, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21001686', 'Zara D��Alia', 'Nam', to_date('1927-10-22', 'YYYY-MM-DD'), '24 Sant Ganj Ulhasnagar', '00594563369', 'CLC', 'CNTT', 127, 6.17);

INSERT INTO SINHVIEN
VALUES ('SV21001687', 'Kanav Rout', 'Nam', to_date('1944-07-04', 'YYYY-MM-DD'), '47/399 Chatterjee Ganj Chandigarh', '+917190142946', 'CLC', 'MMT', 96, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21001688', 'Lakshay Bhattacharyya', 'N?', to_date('1954-02-09', 'YYYY-MM-DD'), '97/721 Issac Circle Kottayam', '+917375428353', 'CTTT', 'CNPM', 36, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21001689', 'Darshit Krishnan', 'N?', to_date('1930-05-23', 'YYYY-MM-DD'), 'H.No. 25 Rau Circle Naihati', '07151590492', 'CLC', 'CNPM', 90, 6.18);

INSERT INTO SINHVIEN
VALUES ('SV21001690', 'Zara Babu', 'Nam', to_date('2017-10-16', 'YYYY-MM-DD'), '87/260 Upadhyay Nagar Morbi', '+915449046468', 'CLC', 'CNPM', 84, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21001691', 'Trisha Anne', 'Nam', to_date('2016-07-18', 'YYYY-MM-DD'), 'H.No. 03 Lata Path Purnia', '+917829558198', 'CLC', 'CNPM', 28, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21001692', 'Jayesh Shah', 'N?', to_date('2004-01-21', 'YYYY-MM-DD'), '659 Varma Marg Varanasi', '2609536148', 'CLC', 'MMT', 89, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21001693', 'Vardaniya Vohra', 'N?', to_date('1964-03-26', 'YYYY-MM-DD'), 'H.No. 21 Ramaswamy Ganj Imphal', '+919494552114', 'CTTT', 'MMT', 21, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21001694', 'Nitara Contractor', 'Nam', to_date('1951-03-13', 'YYYY-MM-DD'), '599 Gade Circle Avadi', '9683045820', 'VP', 'CNTT', 56, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21001695', 'Renee Bala', 'N?', to_date('2016-05-02', 'YYYY-MM-DD'), '85 Soman Street Thoothukudi', '05475819995', 'CQ', 'TGMT', 55, 9.31);

INSERT INTO SINHVIEN
VALUES ('SV21001696', 'Tara Garg', 'N?', to_date('2005-03-21', 'YYYY-MM-DD'), '34 Varughese Muzaffarnagar', '+910797459848', 'CQ', 'MMT', 117, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21001697', 'Vihaan Mall', 'Nam', to_date('1967-01-03', 'YYYY-MM-DD'), '91 Boase Patna', '+915853869485', 'CTTT', 'KHMT', 11, 5.48);

INSERT INTO SINHVIEN
VALUES ('SV21001698', 'Nakul Sampath', 'N?', to_date('1954-08-01', 'YYYY-MM-DD'), '45/011 Subramaniam Marg Barasat', '09184664866', 'VP', 'CNPM', 119, 6.65);

INSERT INTO SINHVIEN
VALUES ('SV21001699', 'Anya Saxena', 'N?', to_date('1934-09-01', 'YYYY-MM-DD'), '99 Borah Chowk Dewas', '6757428506', 'VP', 'TGMT', 47, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21001700', 'Jhanvi Walla', 'N?', to_date('2001-02-22', 'YYYY-MM-DD'), 'H.No. 420 Rout Path Surat', '5282047053', 'CQ', 'CNPM', 109, 9.41);

INSERT INTO SINHVIEN
VALUES ('SV21001701', 'Vidur Korpal', 'N?', to_date('1991-08-07', 'YYYY-MM-DD'), '02 Rao Ganj Erode', '+910269033885', 'CLC', 'HTTT', 43, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21001702', 'Lavanya Kari', 'Nam', to_date('1948-08-24', 'YYYY-MM-DD'), '85/28 Ganguly Road Haridwar', '+913834999043', 'CTTT', 'KHMT', 17, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21001703', 'Navya Johal', 'Nam', to_date('1918-05-30', 'YYYY-MM-DD'), '40 Saxena Road Jorhat', '2160957598', 'VP', 'HTTT', 5, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21001704', 'Samar Shan', 'Nam', to_date('1924-10-12', 'YYYY-MM-DD'), '83/12 Buch Street Hubli�CDharwad', '06025856617', 'VP', 'HTTT', 6, 7.2);

INSERT INTO SINHVIEN
VALUES ('SV21001705', 'Shamik Vasa', 'Nam', to_date('2016-10-12', 'YYYY-MM-DD'), '89/588 Kumer Marg Malegaon', '+912872565328', 'CQ', 'MMT', 58, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21001706', 'Taimur Chander', 'Nam', to_date('1975-10-15', 'YYYY-MM-DD'), '75 Gera Muzaffarnagar', '03742309948', 'CTTT', 'TGMT', 60, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21001707', 'Priyansh Behl', 'N?', to_date('2016-06-01', 'YYYY-MM-DD'), '99/473 Mand Kolhapur', '+916750996112', 'CQ', 'KHMT', 5, 7.0);

INSERT INTO SINHVIEN
VALUES ('SV21001708', 'Anvi Upadhyay', 'N?', to_date('2017-05-11', 'YYYY-MM-DD'), 'H.No. 62 Dass Marg Rewa', '6534040299', 'CTTT', 'MMT', 74, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21001709', 'Gatik Varughese', 'Nam', to_date('1909-04-20', 'YYYY-MM-DD'), '68 Dave Zila Udupi', '0845040025', 'VP', 'MMT', 63, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21001710', 'Misha Hari', 'Nam', to_date('1967-06-19', 'YYYY-MM-DD'), 'H.No. 782 Wali Road Mango', '06778320272', 'CLC', 'CNTT', 34, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21001711', 'Damini Gara', 'N?', to_date('1950-04-08', 'YYYY-MM-DD'), '18/025 Borra Chowk Darbhanga', '9922225013', 'CTTT', 'TGMT', 134, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21001712', 'Miraya Singh', 'N?', to_date('1987-07-13', 'YYYY-MM-DD'), 'H.No. 217 Badami Zila Mango', '4215430269', 'CTTT', 'MMT', 104, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21001713', 'Nakul Agrawal', 'N?', to_date('1934-09-19', 'YYYY-MM-DD'), 'H.No. 979 Handa Nagar Bijapur', '4133926689', 'VP', 'MMT', 103, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21001714', 'Jivin Vora', 'Nam', to_date('1952-09-06', 'YYYY-MM-DD'), 'H.No. 12 Kapur Path Sasaram', '4896976789', 'CTTT', 'HTTT', 26, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21001715', 'Gatik Sood', 'Nam', to_date('1933-08-21', 'YYYY-MM-DD'), '97/366 Krishnamurthy Nagar Dehradun', '00185934554', 'CLC', 'MMT', 104, 5.27);

INSERT INTO SINHVIEN
VALUES ('SV21001716', 'Advik Halder', 'N?', to_date('1923-03-18', 'YYYY-MM-DD'), '10/021 Behl Path Bhiwandi', '8195858913', 'VP', 'KHMT', 122, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21001717', 'Divij Sengupta', 'Nam', to_date('1926-05-22', 'YYYY-MM-DD'), '20/49 Goyal Ganj Loni', '5075222494', 'VP', 'CNPM', 129, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21001718', 'Hiran Randhawa', 'Nam', to_date('1965-06-22', 'YYYY-MM-DD'), '485 Anne Nagar Thanjavur', '+916259294872', 'CQ', 'CNPM', 20, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21001719', 'Romil Hora', 'Nam', to_date('1977-09-09', 'YYYY-MM-DD'), 'H.No. 134 Venkatesh Nagar Guntur', '+915206037936', 'VP', 'HTTT', 83, 8.41);

INSERT INTO SINHVIEN
VALUES ('SV21001720', 'Jivika Chada', 'Nam', to_date('1989-03-20', 'YYYY-MM-DD'), '89/96 Vaidya Street Sonipat', '+917680923133', 'CTTT', 'MMT', 69, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21001721', 'Dhruv Raja', 'N?', to_date('1988-10-02', 'YYYY-MM-DD'), '22/061 Raju Nagar Kolhapur', '4258718835', 'CLC', 'HTTT', 82, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21001722', 'Badal Ratta', 'Nam', to_date('1935-07-30', 'YYYY-MM-DD'), '88/10 Bassi Marg Hospet', '5682063158', 'CTTT', 'TGMT', 23, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21001723', 'Alisha Dugar', 'N?', to_date('2011-01-14', 'YYYY-MM-DD'), '798 Devan Ganj Unnao', '03337345300', 'CTTT', 'KHMT', 38, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21001724', 'Zain Devi', 'N?', to_date('1936-06-02', 'YYYY-MM-DD'), '721 Sunder Ganj Singrauli', '04252410513', 'VP', 'CNPM', 119, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21001725', 'Azad Manne', 'Nam', to_date('1914-12-13', 'YYYY-MM-DD'), '098 Korpal Marg Tiruvottiyur', '+917237474433', 'CTTT', 'CNTT', 29, 4.33);

INSERT INTO SINHVIEN
VALUES ('SV21001726', 'Renee Rajagopal', 'N?', to_date('1960-08-03', 'YYYY-MM-DD'), 'H.No. 58 Bir Nagar Bijapur', '0782429688', 'CLC', 'CNTT', 2, 5.56);

INSERT INTO SINHVIEN
VALUES ('SV21001727', 'Gokul Kala', 'N?', to_date('1911-10-14', 'YYYY-MM-DD'), 'H.No. 28 Savant Road Barasat', '+912012841143', 'VP', 'MMT', 24, 4.88);

INSERT INTO SINHVIEN
VALUES ('SV21001728', 'Piya Dayal', 'Nam', to_date('1979-07-07', 'YYYY-MM-DD'), '980 Majumdar Ganj Khora ', '3139552867', 'CTTT', 'HTTT', 131, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21001729', 'Ivan Mander', 'Nam', to_date('1996-11-03', 'YYYY-MM-DD'), '88/94 Sood Circle Munger', '4147605938', 'CQ', 'TGMT', 69, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21001730', 'Akarsh Dhingra', 'N?', to_date('1967-10-22', 'YYYY-MM-DD'), 'H.No. 45 Gaba Nagar Motihari', '2710236534', 'VP', 'MMT', 25, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21001731', 'Samarth Kuruvilla', 'N?', to_date('1920-12-30', 'YYYY-MM-DD'), '43/858 Chawla Zila Mumbai', '0974395829', 'CQ', 'TGMT', 87, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21001732', 'Kiaan Kulkarni', 'Nam', to_date('1965-08-04', 'YYYY-MM-DD'), '44 Venkatesh Street Siwan', '02191777488', 'VP', 'TGMT', 48, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001733', 'Dharmajan Bir', 'N?', to_date('1923-07-19', 'YYYY-MM-DD'), '373 Vora Marg Bhiwandi', '7015137632', 'CQ', 'KHMT', 85, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21001734', 'Sahil Mander', 'N?', to_date('1958-08-01', 'YYYY-MM-DD'), '20 Mann Zila Ulhasnagar', '+915260636597', 'VP', 'CNTT', 51, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21001735', 'Kimaya Chada', 'Nam', to_date('1973-10-01', 'YYYY-MM-DD'), '73/39 Shukla Chowk Bareilly', '7063490904', 'VP', 'CNTT', 14, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21001736', 'Divij Sridhar', 'N?', to_date('1960-06-13', 'YYYY-MM-DD'), '60 Dhawan Nagar Maheshtala', '08869159714', 'CQ', 'MMT', 35, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21001737', 'Manikya Doctor', 'N?', to_date('1922-11-02', 'YYYY-MM-DD'), '94 Acharya Path Ozhukarai', '3230445039', 'VP', 'CNPM', 122, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21001738', 'Aarna Dhar', 'N?', to_date('2002-12-20', 'YYYY-MM-DD'), '06/687 Sabharwal Chowk Sasaram', '+910342507838', 'VP', 'TGMT', 138, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21001739', 'Shaan Gade', 'Nam', to_date('1999-10-02', 'YYYY-MM-DD'), '06/37 Sabharwal Ganj Miryalaguda', '+911048014527', 'VP', 'CNPM', 39, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21001740', 'Kabir Sawhney', 'Nam', to_date('1981-11-19', 'YYYY-MM-DD'), '676 Bath Marg Warangal', '2837279107', 'CLC', 'MMT', 57, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21001741', 'Diya Roy', 'N?', to_date('1927-10-30', 'YYYY-MM-DD'), '20/60 Taneja Nagar Sultan Pur Majra', '3593331841', 'CLC', 'CNTT', 79, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21001742', 'Alisha Badami', 'N?', to_date('2021-01-10', 'YYYY-MM-DD'), '25/250 Cheema Circle Madurai', '08436166354', 'CLC', 'CNTT', 92, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21001743', 'Emir Singh', 'N?', to_date('1967-12-24', 'YYYY-MM-DD'), '38/778 Chokshi Road Bhiwandi', '07043782044', 'CTTT', 'KHMT', 93, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21001744', 'Shray Chadha', 'N?', to_date('1992-02-01', 'YYYY-MM-DD'), 'H.No. 17 Arya Marg Mau', '+919385721256', 'CQ', 'MMT', 40, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21001745', 'Kaira Bhagat', 'N?', to_date('1929-07-09', 'YYYY-MM-DD'), '121 Doctor Chowk Panihati', '0940909010', 'CLC', 'KHMT', 64, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21001746', 'Aaryahi Kota', 'N?', to_date('2020-01-17', 'YYYY-MM-DD'), '298 Sinha Nagar Darbhanga', '+914545782812', 'VP', 'CNTT', 78, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21001747', 'Ryan Rau', 'Nam', to_date('1973-12-01', 'YYYY-MM-DD'), '38/205 Bail Path Jaunpur', '4233073757', 'VP', 'MMT', 111, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21001748', 'Adira Trivedi', 'Nam', to_date('1924-09-19', 'YYYY-MM-DD'), '795 Dara Zila Silchar', '+910903614231', 'CLC', 'CNTT', 37, 7.44);

INSERT INTO SINHVIEN
VALUES ('SV21001749', 'Taran Bobal', 'Nam', to_date('1932-08-21', 'YYYY-MM-DD'), '30/477 Rastogi Road Narasaraopet', '03769629311', 'VP', 'KHMT', 116, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21001750', 'Himmat Dugar', 'N?', to_date('1939-03-01', 'YYYY-MM-DD'), '616 Talwar Path Jaipur', '+911480633996', 'CQ', 'CNTT', 85, 8.58);

INSERT INTO SINHVIEN
VALUES ('SV21001751', 'Anahi Bhasin', 'N?', to_date('2018-05-21', 'YYYY-MM-DD'), '375 Bumb Zila Dibrugarh', '0967484721', 'CQ', 'CNPM', 132, 5.06);

INSERT INTO SINHVIEN
VALUES ('SV21001752', 'Sumer Tripathi', 'N?', to_date('1973-10-08', 'YYYY-MM-DD'), '53 Dayal Kolhapur', '02291593290', 'VP', 'CNPM', 79, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21001753', 'Jayesh Chander', 'Nam', to_date('2002-12-03', 'YYYY-MM-DD'), 'H.No. 06 Bhatt Nagar Ballia', '1813888522', 'CTTT', 'MMT', 121, 6.48);

INSERT INTO SINHVIEN
VALUES ('SV21001754', 'Ojas Rau', 'N?', to_date('1946-05-28', 'YYYY-MM-DD'), 'H.No. 284 Chawla Path Berhampore', '+914924348393', 'CQ', 'MMT', 85, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21001755', 'Advika Arora', 'N?', to_date('1989-08-22', 'YYYY-MM-DD'), '20 Jhaveri Circle Mahbubnagar', '08903636017', 'CLC', 'CNPM', 126, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21001756', 'Indrajit Saxena', 'N?', to_date('1977-02-17', 'YYYY-MM-DD'), 'H.No. 836 Mahal Road Mau', '07567200001', 'VP', 'HTTT', 115, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21001757', 'Dharmajan Chandran', 'Nam', to_date('2003-03-29', 'YYYY-MM-DD'), '587 Kalita Circle Unnao', '07454311565', 'CLC', 'CNPM', 62, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21001758', 'Aarav Bakshi', 'N?', to_date('1918-04-13', 'YYYY-MM-DD'), '02 Ravel Road Bhopal', '+910847945251', 'CLC', 'HTTT', 54, 4.85);

INSERT INTO SINHVIEN
VALUES ('SV21001759', 'Umang Badal', 'N?', to_date('1927-01-10', 'YYYY-MM-DD'), '37 Tandon Ganj Bharatpur', '2038747766', 'CQ', 'TGMT', 118, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21001760', 'Sahil Goswami', 'Nam', to_date('1960-06-06', 'YYYY-MM-DD'), 'H.No. 24 Krishnan Zila Jabalpur', '+912136202927', 'VP', 'CNPM', 8, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21001761', 'Renee Khalsa', 'Nam', to_date('1918-10-25', 'YYYY-MM-DD'), '707 Sheth Road Mumbai', '+918183117507', 'CLC', 'KHMT', 118, 6.65);

INSERT INTO SINHVIEN
VALUES ('SV21001762', 'Shaan Rajan', 'Nam', to_date('1924-03-01', 'YYYY-MM-DD'), 'H.No. 812 Ganesh Marg Bhiwandi', '07194323471', 'CTTT', 'TGMT', 39, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21001763', 'Alia Chaudhuri', 'N?', to_date('1998-04-22', 'YYYY-MM-DD'), '35 Ray Street Machilipatnam', '+912839824531', 'CTTT', 'CNTT', 80, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21001764', 'Nitya Vohra', 'Nam', to_date('1910-12-10', 'YYYY-MM-DD'), '90 Ganesh Street Tadipatri', '08229332830', 'VP', 'HTTT', 76, 9.21);

INSERT INTO SINHVIEN
VALUES ('SV21001765', 'Ivan Sinha', 'N?', to_date('1957-08-20', 'YYYY-MM-DD'), 'H.No. 02 Lata Street Singrauli', '2676056210', 'CLC', 'KHMT', 5, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21001766', 'Adira Ahluwalia', 'N?', to_date('1936-10-16', 'YYYY-MM-DD'), '98/74 Soni Nagar Motihari', '07097691075', 'VP', 'CNPM', 68, 8.0);

INSERT INTO SINHVIEN
VALUES ('SV21001767', 'Vardaniya Ram', 'Nam', to_date('1949-12-04', 'YYYY-MM-DD'), 'H.No. 10 Mandal Nagercoil', '+917073832485', 'CQ', 'MMT', 94, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21001768', 'Aaryahi Sarma', 'Nam', to_date('1963-05-04', 'YYYY-MM-DD'), '41 Thaker Path Bhimavaram', '+914410695090', 'CLC', 'MMT', 33, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21001769', 'Divyansh Hora', 'Nam', to_date('1936-05-20', 'YYYY-MM-DD'), '47/789 Mahal Zila Berhampore', '7541805990', 'CTTT', 'TGMT', 114, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21001770', 'Pranay Ramesh', 'N?', to_date('1998-04-10', 'YYYY-MM-DD'), 'H.No. 48 Som Street Agra', '05901095502', 'VP', 'HTTT', 7, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21001771', 'Piya Trivedi', 'Nam', to_date('2005-01-12', 'YYYY-MM-DD'), '38 Sanghvi Marg Imphal', '+915272007982', 'CQ', 'MMT', 79, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21001772', 'Raghav Karnik', 'N?', to_date('1999-06-23', 'YYYY-MM-DD'), '55/86 Dave Road Jehanabad', '8575067098', 'CTTT', 'KHMT', 20, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21001773', 'Manikya Seth', 'N?', to_date('1987-04-12', 'YYYY-MM-DD'), '155 Suresh Zila Ramagundam', '+918110680099', 'CQ', 'HTTT', 68, 4.76);

INSERT INTO SINHVIEN
VALUES ('SV21001774', 'Taran Wagle', 'N?', to_date('2016-08-17', 'YYYY-MM-DD'), '13/48 Chopra Road Jammu', '+916883717004', 'CLC', 'CNTT', 133, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21001775', 'Lakshay Varghese', 'N?', to_date('2005-02-15', 'YYYY-MM-DD'), 'H.No. 87 Issac Nagar Agra', '9614405099', 'CLC', 'CNTT', 50, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001776', 'Tanya Dayal', 'N?', to_date('1939-12-13', 'YYYY-MM-DD'), '86/38 Reddy Nagar Panvel', '+913469086551', 'CTTT', 'TGMT', 111, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21001777', 'Anay Rastogi', 'Nam', to_date('2021-06-15', 'YYYY-MM-DD'), 'H.No. 43 Ratta Circle Delhi', '+911161372841', 'CLC', 'HTTT', 17, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21001778', 'Saksham Mandal', 'N?', to_date('1944-11-10', 'YYYY-MM-DD'), '548 Gera Ganj Bharatpur', '+914508865675', 'VP', 'CNTT', 19, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21001779', 'Nishith Lad', 'Nam', to_date('1971-08-12', 'YYYY-MM-DD'), '54 Samra Circle Jehanabad', '00973696120', 'VP', 'KHMT', 41, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21001780', 'Nakul Srinivas', 'N?', to_date('1984-03-30', 'YYYY-MM-DD'), '82/57 Lata Path Bhagalpur', '+919125272244', 'CLC', 'KHMT', 85, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21001781', 'Nakul Bhagat', 'Nam', to_date('2000-12-04', 'YYYY-MM-DD'), 'H.No. 35 Raman Path Raipur', '02633149166', 'VP', 'CNTT', 4, 4.76);

INSERT INTO SINHVIEN
VALUES ('SV21001782', 'Prerak Cherian', 'N?', to_date('1960-12-12', 'YYYY-MM-DD'), '92/941 Anand Zila Jamnagar', '1877362263', 'VP', 'HTTT', 29, 8.49);

INSERT INTO SINHVIEN
VALUES ('SV21001783', 'Jhanvi Sunder', 'Nam', to_date('1975-09-25', 'YYYY-MM-DD'), '995 Kala Circle Mathura', '5750131172', 'CTTT', 'MMT', 2, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21001784', 'Hrishita Dora', 'Nam', to_date('1952-11-20', 'YYYY-MM-DD'), 'H.No. 858 Sibal Chowk Hapur', '+914475773173', 'VP', 'HTTT', 2, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21001785', 'Tiya Vohra', 'N?', to_date('1956-09-15', 'YYYY-MM-DD'), 'H.No. 14 Desai Street Naihati', '08298292368', 'CTTT', 'TGMT', 11, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21001786', 'Hazel Mand', 'N?', to_date('1965-05-15', 'YYYY-MM-DD'), 'H.No. 63 Sahni Zila Moradabad', '08781860505', 'VP', 'TGMT', 21, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21001787', 'Samar Chander', 'Nam', to_date('1975-01-29', 'YYYY-MM-DD'), '21/54 Dhingra Zila Bilaspur', '6989385357', 'CQ', 'KHMT', 98, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21001788', 'Lakshay Sen', 'N?', to_date('1936-07-17', 'YYYY-MM-DD'), 'H.No. 86 Bhavsar Nagar Bokaro', '0273251571', 'VP', 'MMT', 114, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21001789', 'Tiya Gopal', 'N?', to_date('2008-12-04', 'YYYY-MM-DD'), '39/509 Bajaj Chowk Kota', '3514767067', 'CTTT', 'KHMT', 111, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21001790', 'Bhavin Srinivasan', 'Nam', to_date('1997-08-09', 'YYYY-MM-DD'), '677 Bajwa Nagar Bhatpara', '8089988166', 'CLC', 'KHMT', 86, 7.33);

INSERT INTO SINHVIEN
VALUES ('SV21001791', 'Zara Iyer', 'Nam', to_date('2009-12-29', 'YYYY-MM-DD'), '19 Salvi Circle New Delhi', '08080650052', 'VP', 'KHMT', 83, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21001792', 'Divij Savant', 'Nam', to_date('2009-05-27', 'YYYY-MM-DD'), '541 Ganesh Marg Nellore', '+913933631853', 'VP', 'CNPM', 74, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21001793', 'Neelofar Hayre', 'Nam', to_date('1937-11-21', 'YYYY-MM-DD'), '56/925 Venkataraman Nagar Proddatur', '+912022177145', 'CQ', 'HTTT', 112, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21001794', 'Shamik Hans', 'N?', to_date('1918-12-14', 'YYYY-MM-DD'), '85/407 Bandi Circle Ichalkaranji', '1312547248', 'CLC', 'KHMT', 52, 9.56);

INSERT INTO SINHVIEN
VALUES ('SV21001795', 'Mamooty Tripathi', 'Nam', to_date('1965-11-29', 'YYYY-MM-DD'), 'H.No. 28 Kara Purnia', '08805113989', 'CQ', 'KHMT', 55, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21001796', 'Indranil Anne', 'Nam', to_date('1915-11-23', 'YYYY-MM-DD'), '87 Kunda Marg Dibrugarh', '08420841438', 'CLC', 'KHMT', 33, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21001797', 'Indrans Mann', 'Nam', to_date('1944-05-25', 'YYYY-MM-DD'), '46/974 Datta Panipat', '07910009480', 'VP', 'TGMT', 89, 6.24);

INSERT INTO SINHVIEN
VALUES ('SV21001798', 'Taimur Bhattacharyya', 'Nam', to_date('1957-01-19', 'YYYY-MM-DD'), '18/69 Grewal Path Gwalior', '08482208492', 'CLC', 'CNPM', 92, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21001799', 'Siya Uppal', 'Nam', to_date('2000-11-17', 'YYYY-MM-DD'), 'H.No. 99 Varghese Path Durg', '00161247082', 'VP', 'KHMT', 39, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21001800', 'Charvi Dara', 'Nam', to_date('2001-09-15', 'YYYY-MM-DD'), 'H.No. 08 Sinha Ganj Kamarhati', '+916789671259', 'VP', 'KHMT', 22, 5.55);

INSERT INTO SINHVIEN
VALUES ('SV21001801', 'Eshani Shankar', 'N?', to_date('2007-07-05', 'YYYY-MM-DD'), '16 Raju Ganj Miryalaguda', '+915020105441', 'CTTT', 'KHMT', 44, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21001802', 'Azad Sidhu', 'N?', to_date('1918-08-02', 'YYYY-MM-DD'), '85 Hans Circle Durgapur', '08159195699', 'CLC', 'TGMT', 45, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21001803', 'Riya Vala', 'Nam', to_date('1916-08-14', 'YYYY-MM-DD'), 'H.No. 08 Koshy Chowk Raiganj', '+912159143574', 'VP', 'HTTT', 67, 4.25);

INSERT INTO SINHVIEN
VALUES ('SV21001804', 'Ojas Hegde', 'N?', to_date('2020-04-27', 'YYYY-MM-DD'), '61 Singh Road Bangalore', '9253527481', 'CQ', 'HTTT', 25, 9.14);

INSERT INTO SINHVIEN
VALUES ('SV21001805', 'Bhavin Dey', 'Nam', to_date('2022-06-09', 'YYYY-MM-DD'), '31/092 Varughese Ganj Baranagar', '+913092749480', 'VP', 'CNPM', 84, 5.58);

INSERT INTO SINHVIEN
VALUES ('SV21001806', 'Jayan Varkey', 'Nam', to_date('1928-12-25', 'YYYY-MM-DD'), '28/39 Chana Circle Kanpur', '+910594795807', 'CLC', 'CNTT', 98, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21001807', 'Alisha Ranganathan', 'Nam', to_date('2008-06-21', 'YYYY-MM-DD'), '876 Mani Nagar Vadodara', '+910509375027', 'CLC', 'HTTT', 129, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21001808', 'Kanav Babu', 'Nam', to_date('1945-03-01', 'YYYY-MM-DD'), 'H.No. 42 Iyer Path Bihar Sharif', '+911494484716', 'CLC', 'KHMT', 132, 6.71);

INSERT INTO SINHVIEN
VALUES ('SV21001809', 'Baiju Butala', 'N?', to_date('1908-04-11', 'YYYY-MM-DD'), 'H.No. 08 Chahal Zila Danapur', '2291797591', 'CTTT', 'CNTT', 33, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21001810', 'Purab Bakshi', 'N?', to_date('1930-05-25', 'YYYY-MM-DD'), 'H.No. 62 Gala Bangalore', '+919607746329', 'CQ', 'TGMT', 50, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21001811', 'Keya Vaidya', 'Nam', to_date('1997-10-28', 'YYYY-MM-DD'), '930 Bains Street Panvel', '04257665356', 'CTTT', 'TGMT', 2, 6.21);

INSERT INTO SINHVIEN
VALUES ('SV21001812', 'Vardaniya Baral', 'N?', to_date('1921-11-09', 'YYYY-MM-DD'), '73/578 Chandran Path Delhi', '+911937463960', 'CTTT', 'HTTT', 4, 7.74);

INSERT INTO SINHVIEN
VALUES ('SV21001813', 'Kismat Lad', 'N?', to_date('1937-11-14', 'YYYY-MM-DD'), '93/880 Kapadia Bilaspur', '08320949827', 'CQ', 'TGMT', 43, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21001814', 'Aarna Sharaf', 'N?', to_date('1920-02-03', 'YYYY-MM-DD'), 'H.No. 338 Goda Zila Dhule', '03333015058', 'CTTT', 'HTTT', 129, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21001815', 'Vritika Edwin', 'N?', to_date('1998-04-27', 'YYYY-MM-DD'), 'H.No. 81 Mand Circle Ozhukarai', '+910444416435', 'CQ', 'TGMT', 6, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21001816', 'Seher Kashyap', 'Nam', to_date('1959-01-27', 'YYYY-MM-DD'), 'H.No. 81 Manda Chandrapur', '4213627241', 'CTTT', 'HTTT', 128, 8.56);

INSERT INTO SINHVIEN
VALUES ('SV21001817', 'Manikya Saini', 'Nam', to_date('1957-02-08', 'YYYY-MM-DD'), 'H.No. 49 Jaggi Circle Patna', '02545977397', 'CQ', 'CNPM', 52, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21001818', 'Tarini Talwar', 'Nam', to_date('2005-01-14', 'YYYY-MM-DD'), '521 Sahni Chowk Mango', '5633096888', 'CTTT', 'HTTT', 4, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21001819', 'Vardaniya Lal', 'Nam', to_date('1996-11-24', 'YYYY-MM-DD'), 'H.No. 363 Bose Chowk Sangli-Miraj', '3113488047', 'VP', 'CNTT', 70, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21001820', 'Aniruddh Lalla', 'N?', to_date('1963-06-06', 'YYYY-MM-DD'), 'H.No. 66 Keer Circle Rampur', '05254051790', 'CTTT', 'HTTT', 37, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21001821', 'Lakshit Agrawal', 'Nam', to_date('1940-10-30', 'YYYY-MM-DD'), '705 Kumar Marg Bihar Sharif', '4891253016', 'CQ', 'MMT', 10, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001822', 'Madhup Atwal', 'Nam', to_date('1960-08-06', 'YYYY-MM-DD'), 'H.No. 23 Chahal Zila Jammu', '+919556930012', 'CLC', 'CNTT', 31, 7.9);

INSERT INTO SINHVIEN
VALUES ('SV21001823', 'Shalv Mand', 'Nam', to_date('1968-09-06', 'YYYY-MM-DD'), 'H.No. 346 Rajagopalan Marg Bongaigaon', '0476176268', 'CTTT', 'TGMT', 135, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21001824', 'Shamik Sawhney', 'N?', to_date('1985-11-10', 'YYYY-MM-DD'), '614 Golla Street Bulandshahr', '00618665080', 'CTTT', 'CNTT', 78, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21001825', 'Saira Sandal', 'N?', to_date('1915-05-09', 'YYYY-MM-DD'), '11/27 Lall Circle Nanded', '+916250120485', 'CQ', 'CNPM', 25, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21001826', 'Anvi Kadakia', 'Nam', to_date('1983-09-10', 'YYYY-MM-DD'), '49/424 Ganguly Chowk Davanagere', '8616000182', 'VP', 'CNTT', 46, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21001827', 'Akarsh Tata', 'Nam', to_date('1921-02-23', 'YYYY-MM-DD'), '15/061 Chand Zila Vijayawada', '03521093274', 'CLC', 'KHMT', 109, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21001828', 'Yakshit Hayre', 'Nam', to_date('1978-02-01', 'YYYY-MM-DD'), '73/492 Bahri Chowk Bellary', '09392693353', 'CTTT', 'CNPM', 52, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21001829', 'Adira Dua', 'Nam', to_date('1956-02-20', 'YYYY-MM-DD'), '968 Ramaswamy Road Dewas', '1682157972', 'CTTT', 'HTTT', 37, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21001830', 'Pihu Chaudhry', 'N?', to_date('1960-06-19', 'YYYY-MM-DD'), 'H.No. 929 Sarma Zila Panchkula', '8420381062', 'VP', 'CNPM', 114, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21001831', 'Romil Ranganathan', 'Nam', to_date('2012-06-04', 'YYYY-MM-DD'), '05/856 Tandon Udaipur', '01010426168', 'CTTT', 'KHMT', 73, 5.25);

INSERT INTO SINHVIEN
VALUES ('SV21001832', 'Dhanush Kala', 'N?', to_date('2012-11-07', 'YYYY-MM-DD'), 'H.No. 670 Gaba Road Muzaffarpur', '8701001436', 'CTTT', 'TGMT', 102, 7.82);

INSERT INTO SINHVIEN
VALUES ('SV21001833', 'Mishti Hans', 'N?', to_date('1908-12-12', 'YYYY-MM-DD'), '33 Konda Marg Guwahati', '07034580180', 'CQ', 'CNPM', 84, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21001834', 'Rhea Krish', 'N?', to_date('1978-08-25', 'YYYY-MM-DD'), '26 Deol Malegaon', '+911402161968', 'CLC', 'MMT', 85, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21001835', 'Divyansh Dara', 'N?', to_date('1953-10-24', 'YYYY-MM-DD'), '666 Wali Ganj Mehsana', '+917894930870', 'VP', 'TGMT', 7, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21001836', 'Yuvaan Sarma', 'Nam', to_date('1949-05-10', 'YYYY-MM-DD'), 'H.No. 210 Anne Srinagar', '9973200792', 'VP', 'TGMT', 71, 5.0);

INSERT INTO SINHVIEN
VALUES ('SV21001837', 'Kaira Tata', 'N?', to_date('1910-08-28', 'YYYY-MM-DD'), 'H.No. 374 Dada Nagar Jorhat', '+917651914939', 'CTTT', 'KHMT', 63, 9.06);

INSERT INTO SINHVIEN
VALUES ('SV21001838', 'Prisha Buch', 'N?', to_date('1928-06-04', 'YYYY-MM-DD'), 'H.No. 73 Gill Path Katihar', '+918109729139', 'CLC', 'CNTT', 21, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21001839', 'Kabir Mallick', 'Nam', to_date('2016-06-17', 'YYYY-MM-DD'), 'H.No. 45 Kala Haridwar', '1324439936', 'VP', 'CNPM', 133, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21001840', 'Saksham Sharaf', 'N?', to_date('1927-09-30', 'YYYY-MM-DD'), '09/804 Chowdhury Darbhanga', '00484609659', 'CQ', 'CNPM', 82, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21001841', 'Nakul Kar', 'N?', to_date('1978-10-23', 'YYYY-MM-DD'), 'H.No. 917 Loke Chowk Dharmavaram', '0540587362', 'CLC', 'KHMT', 25, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21001842', 'Ehsaan Bail', 'N?', to_date('1912-08-05', 'YYYY-MM-DD'), 'H.No. 95 Bhakta Zila Varanasi', '8583968629', 'CQ', 'MMT', 78, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21001843', 'Prisha Sane', 'Nam', to_date('2002-03-30', 'YYYY-MM-DD'), 'H.No. 597 Yohannan Nagar Rajahmundry', '08431861110', 'CLC', 'HTTT', 55, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21001844', 'Biju Kulkarni', 'Nam', to_date('1984-11-25', 'YYYY-MM-DD'), 'H.No. 782 Golla Circle Bangalore', '03646535262', 'CQ', 'HTTT', 121, 5.65);

INSERT INTO SINHVIEN
VALUES ('SV21001845', 'Hunar Koshy', 'Nam', to_date('1977-02-08', 'YYYY-MM-DD'), '779 Kale Surat', '4693180322', 'CTTT', 'MMT', 9, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21001846', 'Lakshit Singh', 'Nam', to_date('1933-09-17', 'YYYY-MM-DD'), '150 Bhalla Nagar Rewa', '3384262306', 'CTTT', 'HTTT', 127, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21001847', 'Anaya Warrior', 'Nam', to_date('1933-10-22', 'YYYY-MM-DD'), '77/829 Ramaswamy Zila Ambala', '+911597612814', 'CLC', 'TGMT', 77, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21001848', 'Sara Ahuja', 'Nam', to_date('2014-08-17', 'YYYY-MM-DD'), 'H.No. 390 Guha Marg Nellore', '05236138888', 'CLC', 'CNPM', 58, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21001849', 'Kartik Mani', 'Nam', to_date('2015-11-12', 'YYYY-MM-DD'), 'H.No. 42 Hans Chowk Yamunanagar', '+915359419030', 'CQ', 'KHMT', 138, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21001850', 'Madhav Talwar', 'N?', to_date('1945-03-11', 'YYYY-MM-DD'), '53/62 Rana Marg Siliguri', '3813205688', 'VP', 'CNPM', 43, 5.69);

INSERT INTO SINHVIEN
VALUES ('SV21001851', 'Damini Virk', 'N?', to_date('1961-01-01', 'YYYY-MM-DD'), '197 Sankaran Chowk Salem', '+913767945601', 'CTTT', 'CNPM', 21, 8.74);

INSERT INTO SINHVIEN
VALUES ('SV21001852', 'Aradhya Din', 'Nam', to_date('1999-12-15', 'YYYY-MM-DD'), '25/779 Chander Road Thanjavur', '7721626476', 'CLC', 'KHMT', 11, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21001853', 'Anya Kurian', 'N?', to_date('2018-11-03', 'YYYY-MM-DD'), '730 Shetty Path Erode', '8115317281', 'CQ', 'TGMT', 93, 6.39);

INSERT INTO SINHVIEN
VALUES ('SV21001854', 'Indrajit Kothari', 'N?', to_date('1928-03-08', 'YYYY-MM-DD'), 'H.No. 732 Deo Chowk Phagwara', '00497448551', 'CQ', 'CNTT', 127, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21001855', 'Alia Srinivas', 'N?', to_date('1924-05-31', 'YYYY-MM-DD'), 'H.No. 027 Gupta Path Chinsurah', '0952086241', 'CTTT', 'HTTT', 79, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21001856', 'Tiya Kar', 'N?', to_date('1982-02-03', 'YYYY-MM-DD'), '07/095 Tripathi Street Bhimavaram', '+910855566095', 'VP', 'KHMT', 80, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21001857', 'Urvi Kumer', 'Nam', to_date('1932-09-23', 'YYYY-MM-DD'), 'H.No. 36 Wadhwa Zila Katihar', '7657520719', 'CTTT', 'CNPM', 5, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21001858', 'Rania Sarin', 'Nam', to_date('1978-12-19', 'YYYY-MM-DD'), '70/69 Ratta Circle Bangalore', '05263819023', 'CLC', 'CNTT', 90, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001859', 'Ahana  Sidhu', 'Nam', to_date('1990-08-05', 'YYYY-MM-DD'), 'H.No. 13 Warrior Chowk Chapra', '+917315386938', 'CLC', 'TGMT', 15, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21001860', 'Shanaya Chad', 'N?', to_date('1935-08-09', 'YYYY-MM-DD'), '79 Viswanathan Ganj New Delhi', '0826577464', 'CQ', 'HTTT', 49, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21001861', 'Siya Sawhney', 'N?', to_date('1988-02-20', 'YYYY-MM-DD'), 'H.No. 197 Edwin Nagar Hindupur', '04962274570', 'CLC', 'MMT', 33, 8.28);

INSERT INTO SINHVIEN
VALUES ('SV21001862', 'Bhavin Mahajan', 'Nam', to_date('1964-12-08', 'YYYY-MM-DD'), '57/003 Wagle Street Chandrapur', '4967721618', 'CTTT', 'CNTT', 38, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21001863', 'Seher Kaur', 'N?', to_date('1990-08-01', 'YYYY-MM-DD'), '88/81 Walia Road Warangal', '0238157555', 'CLC', 'KHMT', 80, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21001864', 'Shalv Badal', 'N?', to_date('1994-06-26', 'YYYY-MM-DD'), '80/54 Wali Path Bhilai', '02370832778', 'VP', 'HTTT', 48, 4.55);

INSERT INTO SINHVIEN
VALUES ('SV21001865', 'Shlok Chakraborty', 'N?', to_date('1977-05-24', 'YYYY-MM-DD'), 'H.No. 975 Dhar Ganj Nagercoil', '08753559400', 'CLC', 'MMT', 17, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21001866', 'Tara Sem', 'N?', to_date('2019-08-24', 'YYYY-MM-DD'), '688 Deo Circle Pune', '5753958789', 'VP', 'MMT', 134, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21001867', 'Jayesh Mahajan', 'Nam', to_date('1989-11-02', 'YYYY-MM-DD'), 'H.No. 711 Chacko Ozhukarai', '+916054988859', 'CLC', 'TGMT', 26, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21001868', 'Vardaniya Karan', 'Nam', to_date('1951-11-12', 'YYYY-MM-DD'), '174 Taneja Road Jalgaon', '9590255709', 'CTTT', 'CNPM', 111, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21001869', 'Lavanya Chowdhury', 'N?', to_date('1987-06-28', 'YYYY-MM-DD'), '43/45 Varughese Zila Chapra', '5885909314', 'CQ', 'TGMT', 67, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21001870', 'Inaaya  Garg', 'N?', to_date('2012-07-27', 'YYYY-MM-DD'), 'H.No. 13 Saraf Road Mangalore', '6782727902', 'VP', 'CNPM', 31, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21001871', 'Zara Kannan', 'Nam', to_date('1966-11-13', 'YYYY-MM-DD'), '47 Chana Nagar Chinsurah', '3811868772', 'CLC', 'HTTT', 111, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21001872', 'Miraan Balakrishnan', 'N?', to_date('1961-10-25', 'YYYY-MM-DD'), '686 Halder Path Bettiah', '+913211512541', 'VP', 'TGMT', 21, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21001873', 'Lakshit Guha', 'N?', to_date('1965-09-23', 'YYYY-MM-DD'), '96 Kanda Ganj Arrah', '+910316813428', 'CTTT', 'HTTT', 133, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21001874', 'Anya Dhar', 'Nam', to_date('2010-12-13', 'YYYY-MM-DD'), '64/97 Suri Path Proddatur', '+911522935553', 'CQ', 'CNPM', 9, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21001875', 'Anay Gole', 'N?', to_date('1923-11-21', 'YYYY-MM-DD'), 'H.No. 43 Sant Street Bongaigaon', '5674905806', 'VP', 'CNTT', 71, 7.13);

INSERT INTO SINHVIEN
VALUES ('SV21001876', 'Hridaan Kala', 'N?', to_date('1991-09-10', 'YYYY-MM-DD'), '76 Sodhi Road Mangalore', '2505959384', 'CTTT', 'CNTT', 137, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21001877', 'Vritika Khatri', 'Nam', to_date('2005-11-20', 'YYYY-MM-DD'), '77/92 Sridhar Marg Howrah', '+910817459433', 'CTTT', 'TGMT', 48, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21001878', 'Diya Edwin', 'N?', to_date('1915-08-18', 'YYYY-MM-DD'), '16 Sawhney Circle Nashik', '04332372271', 'CTTT', 'HTTT', 62, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21001879', 'Amira Datta', 'N?', to_date('1948-08-16', 'YYYY-MM-DD'), 'H.No. 19 Bail Street Ujjain', '9463213820', 'VP', 'HTTT', 25, 6.89);

INSERT INTO SINHVIEN
VALUES ('SV21001880', 'Ojas Deshmukh', 'N?', to_date('1961-11-19', 'YYYY-MM-DD'), '680 Golla Marg Anantapur', '+911055549719', 'VP', 'TGMT', 106, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21001881', 'Yuvraj  Sem', 'N?', to_date('2008-08-21', 'YYYY-MM-DD'), '09/78 Sami Ghaziabad', '08030279087', 'CTTT', 'CNTT', 2, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21001882', 'Damini Joshi', 'N?', to_date('1940-05-31', 'YYYY-MM-DD'), '93/737 Ahluwalia Street Patiala', '+916909030523', 'CTTT', 'MMT', 55, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21001883', 'Gokul Sangha', 'N?', to_date('2011-09-24', 'YYYY-MM-DD'), '49/58 Sethi Ganj Bilaspur', '4283557599', 'CLC', 'CNPM', 51, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21001884', 'Keya Bhatnagar', 'Nam', to_date('1988-08-28', 'YYYY-MM-DD'), '21/46 Mander Marg Guna', '04295636681', 'CTTT', 'CNTT', 2, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21001885', 'Shalv Wali', 'N?', to_date('1993-09-17', 'YYYY-MM-DD'), '53 Majumdar Circle Aurangabad', '3892717964', 'CQ', 'MMT', 36, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21001886', 'Anika Sur', 'Nam', to_date('1967-07-21', 'YYYY-MM-DD'), 'H.No. 989 Suri Circle Chittoor', '09314474128', 'CLC', 'KHMT', 120, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21001887', 'Kavya Sehgal', 'Nam', to_date('1958-10-08', 'YYYY-MM-DD'), '94 Bir Road Bulandshahr', '09260593689', 'VP', 'KHMT', 105, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21001888', 'Heer Koshy', 'Nam', to_date('1908-10-07', 'YYYY-MM-DD'), '44/42 Bains Ganj Deoghar', '+916165027623', 'CTTT', 'TGMT', 24, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21001889', 'Rhea Chadha', 'N?', to_date('1978-05-15', 'YYYY-MM-DD'), 'H.No. 74 Jhaveri Ganj Visakhapatnam', '1210324757', 'CQ', 'CNPM', 78, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21001890', 'Vritika Venkataraman', 'N?', to_date('1965-08-04', 'YYYY-MM-DD'), 'H.No. 786 Grewal Nagar Sonipat', '3333601652', 'CQ', 'CNPM', 99, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21001891', 'Taran Cherian', 'Nam', to_date('1935-10-27', 'YYYY-MM-DD'), 'H.No. 666 Deep Path Muzaffarnagar', '4056293418', 'CLC', 'MMT', 71, 4.17);

INSERT INTO SINHVIEN
VALUES ('SV21001892', 'Ryan Khatri', 'Nam', to_date('1995-02-08', 'YYYY-MM-DD'), 'H.No. 473 Gulati Marg Mirzapur', '+910837549996', 'CQ', 'MMT', 116, 7.51);

INSERT INTO SINHVIEN
VALUES ('SV21001893', 'Anay Lall', 'Nam', to_date('1938-05-06', 'YYYY-MM-DD'), 'H.No. 16 Trivedi Marg Tumkur', '7671774216', 'CLC', 'CNTT', 138, 8.46);

INSERT INTO SINHVIEN
VALUES ('SV21001894', 'Mamooty Thaman', 'Nam', to_date('1992-11-08', 'YYYY-MM-DD'), '184 Sarraf Marg Gwalior', '2071296724', 'VP', 'CNPM', 64, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21001895', 'Gokul Arya', 'N?', to_date('2022-05-30', 'YYYY-MM-DD'), 'H.No. 96 Issac Nagar Muzaffarnagar', '0338441331', 'CTTT', 'KHMT', 29, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21001896', 'Vaibhav Dhaliwal', 'N?', to_date('1961-12-19', 'YYYY-MM-DD'), '21/97 Konda Nagar Surat', '+919780969791', 'CQ', 'CNTT', 22, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21001897', 'Ojas Sangha', 'Nam', to_date('1946-11-01', 'YYYY-MM-DD'), '777 Atwal Marg Saharsa', '2322836881', 'VP', 'CNTT', 56, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21001898', 'Prerak Lanka', 'Nam', to_date('1958-06-09', 'YYYY-MM-DD'), 'H.No. 34 Bali Ganj Amaravati', '+910364624141', 'CTTT', 'MMT', 100, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21001899', 'Hazel Kumer', 'Nam', to_date('1919-08-15', 'YYYY-MM-DD'), 'H.No. 688 Bhavsar Path Hyderabad', '5665270196', 'CLC', 'MMT', 9, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21001900', 'Taran Raj', 'Nam', to_date('1922-07-23', 'YYYY-MM-DD'), '82/28 Kibe Nagar Amritsar', '00548700009', 'VP', 'CNTT', 53, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21001901', 'Ahana  Date', 'Nam', to_date('1912-03-28', 'YYYY-MM-DD'), 'H.No. 120 Cherian Road Jabalpur', '04453048843', 'CTTT', 'CNPM', 116, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21001902', 'Zeeshan Ahluwalia', 'N?', to_date('1999-08-20', 'YYYY-MM-DD'), 'H.No. 453 Balan Street Jehanabad', '3837943398', 'CTTT', 'CNTT', 58, 7.9);

INSERT INTO SINHVIEN
VALUES ('SV21001903', 'Neysa Chaudry', 'Nam', to_date('1986-07-06', 'YYYY-MM-DD'), '13 Batra Raipur', '+918851351618', 'CTTT', 'TGMT', 37, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21001904', 'Saanvi Solanki', 'Nam', to_date('1964-09-17', 'YYYY-MM-DD'), '38/49 Chandran Street Surat', '03653949112', 'VP', 'CNPM', 132, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21001905', 'Dhruv Ramakrishnan', 'Nam', to_date('2006-05-22', 'YYYY-MM-DD'), 'H.No. 480 Walla Circle Kavali', '00860840747', 'VP', 'CNTT', 69, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21001906', 'Tanya Gade', 'N?', to_date('1988-01-25', 'YYYY-MM-DD'), '40/868 Shetty Marg Srinagar', '01136321109', 'CTTT', 'KHMT', 125, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21001907', 'Nishith Ganesan', 'Nam', to_date('1919-04-23', 'YYYY-MM-DD'), '16/607 Khalsa Marg Bhalswa Jahangir Pur', '2389282252', 'CTTT', 'CNPM', 69, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21001908', 'Oorja Goyal', 'N?', to_date('1992-02-02', 'YYYY-MM-DD'), 'H.No. 59 Doshi Path Tadipatri', '02814974834', 'CTTT', 'MMT', 32, 5.48);

INSERT INTO SINHVIEN
VALUES ('SV21001909', 'Heer Badal', 'Nam', to_date('1968-11-09', 'YYYY-MM-DD'), '796 Grover Chowk Kolhapur', '05003407913', 'CTTT', 'MMT', 89, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21001910', 'Vanya Bedi', 'Nam', to_date('2006-12-06', 'YYYY-MM-DD'), '20/59 Kalla Zila Bidhannagar', '+918595260092', 'CLC', 'TGMT', 95, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21001911', 'Dhruv Seshadri', 'N?', to_date('1931-04-20', 'YYYY-MM-DD'), '92/45 Bora Nagar Uluberia', '08278775799', 'CTTT', 'KHMT', 81, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21001912', 'Eshani Gola', 'N?', to_date('2012-09-22', 'YYYY-MM-DD'), 'H.No. 97 Anne Marg Morbi', '+914135017049', 'VP', 'CNPM', 14, 8.89);

INSERT INTO SINHVIEN
VALUES ('SV21001913', 'Indrajit Dar', 'Nam', to_date('1971-11-01', 'YYYY-MM-DD'), '15 Sura Zila Cuttack', '+919678279061', 'CTTT', 'KHMT', 36, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21001914', 'Zaina Dixit', 'N?', to_date('1982-03-11', 'YYYY-MM-DD'), 'H.No. 207 Devi Street Kolhapur', '03457561079', 'VP', 'MMT', 129, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21001915', 'Yasmin Karpe', 'Nam', to_date('1913-02-19', 'YYYY-MM-DD'), 'H.No. 114 Uppal Path Sultan Pur Majra', '02917532433', 'CTTT', 'KHMT', 66, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21001916', 'Hiran Bali', 'Nam', to_date('2022-11-20', 'YYYY-MM-DD'), '01/831 Soni Circle Farrukhabad', '+916274122881', 'CLC', 'TGMT', 113, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21001917', 'Shalv Magar', 'Nam', to_date('2001-10-11', 'YYYY-MM-DD'), '400 Kalita Circle Ahmedabad', '7103310581', 'CTTT', 'MMT', 95, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21001918', 'Kiaan Mand', 'Nam', to_date('1985-11-07', 'YYYY-MM-DD'), '15 Walia Zila Visakhapatnam', '+918680186029', 'CLC', 'CNTT', 89, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21001919', 'Stuvan Sandhu', 'Nam', to_date('2005-07-07', 'YYYY-MM-DD'), '98 Jha Jalna', '9843581360', 'CTTT', 'KHMT', 50, 6.97);

INSERT INTO SINHVIEN
VALUES ('SV21001920', 'Gatik Manne', 'Nam', to_date('1998-01-07', 'YYYY-MM-DD'), '40/670 Dugar Nagar Coimbatore', '+918764776006', 'VP', 'HTTT', 77, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21001921', 'Tara Mannan', 'Nam', to_date('1927-12-19', 'YYYY-MM-DD'), '749 Jani Nagar Panvel', '1585542780', 'VP', 'MMT', 41, 4.39);

INSERT INTO SINHVIEN
VALUES ('SV21001922', 'Ela Bhatt', 'Nam', to_date('1937-11-16', 'YYYY-MM-DD'), '068 Taneja Circle Katihar', '7335078580', 'CQ', 'MMT', 93, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21001923', 'Mannat Butala', 'Nam', to_date('1974-06-12', 'YYYY-MM-DD'), '65/895 Gokhale Marg Nagaon', '+919835310063', 'CQ', 'CNPM', 14, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21001924', 'Vaibhav Kara', 'N?', to_date('2021-12-19', 'YYYY-MM-DD'), '325 Manda Chowk Jodhpur', '03742969918', 'CLC', 'HTTT', 91, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21001925', 'Nishith Edwin', 'Nam', to_date('1951-03-24', 'YYYY-MM-DD'), 'H.No. 467 Sidhu Chowk Tiruchirappalli', '02048222383', 'CTTT', 'MMT', 54, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21001926', 'Kismat Singh', 'Nam', to_date('1972-05-02', 'YYYY-MM-DD'), '234 Batta Nagar Bhavnagar', '+919088509069', 'CLC', 'TGMT', 39, 7.9);

INSERT INTO SINHVIEN
VALUES ('SV21001927', 'Vanya Dhar', 'Nam', to_date('1968-09-07', 'YYYY-MM-DD'), 'H.No. 261 Rana Zila Pallavaram', '+917398108150', 'VP', 'CNPM', 32, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21001928', 'Vidur Uppal', 'Nam', to_date('2021-05-16', 'YYYY-MM-DD'), '529 Srinivasan Ganj Chittoor', '+917032113748', 'VP', 'TGMT', 110, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21001929', 'Kaira Sarkar', 'Nam', to_date('1927-05-23', 'YYYY-MM-DD'), '15/35 Vyas Dhanbad', '2213807336', 'CLC', 'CNTT', 83, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21001930', 'Ela Bhatt', 'Nam', to_date('1965-09-15', 'YYYY-MM-DD'), 'H.No. 868 Acharya Road Korba', '+910913979279', 'CLC', 'MMT', 83, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21001931', 'Dhanuk Bir', 'N?', to_date('1978-12-19', 'YYYY-MM-DD'), '16/59 Tandon Ganj Naihati', '+914720484063', 'VP', 'TGMT', 24, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21001932', 'Anvi D��Alia', 'Nam', to_date('1930-01-14', 'YYYY-MM-DD'), '29/424 Korpal Nagar Deoghar', '05822064139', 'VP', 'KHMT', 96, 5.17);

INSERT INTO SINHVIEN
VALUES ('SV21001933', 'Reyansh Tata', 'Nam', to_date('1996-04-29', 'YYYY-MM-DD'), '18/93 Tiwari Shimoga', '5924522578', 'VP', 'HTTT', 84, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21001934', 'Rasha Dar', 'N?', to_date('1937-01-24', 'YYYY-MM-DD'), 'H.No. 49 Hegde Street Tadipatri', '09333231631', 'CQ', 'KHMT', 62, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21001935', 'Indrajit Basu', 'Nam', to_date('1963-02-12', 'YYYY-MM-DD'), '03/39 Virk Street Bellary', '+914096603361', 'CTTT', 'MMT', 131, 4.17);

INSERT INTO SINHVIEN
VALUES ('SV21001936', 'Amani Shanker', 'Nam', to_date('1917-09-23', 'YYYY-MM-DD'), '00 Mahajan Ganj Panihati', '06023344356', 'VP', 'MMT', 17, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21001937', 'Tushar Chaudhry', 'Nam', to_date('1948-10-30', 'YYYY-MM-DD'), '65/53 Chauhan Zila Phagwara', '+914982349031', 'VP', 'CNPM', 4, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21001938', 'Purab Lall', 'N?', to_date('1918-08-18', 'YYYY-MM-DD'), '16/491 Kaur Path Yamunanagar', '+915415161141', 'VP', 'CNTT', 108, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21001939', 'Raunak Vyas', 'Nam', to_date('1980-03-27', 'YYYY-MM-DD'), '49 Borde Ganj Jabalpur', '+914579520507', 'CLC', 'KHMT', 34, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21001940', 'Shanaya Sunder', 'Nam', to_date('1917-02-19', 'YYYY-MM-DD'), 'H.No. 56 Hans Srinagar', '+912871732028', 'CTTT', 'TGMT', 17, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21001941', 'Prerak Bhardwaj', 'N?', to_date('2014-11-06', 'YYYY-MM-DD'), '93 Bhavsar Malda', '+911410937678', 'CLC', 'CNTT', 115, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21001942', 'Faiyaz Vig', 'Nam', to_date('1947-08-11', 'YYYY-MM-DD'), 'H.No. 55 Bajwa Path Gandhidham', '7312324981', 'VP', 'CNPM', 47, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21001943', 'Indrans Sankar', 'N?', to_date('2006-06-15', 'YYYY-MM-DD'), 'H.No. 261 Lad Street Silchar', '+910948630747', 'CTTT', 'HTTT', 31, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21001944', 'Prisha Setty', 'N?', to_date('1968-10-16', 'YYYY-MM-DD'), '36 Kata Marg Haldia', '+918374529565', 'CQ', 'KHMT', 133, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21001945', 'Diya Gaba', 'N?', to_date('1950-01-12', 'YYYY-MM-DD'), '281 Balay Street Miryalaguda', '+912579229063', 'CTTT', 'HTTT', 29, 8.86);

INSERT INTO SINHVIEN
VALUES ('SV21001946', 'Zain Subramanian', 'N?', to_date('1912-12-22', 'YYYY-MM-DD'), '99/206 Sachdeva Zila Bhind', '+912185243003', 'CQ', 'CNTT', 39, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21001947', 'Sara Barman', 'N?', to_date('1931-08-03', 'YYYY-MM-DD'), '26 Dalal Ganj Ulhasnagar', '5017618749', 'CQ', 'TGMT', 89, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21001948', 'Dhanush Sami', 'N?', to_date('2008-03-07', 'YYYY-MM-DD'), '64 Venkataraman Chowk Gorakhpur', '03851064748', 'CLC', 'CNPM', 121, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21001949', 'Nirvi Balasubramanian', 'N?', to_date('2020-08-13', 'YYYY-MM-DD'), 'H.No. 133 Datta Nagar Fatehpur', '3273435200', 'CLC', 'CNPM', 1, 8.02);

INSERT INTO SINHVIEN
VALUES ('SV21001950', 'Tushar Rao', 'Nam', to_date('1939-02-19', 'YYYY-MM-DD'), 'H.No. 395 Deshmukh Marg Mangalore', '04306791076', 'CLC', 'CNTT', 98, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21001951', 'Renee Sen', 'N?', to_date('1918-01-26', 'YYYY-MM-DD'), '22 Deol Bettiah', '+911052047852', 'VP', 'KHMT', 98, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21001952', 'Khushi Savant', 'N?', to_date('2009-11-02', 'YYYY-MM-DD'), '351 Kaul Street Ramagundam', '2220467722', 'CTTT', 'CNTT', 3, 6.65);

INSERT INTO SINHVIEN
VALUES ('SV21001953', 'Eva Garg', 'N?', to_date('1963-06-29', 'YYYY-MM-DD'), '49 Sharaf Zila Guntur', '08093715116', 'CTTT', 'KHMT', 61, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21001954', 'Damini Jaggi', 'N?', to_date('1913-05-26', 'YYYY-MM-DD'), '88/00 Atwal Marg Satna', '+914669841494', 'CTTT', 'CNTT', 136, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21001955', 'Manikya Zachariah', 'N?', to_date('1920-01-31', 'YYYY-MM-DD'), '92/59 Rajagopalan Street Patiala', '09261337223', 'VP', 'CNPM', 78, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21001956', 'Jayant Dara', 'N?', to_date('1952-05-13', 'YYYY-MM-DD'), 'H.No. 952 Wali Road Bikaner', '8353465670', 'CQ', 'KHMT', 51, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21001957', 'Hunar Ramesh', 'Nam', to_date('1916-11-05', 'YYYY-MM-DD'), '651 Dasgupta Ganj Hapur', '00515711887', 'CTTT', 'TGMT', 60, 4.21);

INSERT INTO SINHVIEN
VALUES ('SV21001958', 'Anaya Ben', 'Nam', to_date('1931-03-13', 'YYYY-MM-DD'), '27/32 Subramaniam Raebareli', '01849158432', 'VP', 'TGMT', 130, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21001959', 'Kiaan Chandra', 'N?', to_date('1944-07-14', 'YYYY-MM-DD'), '07/53 Doctor Road Rourkela', '+917315299323', 'CLC', 'CNTT', 44, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21001960', 'Rania Saraf', 'Nam', to_date('1975-11-26', 'YYYY-MM-DD'), '86/595 Kothari Chowk Bhopal', '+911475610319', 'CTTT', 'CNTT', 102, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21001961', 'Saksham Mammen', 'N?', to_date('1911-11-05', 'YYYY-MM-DD'), 'H.No. 05 Balan Circle Thiruvananthapuram', '+915952656483', 'CQ', 'CNTT', 118, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21001962', 'Saira Tandon', 'Nam', to_date('1991-10-13', 'YYYY-MM-DD'), 'H.No. 51 Randhawa Ganj Bhiwani', '05136087544', 'CTTT', 'TGMT', 50, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21001963', 'Shamik Chahal', 'Nam', to_date('1949-11-30', 'YYYY-MM-DD'), 'H.No. 31 Ratta Chowk Pudukkottai', '+910358006081', 'CLC', 'CNTT', 48, 5.19);

INSERT INTO SINHVIEN
VALUES ('SV21001964', 'Mohanlal Tank', 'Nam', to_date('1914-01-01', 'YYYY-MM-DD'), 'H.No. 81 Subramaniam Ganj Howrah', '07729667790', 'CQ', 'CNTT', 114, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21001965', 'Aayush Maharaj', 'Nam', to_date('1948-10-25', 'YYYY-MM-DD'), 'H.No. 09 Sekhon Marg Karaikudi', '1922786680', 'CQ', 'KHMT', 5, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21001966', 'Dhruv Aggarwal', 'N?', to_date('1909-09-14', 'YYYY-MM-DD'), '02/75 Chatterjee Street Salem', '+914404453956', 'CLC', 'MMT', 59, 7.66);

INSERT INTO SINHVIEN
VALUES ('SV21001967', 'Zain Chandra', 'N?', to_date('1922-04-22', 'YYYY-MM-DD'), '51/181 Subramaniam Nagar Siwan', '+918096961992', 'CTTT', 'HTTT', 25, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21001968', 'Darshit Ganesan', 'N?', to_date('1995-07-02', 'YYYY-MM-DD'), 'H.No. 64 Sandal Street Ratlam', '+914137323083', 'CQ', 'MMT', 12, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21001969', 'Pari Edwin', 'N?', to_date('2013-10-07', 'YYYY-MM-DD'), '00/61 Chand Zila Pune', '6205171064', 'CLC', 'TGMT', 22, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21001970', 'Nitya Mangal', 'Nam', to_date('2001-10-29', 'YYYY-MM-DD'), '82/32 Sant Path Eluru', '04272104119', 'CLC', 'TGMT', 29, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21001971', 'Himmat Ravi', 'N?', to_date('1915-07-23', 'YYYY-MM-DD'), '196 Savant Ganj Jammu', '00630840222', 'VP', 'MMT', 95, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21001972', 'Aarna Sood', 'N?', to_date('1927-04-20', 'YYYY-MM-DD'), '80/883 Hayer Road Sultan Pur Majra', '+912309848653', 'CLC', 'HTTT', 59, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21001973', 'Amira Dhaliwal', 'Nam', to_date('2021-10-13', 'YYYY-MM-DD'), '23/39 Thaker Udupi', '07633077378', 'VP', 'KHMT', 103, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21001974', 'Sumer Samra', 'N?', to_date('1991-03-20', 'YYYY-MM-DD'), '01 Gokhale Nagar Howrah', '3044710621', 'CTTT', 'HTTT', 66, 4.4);

INSERT INTO SINHVIEN
VALUES ('SV21001975', 'Indrajit Iyengar', 'N?', to_date('1972-06-10', 'YYYY-MM-DD'), 'H.No. 937 Vig Nagar Eluru', '01051451403', 'VP', 'MMT', 0, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21001976', 'Kashvi Mane', 'Nam', to_date('1969-07-11', 'YYYY-MM-DD'), '93/63 Balan Zila Nashik', '+919896369883', 'CTTT', 'KHMT', 55, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21001977', 'Samar Raju', 'Nam', to_date('2002-01-24', 'YYYY-MM-DD'), 'H.No. 39 Kothari Nagar Berhampur', '+912919438295', 'CLC', 'HTTT', 94, 7.7);

INSERT INTO SINHVIEN
VALUES ('SV21001978', 'Jhanvi Sankaran', 'Nam', to_date('1990-08-11', 'YYYY-MM-DD'), '59/901 Kuruvilla Ahmedabad', '4554304486', 'VP', 'CNTT', 9, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21001979', 'Dhanuk Kumar', 'Nam', to_date('1958-09-14', 'YYYY-MM-DD'), '44/374 Agrawal Circle Machilipatnam', '+911596562408', 'CLC', 'HTTT', 30, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21001980', 'Vardaniya Gara', 'Nam', to_date('1918-11-25', 'YYYY-MM-DD'), 'H.No. 35 Bir Zila Hospet', '+918518237477', 'CTTT', 'CNTT', 106, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21001981', 'Riya Kulkarni', 'N?', to_date('1990-03-05', 'YYYY-MM-DD'), 'H.No. 106 Khanna Ganj Vijayawada', '+914115858196', 'CLC', 'MMT', 55, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21001982', 'Renee Ramakrishnan', 'Nam', to_date('2008-04-07', 'YYYY-MM-DD'), 'H.No. 13 Garg Chowk Sambhal', '+911636299268', 'CTTT', 'MMT', 26, 8.22);

INSERT INTO SINHVIEN
VALUES ('SV21001983', 'Jivika Hegde', 'Nam', to_date('2005-05-28', 'YYYY-MM-DD'), '324 Brar Road Katni', '+913833513963', 'CLC', 'CNPM', 64, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21001984', 'Hiran Guha', 'N?', to_date('1919-07-22', 'YYYY-MM-DD'), '78/96 Contractor Ganj Mango', '5988134278', 'CQ', 'HTTT', 113, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21001985', 'Kashvi Garg', 'N?', to_date('1910-10-11', 'YYYY-MM-DD'), '728 Grewal Circle Sirsa', '+915123312855', 'CLC', 'CNTT', 0, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21001986', 'Kavya Kade', 'Nam', to_date('1947-10-10', 'YYYY-MM-DD'), '26/224 Doctor Ramgarh', '6063076260', 'CLC', 'HTTT', 85, 4.97);

INSERT INTO SINHVIEN
VALUES ('SV21001987', 'Hazel Ben', 'Nam', to_date('1932-05-21', 'YYYY-MM-DD'), 'H.No. 05 Seshadri Marg Morbi', '01553281436', 'CTTT', 'KHMT', 25, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21001988', 'Baiju Banerjee', 'Nam', to_date('2001-07-09', 'YYYY-MM-DD'), '55/576 Gaba Road Shivpuri', '03382129803', 'CLC', 'KHMT', 41, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21001989', 'Suhana Rastogi', 'Nam', to_date('1910-04-03', 'YYYY-MM-DD'), 'H.No. 13 Kale Circle Bijapur', '02953750660', 'VP', 'CNPM', 92, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21001990', 'Ojas Sachdev', 'Nam', to_date('2011-12-12', 'YYYY-MM-DD'), 'H.No. 652 Tak Chowk Pondicherry', '09537600439', 'VP', 'CNTT', 26, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21001991', 'Zeeshan Sanghvi', 'Nam', to_date('1939-03-17', 'YYYY-MM-DD'), '35/572 Sama Path Kavali', '5094945433', 'CTTT', 'HTTT', 101, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21001992', 'Yakshit Raja', 'N?', to_date('1927-10-25', 'YYYY-MM-DD'), '650 Bose Street Hubli�CDharwad', '03386311806', 'VP', 'MMT', 82, 9.38);

INSERT INTO SINHVIEN
VALUES ('SV21001993', 'Indrajit Zachariah', 'N?', to_date('1979-12-19', 'YYYY-MM-DD'), 'H.No. 89 Varughese Path Salem', '04016362553', 'CTTT', 'CNPM', 21, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21001994', 'Adira Vasa', 'Nam', to_date('1943-07-05', 'YYYY-MM-DD'), 'H.No. 25 Chakrabarti Salem', '0940399521', 'CLC', 'MMT', 8, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21001995', 'Shray Mand', 'Nam', to_date('1911-07-04', 'YYYY-MM-DD'), 'H.No. 001 Bansal Ganj Raebareli', '01975443162', 'CQ', 'HTTT', 86, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21001996', 'Kabir Char', 'Nam', to_date('1967-09-26', 'YYYY-MM-DD'), 'H.No. 816 Hayre Street Gulbarga', '+910361560188', 'CTTT', 'TGMT', 57, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21001997', 'Misha Zachariah', 'N?', to_date('1978-09-29', 'YYYY-MM-DD'), '05 Chandran Chowk Gopalpur', '+914521221589', 'CTTT', 'HTTT', 119, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21001998', 'Adira Babu', 'Nam', to_date('1931-12-16', 'YYYY-MM-DD'), '66 Chhabra Path Bahraich', '02450652848', 'VP', 'TGMT', 126, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21001999', 'Ishaan Shroff', 'Nam', to_date('1914-12-11', 'YYYY-MM-DD'), 'H.No. 30 Kanda Ganj Ozhukarai', '03323978300', 'CTTT', 'CNPM', 20, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21002000', 'Azad Gaba', 'N?', to_date('1961-05-17', 'YYYY-MM-DD'), '52 Vasa Circle Surendranagar Dudhrej', '1652058185', 'CTTT', 'CNPM', 97, 6.56);

INSERT INTO SINHVIEN
VALUES ('SV21002001', 'Devansh Sarkar', 'N?', to_date('1930-05-28', 'YYYY-MM-DD'), '37/513 Thakur Nellore', '+916460570075', 'CTTT', 'TGMT', 69, 6.33);

INSERT INTO SINHVIEN
VALUES ('SV21002002', 'Keya Mand', 'Nam', to_date('2000-03-31', 'YYYY-MM-DD'), '31/945 Bakshi Chowk Guntur', '3151517322', 'CLC', 'CNTT', 67, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21002003', 'Hrishita Kashyap', 'N?', to_date('1921-03-29', 'YYYY-MM-DD'), '92/27 Vala Ganj Tadepalligudem', '+911812359715', 'VP', 'CNPM', 34, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21002004', 'Keya Rau', 'Nam', to_date('1988-04-12', 'YYYY-MM-DD'), '309 D��Alia Path Yamunanagar', '05116149979', 'VP', 'HTTT', 47, 9.46);

INSERT INTO SINHVIEN
VALUES ('SV21002005', 'Ritvik Bava', 'Nam', to_date('1933-10-21', 'YYYY-MM-DD'), '46/79 Talwar Chowk Malegaon', '07766385627', 'CQ', 'CNTT', 125, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21002006', 'Anika Mane', 'Nam', to_date('1960-06-16', 'YYYY-MM-DD'), 'H.No. 05 Ramachandran Nagar Ambala', '7805371691', 'CQ', 'KHMT', 125, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21002007', 'Pari Mall', 'N?', to_date('1992-09-19', 'YYYY-MM-DD'), '667 Gala Nagar Nashik', '+917093149904', 'VP', 'MMT', 80, 4.48);

INSERT INTO SINHVIEN
VALUES ('SV21002008', 'Reyansh Kumer', 'N?', to_date('1974-07-18', 'YYYY-MM-DD'), 'H.No. 049 Kumer Ganj Barasat', '08842889860', 'VP', 'MMT', 32, 7.59);

INSERT INTO SINHVIEN
VALUES ('SV21002009', 'Tara Warrior', 'Nam', to_date('1982-03-20', 'YYYY-MM-DD'), '15 Dua Nagar Tiruppur', '5869609647', 'CQ', 'CNPM', 8, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21002010', 'Mamooty Singh', 'N?', to_date('1962-04-24', 'YYYY-MM-DD'), '106 Sheth Road Bharatpur', '4176057165', 'VP', 'TGMT', 113, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21002011', 'Anay Agrawal', 'N?', to_date('1952-01-23', 'YYYY-MM-DD'), '282 Kakar Road Ambattur', '07461658220', 'VP', 'HTTT', 80, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21002012', 'Anahita Arora', 'Nam', to_date('1983-06-08', 'YYYY-MM-DD'), 'H.No. 49 Kunda Path Raichur', '7859700123', 'CQ', 'MMT', 38, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002013', 'Aaina Bakshi', 'N?', to_date('1949-04-10', 'YYYY-MM-DD'), '08 Salvi Street Tadepalligudem', '+916057609913', 'VP', 'HTTT', 87, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21002014', 'Shray Batra', 'Nam', to_date('2016-06-26', 'YYYY-MM-DD'), 'H.No. 58 Devi Chowk Hajipur', '06640353580', 'VP', 'CNPM', 32, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21002015', 'Damini Sagar', 'N?', to_date('1951-03-29', 'YYYY-MM-DD'), '52/223 Choudhry Chowk Dhule', '03442815224', 'CTTT', 'HTTT', 74, 4.46);

INSERT INTO SINHVIEN
VALUES ('SV21002016', 'Anvi Bhattacharyya', 'N?', to_date('1936-08-25', 'YYYY-MM-DD'), 'H.No. 684 Srinivasan Sirsa', '2011555848', 'CLC', 'KHMT', 8, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21002017', 'Charvi Chowdhury', 'Nam', to_date('1985-07-30', 'YYYY-MM-DD'), 'H.No. 362 Bali Path Belgaum', '01452554412', 'VP', 'KHMT', 111, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21002018', 'Aayush Sanghvi', 'Nam', to_date('2021-11-30', 'YYYY-MM-DD'), 'H.No. 78 Sane Nagar Junagadh', '+916914920378', 'CLC', 'MMT', 13, 7.33);

INSERT INTO SINHVIEN
VALUES ('SV21002019', 'Parinaaz Sankar', 'Nam', to_date('1964-02-15', 'YYYY-MM-DD'), '71/67 Thakkar Marg Avadi', '05468714856', 'VP', 'CNPM', 2, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21002020', 'Siya Zacharia', 'N?', to_date('1995-01-19', 'YYYY-MM-DD'), '542 Upadhyay Chowk Morena', '3046859965', 'CQ', 'TGMT', 22, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21002021', 'Keya Madan', 'N?', to_date('2020-12-14', 'YYYY-MM-DD'), 'H.No. 713 Subramanian Marg Saharsa', '1512512904', 'VP', 'CNPM', 77, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21002022', 'Advika Bhakta', 'N?', to_date('1925-10-14', 'YYYY-MM-DD'), '40 Bakshi Circle Satara', '5297482826', 'CQ', 'CNTT', 26, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21002023', 'Gatik Kulkarni', 'Nam', to_date('2009-05-06', 'YYYY-MM-DD'), '984 Sachar Circle Tirupati', '07292682195', 'CQ', 'CNPM', 66, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21002024', 'Adah Mammen', 'Nam', to_date('1915-05-09', 'YYYY-MM-DD'), 'H.No. 427 Krishnan Kamarhati', '9758969757', 'CTTT', 'CNPM', 133, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002025', 'Shalv Mandal', 'Nam', to_date('1999-02-14', 'YYYY-MM-DD'), '83 Karan Marg Sultan Pur Majra', '+918021685810', 'CQ', 'TGMT', 28, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21002026', 'Ahana  Soni', 'Nam', to_date('1912-12-30', 'YYYY-MM-DD'), 'H.No. 68 Anne Road Silchar', '8450102957', 'VP', 'HTTT', 18, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21002027', 'Aradhya Bhatia', 'Nam', to_date('2014-04-11', 'YYYY-MM-DD'), '78/85 Gill Marg Dibrugarh', '02785973267', 'CLC', 'MMT', 40, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002028', 'Sara Sachdeva', 'Nam', to_date('1920-05-10', 'YYYY-MM-DD'), '05 Jayaraman Marg Singrauli', '02628209751', 'CLC', 'CNPM', 103, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21002029', 'Advik Deol', 'Nam', to_date('1926-08-16', 'YYYY-MM-DD'), '44/551 Dalal Vasai-Virar', '2197446976', 'CLC', 'CNTT', 8, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21002030', 'Nakul Jaggi', 'Nam', to_date('1917-03-21', 'YYYY-MM-DD'), '45 Chacko Circle Jammu', '07543226455', 'VP', 'MMT', 75, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21002031', 'Kiara Bajaj', 'N?', to_date('1989-08-07', 'YYYY-MM-DD'), 'H.No. 55 Sathe Road Rajahmundry', '01869657005', 'VP', 'TGMT', 16, 6.38);

INSERT INTO SINHVIEN
VALUES ('SV21002032', 'Jayesh Karpe', 'N?', to_date('1938-10-28', 'YYYY-MM-DD'), '05 Mangal Chowk Khammam', '06738341899', 'CLC', 'TGMT', 22, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21002033', 'Navya Loke', 'N?', to_date('1911-09-25', 'YYYY-MM-DD'), 'H.No. 38 Barad Circle Gangtok', '+916279261182', 'CLC', 'TGMT', 9, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21002034', 'Amani Ganesan', 'N?', to_date('2013-06-01', 'YYYY-MM-DD'), 'H.No. 165 Bedi Marg Gandhinagar', '+918772210418', 'CQ', 'CNPM', 71, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21002035', 'Sahil Saxena', 'Nam', to_date('1994-10-26', 'YYYY-MM-DD'), '75/900 Dada Ganj Mathura', '6688062871', 'CLC', 'TGMT', 134, 8.42);

INSERT INTO SINHVIEN
VALUES ('SV21002036', 'Mishti Tailor', 'N?', to_date('1964-08-24', 'YYYY-MM-DD'), '73/001 Luthra Street Gulbarga', '8080188920', 'CTTT', 'HTTT', 1, 5.17);

INSERT INTO SINHVIEN
VALUES ('SV21002037', 'Tiya Shere', 'N?', to_date('1970-08-10', 'YYYY-MM-DD'), '784 Char Marg Bellary', '03117498446', 'CQ', 'TGMT', 0, 6.18);

INSERT INTO SINHVIEN
VALUES ('SV21002038', 'Veer Divan', 'Nam', to_date('1985-07-06', 'YYYY-MM-DD'), '264 Din Chowk Tirunelveli', '+910321079937', 'CQ', 'KHMT', 6, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21002039', 'Kimaya Dara', 'N?', to_date('2001-03-21', 'YYYY-MM-DD'), '57 Bal Ganj Bhavnagar', '03033368270', 'CLC', 'HTTT', 12, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21002040', 'Vaibhav Khanna', 'N?', to_date('1915-09-16', 'YYYY-MM-DD'), 'H.No. 31 Gola Street Karawal Nagar', '+915953061791', 'CTTT', 'CNTT', 51, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21002041', 'Misha Rout', 'N?', to_date('1911-12-27', 'YYYY-MM-DD'), 'H.No. 19 Swaminathan Bellary', '5320440254', 'CQ', 'CNPM', 117, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21002042', 'Anika Boase', 'Nam', to_date('1939-07-30', 'YYYY-MM-DD'), 'H.No. 780 Ramaswamy Circle Latur', '5211861733', 'CLC', 'MMT', 30, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21002043', 'Yakshit Luthra', 'N?', to_date('1984-08-22', 'YYYY-MM-DD'), 'H.No. 59 Gupta Road Munger', '+914974358465', 'CQ', 'KHMT', 136, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21002044', 'Piya Ahuja', 'Nam', to_date('1921-11-11', 'YYYY-MM-DD'), '98/28 Yogi Zila Bahraich', '1484253153', 'CQ', 'TGMT', 105, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21002045', 'Ojas Sethi', 'N?', to_date('1982-03-20', 'YYYY-MM-DD'), '63 Chopra Nagar Vasai-Virar', '0182999625', 'CTTT', 'CNTT', 70, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21002046', 'Divit Lanka', 'N?', to_date('1959-10-25', 'YYYY-MM-DD'), '54/30 Khurana Nagar Ghaziabad', '+916068460136', 'VP', 'CNPM', 50, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21002047', 'Anahita Wason', 'N?', to_date('1986-05-27', 'YYYY-MM-DD'), 'H.No. 069 Cheema Nagar Nagercoil', '+917536878780', 'CTTT', 'TGMT', 104, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21002048', 'Nishith Borde', 'Nam', to_date('1922-02-24', 'YYYY-MM-DD'), 'H.No. 296 Konda Street Bhiwandi', '00758502618', 'CTTT', 'CNPM', 82, 9.31);

INSERT INTO SINHVIEN
VALUES ('SV21002049', 'Anya Kapur', 'Nam', to_date('1943-11-24', 'YYYY-MM-DD'), '011 Mane Zila Raichur', '+917165425864', 'CTTT', 'CNTT', 137, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21002050', 'Umang Tank', 'N?', to_date('2005-01-04', 'YYYY-MM-DD'), '00/73 Dua Street Silchar', '2670191059', 'VP', 'MMT', 119, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21002051', 'Mamooty Swaminathan', 'Nam', to_date('1935-09-02', 'YYYY-MM-DD'), '22/639 Loyal Zila Bhiwani', '+911154660994', 'CQ', 'CNTT', 127, 5.12);

INSERT INTO SINHVIEN
VALUES ('SV21002052', 'Alisha Lad', 'N?', to_date('1962-06-22', 'YYYY-MM-DD'), '413 Jha Nagar Bareilly', '6463235847', 'CQ', 'MMT', 27, 9.12);

INSERT INTO SINHVIEN
VALUES ('SV21002053', 'Dhanuk Ratti', 'N?', to_date('2003-11-13', 'YYYY-MM-DD'), '12/874 Sekhon Marg Panvel', '+914209941398', 'CTTT', 'TGMT', 60, 9.52);

INSERT INTO SINHVIEN
VALUES ('SV21002054', 'Rhea Goyal', 'Nam', to_date('1921-06-02', 'YYYY-MM-DD'), '187 Borde Chowk Bettiah', '2593275340', 'CQ', 'TGMT', 27, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21002055', 'Lagan Balasubramanian', 'N?', to_date('2004-09-10', 'YYYY-MM-DD'), '23/336 Vora Ganj Aizawl', '+916037204974', 'CQ', 'HTTT', 92, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21002056', 'Misha Dave', 'N?', to_date('1949-08-20', 'YYYY-MM-DD'), '111 Chowdhury Road Raipur', '+913959824441', 'VP', 'TGMT', 4, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21002057', 'Pihu Vig', 'N?', to_date('1942-01-05', 'YYYY-MM-DD'), '26/84 Halder Road Gwalior', '+910044784026', 'CTTT', 'TGMT', 136, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21002058', 'Aayush Shroff', 'N?', to_date('1972-09-22', 'YYYY-MM-DD'), '59 Chowdhury Marg Jalgaon', '+916443670705', 'VP', 'MMT', 35, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21002059', 'Mamooty Sagar', 'Nam', to_date('1965-12-29', 'YYYY-MM-DD'), 'H.No. 234 Kashyap Ganj Bhagalpur', '05887662138', 'CQ', 'HTTT', 36, 7.16);

INSERT INTO SINHVIEN
VALUES ('SV21002060', 'Priyansh Kamdar', 'Nam', to_date('1921-09-07', 'YYYY-MM-DD'), 'H.No. 46 Savant Marg Alappuzha', '+918467733375', 'VP', 'TGMT', 35, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21002061', 'Pihu Khurana', 'N?', to_date('1937-06-20', 'YYYY-MM-DD'), '981 Dua Nagar Jorhat', '8111848525', 'CQ', 'HTTT', 46, 6.6);

INSERT INTO SINHVIEN
VALUES ('SV21002062', 'Kavya Saran', 'Nam', to_date('1950-07-21', 'YYYY-MM-DD'), 'H.No. 233 Das Mathura', '04365283386', 'CTTT', 'TGMT', 124, 5.75);

INSERT INTO SINHVIEN
VALUES ('SV21002063', 'Dharmajan Babu', 'Nam', to_date('1938-12-25', 'YYYY-MM-DD'), 'H.No. 765 Sawhney Nagar Rourkela', '1087711311', 'VP', 'HTTT', 136, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21002064', 'Nitya Mangat', 'Nam', to_date('1939-10-28', 'YYYY-MM-DD'), '20/100 Raja Ganj Thoothukudi', '+914557658210', 'VP', 'KHMT', 19, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21002065', 'Heer Balan', 'N?', to_date('1956-05-11', 'YYYY-MM-DD'), '35/975 Tandon Nagar Amritsar', '+917365314156', 'VP', 'MMT', 19, 5.99);

INSERT INTO SINHVIEN
VALUES ('SV21002066', 'Khushi Venkatesh', 'Nam', to_date('1945-02-08', 'YYYY-MM-DD'), '891 Butala Nagar Tenali', '+912317635275', 'CLC', 'TGMT', 30, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21002067', 'Mamooty Kala', 'Nam', to_date('1952-04-27', 'YYYY-MM-DD'), '284 Lanka Street Hapur', '1188183288', 'CTTT', 'MMT', 138, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21002068', 'Rasha Batra', 'N?', to_date('2019-08-23', 'YYYY-MM-DD'), '651 Samra Chowk Deoghar', '03760044809', 'CQ', 'HTTT', 36, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21002069', 'Purab Wason', 'N?', to_date('1931-02-28', 'YYYY-MM-DD'), '967 Rajan Road Bikaner', '09438717484', 'CQ', 'KHMT', 46, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21002070', 'Pihu Mall', 'Nam', to_date('1997-11-11', 'YYYY-MM-DD'), '13/023 Dewan Munger', '07893896657', 'CQ', 'CNPM', 53, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21002071', 'Yuvaan Brar', 'Nam', to_date('1921-02-01', 'YYYY-MM-DD'), '575 Saraf Begusarai', '+917660473661', 'CLC', 'KHMT', 78, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21002072', 'Samar Gill', 'N?', to_date('1966-07-24', 'YYYY-MM-DD'), '31/034 Cherian Jehanabad', '+918872746067', 'VP', 'TGMT', 115, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21002073', 'Samiha Sidhu', 'Nam', to_date('2001-12-05', 'YYYY-MM-DD'), 'H.No. 362 Banik Path Etawah', '05837774793', 'VP', 'HTTT', 111, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21002074', 'Zaina Suresh', 'Nam', to_date('1945-10-12', 'YYYY-MM-DD'), 'H.No. 823 Sunder Madhyamgram', '1025802179', 'VP', 'CNPM', 18, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21002075', 'Adira Bajwa', 'N?', to_date('1931-08-16', 'YYYY-MM-DD'), 'H.No. 98 Gill Path Durg', '03414346258', 'CQ', 'KHMT', 21, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21002076', 'Vardaniya Sandhu', 'Nam', to_date('1924-06-06', 'YYYY-MM-DD'), '503 Bhat Nagar Delhi', '6817429792', 'CTTT', 'TGMT', 60, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21002077', 'Riya Srinivas', 'N?', to_date('1990-08-29', 'YYYY-MM-DD'), '92/697 Karan Zila Nellore', '+914458444740', 'VP', 'HTTT', 9, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21002078', 'Divij Hegde', 'Nam', to_date('1969-03-10', 'YYYY-MM-DD'), 'H.No. 464 Rama Deoghar', '+918028065329', 'CLC', 'CNTT', 11, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21002079', 'Kismat Sengupta', 'Nam', to_date('2004-10-15', 'YYYY-MM-DD'), '300 Magar Nagpur', '6355122910', 'CQ', 'TGMT', 130, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21002080', 'Armaan Borra', 'Nam', to_date('1961-01-16', 'YYYY-MM-DD'), '52/05 Amble Ganj Proddatur', '+910795582549', 'CLC', 'MMT', 19, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21002081', 'Inaaya  Som', 'N?', to_date('2013-07-08', 'YYYY-MM-DD'), '63/796 Baria Road Raipur', '00043397126', 'VP', 'CNTT', 45, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21002082', 'Amani Deol', 'N?', to_date('1973-11-17', 'YYYY-MM-DD'), '60/427 Dhar Road Naihati', '0636754485', 'VP', 'MMT', 26, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21002083', 'Tarini Dayal', 'Nam', to_date('1992-02-22', 'YYYY-MM-DD'), '04 Sharma Nagar Nagpur', '2870123488', 'VP', 'MMT', 90, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21002084', 'Shalv Deshpande', 'Nam', to_date('1913-11-21', 'YYYY-MM-DD'), '79/736 Dugar Circle Bhagalpur', '+919231088108', 'CQ', 'CNPM', 125, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21002085', 'Neelofar Gill', 'Nam', to_date('1911-06-07', 'YYYY-MM-DD'), '88/46 Kari Zila Guntakal', '05499491299', 'CQ', 'CNTT', 59, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21002086', 'Uthkarsh Badami', 'Nam', to_date('1972-08-07', 'YYYY-MM-DD'), '23/33 Hora Ganj Sambalpur', '0955010378', 'CLC', 'HTTT', 28, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21002087', 'Shayak Dhawan', 'N?', to_date('1924-03-19', 'YYYY-MM-DD'), 'H.No. 291 Maharaj Chowk Chennai', '1987424320', 'VP', 'CNTT', 6, 4.77);

INSERT INTO SINHVIEN
VALUES ('SV21002088', 'Keya Chandra', 'N?', to_date('1956-08-03', 'YYYY-MM-DD'), '29 Ram Street Kochi', '00860938525', 'CQ', 'CNTT', 43, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21002089', 'Kiara Dalal', 'N?', to_date('1936-11-01', 'YYYY-MM-DD'), '98 Sami Ganj Kavali', '9557778083', 'VP', 'HTTT', 131, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21002090', 'Uthkarsh Rege', 'N?', to_date('1948-09-25', 'YYYY-MM-DD'), '59 Garg Nagar Vijayanagaram', '2997050082', 'CLC', 'KHMT', 36, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21002091', 'Tarini Rana', 'Nam', to_date('1915-06-07', 'YYYY-MM-DD'), '31 Chanda Ganj Jorhat', '00173205677', 'CTTT', 'TGMT', 44, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21002092', 'Anahi Bhasin', 'Nam', to_date('1913-06-29', 'YYYY-MM-DD'), '03 Kade Ujjain', '05660376697', 'VP', 'CNPM', 16, 5.0);

INSERT INTO SINHVIEN
VALUES ('SV21002093', 'Aradhya Biswas', 'Nam', to_date('2023-10-26', 'YYYY-MM-DD'), '72/613 Char Circle Sagar', '+910926875642', 'CLC', 'HTTT', 61, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21002094', 'Samaira Sant', 'Nam', to_date('1983-11-20', 'YYYY-MM-DD'), 'H.No. 912 D��Alia Marg Maheshtala', '+912115097871', 'CTTT', 'KHMT', 98, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21002095', 'Mohanlal Chandran', 'N?', to_date('1929-05-24', 'YYYY-MM-DD'), '71/038 Khurana Road Bhatpara', '+910554725557', 'CTTT', 'CNPM', 72, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21002096', 'Tarini Arora', 'N?', to_date('1952-05-27', 'YYYY-MM-DD'), '80/26 Keer Street Bulandshahr', '05058349507', 'CLC', 'KHMT', 124, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21002097', 'Jhanvi Vala', 'N?', to_date('1920-12-12', 'YYYY-MM-DD'), 'H.No. 09 Shroff Nagar Ramagundam', '+919021241227', 'VP', 'CNTT', 39, 5.86);

INSERT INTO SINHVIEN
VALUES ('SV21002098', 'Nitya Chadha', 'N?', to_date('1916-03-06', 'YYYY-MM-DD'), '32/871 Tank Street Kurnool', '+916730963943', 'CQ', 'MMT', 124, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21002099', 'Kartik Uppal', 'Nam', to_date('1912-11-26', 'YYYY-MM-DD'), '528 Loke Nagar Sonipat', '+918242758539', 'VP', 'HTTT', 133, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21002100', 'Aarna Toor', 'Nam', to_date('1987-11-15', 'YYYY-MM-DD'), 'H.No. 449 Sood Vellore', '0446968659', 'VP', 'KHMT', 11, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21002101', 'Navya Tara', 'Nam', to_date('1996-11-19', 'YYYY-MM-DD'), 'H.No. 14 Bajaj Circle Singrauli', '+918345205037', 'CTTT', 'TGMT', 137, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21002102', 'Yashvi Bajaj', 'Nam', to_date('2010-01-11', 'YYYY-MM-DD'), 'H.No. 718 Magar Circle Gopalpur', '07555996947', 'CQ', 'CNTT', 116, 8.05);

INSERT INTO SINHVIEN
VALUES ('SV21002103', 'Vedika Kohli', 'N?', to_date('2006-12-03', 'YYYY-MM-DD'), '61/629 Sathe Path Karnal', '+912637718296', 'CTTT', 'HTTT', 73, 4.53);

INSERT INTO SINHVIEN
VALUES ('SV21002104', 'Seher Andra', 'N?', to_date('1923-03-29', 'YYYY-MM-DD'), '931 Dash Zila Ulhasnagar', '8025982975', 'CLC', 'CNTT', 46, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21002105', 'Amira Borra', 'N?', to_date('1920-11-07', 'YYYY-MM-DD'), 'H.No. 161 Bhatnagar Ganj Surat', '+917314429162', 'CQ', 'KHMT', 106, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21002106', 'Aniruddh Konda', 'Nam', to_date('1939-12-06', 'YYYY-MM-DD'), '564 Chakraborty Marg Guntur', '3872623113', 'CQ', 'TGMT', 17, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21002107', 'Shamik Suri', 'Nam', to_date('2003-05-03', 'YYYY-MM-DD'), '502 Garde Chowk Rourkela', '+916478537481', 'CTTT', 'CNTT', 66, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21002108', 'Rati Talwar', 'Nam', to_date('1945-06-02', 'YYYY-MM-DD'), '468 Suresh Path Gangtok', '+916416433549', 'VP', 'HTTT', 118, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21002109', 'Anay Dara', 'Nam', to_date('2019-01-16', 'YYYY-MM-DD'), 'H.No. 64 Thaker Marg Hajipur', '03539954677', 'VP', 'CNPM', 41, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21002110', 'Sana Ravi', 'N?', to_date('2010-02-15', 'YYYY-MM-DD'), '532 Wagle Ganj Sagar', '8524342199', 'CQ', 'KHMT', 81, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21002111', 'Seher Amble', 'N?', to_date('1993-07-27', 'YYYY-MM-DD'), '65/11 Datta Nagar Raiganj', '07954922000', 'CQ', 'CNPM', 76, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21002112', 'Hrishita Saha', 'N?', to_date('1957-01-10', 'YYYY-MM-DD'), '02/509 Bhattacharyya Circle Alwar', '09204295066', 'CLC', 'CNPM', 64, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21002113', 'Anay Sharma', 'Nam', to_date('1949-12-17', 'YYYY-MM-DD'), '13/10 Hegde Bhubaneswar', '+910047850103', 'VP', 'MMT', 100, 4.2);

INSERT INTO SINHVIEN
VALUES ('SV21002114', 'Vanya Kapoor', 'Nam', to_date('1958-08-12', 'YYYY-MM-DD'), '32/176 Bansal Road Guna', '07812533322', 'CLC', 'MMT', 67, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21002115', 'Badal Sehgal', 'N?', to_date('2008-02-28', 'YYYY-MM-DD'), '02/76 Behl Street Secunderabad', '+917874203609', 'VP', 'CNPM', 71, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21002116', 'Mohanlal Kakar', 'Nam', to_date('1930-12-25', 'YYYY-MM-DD'), '95/27 Sur Nagar Katni', '00252334213', 'CLC', 'KHMT', 135, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21002117', 'Kimaya Bhatnagar', 'N?', to_date('1987-08-04', 'YYYY-MM-DD'), 'H.No. 595 Wable Circle Kolhapur', '5235180832', 'CLC', 'MMT', 79, 5.2);

INSERT INTO SINHVIEN
VALUES ('SV21002118', 'Mehul Gera', 'N?', to_date('1995-03-30', 'YYYY-MM-DD'), 'H.No. 25 Chand Ganj Pondicherry', '+915631627948', 'CLC', 'MMT', 85, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21002119', 'Mishti Ravi', 'Nam', to_date('1985-05-10', 'YYYY-MM-DD'), '897 Sharaf Chowk Erode', '+911523939391', 'CTTT', 'CNTT', 64, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21002120', 'Yuvraj  Date', 'N?', to_date('1909-01-26', 'YYYY-MM-DD'), '149 Thakur Path Berhampur', '06414551587', 'VP', 'HTTT', 62, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21002121', 'Ranbir Bath', 'N?', to_date('1994-07-04', 'YYYY-MM-DD'), '19/062 Sawhney Chowk Coimbatore', '06551895599', 'VP', 'TGMT', 135, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21002122', 'Rania Warrior', 'Nam', to_date('1919-03-31', 'YYYY-MM-DD'), '140 Bal Marg Hapur', '05770282271', 'VP', 'CNTT', 35, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21002123', 'Azad Bhatia', 'N?', to_date('2011-11-04', 'YYYY-MM-DD'), '43/955 Shah Road Sambhal', '+916020652373', 'CQ', 'CNPM', 66, 7.55);

INSERT INTO SINHVIEN
VALUES ('SV21002124', 'Purab Kapur', 'N?', to_date('1931-08-03', 'YYYY-MM-DD'), '20/39 Hayre Road Thrissur', '06238382731', 'CLC', 'MMT', 68, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002125', 'Baiju Atwal', 'N?', to_date('2016-03-10', 'YYYY-MM-DD'), '57/481 Sahota Ganj Jhansi', '1800190066', 'VP', 'CNTT', 2, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21002126', 'Darshit Dhar', 'Nam', to_date('2018-02-22', 'YYYY-MM-DD'), '42/489 Raj Marg Pallavaram', '5553857479', 'CQ', 'HTTT', 112, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21002127', 'Tanya Bava', 'N?', to_date('1912-12-26', 'YYYY-MM-DD'), 'H.No. 84 Gulati Nagar Bellary', '+918414938044', 'CQ', 'MMT', 44, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21002128', 'Mehul Sekhon', 'Nam', to_date('1927-04-10', 'YYYY-MM-DD'), '83/490 Deshmukh Chowk Loni', '+917837459699', 'VP', 'KHMT', 124, 5.0);

INSERT INTO SINHVIEN
VALUES ('SV21002129', 'Himmat Sarraf', 'N?', to_date('1938-01-06', 'YYYY-MM-DD'), 'H.No. 767 Sunder Circle Rohtak', '+910343249646', 'CLC', 'CNTT', 44, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21002130', 'Adah Kant', 'N?', to_date('1930-12-29', 'YYYY-MM-DD'), 'H.No. 990 Mangal Road Raebareli', '07318329007', 'CLC', 'KHMT', 53, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21002131', 'Zoya Dhawan', 'Nam', to_date('2016-03-15', 'YYYY-MM-DD'), '41/61 Dhawan Marg Shimoga', '+918671355177', 'CTTT', 'HTTT', 51, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002132', 'Ivan Chawla', 'Nam', to_date('1985-05-12', 'YYYY-MM-DD'), '98/723 Date Jaunpur', '3643870650', 'CQ', 'KHMT', 93, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21002133', 'Yuvaan Apte', 'Nam', to_date('2016-01-15', 'YYYY-MM-DD'), 'H.No. 99 Warrior Saharanpur', '+915750849835', 'CLC', 'KHMT', 82, 6.24);

INSERT INTO SINHVIEN
VALUES ('SV21002134', 'Ehsaan Kade', 'Nam', to_date('1933-07-29', 'YYYY-MM-DD'), '432 Dua Marg Amravati', '09289145009', 'CLC', 'MMT', 120, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21002135', 'Navya Krishnamurthy', 'Nam', to_date('1935-08-09', 'YYYY-MM-DD'), '76/166 Mahal Road Thane', '+917475000064', 'CTTT', 'TGMT', 113, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21002136', 'Inaaya  Bobal', 'N?', to_date('1920-09-06', 'YYYY-MM-DD'), '47/37 Bajaj Street Bhatpara', '02443880157', 'CTTT', 'KHMT', 0, 5.02);

INSERT INTO SINHVIEN
VALUES ('SV21002137', 'Veer Dube', 'Nam', to_date('1930-02-25', 'YYYY-MM-DD'), '40 Raval Path Cuttack', '04725777134', 'VP', 'TGMT', 47, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21002138', 'Manjari Ram', 'N?', to_date('2002-07-02', 'YYYY-MM-DD'), '50/780 Khare Marg Tinsukia', '+911845527938', 'CQ', 'HTTT', 113, 5.12);

INSERT INTO SINHVIEN
VALUES ('SV21002139', 'Aarna Dhar', 'Nam', to_date('1913-03-01', 'YYYY-MM-DD'), '056 Yogi Chowk Ajmer', '02749088614', 'VP', 'KHMT', 122, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21002140', 'Heer Bobal', 'Nam', to_date('1939-10-29', 'YYYY-MM-DD'), 'H.No. 97 Dhar Road Karimnagar', '3666622057', 'CTTT', 'TGMT', 1, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21002141', 'Anahi Gara', 'Nam', to_date('1914-05-20', 'YYYY-MM-DD'), '748 Sandhu Street Rohtak', '08000521463', 'VP', 'TGMT', 98, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21002142', 'Shaan Walia', 'N?', to_date('1919-04-30', 'YYYY-MM-DD'), '55/12 Kapoor Marg Tirupati', '6329282211', 'CTTT', 'KHMT', 98, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21002143', 'Madhup Majumdar', 'Nam', to_date('2007-04-06', 'YYYY-MM-DD'), 'H.No. 13 Shankar Circle Secunderabad', '+910016323843', 'CQ', 'CNTT', 122, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21002144', 'Diya Sastry', 'Nam', to_date('1983-11-11', 'YYYY-MM-DD'), '264 Sachdev Circle Hospet', '+912904867128', 'CLC', 'HTTT', 66, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21002145', 'Nirvaan Dar', 'Nam', to_date('1984-07-30', 'YYYY-MM-DD'), '72 Dayal Circle Bhiwani', '05689206282', 'CTTT', 'MMT', 100, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21002146', 'Dhanuk Sha', 'N?', to_date('2010-07-15', 'YYYY-MM-DD'), '69/689 Lad Road Machilipatnam', '08878945425', 'CQ', 'KHMT', 43, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21002147', 'Onkar Apte', 'N?', to_date('1955-12-14', 'YYYY-MM-DD'), '970 Tella Nagar Lucknow', '3007811581', 'VP', 'TGMT', 91, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21002148', 'Aniruddh Borde', 'Nam', to_date('1922-10-11', 'YYYY-MM-DD'), 'H.No. 119 Talwar Nagar Surendranagar Dudhrej', '4037635089', 'CQ', 'HTTT', 128, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002149', 'Nayantara Kari', 'Nam', to_date('1913-11-07', 'YYYY-MM-DD'), '71/33 Raval Circle Hyderabad', '06879519021', 'CLC', 'MMT', 30, 7.7);

INSERT INTO SINHVIEN
VALUES ('SV21002150', 'Ivana Luthra', 'N?', to_date('2001-09-29', 'YYYY-MM-DD'), 'H.No. 475 Sastry Street Alappuzha', '3998556464', 'CTTT', 'CNTT', 70, 6.28);

INSERT INTO SINHVIEN
VALUES ('SV21002151', 'Kavya Tandon', 'Nam', to_date('1956-08-12', 'YYYY-MM-DD'), '68 Mallick Ganj Ozhukarai', '06953872169', 'VP', 'MMT', 108, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002152', 'Eshani Agate', 'N?', to_date('1947-06-07', 'YYYY-MM-DD'), 'H.No. 186 Bhavsar Road Gangtok', '+917911803596', 'CTTT', 'CNPM', 137, 7.89);

INSERT INTO SINHVIEN
VALUES ('SV21002153', 'Hridaan Ramesh', 'N?', to_date('2006-02-02', 'YYYY-MM-DD'), 'H.No. 30 Sood Circle Amritsar', '+912093513598', 'CLC', 'HTTT', 42, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21002154', 'Akarsh Khare', 'N?', to_date('1926-08-27', 'YYYY-MM-DD'), '437 Chaudhary Path Uluberia', '1851868119', 'VP', 'KHMT', 132, 6.64);

INSERT INTO SINHVIEN
VALUES ('SV21002155', 'Divij Bera', 'N?', to_date('1996-12-27', 'YYYY-MM-DD'), '58/816 Goyal Street Kamarhati', '+919837894740', 'CTTT', 'HTTT', 131, 6.58);

INSERT INTO SINHVIEN
VALUES ('SV21002156', 'Rohan Karan', 'N?', to_date('1981-05-19', 'YYYY-MM-DD'), 'H.No. 774 Dube Road Lucknow', '06264185038', 'CTTT', 'KHMT', 21, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21002157', 'Kismat Din', 'N?', to_date('1961-12-27', 'YYYY-MM-DD'), 'H.No. 57 Kala Circle Bettiah', '+918662793819', 'CQ', 'HTTT', 41, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21002158', 'Nirvi Dhawan', 'Nam', to_date('1916-11-21', 'YYYY-MM-DD'), '69 Joshi Road Tirupati', '00814982791', 'CLC', 'TGMT', 94, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21002159', 'Lakshit Dhar', 'N?', to_date('1921-12-12', 'YYYY-MM-DD'), '73/66 Deshmukh Anantapuram', '4687055101', 'CTTT', 'CNPM', 108, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21002160', 'Armaan Joshi', 'Nam', to_date('1979-06-04', 'YYYY-MM-DD'), '965 Chatterjee Marg Ramgarh', '3034665599', 'VP', 'HTTT', 87, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21002161', 'Amira Biswas', 'N?', to_date('2016-03-07', 'YYYY-MM-DD'), '61/44 Dube Street Bilaspur', '+913460398803', 'CLC', 'CNPM', 63, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21002162', 'Lakshit Tandon', 'Nam', to_date('2000-02-02', 'YYYY-MM-DD'), '821 Borde Chowk Dhule', '00654056462', 'CTTT', 'CNTT', 116, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21002163', 'Rohan Bose', 'N?', to_date('1914-01-04', 'YYYY-MM-DD'), '66/78 Buch Circle Dibrugarh', '05835658600', 'CTTT', 'CNTT', 131, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002164', 'Prerak Gole', 'N?', to_date('1942-04-08', 'YYYY-MM-DD'), '90/365 Keer Street Shivpuri', '06901851110', 'VP', 'TGMT', 43, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21002165', 'Anvi Bawa', 'Nam', to_date('2021-01-26', 'YYYY-MM-DD'), 'H.No. 364 Mallick Path Purnia', '+916254259192', 'CLC', 'CNTT', 81, 8.0);

INSERT INTO SINHVIEN
VALUES ('SV21002166', 'Mishti Dasgupta', 'Nam', to_date('1936-01-29', 'YYYY-MM-DD'), '513 Chaudhry Ganj Nandyal', '+917996003314', 'CQ', 'KHMT', 63, 6.39);

INSERT INTO SINHVIEN
VALUES ('SV21002167', 'Tejas Datta', 'N?', to_date('1924-09-09', 'YYYY-MM-DD'), 'H.No. 474 Baria Nagar Dindigul', '03171553926', 'CQ', 'CNTT', 83, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21002168', 'Tarini Sarkar', 'N?', to_date('1961-12-14', 'YYYY-MM-DD'), '27/640 Ravel Road Silchar', '06058711335', 'CTTT', 'MMT', 17, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21002169', 'Suhana Raju', 'N?', to_date('1919-09-02', 'YYYY-MM-DD'), 'H.No. 50 Kalla Path Erode', '+912714326857', 'CLC', 'TGMT', 99, 5.69);

INSERT INTO SINHVIEN
VALUES ('SV21002170', 'Divyansh Doctor', 'Nam', to_date('2001-04-07', 'YYYY-MM-DD'), '62/94 Raja Circle Pondicherry', '3353414536', 'CLC', 'KHMT', 66, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21002171', 'Ryan Kulkarni', 'Nam', to_date('1952-09-07', 'YYYY-MM-DD'), 'H.No. 69 Bansal Path Bareilly', '+915628444538', 'VP', 'KHMT', 138, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21002172', 'Reyansh Chaudhary', 'Nam', to_date('1909-12-21', 'YYYY-MM-DD'), '15 Agate Ganj Ichalkaranji', '+912587537038', 'CTTT', 'MMT', 54, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21002173', 'Inaaya  Swamy', 'Nam', to_date('1962-07-07', 'YYYY-MM-DD'), '868 Tara Street Bhusawal', '01678040693', 'CQ', 'KHMT', 120, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21002174', 'Indrajit Borra', 'N?', to_date('1986-01-26', 'YYYY-MM-DD'), '11/739 Saraf Street Gurgaon', '6884225471', 'CQ', 'TGMT', 41, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21002175', 'Alisha Datta', 'N?', to_date('1908-05-23', 'YYYY-MM-DD'), '82/05 Yadav Ganj Karnal', '8720612867', 'CLC', 'CNTT', 90, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21002176', 'Romil Rege', 'Nam', to_date('1947-04-17', 'YYYY-MM-DD'), '10/67 Sabharwal Circle Satara', '+913590107303', 'VP', 'HTTT', 36, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21002177', 'Chirag Gupta', 'Nam', to_date('2005-02-24', 'YYYY-MM-DD'), '11 Bajaj Zila Shimoga', '+913604587742', 'CLC', 'CNTT', 103, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21002178', 'Azad Uppal', 'N?', to_date('1982-12-07', 'YYYY-MM-DD'), '36 Wadhwa Path Nellore', '9477602105', 'CQ', 'TGMT', 59, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21002179', 'Aayush Salvi', 'Nam', to_date('1962-12-24', 'YYYY-MM-DD'), 'H.No. 258 Madan Road Nanded', '6023505514', 'CTTT', 'KHMT', 109, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21002180', 'Zara Kothari', 'N?', to_date('1915-04-06', 'YYYY-MM-DD'), '974 Bobal Zila Tezpur', '2910368838', 'CLC', 'HTTT', 16, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21002181', 'Tanya De', 'Nam', to_date('1952-11-18', 'YYYY-MM-DD'), '320 Sandhu Road Tezpur', '04677485182', 'CLC', 'TGMT', 120, 4.17);

INSERT INTO SINHVIEN
VALUES ('SV21002182', 'Damini Chaudhary', 'N?', to_date('1982-07-03', 'YYYY-MM-DD'), '59 Raj Nagar Salem', '07985744529', 'CLC', 'TGMT', 74, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21002183', 'Mannat Sanghvi', 'Nam', to_date('1952-04-30', 'YYYY-MM-DD'), '98/513 Bajaj Nagar Bally', '+917644026273', 'CLC', 'MMT', 39, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21002184', 'Miraya Bhatia', 'Nam', to_date('1938-07-22', 'YYYY-MM-DD'), '993 Rout Street Raipur', '+913586856776', 'VP', 'HTTT', 54, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21002185', 'Dhruv Barad', 'Nam', to_date('1908-11-04', 'YYYY-MM-DD'), '61 Dayal Road Sasaram', '01168898475', 'CTTT', 'CNPM', 47, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21002186', 'Armaan Choudhary', 'N?', to_date('1940-11-23', 'YYYY-MM-DD'), '17 Choudhry Chowk Srinagar', '+910016715076', 'CLC', 'MMT', 138, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21002187', 'Saira Chahal', 'Nam', to_date('1960-10-07', 'YYYY-MM-DD'), 'H.No. 253 Hayre Zila Purnia', '00224690205', 'CQ', 'KHMT', 99, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21002188', 'Kabir Tata', 'N?', to_date('1989-02-10', 'YYYY-MM-DD'), '23/331 Rastogi Circle Baranagar', '+914028006738', 'CTTT', 'MMT', 133, 8.42);

INSERT INTO SINHVIEN
VALUES ('SV21002189', 'Myra Chauhan', 'Nam', to_date('1992-08-14', 'YYYY-MM-DD'), 'H.No. 09 Bansal Pudukkottai', '01066865900', 'CQ', 'KHMT', 35, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21002190', 'Baiju Jayaraman', 'Nam', to_date('1989-03-24', 'YYYY-MM-DD'), 'H.No. 979 Konda Dibrugarh', '03412001762', 'CTTT', 'KHMT', 44, 8.71);

INSERT INTO SINHVIEN
VALUES ('SV21002191', 'Advika Jhaveri', 'N?', to_date('1983-09-25', 'YYYY-MM-DD'), '62 Khanna Zila Pali', '0203816325', 'VP', 'TGMT', 133, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21002192', 'Anahi Mahal', 'Nam', to_date('2007-08-13', 'YYYY-MM-DD'), '59/605 Jaggi Zila Nagercoil', '7169101922', 'CTTT', 'TGMT', 69, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21002193', 'Amira Randhawa', 'N?', to_date('1929-10-08', 'YYYY-MM-DD'), '28/336 Kapadia Marg Hapur', '09135860341', 'CTTT', 'KHMT', 65, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21002194', 'Onkar Mahal', 'Nam', to_date('2001-11-03', 'YYYY-MM-DD'), '796 Raval Ganj Malegaon', '+917169513312', 'VP', 'CNTT', 36, 7.82);

INSERT INTO SINHVIEN
VALUES ('SV21002195', 'Jayesh Rau', 'Nam', to_date('1999-10-11', 'YYYY-MM-DD'), 'H.No. 427 Sarma Ganj Jammu', '3833482759', 'CTTT', 'KHMT', 102, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21002196', 'Zeeshan Vaidya', 'Nam', to_date('1994-05-05', 'YYYY-MM-DD'), '97/690 Virk Marg Erode', '+910786888587', 'CQ', 'TGMT', 13, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21002197', 'Ryan Vig', 'Nam', to_date('1919-02-25', 'YYYY-MM-DD'), '171 Toor Road Adoni', '8678125164', 'CLC', 'TGMT', 13, 4.21);

INSERT INTO SINHVIEN
VALUES ('SV21002198', 'Ishaan Chowdhury', 'N?', to_date('2012-05-28', 'YYYY-MM-DD'), '70 Ratti Circle Suryapet', '+913790242258', 'CQ', 'CNTT', 38, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21002199', 'Lavanya Luthra', 'Nam', to_date('1977-03-15', 'YYYY-MM-DD'), '672 Chada Zila Nadiad', '09814199327', 'VP', 'MMT', 59, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21002200', 'Ela Sami', 'N?', to_date('1925-07-08', 'YYYY-MM-DD'), '57 Ratta Nagar Suryapet', '1664145921', 'CLC', 'MMT', 136, 7.24);

INSERT INTO SINHVIEN
VALUES ('SV21002201', 'Jayesh Bahl', 'N?', to_date('1945-08-06', 'YYYY-MM-DD'), '32/863 Hayre Street Nellore', '+918986102022', 'CLC', 'KHMT', 66, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21002202', 'Trisha Lad', 'N?', to_date('1943-03-18', 'YYYY-MM-DD'), '04/24 Khare Marg Saharanpur', '05986456277', 'CLC', 'CNTT', 115, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21002203', 'Madhup Choudhary', 'Nam', to_date('1990-04-17', 'YYYY-MM-DD'), '465 Chad Ganj Anand', '00687885835', 'VP', 'TGMT', 111, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21002204', 'Eva Rege', 'N?', to_date('1959-10-01', 'YYYY-MM-DD'), '22/604 Buch Street Burhanpur', '7242420423', 'CQ', 'TGMT', 26, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21002205', 'Mahika Ray', 'Nam', to_date('1933-07-15', 'YYYY-MM-DD'), 'H.No. 76 Rajagopal Marg Kozhikode', '05341633836', 'CQ', 'TGMT', 133, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21002206', 'Rasha Deshmukh', 'Nam', to_date('1949-06-17', 'YYYY-MM-DD'), '35 Jayaraman Zila Panchkula', '08971708450', 'CTTT', 'CNPM', 106, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21002207', 'Nakul Comar', 'Nam', to_date('1997-10-30', 'YYYY-MM-DD'), 'H.No. 59 Sura Marg Suryapet', '+915778968156', 'CQ', 'CNPM', 119, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21002208', 'Nishith Master', 'Nam', to_date('1935-09-30', 'YYYY-MM-DD'), '187 Shenoy Nagar Morena', '5588191081', 'VP', 'HTTT', 47, 4.98);

INSERT INTO SINHVIEN
VALUES ('SV21002209', 'Ela Chaudry', 'N?', to_date('2022-11-04', 'YYYY-MM-DD'), '93/25 Boase Nagar Ballia', '8381825775', 'VP', 'CNPM', 118, 9.48);

INSERT INTO SINHVIEN
VALUES ('SV21002210', 'Vardaniya Raman', 'N?', to_date('1961-01-12', 'YYYY-MM-DD'), '707 Choudhry Path Gorakhpur', '+917263524715', 'VP', 'KHMT', 67, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21002211', 'Raunak Madan', 'Nam', to_date('1997-09-12', 'YYYY-MM-DD'), '09/99 Kannan Marg Malda', '08026096821', 'VP', 'HTTT', 122, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21002212', 'Jiya Thakur', 'N?', to_date('1929-02-05', 'YYYY-MM-DD'), '57/78 Kapur Path Rajahmundry', '03781821888', 'CTTT', 'HTTT', 62, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21002213', 'Divij Ganesan', 'N?', to_date('1957-02-02', 'YYYY-MM-DD'), 'H.No. 69 Dar Road Gudivada', '+912230356082', 'CQ', 'KHMT', 106, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21002214', 'Aarush Goyal', 'N?', to_date('1974-11-04', 'YYYY-MM-DD'), 'H.No. 12 Ganguly Chandigarh', '+919268984419', 'CQ', 'TGMT', 84, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002215', 'Sana Brahmbhatt', 'N?', to_date('1949-08-08', 'YYYY-MM-DD'), '952 Venkataraman Marg Bhopal', '+912421818888', 'CQ', 'KHMT', 63, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21002216', 'Taimur Bhakta', 'Nam', to_date('2005-06-08', 'YYYY-MM-DD'), '45/62 Ramanathan Zila Sultan Pur Majra', '02519664082', 'CTTT', 'CNPM', 1, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21002217', 'Ryan Shetty', 'Nam', to_date('1995-11-15', 'YYYY-MM-DD'), '258 Krish Road Satara', '+910436264752', 'VP', 'CNPM', 79, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21002218', 'Ritvik Tripathi', 'N?', to_date('1936-07-23', 'YYYY-MM-DD'), '32 Chand Circle Kumbakonam', '3614802727', 'CQ', 'HTTT', 110, 9.77);

INSERT INTO SINHVIEN
VALUES ('SV21002219', 'Veer Kaul', 'N?', to_date('1950-08-08', 'YYYY-MM-DD'), '77/71 Sehgal Circle Rohtak', '9801105162', 'CQ', 'TGMT', 46, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21002220', 'Keya Chana', 'Nam', to_date('2023-02-15', 'YYYY-MM-DD'), 'H.No. 659 Krishna Zila Phusro', '+913447471259', 'CQ', 'KHMT', 123, 6.97);

INSERT INTO SINHVIEN
VALUES ('SV21002221', 'Vedika Mani', 'N?', to_date('1927-10-28', 'YYYY-MM-DD'), 'H.No. 72 Hayre Street Kharagpur', '+914745171130', 'CLC', 'CNTT', 88, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21002222', 'Dhruv Dutt', 'Nam', to_date('1911-07-30', 'YYYY-MM-DD'), '42/324 Sabharwal Bettiah', '7257630842', 'CLC', 'MMT', 33, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21002223', 'Damini Dey', 'N?', to_date('1950-11-03', 'YYYY-MM-DD'), 'H.No. 412 Hari Bhopal', '08449178641', 'CQ', 'KHMT', 126, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21002224', 'Anvi Mall', 'N?', to_date('1917-07-16', 'YYYY-MM-DD'), 'H.No. 209 Bakshi Bilaspur', '08861796686', 'VP', 'TGMT', 89, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21002225', 'Shalv Bail', 'Nam', to_date('2011-07-10', 'YYYY-MM-DD'), '92 Shere Street Dewas', '01170459309', 'VP', 'CNPM', 96, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21002226', 'Ayesha Sachdeva', 'N?', to_date('1912-05-01', 'YYYY-MM-DD'), 'H.No. 79 Mahal Chowk Silchar', '+910080278531', 'CLC', 'KHMT', 105, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21002227', 'Adira Gola', 'N?', to_date('2010-02-18', 'YYYY-MM-DD'), 'H.No. 26 Rajagopalan Nagar Kanpur', '5888912904', 'CQ', 'KHMT', 130, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21002228', 'Raunak Mani', 'N?', to_date('1971-10-13', 'YYYY-MM-DD'), 'H.No. 39 Bhavsar Chowk Madanapalle', '8920933455', 'CTTT', 'KHMT', 84, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21002229', 'Tushar Yohannan', 'N?', to_date('1934-07-22', 'YYYY-MM-DD'), '49/542 Dhar Chowk Farrukhabad', '+917617762679', 'CQ', 'MMT', 121, 4.39);

INSERT INTO SINHVIEN
VALUES ('SV21002230', 'Kimaya Loyal', 'Nam', to_date('1929-05-13', 'YYYY-MM-DD'), 'H.No. 00 Contractor Zila Machilipatnam', '2604482544', 'CLC', 'TGMT', 71, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21002231', 'Purab Rege', 'N?', to_date('1983-08-13', 'YYYY-MM-DD'), 'H.No. 62 Badami Guntur', '7584821506', 'CQ', 'HTTT', 113, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21002232', 'Drishya Ray', 'N?', to_date('1915-01-15', 'YYYY-MM-DD'), '663 Ratta Road Bahraich', '+910238218311', 'CTTT', 'HTTT', 109, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21002233', 'Vaibhav Kota', 'Nam', to_date('1923-09-28', 'YYYY-MM-DD'), '300 Borde Road Nellore', '02110691320', 'VP', 'HTTT', 109, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21002234', 'Kiaan Devi', 'N?', to_date('2016-11-07', 'YYYY-MM-DD'), 'H.No. 70 Varty Ganj Parbhani', '+913995039275', 'CTTT', 'TGMT', 56, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21002235', 'Shaan Basak', 'N?', to_date('1975-07-29', 'YYYY-MM-DD'), 'H.No. 48 Sarna Ganj Aurangabad', '+912027709335', 'CQ', 'HTTT', 7, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21002236', 'Drishya Maharaj', 'Nam', to_date('1958-08-22', 'YYYY-MM-DD'), '329 Sandal Circle Hubli�CDharwad', '06695433985', 'VP', 'KHMT', 65, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21002237', 'Aarav Bir', 'Nam', to_date('1977-11-08', 'YYYY-MM-DD'), 'H.No. 719 Deol Circle Panchkula', '09575235846', 'CTTT', 'TGMT', 0, 5.57);

INSERT INTO SINHVIEN
VALUES ('SV21002238', 'Misha Golla', 'N?', to_date('1918-10-21', 'YYYY-MM-DD'), '079 Khare Circle Mau', '07135118759', 'CQ', 'TGMT', 56, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21002239', 'Nakul Shukla', 'N?', to_date('1922-02-13', 'YYYY-MM-DD'), 'H.No. 260 Zacharia Path Jamnagar', '4854560572', 'CTTT', 'KHMT', 109, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21002240', 'Misha Bala', 'Nam', to_date('1986-06-19', 'YYYY-MM-DD'), '13/66 Suri Hyderabad', '+914105192860', 'CTTT', 'CNPM', 99, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21002241', 'Neelofar Barad', 'Nam', to_date('1998-02-06', 'YYYY-MM-DD'), '33/564 Arora Chowk Bahraich', '1928476009', 'CTTT', 'HTTT', 51, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21002242', 'Hazel Sachdeva', 'N?', to_date('1952-01-12', 'YYYY-MM-DD'), '66 Contractor Guna', '5198909130', 'VP', 'KHMT', 61, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21002243', 'Vidur Talwar', 'N?', to_date('1946-04-09', 'YYYY-MM-DD'), '42/34 Dixit Ganj Deoghar', '06586741768', 'VP', 'HTTT', 97, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21002244', 'Anahita Baral', 'N?', to_date('2002-12-29', 'YYYY-MM-DD'), '47 Kohli Nagar Siwan', '3453001626', 'CTTT', 'MMT', 45, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21002245', 'Neysa Arora', 'Nam', to_date('1945-05-21', 'YYYY-MM-DD'), '05 Khare Nagar Korba', '+915433267582', 'CLC', 'TGMT', 97, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21002246', 'Indrajit Hari', 'N?', to_date('1925-05-26', 'YYYY-MM-DD'), 'H.No. 055 Sahni Zila Ajmer', '01941318930', 'CTTT', 'CNTT', 3, 6.83);

INSERT INTO SINHVIEN
VALUES ('SV21002247', 'Saanvi Amble', 'Nam', to_date('1931-03-22', 'YYYY-MM-DD'), '01/81 Dugal Ganj Ballia', '+916762423201', 'VP', 'CNPM', 119, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21002248', 'Kartik Kala', 'Nam', to_date('1963-01-20', 'YYYY-MM-DD'), 'H.No. 23 Garg Path Katni', '+916497171767', 'CTTT', 'HTTT', 135, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21002249', 'Lagan Mander', 'Nam', to_date('1936-07-11', 'YYYY-MM-DD'), '89 Suresh Ujjain', '05075928608', 'CLC', 'HTTT', 19, 5.19);

INSERT INTO SINHVIEN
VALUES ('SV21002250', 'Rhea Bhattacharyya', 'N?', to_date('2010-05-16', 'YYYY-MM-DD'), 'H.No. 85 Dass Road Gwalior', '04042178150', 'CLC', 'KHMT', 80, 6.11);

INSERT INTO SINHVIEN
VALUES ('SV21002251', 'Azad Raj', 'N?', to_date('1922-03-04', 'YYYY-MM-DD'), 'H.No. 504 Zacharia Nagar Mathura', '4737391638', 'CLC', 'MMT', 133, 6.33);

INSERT INTO SINHVIEN
VALUES ('SV21002252', 'Hiran Gole', 'Nam', to_date('1942-08-31', 'YYYY-MM-DD'), '72 Choudhury Circle Eluru', '+911538842196', 'CTTT', 'HTTT', 45, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21002253', 'Hunar Krishnamurthy', 'N?', to_date('1937-09-11', 'YYYY-MM-DD'), '180 Agarwal Nagar Bhilwara', '+919700957459', 'CLC', 'HTTT', 31, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21002254', 'Devansh Bhat', 'Nam', to_date('1988-03-20', 'YYYY-MM-DD'), '44/34 Guha Kadapa', '2014296535', 'CTTT', 'KHMT', 92, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21002255', 'Gatik Gola', 'Nam', to_date('1938-10-17', 'YYYY-MM-DD'), 'H.No. 03 Mane Marg Kochi', '6806273963', 'CLC', 'HTTT', 64, 5.79);

INSERT INTO SINHVIEN
VALUES ('SV21002256', 'Badal Deshpande', 'N?', to_date('1949-07-22', 'YYYY-MM-DD'), 'H.No. 68 Butala Zila Tadipatri', '1352563293', 'CQ', 'KHMT', 42, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21002257', 'Jivika Saxena', 'N?', to_date('1920-05-12', 'YYYY-MM-DD'), '72/660 Sane Zila Ujjain', '+913645156901', 'CLC', 'TGMT', 118, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21002258', 'Vaibhav Contractor', 'N?', to_date('1909-07-30', 'YYYY-MM-DD'), 'H.No. 493 Chahal Marg Asansol', '09365901405', 'CTTT', 'HTTT', 80, 7.22);

INSERT INTO SINHVIEN
VALUES ('SV21002259', 'Raghav Sastry', 'Nam', to_date('1974-10-01', 'YYYY-MM-DD'), 'H.No. 941 Basu Zila Rajkot', '08198970895', 'VP', 'TGMT', 5, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21002260', 'Hunar Banerjee', 'N?', to_date('1955-03-03', 'YYYY-MM-DD'), '18/95 Chowdhury Ganj Bhilwara', '9656429578', 'CTTT', 'TGMT', 133, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21002261', 'Adah Sekhon', 'Nam', to_date('2022-07-27', 'YYYY-MM-DD'), 'H.No. 86 Kapoor Road Davanagere', '06720328823', 'VP', 'HTTT', 0, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21002262', 'Advika Dutt', 'N?', to_date('1916-08-23', 'YYYY-MM-DD'), '69 Swaminathan Path Chandigarh', '3841726279', 'VP', 'CNPM', 119, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21002263', 'Manikya Jaggi', 'N?', to_date('2013-03-15', 'YYYY-MM-DD'), 'H.No. 38 De Path Hosur', '+915459819702', 'CQ', 'CNTT', 39, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21002264', 'Saira Shan', 'N?', to_date('1987-05-15', 'YYYY-MM-DD'), '88/52 Kurian Road Uluberia', '03390636592', 'CLC', 'HTTT', 128, 7.01);

INSERT INTO SINHVIEN
VALUES ('SV21002265', 'Ivana Bhagat', 'Nam', to_date('1976-08-30', 'YYYY-MM-DD'), '482 Bath Zila Alappuzha', '01681827232', 'CLC', 'KHMT', 83, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21002266', 'Aarna Gola', 'N?', to_date('1932-10-16', 'YYYY-MM-DD'), 'H.No. 282 Barad Zila Tadepalligudem', '8359741896', 'CQ', 'MMT', 102, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002267', 'Miraan Sura', 'N?', to_date('1929-06-17', 'YYYY-MM-DD'), '450 Dhingra Ganj Panvel', '00350764708', 'CTTT', 'CNTT', 9, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21002268', 'Yuvaan Karnik', 'N?', to_date('1923-10-20', 'YYYY-MM-DD'), '92/271 Shukla Chowk Pallavaram', '09874210306', 'VP', 'HTTT', 137, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21002269', 'Dishani Arya', 'Nam', to_date('1912-06-05', 'YYYY-MM-DD'), '98 Chawla Zila Bhind', '02663946101', 'VP', 'MMT', 114, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21002270', 'Manjari Lalla', 'Nam', to_date('1956-10-06', 'YYYY-MM-DD'), '78/170 Zachariah Ganj Gopalpur', '6432775795', 'CLC', 'CNPM', 101, 9.65);

INSERT INTO SINHVIEN
VALUES ('SV21002271', 'Ishaan Manne', 'N?', to_date('1941-09-05', 'YYYY-MM-DD'), 'H.No. 01 Agarwal Circle Shivpuri', '6116079543', 'CTTT', 'MMT', 115, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21002272', 'Tanya Bhardwaj', 'Nam', to_date('2006-10-17', 'YYYY-MM-DD'), '690 Atwal Chowk Bareilly', '09169341581', 'CLC', 'KHMT', 3, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21002273', 'Riaan Bhandari', 'N?', to_date('1970-09-10', 'YYYY-MM-DD'), '035 Chatterjee Path Pallavaram', '+914857885607', 'CQ', 'CNPM', 28, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21002274', 'Taran Wable', 'Nam', to_date('2003-10-21', 'YYYY-MM-DD'), '54 Shenoy Path Ozhukarai', '00677690597', 'CTTT', 'CNTT', 118, 9.48);

INSERT INTO SINHVIEN
VALUES ('SV21002275', 'Jayan Sarin', 'N?', to_date('2018-07-16', 'YYYY-MM-DD'), '968 Kalita Muzaffarnagar', '0067497094', 'CTTT', 'TGMT', 33, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21002276', 'Chirag Subramanian', 'N?', to_date('1962-02-03', 'YYYY-MM-DD'), '403 Badal Circle Gudivada', '08329350902', 'VP', 'CNPM', 4, 5.86);

INSERT INTO SINHVIEN
VALUES ('SV21002277', 'Adira Varughese', 'N?', to_date('1970-01-09', 'YYYY-MM-DD'), '75/855 Bandi Nagar Raichur', '09262228145', 'CTTT', 'HTTT', 45, 6.77);

INSERT INTO SINHVIEN
VALUES ('SV21002278', 'Faiyaz Ravel', 'N?', to_date('1925-03-14', 'YYYY-MM-DD'), 'H.No. 102 Sodhi Street Bhiwani', '+919080833774', 'CTTT', 'MMT', 60, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21002279', 'Oorja Ravi', 'Nam', to_date('2004-02-23', 'YYYY-MM-DD'), 'H.No. 925 Seth Nagar Ludhiana', '+912008439001', 'VP', 'CNPM', 59, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21002280', 'Emir Sridhar', 'N?', to_date('1951-08-21', 'YYYY-MM-DD'), '83 Bedi Road Srinagar', '08035668169', 'CQ', 'CNTT', 42, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21002281', 'Renee Tata', 'Nam', to_date('1980-12-08', 'YYYY-MM-DD'), 'H.No. 389 Upadhyay Circle Kirari Suleman Nagar', '04386933199', 'CQ', 'MMT', 54, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21002282', 'Jivika Cherian', 'N?', to_date('1988-11-24', 'YYYY-MM-DD'), '87/584 Basak Path Gopalpur', '05234227297', 'CLC', 'MMT', 1, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21002283', 'Prisha Mahal', 'Nam', to_date('1912-09-19', 'YYYY-MM-DD'), 'H.No. 291 Ravi Chowk Tenali', '08640900923', 'CQ', 'HTTT', 118, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21002284', 'Aniruddh Bhagat', 'Nam', to_date('1922-12-26', 'YYYY-MM-DD'), '48 Borah Chandigarh', '07400272803', 'CTTT', 'CNTT', 90, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21002285', 'Rania Grover', 'N?', to_date('1956-11-12', 'YYYY-MM-DD'), 'H.No. 534 Agrawal Zila Darbhanga', '+918878200046', 'CQ', 'TGMT', 0, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21002286', 'Jayesh Lata', 'N?', to_date('1996-05-02', 'YYYY-MM-DD'), 'H.No. 551 Krishnamurthy Marg Kurnool', '04643635669', 'CQ', 'HTTT', 31, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21002287', 'Anya Madan', 'Nam', to_date('1933-03-19', 'YYYY-MM-DD'), 'H.No. 291 Rau Chowk Bhavnagar', '09184348740', 'VP', 'CNTT', 138, 7.13);

INSERT INTO SINHVIEN
VALUES ('SV21002288', 'Gatik Zacharia', 'N?', to_date('1949-10-06', 'YYYY-MM-DD'), '05/023 Kumar Path Sri Ganganagar', '08912941941', 'CQ', 'CNTT', 52, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21002289', 'Madhav Singhal', 'N?', to_date('2021-01-06', 'YYYY-MM-DD'), 'H.No. 16 Zacharia Road Anand', '05766766368', 'CTTT', 'MMT', 123, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21002290', 'Raghav Mangat', 'Nam', to_date('1999-06-29', 'YYYY-MM-DD'), '33/88 Badal Marg Madhyamgram', '+918114559168', 'CLC', 'TGMT', 11, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21002291', 'Pari Bahri', 'Nam', to_date('1981-08-10', 'YYYY-MM-DD'), '79/277 Madan Circle Bhubaneswar', '01168198840', 'VP', 'MMT', 19, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21002292', 'Vihaan Bajaj', 'N?', to_date('1994-08-04', 'YYYY-MM-DD'), '149 Lal Chowk Noida', '+918238599423', 'CQ', 'TGMT', 46, 8.34);

INSERT INTO SINHVIEN
VALUES ('SV21002293', 'Dhanuk Sengupta', 'Nam', to_date('2017-09-25', 'YYYY-MM-DD'), '49 Brahmbhatt Nagar Dhule', '+916484708494', 'CTTT', 'CNPM', 39, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21002294', 'Abram Sekhon', 'N?', to_date('1991-11-22', 'YYYY-MM-DD'), 'H.No. 443 Buch Street Hosur', '4526905438', 'VP', 'HTTT', 53, 5.56);

INSERT INTO SINHVIEN
VALUES ('SV21002295', 'Dhanuk Kannan', 'N?', to_date('2015-01-08', 'YYYY-MM-DD'), '00/37 Kibe Zila Thiruvananthapuram', '+913814673987', 'CQ', 'KHMT', 131, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21002296', 'Emir Kadakia', 'N?', to_date('2005-06-05', 'YYYY-MM-DD'), '633 Sharaf Ganj Pimpri-Chinchwad', '+912147295056', 'CLC', 'HTTT', 15, 9.22);

INSERT INTO SINHVIEN
VALUES ('SV21002297', 'Taran Lall', 'N?', to_date('2018-03-06', 'YYYY-MM-DD'), '23/54 Rana Etawah', '+916492926724', 'CLC', 'MMT', 133, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21002298', 'Renee Kala', 'Nam', to_date('2007-04-23', 'YYYY-MM-DD'), '970 Ravi Path Bhagalpur', '00848973747', 'VP', 'TGMT', 115, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21002299', 'Trisha Lal', 'Nam', to_date('2020-02-12', 'YYYY-MM-DD'), '81 Balasubramanian Road Durgapur', '+913771736371', 'CQ', 'MMT', 95, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21002300', 'Lakshit Uppal', 'Nam', to_date('1953-06-06', 'YYYY-MM-DD'), '70/571 Thakkar Circle Rohtak', '+913573677782', 'CQ', 'HTTT', 32, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21002301', 'Saksham Lad', 'N?', to_date('2015-11-22', 'YYYY-MM-DD'), '22 Loyal Road Rourkela', '+918969125989', 'CTTT', 'MMT', 29, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21002302', 'Jiya Sane', 'N?', to_date('1913-05-15', 'YYYY-MM-DD'), '850 Chander Street Aurangabad', '5101519693', 'CLC', 'HTTT', 133, 4.53);

INSERT INTO SINHVIEN
VALUES ('SV21002303', 'Lakshay Bhardwaj', 'N?', to_date('1926-06-27', 'YYYY-MM-DD'), '485 Loyal Marg Mehsana', '+919577631247', 'VP', 'TGMT', 60, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21002304', 'Navya Chad', 'N?', to_date('2003-10-28', 'YYYY-MM-DD'), '366 Dugar Circle Ambarnath', '09905971907', 'CLC', 'MMT', 100, 9.58);

INSERT INTO SINHVIEN
VALUES ('SV21002305', 'Raghav Sane', 'N?', to_date('2009-05-28', 'YYYY-MM-DD'), '43 Kata Zila Ranchi', '1858305292', 'CQ', 'KHMT', 50, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21002306', 'Samarth Bandi', 'N?', to_date('1955-01-06', 'YYYY-MM-DD'), '64/653 Bains Path Aligarh', '+910870378081', 'VP', 'MMT', 82, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21002307', 'Himmat Dhingra', 'N?', to_date('1973-04-22', 'YYYY-MM-DD'), '77/48 De Zila Latur', '8427858178', 'CQ', 'KHMT', 37, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21002308', 'Ela Datta', 'N?', to_date('1944-09-07', 'YYYY-MM-DD'), '00/14 Deo Path Nangloi Jat', '4800239732', 'VP', 'HTTT', 59, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21002309', 'Armaan Sen', 'Nam', to_date('2001-11-01', 'YYYY-MM-DD'), '21 Bhatti Ganj Bangalore', '+916683185735', 'CQ', 'HTTT', 104, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21002310', 'Jhanvi Solanki', 'Nam', to_date('1952-09-18', 'YYYY-MM-DD'), '20 Sawhney Path Asansol', '08527898817', 'CQ', 'MMT', 3, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21002311', 'Zara Guha', 'Nam', to_date('1980-03-07', 'YYYY-MM-DD'), '805 Chadha Zila Machilipatnam', '0182273837', 'CLC', 'MMT', 71, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21002312', 'Tara Raman', 'Nam', to_date('1928-03-26', 'YYYY-MM-DD'), 'H.No. 919 Kalla Amroha', '0827344156', 'CQ', 'CNPM', 59, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21002313', 'Chirag Loke', 'N?', to_date('1955-06-14', 'YYYY-MM-DD'), 'H.No. 83 Lata Kolhapur', '0986930708', 'CLC', 'HTTT', 21, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21002314', 'Raghav Guha', 'N?', to_date('2012-11-21', 'YYYY-MM-DD'), 'H.No. 43 Kara Road Srinagar', '+917933935813', 'VP', 'CNPM', 86, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21002315', 'Uthkarsh Jaggi', 'N?', to_date('2017-09-27', 'YYYY-MM-DD'), '76/363 Bala Road Bhubaneswar', '9092724795', 'VP', 'MMT', 122, 5.17);

INSERT INTO SINHVIEN
VALUES ('SV21002316', 'Amani Mangat', 'N?', to_date('1942-08-27', 'YYYY-MM-DD'), '95/778 Mand Street Faridabad', '04047755456', 'VP', 'TGMT', 93, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21002317', 'Ranbir Rau', 'N?', to_date('2004-07-26', 'YYYY-MM-DD'), 'H.No. 959 Goyal Road Bally', '+918530716397', 'CLC', 'TGMT', 100, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21002318', 'Lavanya Cherian', 'Nam', to_date('1980-01-16', 'YYYY-MM-DD'), 'H.No. 844 Bains Marg Gopalpur', '+918727533395', 'VP', 'KHMT', 28, 7.68);

INSERT INTO SINHVIEN
VALUES ('SV21002319', 'Vivaan Divan', 'Nam', to_date('1979-05-18', 'YYYY-MM-DD'), 'H.No. 62 Dar Street Jalna', '6752241511', 'VP', 'CNTT', 117, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21002320', 'Anaya Taneja', 'Nam', to_date('1940-05-05', 'YYYY-MM-DD'), '70/803 Sama Circle Rajkot', '1000573404', 'CTTT', 'KHMT', 128, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21002321', 'Zain Ram', 'Nam', to_date('2011-10-25', 'YYYY-MM-DD'), 'H.No. 85 Tank Path Bongaigaon', '+919649318549', 'VP', 'TGMT', 38, 6.36);

INSERT INTO SINHVIEN
VALUES ('SV21002322', 'Anahi Chana', 'Nam', to_date('1983-08-01', 'YYYY-MM-DD'), 'H.No. 20 Dua Marg Muzaffarnagar', '08933120967', 'VP', 'CNTT', 10, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21002323', 'Anahi Yohannan', 'N?', to_date('1925-07-02', 'YYYY-MM-DD'), 'H.No. 412 Chandra Road Ahmedabad', '0799119715', 'VP', 'KHMT', 131, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21002324', 'Kimaya Sood', 'Nam', to_date('1960-09-24', 'YYYY-MM-DD'), '48/173 Kunda Nagar Ramagundam', '+917722236450', 'CQ', 'MMT', 82, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21002325', 'Ishaan Tara', 'N?', to_date('2020-01-19', 'YYYY-MM-DD'), '19 Doshi Road Allahabad', '0374531901', 'VP', 'KHMT', 9, 4.96);

INSERT INTO SINHVIEN
VALUES ('SV21002326', 'Inaaya  Thakur', 'Nam', to_date('1939-11-26', 'YYYY-MM-DD'), '381 Anand Ganj Dhanbad', '+912451201776', 'CLC', 'CNTT', 63, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002327', 'Rati Sathe', 'N?', to_date('1963-11-16', 'YYYY-MM-DD'), '46/950 Datta Street Jammu', '02516596292', 'CQ', 'MMT', 46, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21002328', 'Sumer Chaudry', 'N?', to_date('2015-12-25', 'YYYY-MM-DD'), '94/122 Dhawan Zila Orai', '3222467836', 'CLC', 'CNPM', 71, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21002329', 'Priyansh Devi', 'N?', to_date('2006-07-18', 'YYYY-MM-DD'), '70/417 Mammen Nagar Ujjain', '4812374407', 'CLC', 'HTTT', 6, 9.87);

INSERT INTO SINHVIEN
VALUES ('SV21002330', 'Parinaaz Ahluwalia', 'Nam', to_date('1916-03-08', 'YYYY-MM-DD'), '44 Bhatt Path Cuttack', '02996547321', 'CQ', 'HTTT', 27, 6.11);

INSERT INTO SINHVIEN
VALUES ('SV21002331', 'Ira Ravel', 'N?', to_date('2013-09-29', 'YYYY-MM-DD'), '703 Aurora Ahmednagar', '+919004524623', 'CQ', 'CNTT', 65, 5.05);

INSERT INTO SINHVIEN
VALUES ('SV21002332', 'Chirag Magar', 'N?', to_date('1951-10-07', 'YYYY-MM-DD'), '99/473 Sidhu Path Danapur', '5449265261', 'CTTT', 'MMT', 95, 8.71);

INSERT INTO SINHVIEN
VALUES ('SV21002333', 'Vaibhav Swamy', 'Nam', to_date('1962-11-09', 'YYYY-MM-DD'), '676 Dhillon Street Cuttack', '01224759570', 'CQ', 'HTTT', 132, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21002334', 'Ishaan Sachdeva', 'N?', to_date('1918-02-17', 'YYYY-MM-DD'), 'H.No. 847 Rastogi Path Bareilly', '+912357383595', 'CLC', 'HTTT', 11, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21002335', 'Nakul Grewal', 'Nam', to_date('1979-05-07', 'YYYY-MM-DD'), '17/17 Dalal Circle Singrauli', '+916653805565', 'CQ', 'MMT', 110, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21002336', 'Eva Kata', 'Nam', to_date('2011-05-23', 'YYYY-MM-DD'), '730 Dhawan Ganj Guntur', '09454175853', 'VP', 'CNPM', 84, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21002337', 'Vritika Sarkar', 'N?', to_date('1969-07-07', 'YYYY-MM-DD'), '44/926 Wable Chowk Vijayanagaram', '+910082073713', 'VP', 'KHMT', 29, 5.46);

INSERT INTO SINHVIEN
VALUES ('SV21002338', 'Fateh Kanda', 'N?', to_date('1919-01-20', 'YYYY-MM-DD'), '03 Tiwari Zila Bhagalpur', '5994401386', 'CLC', 'HTTT', 77, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21002339', 'Gokul Khosla', 'N?', to_date('2007-02-13', 'YYYY-MM-DD'), '27 Kalita Ganj Orai', '+917200663341', 'CLC', 'CNPM', 58, 9.21);

INSERT INTO SINHVIEN
VALUES ('SV21002340', 'Zain Edwin', 'Nam', to_date('1981-08-02', 'YYYY-MM-DD'), '46/98 Rattan Circle Erode', '7589498839', 'CTTT', 'CNPM', 54, 9.61);

INSERT INTO SINHVIEN
VALUES ('SV21002341', 'Abram Walia', 'N?', to_date('2008-01-03', 'YYYY-MM-DD'), 'H.No. 810 Mall Nagar Noida', '01461807559', 'CTTT', 'MMT', 15, 6.21);

INSERT INTO SINHVIEN
VALUES ('SV21002342', 'Miraan Raj', 'N?', to_date('1990-06-01', 'YYYY-MM-DD'), 'H.No. 088 Kunda Zila Sambhal', '08278254195', 'CQ', 'HTTT', 77, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21002343', 'Zaina Vohra', 'N?', to_date('1962-07-12', 'YYYY-MM-DD'), 'H.No. 44 Johal Road Singrauli', '01186880524', 'CQ', 'KHMT', 65, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21002344', 'Ishita Som', 'N?', to_date('1932-05-28', 'YYYY-MM-DD'), 'H.No. 368 Grewal Street Kamarhati', '1307220366', 'CLC', 'CNPM', 110, 5.32);

INSERT INTO SINHVIEN
VALUES ('SV21002345', 'Vidur Kurian', 'N?', to_date('1910-07-21', 'YYYY-MM-DD'), '63/795 Solanki Marg Bahraich', '02081500238', 'CQ', 'TGMT', 8, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21002346', 'Farhan Venkatesh', 'Nam', to_date('1990-09-08', 'YYYY-MM-DD'), '83 Bava Ganj Karaikudi', '+914671589188', 'CLC', 'KHMT', 43, 4.09);

INSERT INTO SINHVIEN
VALUES ('SV21002347', 'Aarna Kothari', 'N?', to_date('1995-01-12', 'YYYY-MM-DD'), 'H.No. 771 Deo Street Karaikudi', '+913900856643', 'VP', 'CNPM', 126, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21002348', 'Keya Bajwa', 'N?', to_date('1921-06-05', 'YYYY-MM-DD'), 'H.No. 49 Bumb Zila Pali', '2577680812', 'CLC', 'CNTT', 134, 7.2);

INSERT INTO SINHVIEN
VALUES ('SV21002349', 'Drishya Bhatia', 'Nam', to_date('2012-05-23', 'YYYY-MM-DD'), '53 Kala Street Bhopal', '+915203605738', 'VP', 'KHMT', 98, 7.82);

INSERT INTO SINHVIEN
VALUES ('SV21002350', 'Anika Sabharwal', 'N?', to_date('1964-10-25', 'YYYY-MM-DD'), 'H.No. 324 Randhawa Nandyal', '07761573702', 'CTTT', 'CNPM', 57, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21002351', 'Indranil Divan', 'Nam', to_date('1953-02-06', 'YYYY-MM-DD'), '19/941 Venkatesh Bhilwara', '08693500802', 'CQ', 'HTTT', 28, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21002352', 'Shlok Kulkarni', 'N?', to_date('1988-05-07', 'YYYY-MM-DD'), 'H.No. 902 Sekhon Marg Faridabad', '+917317784600', 'CQ', 'HTTT', 112, 9.17);

INSERT INTO SINHVIEN
VALUES ('SV21002353', 'Indrans Kalla', 'N?', to_date('1953-02-28', 'YYYY-MM-DD'), 'H.No. 55 Sunder Zila Satna', '+919382664285', 'CQ', 'TGMT', 48, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21002354', 'Farhan Dey', 'N?', to_date('2020-10-16', 'YYYY-MM-DD'), 'H.No. 194 Gupta Ganj Nandyal', '2830716385', 'CTTT', 'CNTT', 62, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21002355', 'Hansh Yogi', 'Nam', to_date('1944-04-23', 'YYYY-MM-DD'), '46/859 Khurana Street Alappuzha', '00868929032', 'CQ', 'TGMT', 45, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21002356', 'Anay Seshadri', 'Nam', to_date('1919-02-23', 'YYYY-MM-DD'), 'H.No. 145 Mannan Circle Junagadh', '8843111461', 'CTTT', 'HTTT', 5, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21002357', 'Ivan Basu', 'N?', to_date('1965-05-24', 'YYYY-MM-DD'), 'H.No. 533 Sankar Kirari Suleman Nagar', '+913208294699', 'CTTT', 'HTTT', 127, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21002358', 'Tushar Ratta', 'N?', to_date('1949-08-26', 'YYYY-MM-DD'), 'H.No. 93 Vyas Sonipat', '03793541340', 'VP', 'KHMT', 0, 8.48);

INSERT INTO SINHVIEN
VALUES ('SV21002359', 'Anaya Borde', 'N?', to_date('1997-05-05', 'YYYY-MM-DD'), '59/358 Kothari Zila Aizawl', '1924028817', 'CTTT', 'KHMT', 122, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21002360', 'Kanav Deep', 'Nam', to_date('1971-11-15', 'YYYY-MM-DD'), '277 Viswanathan Patna', '03778703244', 'CTTT', 'CNTT', 23, 4.33);

INSERT INTO SINHVIEN
VALUES ('SV21002361', 'Sumer Tandon', 'Nam', to_date('2011-10-11', 'YYYY-MM-DD'), '036 Rajagopalan Ganj Alwar', '7523161307', 'CLC', 'TGMT', 92, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21002362', 'Vivaan Lad', 'N?', to_date('1967-10-13', 'YYYY-MM-DD'), '83/29 Randhawa Ganj Pondicherry', '00049783982', 'CLC', 'CNPM', 84, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21002363', 'Armaan Venkataraman', 'N?', to_date('1992-12-21', 'YYYY-MM-DD'), 'H.No. 28 Ray Road Amravati', '8248916540', 'CTTT', 'CNPM', 55, 6.48);

INSERT INTO SINHVIEN
VALUES ('SV21002364', 'Tiya Bakshi', 'Nam', to_date('1982-12-17', 'YYYY-MM-DD'), '25/069 Chaudhary Marg Karimnagar', '3428874342', 'CQ', 'CNPM', 101, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21002365', 'Farhan Bassi', 'N?', to_date('2017-12-16', 'YYYY-MM-DD'), 'H.No. 455 Ghose Path Madurai', '8657419562', 'CQ', 'MMT', 122, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21002366', 'Jiya Gola', 'Nam', to_date('1924-01-05', 'YYYY-MM-DD'), '37/48 Sabharwal Ganj Jodhpur', '08117429735', 'CTTT', 'TGMT', 90, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21002367', 'Romil Vora', 'Nam', to_date('2007-08-16', 'YYYY-MM-DD'), '14/00 Jain Zila Aizawl', '05035915050', 'CQ', 'CNPM', 73, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21002368', 'Faiyaz Chana', 'N?', to_date('2023-05-16', 'YYYY-MM-DD'), 'H.No. 58 Dar Ganj Aligarh', '+919995209330', 'CQ', 'CNTT', 15, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21002369', 'Zeeshan Cherian', 'N?', to_date('1979-12-23', 'YYYY-MM-DD'), '26/65 Sami Street Maheshtala', '+917524473747', 'CTTT', 'MMT', 132, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002370', 'Samar Ranganathan', 'Nam', to_date('1936-08-19', 'YYYY-MM-DD'), '009 Ramachandran Chowk Gandhinagar', '04641884035', 'CQ', 'CNPM', 19, 7.74);

INSERT INTO SINHVIEN
VALUES ('SV21002371', 'Indrajit Ganguly', 'Nam', to_date('1975-11-28', 'YYYY-MM-DD'), '65 Bhandari Path Hapur', '+916614993627', 'CTTT', 'TGMT', 3, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21002372', 'Hazel Brar', 'N?', to_date('1995-07-29', 'YYYY-MM-DD'), '33/908 Swaminathan Nagar Jehanabad', '+917514186189', 'CLC', 'CNPM', 33, 4.45);

INSERT INTO SINHVIEN
VALUES ('SV21002373', 'Seher Kata', 'N?', to_date('1996-03-18', 'YYYY-MM-DD'), '822 Chacko Road Bardhaman', '6422383052', 'VP', 'MMT', 70, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21002374', 'Lagan Rau', 'Nam', to_date('2023-09-03', 'YYYY-MM-DD'), '34/149 Chanda Chowk Belgaum', '+915841681136', 'CQ', 'CNPM', 36, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21002375', 'Azad Korpal', 'Nam', to_date('1952-01-30', 'YYYY-MM-DD'), '45/490 Kala Circle Raipur', '1065281592', 'CLC', 'CNPM', 15, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21002376', 'Fateh Sathe', 'N?', to_date('2010-09-26', 'YYYY-MM-DD'), '92/769 Shankar Street Aizawl', '+918486572473', 'CLC', 'MMT', 137, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21002377', 'Rania Agarwal', 'N?', to_date('2020-08-17', 'YYYY-MM-DD'), 'H.No. 10 Vaidya Road Unnao', '06395358814', 'VP', 'CNPM', 70, 8.48);

INSERT INTO SINHVIEN
VALUES ('SV21002378', 'Ira Raja', 'Nam', to_date('1991-01-31', 'YYYY-MM-DD'), 'H.No. 88 Mannan Bhind', '09395848212', 'CTTT', 'CNPM', 105, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21002379', 'Dhanuk Chandra', 'Nam', to_date('1989-04-13', 'YYYY-MM-DD'), 'H.No. 84 Ranganathan Chowk Ozhukarai', '02608729393', 'CLC', 'MMT', 24, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21002380', 'Shalv Chaudhary', 'N?', to_date('2000-03-13', 'YYYY-MM-DD'), '97/05 Jani Malda', '02632556595', 'VP', 'TGMT', 137, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21002381', 'Taimur Dash', 'Nam', to_date('2019-02-11', 'YYYY-MM-DD'), 'H.No. 193 Rege Chowk Gandhidham', '8453434037', 'CTTT', 'TGMT', 89, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21002382', 'Riaan Ramaswamy', 'N?', to_date('1947-12-08', 'YYYY-MM-DD'), '188 Barad Tirunelveli', '2126194652', 'VP', 'HTTT', 122, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21002383', 'Elakshi Barad', 'N?', to_date('1944-06-03', 'YYYY-MM-DD'), '33 Sura Path Noida', '04406524247', 'CQ', 'CNPM', 87, 7.31);

INSERT INTO SINHVIEN
VALUES ('SV21002384', 'Piya Ramakrishnan', 'Nam', to_date('1988-10-27', 'YYYY-MM-DD'), '70 Varma Nagar Alwar', '5087874879', 'CTTT', 'KHMT', 92, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21002385', 'Amira Saraf', 'Nam', to_date('1941-02-20', 'YYYY-MM-DD'), '886 Chhabra Chowk Katni', '+915597695442', 'CQ', 'HTTT', 86, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21002386', 'Himmat Chanda', 'N?', to_date('2020-06-04', 'YYYY-MM-DD'), 'H.No. 30 Khosla Path Gwalior', '0882461506', 'VP', 'CNPM', 44, 4.53);

INSERT INTO SINHVIEN
VALUES ('SV21002387', 'Heer Mallick', 'Nam', to_date('2021-04-18', 'YYYY-MM-DD'), 'H.No. 007 Hari Circle Sonipat', '02959585837', 'CTTT', 'HTTT', 46, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21002388', 'Madhup Bhatia', 'N?', to_date('1978-10-28', 'YYYY-MM-DD'), '66/540 Tailor Circle Deoghar', '+912190715117', 'CTTT', 'KHMT', 5, 8.92);

INSERT INTO SINHVIEN
VALUES ('SV21002389', 'Armaan Warrior', 'Nam', to_date('1920-02-05', 'YYYY-MM-DD'), '85/67 Doctor Chowk Bhimavaram', '1625057116', 'CQ', 'CNPM', 95, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21002390', 'Manikya Bail', 'N?', to_date('1955-11-18', 'YYYY-MM-DD'), '45/626 Varkey Zila Kurnool', '+911741840475', 'CTTT', 'CNPM', 115, 6.58);

INSERT INTO SINHVIEN
VALUES ('SV21002391', 'Saksham Chandra', 'Nam', to_date('1939-05-10', 'YYYY-MM-DD'), 'H.No. 33 Ganesh Circle Naihati', '+918060871011', 'CTTT', 'TGMT', 136, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21002392', 'Jayesh Bala', 'Nam', to_date('1975-10-14', 'YYYY-MM-DD'), '20/99 Venkataraman Path Thrissur', '+913695399857', 'VP', 'CNTT', 46, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21002393', 'Dhanush Chaudry', 'N?', to_date('1927-12-31', 'YYYY-MM-DD'), '96 Krishnan Zila Nagercoil', '2249418415', 'CTTT', 'CNPM', 39, 8.28);

INSERT INTO SINHVIEN
VALUES ('SV21002394', 'Suhana Lad', 'N?', to_date('1931-05-08', 'YYYY-MM-DD'), 'H.No. 87 Sandal Marg Begusarai', '+911700384546', 'CTTT', 'TGMT', 21, 6.91);

INSERT INTO SINHVIEN
VALUES ('SV21002395', 'Yashvi Hegde', 'Nam', to_date('2010-05-11', 'YYYY-MM-DD'), 'H.No. 13 Lal Marg New Delhi', '06335729846', 'VP', 'TGMT', 68, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21002396', 'Tanya Majumdar', 'N?', to_date('1945-01-06', 'YYYY-MM-DD'), '718 Kalla Road Warangal', '+913754096392', 'CQ', 'CNPM', 17, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21002397', 'Mannat Malhotra', 'Nam', to_date('2008-02-29', 'YYYY-MM-DD'), '480 Chhabra Katni', '4648005682', 'VP', 'TGMT', 22, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21002398', 'Yashvi Sha', 'N?', to_date('1919-03-15', 'YYYY-MM-DD'), '762 Gaba Zila Khora ', '06668933805', 'VP', 'MMT', 135, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21002399', 'Inaaya  Lanka', 'Nam', to_date('1999-03-06', 'YYYY-MM-DD'), 'H.No. 437 Guha Chowk Eluru', '3984391040', 'CLC', 'KHMT', 57, 7.45);

INSERT INTO SINHVIEN
VALUES ('SV21002400', 'Aarav Ram', 'Nam', to_date('1941-11-12', 'YYYY-MM-DD'), '69 Mall Path Srikakulam', '04840936041', 'CTTT', 'KHMT', 131, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21002401', 'Pranay Balasubramanian', 'Nam', to_date('1982-08-24', 'YYYY-MM-DD'), '63/75 Majumdar Kharagpur', '02427851255', 'CQ', 'CNPM', 66, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21002402', 'Rohan Karan', 'N?', to_date('1976-04-01', 'YYYY-MM-DD'), '99 Ghose Nagar Gudivada', '8533757953', 'VP', 'HTTT', 20, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21002403', 'Yasmin Varkey', 'N?', to_date('1911-05-03', 'YYYY-MM-DD'), '26 Contractor Nagar Khora ', '+919507593219', 'VP', 'TGMT', 23, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21002404', 'Gokul Bawa', 'Nam', to_date('1955-08-13', 'YYYY-MM-DD'), 'H.No. 61 Shetty Road Solapur', '+911388871160', 'CTTT', 'HTTT', 2, 5.84);

INSERT INTO SINHVIEN
VALUES ('SV21002405', 'Ehsaan Srinivas', 'N?', to_date('2010-05-13', 'YYYY-MM-DD'), 'H.No. 524 Sastry Street Katni', '3648089163', 'VP', 'CNPM', 17, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21002406', 'Kismat Arya', 'Nam', to_date('1984-12-29', 'YYYY-MM-DD'), '272 Mangal Zila Guna', '+917756155080', 'CLC', 'MMT', 22, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21002407', 'Shayak Chacko', 'N?', to_date('1981-01-13', 'YYYY-MM-DD'), 'H.No. 929 Atwal Nagar Muzaffarpur', '9933791284', 'CQ', 'HTTT', 11, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21002408', 'Jayan Bandi', 'Nam', to_date('1973-09-30', 'YYYY-MM-DD'), 'H.No. 264 Mander Street Bhiwani', '05367878542', 'CLC', 'HTTT', 102, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21002409', 'Jivika Issac', 'Nam', to_date('1978-11-30', 'YYYY-MM-DD'), '84/425 Chandra Gaya', '00063094284', 'CLC', 'KHMT', 86, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21002410', 'Mishti Sant', 'Nam', to_date('2022-05-25', 'YYYY-MM-DD'), '18/424 Barman Chowk Mysore', '1151649779', 'CTTT', 'MMT', 91, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21002411', 'Miraan Doctor', 'Nam', to_date('1956-04-21', 'YYYY-MM-DD'), 'H.No. 06 Bhatt Solapur', '04270379214', 'CLC', 'CNPM', 72, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21002412', 'Nakul Kari', 'N?', to_date('1939-10-27', 'YYYY-MM-DD'), 'H.No. 36 Vyas Zila Bahraich', '+916650317489', 'CLC', 'TGMT', 136, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21002413', 'Ahana  Grover', 'Nam', to_date('1928-08-02', 'YYYY-MM-DD'), '80/695 Chana Street Kishanganj', '09977015582', 'CTTT', 'MMT', 9, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21002414', 'Lakshit Venkataraman', 'N?', to_date('1961-10-12', 'YYYY-MM-DD'), '42/378 Krish Marg Dehradun', '9579396165', 'CLC', 'CNTT', 127, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21002415', 'Anvi Ram', 'Nam', to_date('1932-11-21', 'YYYY-MM-DD'), 'H.No. 49 Shenoy Nagar Thiruvananthapuram', '0919654736', 'CTTT', 'HTTT', 111, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21002416', 'Shayak Behl', 'Nam', to_date('2013-07-02', 'YYYY-MM-DD'), '71 Aurora Circle Tezpur', '03288283187', 'CTTT', 'KHMT', 135, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21002417', 'Lakshit Choudhury', 'N?', to_date('1948-02-28', 'YYYY-MM-DD'), '29/034 Krishnamurthy Satna', '7292388414', 'CTTT', 'KHMT', 63, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21002418', 'Ivana Gokhale', 'N?', to_date('2012-01-22', 'YYYY-MM-DD'), 'H.No. 68 Bava Kozhikode', '2367967017', 'CLC', 'MMT', 48, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21002419', 'Lakshay Banerjee', 'Nam', to_date('2015-08-14', 'YYYY-MM-DD'), '993 Sule Path Hospet', '7157818228', 'VP', 'CNPM', 99, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21002420', 'Hunar Bera', 'N?', to_date('1954-12-09', 'YYYY-MM-DD'), 'H.No. 17 Kade Nagar Srikakulam', '03223383604', 'VP', 'CNPM', 82, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21002421', 'Piya Sekhon', 'Nam', to_date('1958-08-29', 'YYYY-MM-DD'), '20/27 Chand Marg Jamalpur', '+913212011802', 'CQ', 'CNPM', 11, 5.45);

INSERT INTO SINHVIEN
VALUES ('SV21002422', 'Manikya Karan', 'Nam', to_date('1949-03-04', 'YYYY-MM-DD'), '15/704 Sachdev Chowk Bidhannagar', '07403155173', 'CTTT', 'KHMT', 43, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21002423', 'Eva Mandal', 'N?', to_date('2012-05-23', 'YYYY-MM-DD'), '78/27 Chowdhury Road Bahraich', '+916919091162', 'CTTT', 'KHMT', 68, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21002424', 'Misha Bose', 'Nam', to_date('1958-01-26', 'YYYY-MM-DD'), '00 Sarkar Road Singrauli', '08803401283', 'VP', 'TGMT', 23, 9.21);

INSERT INTO SINHVIEN
VALUES ('SV21002425', 'Saira Kade', 'N?', to_date('1959-04-20', 'YYYY-MM-DD'), '59 Devi Street Chittoor', '2613333941', 'CLC', 'TGMT', 41, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21002426', 'Divit Gokhale', 'N?', to_date('1987-06-29', 'YYYY-MM-DD'), 'H.No. 744 Korpal Ganj Chinsurah', '7275926533', 'VP', 'CNPM', 11, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21002427', 'Prisha Issac', 'N?', to_date('1999-11-17', 'YYYY-MM-DD'), 'H.No. 83 Manda Ganj Mumbai', '04748154123', 'CTTT', 'CNTT', 109, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21002428', 'Ritvik Issac', 'N?', to_date('2014-11-12', 'YYYY-MM-DD'), '15 Borde Marg Muzaffarnagar', '+914982453556', 'CLC', 'TGMT', 33, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21002429', 'Anahi Kalita', 'N?', to_date('2011-07-17', 'YYYY-MM-DD'), 'H.No. 772 Mander Chowk Firozabad', '+912152381727', 'CQ', 'CNTT', 27, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21002430', 'Ehsaan Sarkar', 'Nam', to_date('1987-11-07', 'YYYY-MM-DD'), '75 Shukla Chowk Guntur', '+912720472496', 'CTTT', 'CNTT', 110, 4.52);

INSERT INTO SINHVIEN
VALUES ('SV21002431', 'Farhan Comar', 'Nam', to_date('1977-11-16', 'YYYY-MM-DD'), '642 Swamy Ganj Bokaro', '04660804362', 'CLC', 'CNPM', 58, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21002432', 'Yuvraj  Kant', 'Nam', to_date('1929-03-30', 'YYYY-MM-DD'), 'H.No. 95 Warrior Road Vijayanagaram', '07881109831', 'VP', 'KHMT', 77, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21002433', 'Alia Srivastava', 'N?', to_date('1921-09-03', 'YYYY-MM-DD'), 'H.No. 649 Kapoor Road Nagercoil', '07880145088', 'VP', 'MMT', 84, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21002434', 'Hazel Saha', 'N?', to_date('1918-09-21', 'YYYY-MM-DD'), '192 Barman Nagar Gandhidham', '2943966180', 'VP', 'MMT', 53, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21002435', 'Tushar Mammen', 'N?', to_date('1981-01-07', 'YYYY-MM-DD'), 'H.No. 752 Borra Circle Rajpur Sonarpur', '0586469810', 'CTTT', 'MMT', 1, 7.68);

INSERT INTO SINHVIEN
VALUES ('SV21002436', 'Seher Kar', 'N?', to_date('1993-08-14', 'YYYY-MM-DD'), 'H.No. 038 Sundaram Road Ambarnath', '08832768939', 'CLC', 'TGMT', 2, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21002437', 'Hrishita Venkatesh', 'Nam', to_date('2013-03-21', 'YYYY-MM-DD'), 'H.No. 722 Kaur Ganj Dewas', '09413862211', 'CQ', 'CNPM', 7, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21002438', 'Pari Basu', 'Nam', to_date('1988-07-08', 'YYYY-MM-DD'), 'H.No. 995 Sandal Street Amritsar', '03358001589', 'CLC', 'KHMT', 105, 4.46);

INSERT INTO SINHVIEN
VALUES ('SV21002439', 'Nehmat Amble', 'Nam', to_date('1963-10-08', 'YYYY-MM-DD'), 'H.No. 07 Amble Gwalior', '+917635422357', 'CQ', 'CNPM', 134, 5.88);

INSERT INTO SINHVIEN
VALUES ('SV21002440', 'Tanya Agarwal', 'N?', to_date('1955-12-23', 'YYYY-MM-DD'), '60 Sami Marg Fatehpur', '06170725138', 'VP', 'KHMT', 13, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21002441', 'Aradhya Batra', 'Nam', to_date('1946-01-19', 'YYYY-MM-DD'), '44/61 Mani Nagar Thrissur', '+917921459097', 'CLC', 'CNPM', 53, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21002442', 'Dharmajan Rajan', 'Nam', to_date('1958-10-25', 'YYYY-MM-DD'), 'H.No. 86 Ghose Chowk Hospet', '+917581803570', 'CLC', 'TGMT', 36, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21002443', 'Fateh Rattan', 'Nam', to_date('1936-08-30', 'YYYY-MM-DD'), '116 Verma Road Panchkula', '8095312737', 'CTTT', 'MMT', 133, 6.56);

INSERT INTO SINHVIEN
VALUES ('SV21002444', 'Miraya Balan', 'N?', to_date('1928-10-01', 'YYYY-MM-DD'), '495 Som Road Panihati', '+918227909743', 'CQ', 'CNTT', 43, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21002445', 'Baiju Dhar', 'Nam', to_date('1994-01-05', 'YYYY-MM-DD'), '01/75 Chatterjee Street Berhampur', '9070492264', 'VP', 'CNPM', 67, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21002446', 'Tarini Sibal', 'N?', to_date('1943-03-19', 'YYYY-MM-DD'), 'H.No. 02 Keer Zila Firozabad', '+910000721781', 'CTTT', 'KHMT', 118, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21002447', 'Dhruv Sekhon', 'N?', to_date('1957-01-31', 'YYYY-MM-DD'), '529 Bose Circle Aurangabad', '0015569686', 'CLC', 'TGMT', 58, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21002448', 'Siya Bhagat', 'Nam', to_date('1952-10-27', 'YYYY-MM-DD'), 'H.No. 032 Dalal Street Avadi', '03134445440', 'CLC', 'CNTT', 105, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21002449', 'Farhan Dewan', 'Nam', to_date('1917-01-16', 'YYYY-MM-DD'), '20 Chahal Marg Saharsa', '03508583640', 'VP', 'CNPM', 19, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21002450', 'Pari Bhagat', 'N?', to_date('1978-04-15', 'YYYY-MM-DD'), 'H.No. 409 Sama Zila Bhatpara', '06234329235', 'CTTT', 'KHMT', 76, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21002451', 'Kanav Arora', 'Nam', to_date('1995-01-01', 'YYYY-MM-DD'), '550 Dey Circle Secunderabad', '09265921653', 'CLC', 'CNPM', 104, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21002452', 'Eva Gola', 'N?', to_date('1987-09-15', 'YYYY-MM-DD'), 'H.No. 07 Vasa Road Bhiwani', '0201093214', 'CLC', 'HTTT', 73, 9.46);

INSERT INTO SINHVIEN
VALUES ('SV21002453', 'Amira Sule', 'Nam', to_date('1960-07-31', 'YYYY-MM-DD'), 'H.No. 79 Contractor Nagar Visakhapatnam', '+912266505821', 'VP', 'TGMT', 9, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21002454', 'Anya Shukla', 'N?', to_date('1976-12-22', 'YYYY-MM-DD'), '05/005 Kant Street Akola', '06103884591', 'CLC', 'CNTT', 113, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21002455', 'Alisha Mand', 'N?', to_date('1924-09-02', 'YYYY-MM-DD'), '02/21 Chana Path Raebareli', '08970687581', 'CTTT', 'CNTT', 133, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21002456', 'Indrajit Shanker', 'N?', to_date('1965-05-25', 'YYYY-MM-DD'), '067 Seth Nagar Bareilly', '+917897353244', 'CTTT', 'MMT', 107, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21002457', 'Vihaan Dewan', 'N?', to_date('1952-09-19', 'YYYY-MM-DD'), '73/257 Salvi Road Chittoor', '09676911620', 'CTTT', 'CNTT', 137, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21002458', 'Anya Gour', 'Nam', to_date('1963-07-01', 'YYYY-MM-DD'), 'H.No. 769 Upadhyay Circle Pondicherry', '02343058414', 'CTTT', 'CNPM', 114, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21002459', 'Taimur Balakrishnan', 'N?', to_date('1964-04-13', 'YYYY-MM-DD'), '62/170 Trivedi Street Gandhinagar', '07294515159', 'CLC', 'KHMT', 93, 9.69);

INSERT INTO SINHVIEN
VALUES ('SV21002460', 'Abram Dara', 'Nam', to_date('1942-01-24', 'YYYY-MM-DD'), 'H.No. 17 Ghosh Ganj Katni', '+916170105353', 'CTTT', 'KHMT', 1, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002461', 'Drishya Chauhan', 'N?', to_date('2017-09-12', 'YYYY-MM-DD'), '14 Bhattacharyya Chowk Buxar', '1593432607', 'VP', 'MMT', 80, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21002462', 'Umang Kannan', 'N?', to_date('1937-12-25', 'YYYY-MM-DD'), '51/130 Anand Marg Nagaon', '07373052170', 'CLC', 'MMT', 55, 8.22);

INSERT INTO SINHVIEN
VALUES ('SV21002463', 'Advika Shukla', 'Nam', to_date('1912-08-19', 'YYYY-MM-DD'), '58 Chakrabarti Zila Bathinda', '+910168126091', 'VP', 'TGMT', 74, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21002464', 'Samarth Bala', 'N?', to_date('1949-05-21', 'YYYY-MM-DD'), '20 Keer Nagar Burhanpur', '4305103278', 'CQ', 'CNTT', 125, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21002465', 'Yashvi Vasa', 'Nam', to_date('1953-10-09', 'YYYY-MM-DD'), '94/86 Sant Ganj Ambarnath', '05814814009', 'CTTT', 'CNTT', 13, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21002466', 'Rania Chanda', 'N?', to_date('1966-12-27', 'YYYY-MM-DD'), 'H.No. 34 Deep Circle Jaunpur', '3426752726', 'CLC', 'CNPM', 100, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21002467', 'Amira Dutta', 'Nam', to_date('1997-10-22', 'YYYY-MM-DD'), 'H.No. 91 Trivedi Road Kozhikode', '02055327501', 'CTTT', 'TGMT', 123, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21002468', 'Vihaan Singh', 'N?', to_date('1993-04-21', 'YYYY-MM-DD'), '020 Barad Street Anantapuram', '8856979920', 'CTTT', 'CNPM', 129, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21002469', 'Dhruv Date', 'Nam', to_date('2014-06-25', 'YYYY-MM-DD'), '77/140 Shetty Street Ozhukarai', '06770159877', 'VP', 'KHMT', 3, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21002470', 'Raunak Srinivas', 'Nam', to_date('1911-04-01', 'YYYY-MM-DD'), '98/938 Srinivasan Zila Bhusawal', '+916599642015', 'VP', 'MMT', 120, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21002471', 'Aayush Ghosh', 'Nam', to_date('1946-01-30', 'YYYY-MM-DD'), '76 Dave Ganj Baranagar', '00135024200', 'CLC', 'HTTT', 66, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21002472', 'Rhea Sarraf', 'N?', to_date('1957-04-02', 'YYYY-MM-DD'), 'H.No. 105 Dhaliwal Chowk Ozhukarai', '01286805179', 'CQ', 'HTTT', 47, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21002473', 'Amani Kapur', 'Nam', to_date('1960-04-24', 'YYYY-MM-DD'), '48/00 Kala Zila Chandrapur', '09101009422', 'CLC', 'HTTT', 87, 5.55);

INSERT INTO SINHVIEN
VALUES ('SV21002474', 'Anaya Tella', 'Nam', to_date('1949-07-14', 'YYYY-MM-DD'), '28 Swamy Chowk Dehri', '1155197363', 'CLC', 'MMT', 53, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21002475', 'Kanav Mangal', 'N?', to_date('1996-02-22', 'YYYY-MM-DD'), '84/63 Krish Street Rajkot', '4214873510', 'CQ', 'CNTT', 0, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21002476', 'Yasmin Dyal', 'N?', to_date('2005-03-07', 'YYYY-MM-DD'), '57 Dugal Path Nellore', '+915013372550', 'CTTT', 'MMT', 53, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21002477', 'Sana Sheth', 'Nam', to_date('1930-07-09', 'YYYY-MM-DD'), '62 Jaggi Dibrugarh', '00176464660', 'CTTT', 'MMT', 51, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21002478', 'Ranbir Thaker', 'N?', to_date('1913-09-17', 'YYYY-MM-DD'), '32/11 Sandhu Marg Bellary', '01923600948', 'CTTT', 'TGMT', 22, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21002479', 'Hansh Kulkarni', 'Nam', to_date('1936-10-24', 'YYYY-MM-DD'), '98/944 Som Street Jaunpur', '02453744343', 'CQ', 'MMT', 87, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21002480', 'Kartik Brar', 'N?', to_date('2007-09-15', 'YYYY-MM-DD'), '23 Tara Street Meerut', '+917787701235', 'CLC', 'HTTT', 70, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21002481', 'Tanya Setty', 'N?', to_date('1922-08-26', 'YYYY-MM-DD'), '03 Chahal Road Shimoga', '03571954350', 'CQ', 'KHMT', 23, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21002482', 'Keya Anand', 'N?', to_date('2004-01-04', 'YYYY-MM-DD'), 'H.No. 777 Venkataraman South Dumdum', '+913452213242', 'CQ', 'HTTT', 2, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21002483', 'Himmat Roy', 'N?', to_date('1928-04-06', 'YYYY-MM-DD'), 'H.No. 08 D��Alia Marg Kochi', '05039991793', 'VP', 'TGMT', 37, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002484', 'Umang Sibal', 'N?', to_date('1989-09-05', 'YYYY-MM-DD'), '82 Shenoy Nagar Ambala', '5882316605', 'VP', 'CNTT', 117, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21002485', 'Vritika Upadhyay', 'N?', to_date('1984-04-20', 'YYYY-MM-DD'), '52/186 Sandal Circle Burhanpur', '08037431404', 'CQ', 'MMT', 3, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21002486', 'Hazel Suri', 'N?', to_date('1910-04-16', 'YYYY-MM-DD'), 'H.No. 43 Bhavsar Chowk Jaunpur', '+919047448819', 'VP', 'TGMT', 26, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21002487', 'Dhanuk Varghese', 'N?', to_date('1988-01-06', 'YYYY-MM-DD'), 'H.No. 265 Mall Ghaziabad', '8112603061', 'CTTT', 'TGMT', 55, 5.02);

INSERT INTO SINHVIEN
VALUES ('SV21002488', 'Indrajit Arya', 'Nam', to_date('1972-08-29', 'YYYY-MM-DD'), '03/857 Bali Circle Karnal', '06649904142', 'VP', 'HTTT', 55, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21002489', 'Anahita Subramanian', 'N?', to_date('2024-01-10', 'YYYY-MM-DD'), 'H.No. 53 Sura Nagar Tumkur', '+911475470489', 'CLC', 'HTTT', 40, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21002490', 'Oorja Comar', 'Nam', to_date('1940-03-30', 'YYYY-MM-DD'), '23 Khalsa Marg Gurgaon', '02368391155', 'CTTT', 'CNPM', 78, 7.66);

INSERT INTO SINHVIEN
VALUES ('SV21002491', 'Arhaan Johal', 'N?', to_date('1969-11-26', 'YYYY-MM-DD'), 'H.No. 618 Sani Circle Warangal', '6787240946', 'VP', 'MMT', 90, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21002492', 'Inaaya  Sanghvi', 'N?', to_date('2007-06-09', 'YYYY-MM-DD'), 'H.No. 488 Borah Path Rewa', '0267506821', 'CTTT', 'HTTT', 129, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21002493', 'Divij Sane', 'Nam', to_date('1986-10-29', 'YYYY-MM-DD'), '59/80 Bali Street Maheshtala', '07915878770', 'CTTT', 'TGMT', 113, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002494', 'Tanya Kurian', 'Nam', to_date('2014-09-05', 'YYYY-MM-DD'), '757 Sama Road Hazaribagh', '+917471951237', 'CQ', 'MMT', 106, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21002495', 'Siya Loyal', 'N?', to_date('1985-01-17', 'YYYY-MM-DD'), '16 Dass Chowk Rajahmundry', '+910280096700', 'CTTT', 'HTTT', 60, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21002496', 'Nitara Dalal', 'N?', to_date('1946-06-23', 'YYYY-MM-DD'), '22 Raja Nagar Motihari', '7791003216', 'CTTT', 'HTTT', 31, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21002497', 'Mehul Bhatti', 'N?', to_date('1934-06-26', 'YYYY-MM-DD'), 'H.No. 43 Goswami Ganj Proddatur', '4429466306', 'CTTT', 'MMT', 88, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21002498', 'Aarna Dora', 'N?', to_date('1962-07-15', 'YYYY-MM-DD'), '21/615 Sagar Ganj Kolhapur', '1865294683', 'CLC', 'HTTT', 30, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21002499', 'Misha Sharaf', 'Nam', to_date('1908-11-02', 'YYYY-MM-DD'), '84/546 Chaudhry Circle Kota', '+914847028907', 'CLC', 'TGMT', 76, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002500', 'Saira Swamy', 'N?', to_date('2011-09-10', 'YYYY-MM-DD'), '263 Khalsa Zila Bidar', '00149120226', 'CQ', 'CNTT', 47, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21002501', 'Divyansh Krish', 'N?', to_date('1945-03-18', 'YYYY-MM-DD'), 'H.No. 726 Bava Path Delhi', '08755768705', 'CLC', 'CNTT', 35, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21002502', 'Jiya Dugar', 'Nam', to_date('2005-06-10', 'YYYY-MM-DD'), '44 Sastry Ganj Kochi', '+919084411990', 'CLC', 'TGMT', 73, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21002503', 'Alisha Hayer', 'N?', to_date('2006-03-06', 'YYYY-MM-DD'), '705 Gade Zila Bhimavaram', '09484879653', 'VP', 'HTTT', 69, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21002504', 'Oorja Deol', 'Nam', to_date('1997-06-30', 'YYYY-MM-DD'), '61/378 Ramachandran Street Kolhapur', '3828715167', 'VP', 'MMT', 12, 9.61);

INSERT INTO SINHVIEN
VALUES ('SV21002505', 'Tarini Goda', 'N?', to_date('2021-04-19', 'YYYY-MM-DD'), 'H.No. 691 Goel Ganj Bhiwandi', '09218119053', 'VP', 'CNTT', 31, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21002506', 'Bhamini Vohra', 'N?', to_date('1998-09-17', 'YYYY-MM-DD'), 'H.No. 243 Dube Nagar Solapur', '0321476959', 'CLC', 'CNPM', 89, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002507', 'Tejas Barad', 'N?', to_date('1938-11-16', 'YYYY-MM-DD'), 'H.No. 30 Sura Chowk Vasai-Virar', '+911234330732', 'VP', 'CNTT', 56, 9.28);

INSERT INTO SINHVIEN
VALUES ('SV21002508', 'Onkar Zacharia', 'Nam', to_date('1944-11-06', 'YYYY-MM-DD'), '96 Talwar Ganj Begusarai', '1900990252', 'CTTT', 'CNPM', 84, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21002509', 'Raunak Hayre', 'Nam', to_date('1962-02-23', 'YYYY-MM-DD'), 'H.No. 41 Khurana Kadapa', '03103850326', 'CTTT', 'TGMT', 52, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21002510', 'Kashvi Shukla', 'Nam', to_date('1958-07-22', 'YYYY-MM-DD'), '73/49 Mander Marg Morbi', '3566519714', 'CQ', 'HTTT', 106, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21002511', 'Akarsh Bains', 'N?', to_date('1948-03-12', 'YYYY-MM-DD'), 'H.No. 04 Kaul Nagar South Dumdum', '7547340615', 'CTTT', 'KHMT', 40, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21002512', 'Uthkarsh Ganesh', 'Nam', to_date('1986-12-17', 'YYYY-MM-DD'), '56 Koshy Street Berhampur', '+911662362111', 'CQ', 'HTTT', 41, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21002513', 'Kimaya Edwin', 'Nam', to_date('1968-02-02', 'YYYY-MM-DD'), '52 Chadha Marg Jabalpur', '00312230523', 'CLC', 'CNPM', 79, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21002514', 'Rhea Dhar', 'Nam', to_date('1987-11-14', 'YYYY-MM-DD'), '857 Ganguly Ganj Faridabad', '2584522830', 'VP', 'CNTT', 99, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21002515', 'Lagan Sami', 'Nam', to_date('1960-03-29', 'YYYY-MM-DD'), '33/430 Keer Kulti', '+918189358666', 'CLC', 'KHMT', 83, 6.85);

INSERT INTO SINHVIEN
VALUES ('SV21002516', 'Samarth Basak', 'N?', to_date('1988-01-12', 'YYYY-MM-DD'), '113 Chahal Ongole', '04081916341', 'VP', 'HTTT', 128, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21002517', 'Stuvan Bawa', 'Nam', to_date('1969-01-13', 'YYYY-MM-DD'), 'H.No. 55 Das Circle Khammam', '+915062294473', 'CLC', 'CNPM', 135, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21002518', 'Taimur Basak', 'N?', to_date('2000-02-09', 'YYYY-MM-DD'), 'H.No. 113 Ganesan Road Alwar', '05884241161', 'CLC', 'TGMT', 63, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21002519', 'Anaya Thaman', 'N?', to_date('1933-03-02', 'YYYY-MM-DD'), '57/16 Sekhon Zila Loni', '02522395244', 'VP', 'CNTT', 85, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21002520', 'Tara Seshadri', 'N?', to_date('1987-02-28', 'YYYY-MM-DD'), 'H.No. 96 Dalal Chowk Ghaziabad', '08831229305', 'VP', 'KHMT', 128, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21002521', 'Tanya Konda', 'Nam', to_date('1992-01-29', 'YYYY-MM-DD'), '13/58 Chawla Path Latur', '08255972946', 'CQ', 'CNPM', 0, 7.29);

INSERT INTO SINHVIEN
VALUES ('SV21002522', 'Vivaan Deol', 'Nam', to_date('2012-12-05', 'YYYY-MM-DD'), 'H.No. 90 Keer Street Bellary', '05957584631', 'CLC', 'HTTT', 54, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21002523', 'Tushar Kala', 'N?', to_date('1912-10-05', 'YYYY-MM-DD'), '828 Grover Road Singrauli', '5902042344', 'CLC', 'CNTT', 119, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21002524', 'Saksham Dar', 'N?', to_date('2011-04-27', 'YYYY-MM-DD'), 'H.No. 98 Vohra Street Suryapet', '5084700459', 'CQ', 'MMT', 63, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21002525', 'Ritvik Venkataraman', 'Nam', to_date('2016-09-25', 'YYYY-MM-DD'), 'H.No. 093 Jhaveri Nagar Bikaner', '+915583025620', 'CLC', 'CNTT', 106, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21002526', 'Kiara Gulati', 'N?', to_date('1947-10-02', 'YYYY-MM-DD'), 'H.No. 018 Rana Marg Raichur', '+919555673355', 'CLC', 'CNTT', 60, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21002527', 'Pari Banerjee', 'N?', to_date('1994-08-02', 'YYYY-MM-DD'), 'H.No. 720 Varma Nagar Warangal', '5162609390', 'CTTT', 'KHMT', 57, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21002528', 'Aaina Divan', 'N?', to_date('2016-01-28', 'YYYY-MM-DD'), '75/115 Babu Circle Ballia', '4875411612', 'VP', 'CNPM', 36, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21002529', 'Anahi Manne', 'N?', to_date('2016-01-01', 'YYYY-MM-DD'), '258 Swamy Path Salem', '01773389475', 'CTTT', 'KHMT', 103, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21002530', 'Anvi Jha', 'Nam', to_date('1912-10-31', 'YYYY-MM-DD'), 'H.No. 261 Basu Chowk Navi Mumbai', '+910312215834', 'CLC', 'CNTT', 80, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21002531', 'Divij Gaba', 'N?', to_date('2016-10-30', 'YYYY-MM-DD'), '78/21 Ramesh Street Begusarai', '+916474341859', 'VP', 'HTTT', 60, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21002532', 'Darshit Rege', 'N?', to_date('1916-11-23', 'YYYY-MM-DD'), '53/800 Atwal Street Mehsana', '05258824161', 'VP', 'MMT', 110, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21002533', 'Aniruddh Raval', 'Nam', to_date('1966-11-03', 'YYYY-MM-DD'), 'H.No. 791 Gupta Ganj Anand', '4041985566', 'CQ', 'HTTT', 55, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21002534', 'Eshani Bahri', 'Nam', to_date('1972-03-10', 'YYYY-MM-DD'), '824 Tripathi Street Tadepalligudem', '8603790084', 'CQ', 'HTTT', 41, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002535', 'Jiya Bahri', 'Nam', to_date('1994-03-04', 'YYYY-MM-DD'), '178 Thaman Ganj Vijayawada', '8170372424', 'VP', 'MMT', 34, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21002536', 'Ivan Soni', 'N?', to_date('1963-12-27', 'YYYY-MM-DD'), '09 Virk Road Shahjahanpur', '4077463901', 'CQ', 'CNTT', 121, 9.65);

INSERT INTO SINHVIEN
VALUES ('SV21002537', 'Tara Raju', 'Nam', to_date('1946-11-26', 'YYYY-MM-DD'), '151 Wadhwa Tadipatri', '8761392771', 'CQ', 'CNTT', 97, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21002538', 'Yuvraj  Bhardwaj', 'Nam', to_date('2016-01-14', 'YYYY-MM-DD'), '88/935 Chhabra Zila Ujjain', '2894027378', 'CLC', 'KHMT', 32, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21002539', 'Kiaan Agrawal', 'Nam', to_date('1987-12-29', 'YYYY-MM-DD'), '42/07 Tailor Circle Machilipatnam', '+919419814421', 'VP', 'HTTT', 59, 7.53);

INSERT INTO SINHVIEN
VALUES ('SV21002540', 'Prisha Grewal', 'N?', to_date('1945-04-12', 'YYYY-MM-DD'), '15 Chaudhry Circle Aizawl', '+912844264995', 'CTTT', 'CNPM', 73, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21002541', 'Alisha Wadhwa', 'N?', to_date('1992-02-18', 'YYYY-MM-DD'), '711 Issac Nagar Panihati', '5722000152', 'CQ', 'HTTT', 37, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21002542', 'Rohan Salvi', 'N?', to_date('1949-11-30', 'YYYY-MM-DD'), 'H.No. 40 Ramakrishnan Marg Sikar', '04913384939', 'CLC', 'TGMT', 60, 9.15);

INSERT INTO SINHVIEN
VALUES ('SV21002543', 'Jayan Barad', 'N?', to_date('1971-09-20', 'YYYY-MM-DD'), 'H.No. 706 Subramaniam Marg Rampur', '07411768636', 'CTTT', 'CNTT', 102, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002544', 'Tara Roy', 'N?', to_date('1908-09-03', 'YYYY-MM-DD'), 'H.No. 32 Rau Marg Machilipatnam', '+916254509784', 'VP', 'TGMT', 122, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21002545', 'Ahana  Manne', 'N?', to_date('2001-03-05', 'YYYY-MM-DD'), '076 Atwal Circle Pimpri-Chinchwad', '6679393508', 'VP', 'MMT', 65, 8.39);

INSERT INTO SINHVIEN
VALUES ('SV21002546', 'Hridaan Kashyap', 'N?', to_date('1961-12-24', 'YYYY-MM-DD'), '150 Swamy Ganj Ramgarh', '+913367525231', 'VP', 'TGMT', 121, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21002547', 'Aayush Bail', 'N?', to_date('1910-10-24', 'YYYY-MM-DD'), '14 Kata Marg Hajipur', '07193666675', 'VP', 'CNPM', 118, 8.61);

INSERT INTO SINHVIEN
VALUES ('SV21002548', 'Alia Wable', 'Nam', to_date('2023-04-27', 'YYYY-MM-DD'), '83/291 Sant Street Guwahati', '04020002401', 'CQ', 'TGMT', 136, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21002549', 'Zoya Chaudhuri', 'Nam', to_date('1977-05-30', 'YYYY-MM-DD'), 'H.No. 39 Kota Chowk Varanasi', '1449115851', 'CTTT', 'CNTT', 108, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21002550', 'Manjari Zachariah', 'Nam', to_date('2011-03-18', 'YYYY-MM-DD'), 'H.No. 155 Sengupta Nagar Bhavnagar', '+915393989700', 'CQ', 'MMT', 87, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21002551', 'Saira Dara', 'Nam', to_date('1983-02-14', 'YYYY-MM-DD'), 'H.No. 18 Borah Circle Bhubaneswar', '08649280576', 'CTTT', 'KHMT', 50, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21002552', 'Taran Mangal', 'N?', to_date('2001-11-28', 'YYYY-MM-DD'), 'H.No. 95 Sood Chowk Tirupati', '+914509826766', 'CTTT', 'KHMT', 0, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21002553', 'Kismat Dyal', 'N?', to_date('1931-07-17', 'YYYY-MM-DD'), '81/47 Bajwa Road Panihati', '+918529728813', 'CLC', 'CNPM', 127, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21002554', 'Arnav Chanda', 'Nam', to_date('1964-07-30', 'YYYY-MM-DD'), '22/59 Bajwa Nagar Delhi', '5468588972', 'VP', 'HTTT', 74, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21002555', 'Shray Kale', 'Nam', to_date('1946-12-01', 'YYYY-MM-DD'), '53/17 Bava Marg Munger', '3583245364', 'VP', 'CNTT', 126, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21002556', 'Indrans Thaman', 'N?', to_date('2009-03-26', 'YYYY-MM-DD'), '14 Banik Circle Bhiwandi', '02734796261', 'CQ', 'MMT', 16, 6.51);

INSERT INTO SINHVIEN
VALUES ('SV21002557', 'Oorja Hayer', 'Nam', to_date('2018-10-25', 'YYYY-MM-DD'), '969 Kunda Marg Bahraich', '+912436376123', 'VP', 'TGMT', 31, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21002558', 'Indrans Ravel', 'Nam', to_date('1927-07-01', 'YYYY-MM-DD'), '95/104 Raman Farrukhabad', '0737921650', 'VP', 'CNTT', 113, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002559', 'Anya Mammen', 'N?', to_date('1931-10-13', 'YYYY-MM-DD'), '214 Bhargava Marg Aizawl', '+912987865947', 'VP', 'TGMT', 67, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21002560', 'Hiran Dutta', 'N?', to_date('1923-01-20', 'YYYY-MM-DD'), '18/94 Dhingra Street Ramgarh', '0779722841', 'CTTT', 'HTTT', 115, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21002561', 'Yashvi Sane', 'Nam', to_date('1961-02-16', 'YYYY-MM-DD'), 'H.No. 630 Madan Ganj Aizawl', '7730617604', 'CQ', 'KHMT', 82, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21002562', 'Rhea Ratta', 'Nam', to_date('2021-11-13', 'YYYY-MM-DD'), '93/887 Sethi Nagar Asansol', '2909548942', 'CQ', 'MMT', 44, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21002563', 'Advika Chander', 'N?', to_date('1966-03-25', 'YYYY-MM-DD'), '44/61 Rout Zila Karimnagar', '06526829040', 'VP', 'TGMT', 123, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21002564', 'Lakshit Baral', 'Nam', to_date('2007-02-26', 'YYYY-MM-DD'), '15/205 Taneja Circle Rewa', '8060157149', 'CLC', 'KHMT', 132, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21002565', 'Manikya Vala', 'N?', to_date('1996-02-16', 'YYYY-MM-DD'), '11/088 Sandal Nagar Gopalpur', '05683792043', 'CTTT', 'KHMT', 108, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21002566', 'Adira Venkataraman', 'N?', to_date('1931-10-28', 'YYYY-MM-DD'), '06 Divan Street Tiruvottiyur', '09511746421', 'CQ', 'HTTT', 32, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21002567', 'Mannat Wable', 'N?', to_date('1924-02-01', 'YYYY-MM-DD'), '07 Chaudhuri Chowk Alwar', '3579562745', 'CQ', 'KHMT', 43, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21002568', 'Faiyaz Swamy', 'N?', to_date('1966-04-11', 'YYYY-MM-DD'), '87 Dada Ganj Maheshtala', '+915750982954', 'CTTT', 'MMT', 92, 4.77);

INSERT INTO SINHVIEN
VALUES ('SV21002569', 'Zeeshan Chopra', 'N?', to_date('1976-03-28', 'YYYY-MM-DD'), 'H.No. 49 Swamy Marg Rohtak', '05754641581', 'VP', 'HTTT', 17, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21002570', 'Yasmin Bahri', 'N?', to_date('2014-12-20', 'YYYY-MM-DD'), '30/844 Rattan Path Sirsa', '3948543983', 'CQ', 'TGMT', 49, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21002571', 'Aradhya Gokhale', 'Nam', to_date('1957-12-07', 'YYYY-MM-DD'), '85/92 Wali Marg Kollam', '+919433902563', 'VP', 'CNPM', 125, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21002572', 'Kaira Kothari', 'N?', to_date('2001-02-22', 'YYYY-MM-DD'), '758 Shenoy Ganj Tiruppur', '9833271945', 'VP', 'KHMT', 92, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21002573', 'Romil Tara', 'N?', to_date('1916-12-04', 'YYYY-MM-DD'), '291 Barman Marg Gopalpur', '05225174189', 'CTTT', 'MMT', 97, 4.19);

INSERT INTO SINHVIEN
VALUES ('SV21002574', 'Sara Vala', 'N?', to_date('1965-05-22', 'YYYY-MM-DD'), 'H.No. 57 Ganesh Nagar Delhi', '+917794961380', 'VP', 'CNTT', 23, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21002575', 'Nayantara Sekhon', 'N?', to_date('2017-05-02', 'YYYY-MM-DD'), '837 Sha Marg Raichur', '05471733847', 'VP', 'CNTT', 91, 6.24);

INSERT INTO SINHVIEN
VALUES ('SV21002576', 'Ritvik Ganesan', 'N?', to_date('1947-09-18', 'YYYY-MM-DD'), '04/550 Tailor Aizawl', '+913004396259', 'CQ', 'TGMT', 58, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21002577', 'Zara Sachdeva', 'N?', to_date('1954-07-18', 'YYYY-MM-DD'), '55/57 Dash Street Anantapur', '08787631461', 'CLC', 'HTTT', 58, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21002578', 'Khushi Bajaj', 'Nam', to_date('1980-03-24', 'YYYY-MM-DD'), 'H.No. 62 Sehgal Road Giridih', '09901820422', 'CQ', 'KHMT', 136, 4.25);

INSERT INTO SINHVIEN
VALUES ('SV21002579', 'Nitara Dasgupta', 'Nam', to_date('2014-07-02', 'YYYY-MM-DD'), '20 Uppal Path Nizamabad', '1911802491', 'CQ', 'MMT', 119, 9.35);

INSERT INTO SINHVIEN
VALUES ('SV21002580', 'Yakshit Sem', 'N?', to_date('1924-09-08', 'YYYY-MM-DD'), '87/90 Luthra Zila Kota', '2399978846', 'CQ', 'CNTT', 14, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21002581', 'Anaya Lalla', 'Nam', to_date('1947-10-15', 'YYYY-MM-DD'), '959 Bedi Marg Raebareli', '0699141881', 'CLC', 'CNPM', 47, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21002582', 'Kashvi Iyer', 'N?', to_date('1935-03-21', 'YYYY-MM-DD'), '43/55 Deep Road Tiruvottiyur', '01953803210', 'CLC', 'CNTT', 38, 4.85);

INSERT INTO SINHVIEN
VALUES ('SV21002583', 'Stuvan Seshadri', 'Nam', to_date('1980-01-03', 'YYYY-MM-DD'), '805 Basu Road Berhampore', '+918007059131', 'CTTT', 'KHMT', 137, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21002584', 'Kartik Behl', 'N?', to_date('1990-09-09', 'YYYY-MM-DD'), 'H.No. 75 Sodhi Dewas', '06356223647', 'CTTT', 'CNPM', 95, 5.69);

INSERT INTO SINHVIEN
VALUES ('SV21002585', 'Kaira Doctor', 'N?', to_date('1998-05-04', 'YYYY-MM-DD'), 'H.No. 80 Raj Zila Malda', '02382707086', 'CQ', 'TGMT', 84, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21002586', 'Hansh Bhatnagar', 'N?', to_date('1958-10-04', 'YYYY-MM-DD'), 'H.No. 927 Keer Marg Coimbatore', '8645196134', 'CQ', 'MMT', 138, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21002587', 'Mehul Gour', 'N?', to_date('1914-06-14', 'YYYY-MM-DD'), '44 Singh Bahraich', '+913248079681', 'CQ', 'KHMT', 61, 6.01);

INSERT INTO SINHVIEN
VALUES ('SV21002588', 'Hazel Maharaj', 'Nam', to_date('1913-07-25', 'YYYY-MM-DD'), 'H.No. 51 Deep Circle Kanpur', '08322176936', 'CLC', 'KHMT', 0, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21002589', 'Yashvi Gera', 'Nam', to_date('1909-08-14', 'YYYY-MM-DD'), '276 Rout Nagar Morena', '2498978287', 'VP', 'CNPM', 37, 5.57);

INSERT INTO SINHVIEN
VALUES ('SV21002590', 'Emir Rama', 'Nam', to_date('1971-05-29', 'YYYY-MM-DD'), 'H.No. 36 Kapur Street Sonipat', '6880833746', 'CLC', 'KHMT', 6, 8.28);

INSERT INTO SINHVIEN
VALUES ('SV21002591', 'Tejas Khalsa', 'Nam', to_date('1963-08-19', 'YYYY-MM-DD'), '89/08 Kalita Chowk Morbi', '9981399356', 'CLC', 'MMT', 32, 4.97);

INSERT INTO SINHVIEN
VALUES ('SV21002592', 'Adah Sarin', 'Nam', to_date('2019-12-10', 'YYYY-MM-DD'), '892 Vyas Road Burhanpur', '3646391018', 'CLC', 'CNPM', 119, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21002593', 'Ritvik Bail', 'Nam', to_date('1984-01-29', 'YYYY-MM-DD'), '875 Chhabra Street Farrukhabad', '03911285849', 'CLC', 'CNPM', 88, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002594', 'Shayak Khanna', 'Nam', to_date('1930-04-10', 'YYYY-MM-DD'), '71/49 Shanker Circle Jamnagar', '+913515179645', 'CTTT', 'MMT', 29, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002595', 'Nirvi Bhavsar', 'Nam', to_date('2021-09-13', 'YYYY-MM-DD'), '022 Dara Marg Raurkela Industrial Township', '8259780725', 'CQ', 'KHMT', 22, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21002596', 'Tarini Khatri', 'Nam', to_date('1911-05-16', 'YYYY-MM-DD'), '91 Sharaf Ganj Alwar', '6990643024', 'VP', 'KHMT', 62, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21002597', 'Jayant Sunder', 'N?', to_date('1979-06-25', 'YYYY-MM-DD'), 'H.No. 817 Mangal Kolkata', '9390731164', 'CQ', 'HTTT', 50, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21002598', 'Aarush Viswanathan', 'Nam', to_date('1934-07-30', 'YYYY-MM-DD'), 'H.No. 26 Sathe Street Noida', '+910306661188', 'CQ', 'CNTT', 101, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21002599', 'Kartik Khatri', 'Nam', to_date('1959-10-11', 'YYYY-MM-DD'), '63 Halder Circle Parbhani', '09960377784', 'VP', 'HTTT', 11, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21002600', 'Kiara Banik', 'Nam', to_date('1976-10-31', 'YYYY-MM-DD'), 'H.No. 718 Konda Varanasi', '0326258390', 'CLC', 'CNPM', 46, 7.13);

INSERT INTO SINHVIEN
VALUES ('SV21002601', 'Anaya Contractor', 'N?', to_date('1967-04-12', 'YYYY-MM-DD'), 'H.No. 883 Edwin Marg Dewas', '02914729516', 'CLC', 'TGMT', 83, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21002602', 'Vivaan Shah', 'N?', to_date('2014-09-22', 'YYYY-MM-DD'), '92 Kapoor Road Karnal', '+915816021869', 'CTTT', 'CNPM', 105, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21002603', 'Vidur Agrawal', 'Nam', to_date('1977-07-23', 'YYYY-MM-DD'), 'H.No. 808 Manda Street Ambattur', '05412481419', 'VP', 'MMT', 28, 8.36);

INSERT INTO SINHVIEN
VALUES ('SV21002604', 'Myra Bhargava', 'N?', to_date('1948-01-28', 'YYYY-MM-DD'), 'H.No. 885 Savant Chowk Fatehpur', '01253860196', 'VP', 'HTTT', 12, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21002605', 'Dhruv Khanna', 'N?', to_date('1938-09-24', 'YYYY-MM-DD'), '87/22 Aggarwal Chowk Kavali', '3969299390', 'VP', 'KHMT', 52, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21002606', 'Zoya Magar', 'Nam', to_date('1999-05-01', 'YYYY-MM-DD'), 'H.No. 156 Shukla Gandhidham', '+914065650745', 'CQ', 'HTTT', 31, 8.23);

INSERT INTO SINHVIEN
VALUES ('SV21002607', 'Yashvi Batta', 'N?', to_date('1972-01-14', 'YYYY-MM-DD'), 'H.No. 932 Ram Ganj Kalyan-Dombivli', '02257258861', 'CLC', 'KHMT', 72, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21002608', 'Anahi Kunda', 'Nam', to_date('1942-09-12', 'YYYY-MM-DD'), 'H.No. 974 Sibal Berhampur', '+917007137493', 'VP', 'MMT', 126, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21002609', 'Keya Som', 'N?', to_date('1924-08-13', 'YYYY-MM-DD'), '77 Chokshi Nagar Vadodara', '4797007427', 'CTTT', 'HTTT', 60, 7.0);

INSERT INTO SINHVIEN
VALUES ('SV21002610', 'Hrishita Sharaf', 'N?', to_date('1913-01-25', 'YYYY-MM-DD'), '24/435 Maharaj Ganj Adoni', '+914069368867', 'CQ', 'KHMT', 90, 7.2);

INSERT INTO SINHVIEN
VALUES ('SV21002611', 'Aarna Kota', 'Nam', to_date('1981-04-07', 'YYYY-MM-DD'), '87/89 Sundaram Zila Pondicherry', '05829881513', 'CQ', 'KHMT', 28, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21002612', 'Zoya Uppal', 'Nam', to_date('1949-12-10', 'YYYY-MM-DD'), '62/853 Dewan Chowk Mumbai', '6781830461', 'CLC', 'KHMT', 107, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21002613', 'Lagan Dutta', 'N?', to_date('1937-09-28', 'YYYY-MM-DD'), '45/012 Zachariah Circle Machilipatnam', '4602696568', 'VP', 'CNPM', 78, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21002614', 'Yakshit Shukla', 'Nam', to_date('2012-11-01', 'YYYY-MM-DD'), '699 Bedi Chowk Bongaigaon', '+918586936674', 'VP', 'HTTT', 9, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21002615', 'Krish Sur', 'N?', to_date('1927-11-07', 'YYYY-MM-DD'), '46/96 Shetty Visakhapatnam', '+917222050141', 'VP', 'KHMT', 54, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21002616', 'Aayush Ramachandran', 'Nam', to_date('1998-06-01', 'YYYY-MM-DD'), 'H.No. 61 Ghosh Marg Kolkata', '+917553380256', 'VP', 'MMT', 23, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21002617', 'Tanya Chacko', 'N?', to_date('1943-12-04', 'YYYY-MM-DD'), '33/418 Mahajan Ganj Hapur', '09269884097', 'VP', 'TGMT', 14, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21002618', 'Samar Bose', 'Nam', to_date('1944-02-02', 'YYYY-MM-DD'), '91/077 Mand Agartala', '6643732530', 'VP', 'TGMT', 27, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21002619', 'Shalv Gandhi', 'N?', to_date('2005-06-28', 'YYYY-MM-DD'), 'H.No. 50 Randhawa Zila Ambala', '7741534679', 'VP', 'CNTT', 22, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21002620', 'Samar Lanka', 'Nam', to_date('2006-04-15', 'YYYY-MM-DD'), 'H.No. 41 Bora Marg Dehradun', '08095799619', 'CQ', 'CNPM', 9, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21002621', 'Urvi Bhasin', 'N?', to_date('1989-04-23', 'YYYY-MM-DD'), '097 Bhandari Bellary', '6393160729', 'VP', 'TGMT', 63, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21002622', 'Arhaan Sangha', 'N?', to_date('2022-08-21', 'YYYY-MM-DD'), '99/246 Keer Nagar Motihari', '0261398539', 'CTTT', 'CNTT', 83, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21002623', 'Hazel Dugar', 'N?', to_date('1975-10-02', 'YYYY-MM-DD'), 'H.No. 703 Saha Chowk Sangli-Miraj', '9679221468', 'CTTT', 'HTTT', 89, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21002624', 'Badal Kalita', 'N?', to_date('1988-10-04', 'YYYY-MM-DD'), '64 Loyal Road Asansol', '+914571978376', 'VP', 'MMT', 90, 7.97);

INSERT INTO SINHVIEN
VALUES ('SV21002625', 'Indranil Ram', 'N?', to_date('1965-05-12', 'YYYY-MM-DD'), 'H.No. 19 Reddy Ganj Mahbubnagar', '+917228815006', 'CLC', 'CNPM', 94, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21002626', 'Kimaya Bobal', 'N?', to_date('1920-10-15', 'YYYY-MM-DD'), 'H.No. 50 Behl Circle Jalandhar', '02334042098', 'CQ', 'KHMT', 130, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21002627', 'Indrajit Goel', 'N?', to_date('1938-08-22', 'YYYY-MM-DD'), 'H.No. 33 Gopal Road Rourkela', '01445572347', 'CTTT', 'CNPM', 52, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21002628', 'Manjari Vyas', 'Nam', to_date('1990-11-18', 'YYYY-MM-DD'), '65/82 De Circle Varanasi', '7086819667', 'CQ', 'TGMT', 66, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21002629', 'Saksham Kota', 'Nam', to_date('1938-10-11', 'YYYY-MM-DD'), '47/11 Contractor Marg Bhubaneswar', '6233179503', 'CLC', 'CNTT', 109, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21002630', 'Yuvraj  Sharma', 'N?', to_date('1991-11-07', 'YYYY-MM-DD'), 'H.No. 96 Bora Ganj Thoothukudi', '7840361810', 'CLC', 'KHMT', 29, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21002631', 'Darshit Sura', 'N?', to_date('1989-08-01', 'YYYY-MM-DD'), '380 Chand Circle Tiruvottiyur', '06861123061', 'VP', 'MMT', 35, 7.13);

INSERT INTO SINHVIEN
VALUES ('SV21002632', 'Anika Mann', 'N?', to_date('1976-12-14', 'YYYY-MM-DD'), '92/049 Warrior Road Bangalore', '08195453197', 'CQ', 'HTTT', 81, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21002633', 'Biju Mangat', 'Nam', to_date('1951-05-01', 'YYYY-MM-DD'), '937 Mangal Nagar Siliguri', '02217186953', 'VP', 'CNTT', 6, 9.05);

INSERT INTO SINHVIEN
VALUES ('SV21002634', 'Suhana Brar', 'Nam', to_date('1926-05-07', 'YYYY-MM-DD'), '77 Rattan Marg Kota', '7107384886', 'CLC', 'TGMT', 63, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21002635', 'Jivika Dhar', 'Nam', to_date('2018-02-08', 'YYYY-MM-DD'), '06/783 Sethi Road Rampur', '03878530889', 'CTTT', 'KHMT', 61, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21002636', 'Damini Chada', 'N?', to_date('2004-04-23', 'YYYY-MM-DD'), 'H.No. 387 Sarma Chowk Nandyal', '+916069081030', 'CTTT', 'CNTT', 24, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21002637', 'Nirvi Dewan', 'Nam', to_date('1938-02-01', 'YYYY-MM-DD'), 'H.No. 268 Agate Circle Cuttack', '09197036355', 'VP', 'MMT', 101, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21002638', 'Nirvaan Mallick', 'Nam', to_date('2006-04-06', 'YYYY-MM-DD'), 'H.No. 61 Bansal Street Cuttack', '+912532534837', 'CQ', 'MMT', 72, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21002639', 'Stuvan Chand', 'N?', to_date('1918-10-16', 'YYYY-MM-DD'), '97 Bora Road Coimbatore', '09179312545', 'CTTT', 'KHMT', 105, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21002640', 'Vanya Rao', 'N?', to_date('2024-02-25', 'YYYY-MM-DD'), '19/65 Ghosh Zila Hajipur', '09967336554', 'CLC', 'HTTT', 11, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21002641', 'Dishani Arya', 'Nam', to_date('1936-06-12', 'YYYY-MM-DD'), '72/57 Butala Zila Sultan Pur Majra', '5439582765', 'VP', 'HTTT', 49, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21002642', 'Ira Samra', 'Nam', to_date('2009-08-09', 'YYYY-MM-DD'), 'H.No. 837 Dara Ganj Munger', '03054820021', 'CLC', 'TGMT', 105, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21002643', 'Prerak Edwin', 'N?', to_date('2018-11-18', 'YYYY-MM-DD'), '49/07 Sarraf Ganj Bulandshahr', '+913372776158', 'CQ', 'CNTT', 84, 7.5);

INSERT INTO SINHVIEN
VALUES ('SV21002644', 'Piya Kaul', 'N?', to_date('1927-03-29', 'YYYY-MM-DD'), '44/74 Chaudhari Circle Kota', '+913415899079', 'CTTT', 'TGMT', 106, 4.38);

INSERT INTO SINHVIEN
VALUES ('SV21002645', 'Inaaya  Rout', 'Nam', to_date('2018-03-30', 'YYYY-MM-DD'), '99 Sathe Chowk Solapur', '+911487317615', 'VP', 'CNTT', 13, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21002646', 'Vaibhav Amble', 'N?', to_date('1982-12-19', 'YYYY-MM-DD'), '25/67 Barad Circle Karimnagar', '7723929806', 'CLC', 'CNTT', 4, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21002647', 'Gokul Jani', 'Nam', to_date('1924-03-23', 'YYYY-MM-DD'), '78 Trivedi Nagar Begusarai', '+910064014654', 'CQ', 'HTTT', 133, 9.87);

INSERT INTO SINHVIEN
VALUES ('SV21002648', 'Raghav Joshi', 'Nam', to_date('1987-02-12', 'YYYY-MM-DD'), 'H.No. 00 Master Road Kishanganj', '00822427561', 'VP', 'TGMT', 121, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21002649', 'Pranay Roy', 'N?', to_date('1916-05-10', 'YYYY-MM-DD'), 'H.No. 196 Dube Nagar Bhimavaram', '4979419641', 'VP', 'TGMT', 83, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21002650', 'Drishya Chawla', 'N?', to_date('1959-03-27', 'YYYY-MM-DD'), 'H.No. 313 Dewan Marg Nadiad', '5212023678', 'CQ', 'MMT', 31, 9.26);

INSERT INTO SINHVIEN
VALUES ('SV21002651', 'Biju Gulati', 'N?', to_date('1929-03-30', 'YYYY-MM-DD'), 'H.No. 623 Dalal Ganj Pallavaram', '5313009326', 'VP', 'MMT', 10, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21002652', 'Yashvi Bandi', 'N?', to_date('2019-10-01', 'YYYY-MM-DD'), '19 Guha Nagar New Delhi', '+916988612554', 'CQ', 'KHMT', 16, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21002653', 'Seher Sabharwal', 'Nam', to_date('1953-03-27', 'YYYY-MM-DD'), '403 Borah Chowk Ozhukarai', '04758541013', 'CQ', 'TGMT', 28, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21002654', 'Lavanya Jha', 'Nam', to_date('1942-03-18', 'YYYY-MM-DD'), '307 Sandal Sonipat', '02708526256', 'CTTT', 'KHMT', 55, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21002655', 'Shray Keer', 'N?', to_date('1959-09-16', 'YYYY-MM-DD'), 'H.No. 21 Bhavsar Path Buxar', '02365324995', 'CLC', 'MMT', 104, 8.74);

INSERT INTO SINHVIEN
VALUES ('SV21002656', 'Aarna Venkataraman', 'N?', to_date('1945-12-19', 'YYYY-MM-DD'), '65/246 Rastogi Zila Kulti', '7131455496', 'CQ', 'HTTT', 62, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21002657', 'Ojas Badal', 'Nam', to_date('1932-07-19', 'YYYY-MM-DD'), '83 Loyal Zila Jaipur', '07997871051', 'CLC', 'KHMT', 97, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21002658', 'Ira Savant', 'N?', to_date('1968-07-21', 'YYYY-MM-DD'), 'H.No. 55 Din Road Gulbarga', '+915265705407', 'CQ', 'KHMT', 65, 4.46);

INSERT INTO SINHVIEN
VALUES ('SV21002659', 'Ojas Chandran', 'N?', to_date('1951-12-29', 'YYYY-MM-DD'), '00/68 Kumer Mysore', '+913104134710', 'CLC', 'HTTT', 66, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21002660', 'Purab Mangal', 'N?', to_date('1972-01-16', 'YYYY-MM-DD'), '85 Chahal Ganj Mirzapur', '+917275814580', 'CLC', 'CNTT', 65, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21002661', 'Kaira Handa', 'Nam', to_date('1985-08-31', 'YYYY-MM-DD'), 'H.No. 62 Gera Chowk Malegaon', '01172446263', 'VP', 'CNPM', 15, 6.98);

INSERT INTO SINHVIEN
VALUES ('SV21002662', 'Elakshi Rege', 'N?', to_date('1931-01-30', 'YYYY-MM-DD'), '33 Ramesh Path Mahbubnagar', '2381592601', 'CTTT', 'KHMT', 74, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002663', 'Stuvan Sibal', 'N?', to_date('1989-04-09', 'YYYY-MM-DD'), '54/11 Dubey Zila Kumbakonam', '6480652513', 'CTTT', 'HTTT', 6, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21002664', 'Nakul Kaul', 'N?', to_date('1920-02-04', 'YYYY-MM-DD'), 'H.No. 17 Ramachandran Ganj Jorhat', '08418076956', 'CQ', 'CNTT', 25, 8.98);

INSERT INTO SINHVIEN
VALUES ('SV21002665', 'Romil Wason', 'N?', to_date('1917-08-27', 'YYYY-MM-DD'), 'H.No. 02 Kohli Road Bathinda', '+914552486167', 'VP', 'HTTT', 8, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21002666', 'Reyansh Kapadia', 'Nam', to_date('1961-09-15', 'YYYY-MM-DD'), '832 Sarraf Zila Indore', '00456533158', 'CTTT', 'MMT', 99, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21002667', 'Tejas Chakraborty', 'N?', to_date('1927-02-23', 'YYYY-MM-DD'), 'H.No. 81 Chandran Circle Bhavnagar', '0642329383', 'CQ', 'CNPM', 32, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21002668', 'Samiha Krishna', 'N?', to_date('2004-03-08', 'YYYY-MM-DD'), 'H.No. 316 Goda Path Bijapur', '5230464752', 'VP', 'CNTT', 75, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21002669', 'Shanaya Anne', 'N?', to_date('1989-09-27', 'YYYY-MM-DD'), '60/40 Bhatia Circle Ahmednagar', '4639094691', 'CLC', 'CNTT', 105, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21002670', 'Heer Magar', 'N?', to_date('1990-04-16', 'YYYY-MM-DD'), '682 Ramakrishnan Street Bongaigaon', '+919285100974', 'CQ', 'HTTT', 85, 9.65);

INSERT INTO SINHVIEN
VALUES ('SV21002671', 'Nitara Savant', 'N?', to_date('1930-02-28', 'YYYY-MM-DD'), '70/390 Solanki Street Bokaro', '+914442330643', 'VP', 'HTTT', 23, 7.11);

INSERT INTO SINHVIEN
VALUES ('SV21002672', 'Jayant Deshmukh', 'N?', to_date('1914-05-03', 'YYYY-MM-DD'), '472 Sahota Ganj Adoni', '00153286027', 'CQ', 'KHMT', 125, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21002673', 'Kaira Krishnamurthy', 'Nam', to_date('2018-02-08', 'YYYY-MM-DD'), '56 Kurian Nagar Mau', '01711728200', 'CTTT', 'TGMT', 46, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21002674', 'Vivaan Sarraf', 'N?', to_date('2009-06-21', 'YYYY-MM-DD'), 'H.No. 324 Gade Street Pali', '+912698637773', 'CLC', 'MMT', 131, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21002675', 'Ryan Char', 'N?', to_date('2017-11-01', 'YYYY-MM-DD'), 'H.No. 91 Badal Chowk Thoothukudi', '00695112030', 'CTTT', 'KHMT', 133, 9.52);

INSERT INTO SINHVIEN
VALUES ('SV21002676', 'Kartik Kibe', 'Nam', to_date('1967-01-27', 'YYYY-MM-DD'), '74/00 Soni Ambala', '09780476018', 'CTTT', 'MMT', 67, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21002677', 'Samar Sekhon', 'Nam', to_date('1977-03-23', 'YYYY-MM-DD'), '22 Sawhney Chowk Mango', '5808973664', 'CLC', 'TGMT', 57, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21002678', 'Amani Dalal', 'N?', to_date('1974-10-22', 'YYYY-MM-DD'), 'H.No. 15 Borah Chowk Bhind', '3544717233', 'CTTT', 'CNPM', 69, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21002679', 'Pranay Goda', 'Nam', to_date('1952-11-17', 'YYYY-MM-DD'), '66/637 Viswanathan Chowk North Dumdum', '+919471464696', 'CTTT', 'MMT', 63, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21002680', 'Biju Talwar', 'Nam', to_date('2018-04-29', 'YYYY-MM-DD'), 'H.No. 507 Batra Saharanpur', '4921674590', 'CTTT', 'TGMT', 110, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21002681', 'Siya Bakshi', 'N?', to_date('1925-02-26', 'YYYY-MM-DD'), '35 Vala Bhatpara', '4534777402', 'VP', 'CNPM', 92, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21002682', 'Raghav Bajaj', 'Nam', to_date('1957-04-01', 'YYYY-MM-DD'), '29/73 Gour Nagar Gwalior', '+915135445985', 'CQ', 'TGMT', 88, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21002683', 'Nakul Cherian', 'N?', to_date('1956-04-12', 'YYYY-MM-DD'), 'H.No. 748 Kanda Circle Bidar', '+914228700081', 'VP', 'HTTT', 115, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21002684', 'Aaina Datta', 'Nam', to_date('1960-10-12', 'YYYY-MM-DD'), '47/17 Anand Zila Sri Ganganagar', '2635692912', 'CQ', 'KHMT', 17, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21002685', 'Devansh Gill', 'N?', to_date('2021-06-16', 'YYYY-MM-DD'), '04 Chokshi Road Aizawl', '01359985390', 'CQ', 'TGMT', 89, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21002686', 'Farhan Joshi', 'N?', to_date('1917-01-30', 'YYYY-MM-DD'), '723 Char Ganj Bardhaman', '6411253978', 'VP', 'HTTT', 115, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21002687', 'Nakul Atwal', 'Nam', to_date('1946-12-14', 'YYYY-MM-DD'), 'H.No. 04 Mangat Path Kavali', '00626932123', 'VP', 'MMT', 96, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21002688', 'Raunak Shan', 'N?', to_date('1988-07-10', 'YYYY-MM-DD'), '17/129 Sarma Bikaner', '+913096213284', 'VP', 'HTTT', 32, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21002689', 'Raghav Dhaliwal', 'N?', to_date('1991-05-23', 'YYYY-MM-DD'), '45/21 Bhatnagar Marg Baranagar', '+916000774070', 'CQ', 'MMT', 135, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21002690', 'Diya Krishnamurthy', 'Nam', to_date('1919-10-22', 'YYYY-MM-DD'), '51/392 Srinivas Chowk Delhi', '8228683111', 'VP', 'MMT', 102, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21002691', 'Jayant Hegde', 'N?', to_date('1969-05-26', 'YYYY-MM-DD'), '61 Ramachandran Zila Visakhapatnam', '7148404302', 'CLC', 'CNPM', 61, 4.48);

INSERT INTO SINHVIEN
VALUES ('SV21002692', 'Seher Chatterjee', 'Nam', to_date('1970-10-12', 'YYYY-MM-DD'), '77/233 Karan Path Delhi', '04547052177', 'CQ', 'CNPM', 79, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21002693', 'Krish Bala', 'N?', to_date('1975-11-21', 'YYYY-MM-DD'), '56/785 Karnik Nagar Guntakal', '+911293181709', 'CQ', 'MMT', 71, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21002694', 'Indrans Gade', 'N?', to_date('1985-08-15', 'YYYY-MM-DD'), '02 Kapur Nagar Moradabad', '7919350945', 'CLC', 'CNPM', 31, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21002695', 'Seher Chaudhry', 'Nam', to_date('2002-02-26', 'YYYY-MM-DD'), '60/615 Saraf Zila Katihar', '03447640554', 'CQ', 'HTTT', 26, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21002696', 'Vihaan Lalla', 'N?', to_date('1949-07-11', 'YYYY-MM-DD'), '76 Dani Zila Amaravati', '7119682474', 'CLC', 'CNPM', 66, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21002697', 'Biju Varty', 'N?', to_date('1995-06-22', 'YYYY-MM-DD'), '98/823 Raj Nagar Bally', '+912863235564', 'VP', 'HTTT', 43, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21002698', 'Rohan Soni', 'Nam', to_date('1944-08-15', 'YYYY-MM-DD'), 'H.No. 887 Sinha Circle Purnia', '+916392224216', 'VP', 'CNTT', 36, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21002699', 'Baiju Chakraborty', 'N?', to_date('1953-08-24', 'YYYY-MM-DD'), 'H.No. 38 Kulkarni Path Warangal', '+910397573528', 'CTTT', 'HTTT', 119, 5.73);

INSERT INTO SINHVIEN
VALUES ('SV21002700', 'Uthkarsh Tara', 'Nam', to_date('1936-12-14', 'YYYY-MM-DD'), '090 Chaudhry Street Hospet', '3192987398', 'CTTT', 'TGMT', 49, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21002701', 'Pranay Bahri', 'N?', to_date('1953-04-19', 'YYYY-MM-DD'), '92/02 Hora Nagar Bongaigaon', '7803365991', 'CQ', 'CNTT', 62, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21002702', 'Zoya Sharaf', 'N?', to_date('1929-01-22', 'YYYY-MM-DD'), 'H.No. 936 Mammen Zila Maheshtala', '+917703882619', 'CQ', 'CNPM', 43, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21002703', 'Anika Gandhi', 'Nam', to_date('1963-12-24', 'YYYY-MM-DD'), 'H.No. 619 Deep Street Jorhat', '+915718286856', 'CLC', 'CNTT', 25, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21002704', 'Gatik Bajwa', 'N?', to_date('1997-04-21', 'YYYY-MM-DD'), '723 Bora Road Coimbatore', '0958376019', 'CTTT', 'KHMT', 54, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21002705', 'Anahi Solanki', 'N?', to_date('1997-09-11', 'YYYY-MM-DD'), '39/36 Samra Nagar Dharmavaram', '8518292699', 'CTTT', 'KHMT', 85, 8.32);

INSERT INTO SINHVIEN
VALUES ('SV21002706', 'Suhana Trivedi', 'Nam', to_date('2021-05-18', 'YYYY-MM-DD'), 'H.No. 751 Gaba Gopalpur', '02429367117', 'CTTT', 'MMT', 28, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21002707', 'Alia Bhat', 'Nam', to_date('2020-02-02', 'YYYY-MM-DD'), '08 Chadha Ganj Hindupur', '1094672452', 'CTTT', 'CNTT', 8, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21002708', 'Kanav Sachar', 'Nam', to_date('2013-02-16', 'YYYY-MM-DD'), 'H.No. 089 Dewan Ganj Nagercoil', '07267269297', 'CLC', 'CNPM', 59, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21002709', 'Kashvi Varma', 'Nam', to_date('1952-02-18', 'YYYY-MM-DD'), 'H.No. 845 Das Nagar Siwan', '+913587397996', 'CQ', 'KHMT', 59, 9.48);

INSERT INTO SINHVIEN
VALUES ('SV21002710', 'Shalv Sarin', 'Nam', to_date('1954-10-01', 'YYYY-MM-DD'), 'H.No. 96 Borde Chowk Kolhapur', '02627316604', 'VP', 'TGMT', 6, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21002711', 'Hrishita Sheth', 'N?', to_date('1949-04-24', 'YYYY-MM-DD'), '814 Dash Zila Asansol', '09899963028', 'CTTT', 'CNPM', 80, 4.32);

INSERT INTO SINHVIEN
VALUES ('SV21002712', 'Jayan Chad', 'N?', to_date('1938-07-22', 'YYYY-MM-DD'), '58 Goel Nagar Ulhasnagar', '+912933622908', 'CQ', 'MMT', 18, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21002713', 'Biju Gala', 'N?', to_date('1947-04-17', 'YYYY-MM-DD'), '78 Chaudhary Path Patna', '5384606762', 'CTTT', 'MMT', 77, 7.59);

INSERT INTO SINHVIEN
VALUES ('SV21002714', 'Anahita Mandal', 'Nam', to_date('2004-01-06', 'YYYY-MM-DD'), '29/729 Jha Marg Junagadh', '07794334514', 'CTTT', 'TGMT', 137, 4.33);

INSERT INTO SINHVIEN
VALUES ('SV21002715', 'Abram Sodhi', 'Nam', to_date('1982-07-27', 'YYYY-MM-DD'), '36 Malhotra Path Tiruppur', '+912769574469', 'VP', 'HTTT', 75, 9.52);

INSERT INTO SINHVIEN
VALUES ('SV21002716', 'Taran Kothari', 'N?', to_date('1984-06-19', 'YYYY-MM-DD'), '04 Bains Circle Alwar', '3393018150', 'VP', 'TGMT', 117, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21002717', 'Jivika Chowdhury', 'Nam', to_date('2019-11-07', 'YYYY-MM-DD'), '95 Sanghvi Road Asansol', '01506824211', 'CQ', 'MMT', 75, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21002718', 'Rohan Khanna', 'N?', to_date('2009-09-20', 'YYYY-MM-DD'), 'H.No. 75 Banik Path Jalna', '+916394470103', 'CTTT', 'CNTT', 69, 7.85);

INSERT INTO SINHVIEN
VALUES ('SV21002719', 'Baiju Kannan', 'Nam', to_date('1965-04-13', 'YYYY-MM-DD'), '78/729 Tak Barasat', '+914271256694', 'CQ', 'CNTT', 84, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21002720', 'Amani Grewal', 'Nam', to_date('1914-03-11', 'YYYY-MM-DD'), 'H.No. 326 D��Alia Road Mangalore', '5498828681', 'VP', 'KHMT', 62, 5.22);

INSERT INTO SINHVIEN
VALUES ('SV21002721', 'Gatik Bhargava', 'Nam', to_date('1930-03-26', 'YYYY-MM-DD'), '98/711 Krish Varanasi', '+910069216267', 'CQ', 'CNPM', 107, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21002722', 'Prerak Borra', 'Nam', to_date('1927-01-23', 'YYYY-MM-DD'), 'H.No. 522 Kohli Zila Bettiah', '9007207517', 'CLC', 'CNPM', 38, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21002723', 'Biju Gade', 'Nam', to_date('1915-02-14', 'YYYY-MM-DD'), 'H.No. 57 Devi Street North Dumdum', '00367021484', 'CLC', 'HTTT', 44, 5.02);

INSERT INTO SINHVIEN
VALUES ('SV21002724', 'Shamik Mall', 'Nam', to_date('1953-11-06', 'YYYY-MM-DD'), '56/771 Basu Street Hapur', '04011547095', 'CLC', 'CNPM', 33, 9.1);

INSERT INTO SINHVIEN
VALUES ('SV21002725', 'Hansh Gala', 'Nam', to_date('1999-07-19', 'YYYY-MM-DD'), '35/95 Sarin Rampur', '+912747700961', 'CQ', 'CNPM', 136, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21002726', 'Seher Chokshi', 'Nam', to_date('2017-01-01', 'YYYY-MM-DD'), 'H.No. 689 Raj Ganj Hazaribagh', '+913184057104', 'CLC', 'TGMT', 93, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21002727', 'Jivika Thakkar', 'N?', to_date('1918-02-01', 'YYYY-MM-DD'), '37 Swaminathan Circle Jalgaon', '+911637138153', 'CLC', 'CNPM', 51, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21002728', 'Diya Chanda', 'Nam', to_date('1952-10-17', 'YYYY-MM-DD'), '71/034 Gade Street Satna', '02062327783', 'CQ', 'KHMT', 81, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21002729', 'Rati Buch', 'Nam', to_date('1922-01-14', 'YYYY-MM-DD'), '06/75 Agrawal Zila Jalandhar', '2980235784', 'CTTT', 'KHMT', 57, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002730', 'Shray Dugar', 'N?', to_date('2014-04-12', 'YYYY-MM-DD'), '95/765 Tripathi Circle Tirunelveli', '02053259810', 'CQ', 'KHMT', 135, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21002731', 'Hansh Sarma', 'N?', to_date('2021-12-30', 'YYYY-MM-DD'), '06/441 Bawa Path Motihari', '5678618924', 'VP', 'CNTT', 19, 5.11);

INSERT INTO SINHVIEN
VALUES ('SV21002732', 'Dharmajan Keer', 'Nam', to_date('1938-04-20', 'YYYY-MM-DD'), 'H.No. 01 Chad Circle Coimbatore', '0401628574', 'VP', 'CNTT', 110, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21002733', 'Tarini Saha', 'N?', to_date('1974-03-19', 'YYYY-MM-DD'), 'H.No. 181 Ravel Nagar Jalgaon', '03432265183', 'CQ', 'CNPM', 8, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21002734', 'Yakshit Subramanian', 'N?', to_date('1954-10-08', 'YYYY-MM-DD'), 'H.No. 585 Bhasin Road Thiruvananthapuram', '4106077791', 'CTTT', 'TGMT', 89, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21002735', 'Aarna Tak', 'Nam', to_date('1930-05-12', 'YYYY-MM-DD'), '43 Jayaraman Road Panihati', '+917559612041', 'CTTT', 'HTTT', 31, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21002736', 'Kimaya Majumdar', 'N?', to_date('1925-12-17', 'YYYY-MM-DD'), '78/19 Lala Street Gwalior', '09374115281', 'CTTT', 'CNTT', 94, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21002737', 'Prisha Chatterjee', 'N?', to_date('1986-07-06', 'YYYY-MM-DD'), '99 Kakar Chowk Ballia', '03230901026', 'VP', 'MMT', 78, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21002738', 'Sara Gokhale', 'Nam', to_date('1970-11-29', 'YYYY-MM-DD'), '936 Tella Road Giridih', '6863734017', 'VP', 'KHMT', 76, 8.32);

INSERT INTO SINHVIEN
VALUES ('SV21002739', 'Jivin Das', 'N?', to_date('1935-08-13', 'YYYY-MM-DD'), '64/972 Bhatnagar Path Coimbatore', '+912983302065', 'CLC', 'TGMT', 13, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21002740', 'Heer Vasa', 'Nam', to_date('1947-07-23', 'YYYY-MM-DD'), '80 Babu Circle Karimnagar', '+916842559223', 'CQ', 'TGMT', 33, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21002741', 'Madhav Chada', 'N?', to_date('2011-01-25', 'YYYY-MM-DD'), 'H.No. 10 Devi Jorhat', '+910814615325', 'VP', 'CNPM', 82, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21002742', 'Ryan Chanda', 'N?', to_date('2011-04-20', 'YYYY-MM-DD'), 'H.No. 36 Bhatti Path Ajmer', '+912234491923', 'CQ', 'TGMT', 21, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21002743', 'Shaan Shanker', 'N?', to_date('2017-02-19', 'YYYY-MM-DD'), '814 Dhawan Davanagere', '6220749112', 'CQ', 'MMT', 106, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21002744', 'Sana Mani', 'N?', to_date('2013-01-11', 'YYYY-MM-DD'), 'H.No. 13 Saini Marg Jaunpur', '04409750151', 'VP', 'CNTT', 75, 5.77);

INSERT INTO SINHVIEN
VALUES ('SV21002745', 'Priyansh Thakur', 'N?', to_date('1934-01-18', 'YYYY-MM-DD'), 'H.No. 808 Chandra Marg Morena', '5515938693', 'CQ', 'HTTT', 135, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21002746', 'Dhanush Doctor', 'Nam', to_date('2006-07-02', 'YYYY-MM-DD'), '317 Tara Ganj Rourkela', '00656970511', 'CQ', 'CNTT', 55, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21002747', 'Navya Tailor', 'Nam', to_date('1944-10-09', 'YYYY-MM-DD'), '74 Balay Marg Dhule', '1172089579', 'VP', 'TGMT', 11, 8.48);

INSERT INTO SINHVIEN
VALUES ('SV21002748', 'Kiara Gara', 'Nam', to_date('1913-10-03', 'YYYY-MM-DD'), 'H.No. 101 Krishnan Street Panvel', '1560026500', 'VP', 'TGMT', 94, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21002749', 'Hansh Vyas', 'Nam', to_date('1973-04-20', 'YYYY-MM-DD'), '75 Mammen Thrissur', '+911084245784', 'CQ', 'HTTT', 32, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21002750', 'Rasha Biswas', 'N?', to_date('1990-05-28', 'YYYY-MM-DD'), 'H.No. 25 Sharaf Ludhiana', '+914962780373', 'VP', 'CNPM', 45, 4.18);

INSERT INTO SINHVIEN
VALUES ('SV21002751', 'Badal Lanka', 'Nam', to_date('1933-01-18', 'YYYY-MM-DD'), '00 Shenoy Ganj Haridwar', '06693602318', 'CLC', 'MMT', 127, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21002752', 'Alia Zachariah', 'N?', to_date('2016-10-27', 'YYYY-MM-DD'), '630 Bhandari Marg Bhilai', '+912700884145', 'CQ', 'CNTT', 92, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21002753', 'Stuvan D��Alia', 'Nam', to_date('1908-10-25', 'YYYY-MM-DD'), '17 Bora Road Amroha', '+918656184123', 'CTTT', 'CNTT', 119, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21002754', 'Vidur Chakraborty', 'Nam', to_date('1934-10-23', 'YYYY-MM-DD'), '231 Anand Path Kulti', '8161032352', 'CTTT', 'TGMT', 102, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21002755', 'Kartik Badami', 'N?', to_date('1960-12-31', 'YYYY-MM-DD'), 'H.No. 15 Ranganathan Zila Nizamabad', '00510584252', 'CTTT', 'HTTT', 93, 6.17);

INSERT INTO SINHVIEN
VALUES ('SV21002756', 'Hunar Kaur', 'Nam', to_date('1982-04-24', 'YYYY-MM-DD'), '554 Sharma Ganj Alwar', '+915928335542', 'VP', 'MMT', 1, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21002757', 'Tarini Kibe', 'Nam', to_date('1958-09-03', 'YYYY-MM-DD'), '04 Bajwa Nagar Narasaraopet', '+911732895830', 'CQ', 'MMT', 83, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21002758', 'Misha Varkey', 'Nam', to_date('2010-02-06', 'YYYY-MM-DD'), 'H.No. 130 Wali Zila Ozhukarai', '9355839588', 'CQ', 'HTTT', 63, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21002759', 'Kismat Sunder', 'N?', to_date('2012-09-10', 'YYYY-MM-DD'), '10/834 Dave Circle Darbhanga', '6599736425', 'CQ', 'CNPM', 54, 5.77);

INSERT INTO SINHVIEN
VALUES ('SV21002760', 'Saira Suri', 'N?', to_date('1920-04-14', 'YYYY-MM-DD'), '120 Hayre Marg Jaunpur', '+912798889590', 'CLC', 'MMT', 73, 9.75);

INSERT INTO SINHVIEN
VALUES ('SV21002761', 'Alisha Bhalla', 'N?', to_date('1957-07-19', 'YYYY-MM-DD'), 'H.No. 79 Ram Zila Cuttack', '+911743958197', 'CTTT', 'MMT', 102, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21002762', 'Sahil Bala', 'Nam', to_date('1964-05-24', 'YYYY-MM-DD'), 'H.No. 77 Choudhary Street Lucknow', '+915080206018', 'CQ', 'CNTT', 44, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21002763', 'Saanvi Kurian', 'Nam', to_date('1916-11-07', 'YYYY-MM-DD'), '88/027 Sama Moradabad', '01438513600', 'CQ', 'TGMT', 56, 5.5);

INSERT INTO SINHVIEN
VALUES ('SV21002764', 'Khushi Aggarwal', 'N?', to_date('1908-07-06', 'YYYY-MM-DD'), '78/48 Ravel Circle Naihati', '+917108367645', 'CQ', 'TGMT', 13, 8.48);

INSERT INTO SINHVIEN
VALUES ('SV21002765', 'Faiyaz Saini', 'N?', to_date('1987-10-18', 'YYYY-MM-DD'), '30/968 Saxena Road Raebareli', '07449541031', 'CLC', 'MMT', 102, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21002766', 'Khushi Garg', 'Nam', to_date('1997-06-02', 'YYYY-MM-DD'), 'H.No. 220 Khanna Nagar Ongole', '00512329032', 'CQ', 'TGMT', 95, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21002767', 'Zara Shroff', 'Nam', to_date('1946-08-18', 'YYYY-MM-DD'), 'H.No. 091 Trivedi Circle Ghaziabad', '9300830675', 'CLC', 'KHMT', 100, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21002768', 'Gokul Ratta', 'Nam', to_date('1911-08-06', 'YYYY-MM-DD'), 'H.No. 743 Kala Circle Dhanbad', '+910985416104', 'CTTT', 'KHMT', 109, 7.45);

INSERT INTO SINHVIEN
VALUES ('SV21002769', 'Elakshi Raja', 'N?', to_date('1934-01-06', 'YYYY-MM-DD'), '56/398 Barad Circle Sagar', '06279664659', 'VP', 'HTTT', 4, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21002770', 'Nehmat Halder', 'Nam', to_date('1911-08-28', 'YYYY-MM-DD'), '45/185 Subramaniam Street Ratlam', '+917095204874', 'CLC', 'CNTT', 122, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21002771', 'Saanvi Atwal', 'Nam', to_date('2019-03-02', 'YYYY-MM-DD'), '890 Chad Circle Thoothukudi', '06999933373', 'CTTT', 'TGMT', 21, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21002772', 'Ishaan Sastry', 'Nam', to_date('1998-12-27', 'YYYY-MM-DD'), '56/157 Sastry Ganj Medininagar', '4263527595', 'CLC', 'CNTT', 68, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21002773', 'Nakul Lata', 'Nam', to_date('2002-01-03', 'YYYY-MM-DD'), '905 Bath Marg Tiruvottiyur', '08326960489', 'CLC', 'TGMT', 90, 5.22);

INSERT INTO SINHVIEN
VALUES ('SV21002774', 'Prisha Vyas', 'Nam', to_date('1964-11-08', 'YYYY-MM-DD'), '51/52 Chakraborty Circle Bikaner', '+916188917098', 'CLC', 'KHMT', 117, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21002775', 'Kabir Lad', 'N?', to_date('1960-04-11', 'YYYY-MM-DD'), '35/213 Chander Zila Siwan', '4474936832', 'CQ', 'MMT', 134, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21002776', 'Mehul Sheth', 'N?', to_date('1923-09-02', 'YYYY-MM-DD'), 'H.No. 99 Bakshi Anantapur', '+912523126771', 'CQ', 'HTTT', 55, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21002777', 'Veer Khosla', 'Nam', to_date('1936-12-15', 'YYYY-MM-DD'), '25/892 Kanda Ganj Pune', '6671929026', 'CLC', 'KHMT', 131, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21002778', 'Vritika Dutta', 'N?', to_date('1939-10-22', 'YYYY-MM-DD'), 'H.No. 52 Gulati Chowk Kollam', '+918379239921', 'CQ', 'TGMT', 92, 4.44);

INSERT INTO SINHVIEN
VALUES ('SV21002779', 'Farhan Karpe', 'Nam', to_date('1986-07-27', 'YYYY-MM-DD'), 'H.No. 14 Divan Sri Ganganagar', '01450744915', 'CQ', 'HTTT', 10, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21002780', 'Anay Biswas', 'N?', to_date('1948-11-08', 'YYYY-MM-DD'), '828 Chowdhury Ganj Bellary', '+912040456316', 'CTTT', 'KHMT', 59, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21002781', 'Hrishita Sarna', 'N?', to_date('1924-08-08', 'YYYY-MM-DD'), '72 Bandi Zila Siliguri', '08010595826', 'CTTT', 'CNPM', 71, 6.27);

INSERT INTO SINHVIEN
VALUES ('SV21002782', 'Sana Amble', 'Nam', to_date('1989-10-28', 'YYYY-MM-DD'), 'H.No. 951 Grover Tinsukia', '+914619258410', 'CTTT', 'MMT', 54, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21002783', 'Akarsh Chad', 'N?', to_date('1932-09-28', 'YYYY-MM-DD'), 'H.No. 41 Sane Marg Tirupati', '6862746424', 'VP', 'CNTT', 61, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21002784', 'Hridaan Goswami', 'N?', to_date('2022-08-31', 'YYYY-MM-DD'), '39 Anne Zila Bhopal', '+916377799779', 'CQ', 'TGMT', 27, 8.42);

INSERT INTO SINHVIEN
VALUES ('SV21002785', 'Manjari Trivedi', 'N?', to_date('1991-10-06', 'YYYY-MM-DD'), '55/886 Dara Nagar Amaravati', '03762949364', 'CQ', 'MMT', 124, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21002786', 'Saksham Datta', 'Nam', to_date('1965-04-30', 'YYYY-MM-DD'), 'H.No. 42 Lanka Ganj Jaipur', '4208407955', 'CQ', 'MMT', 13, 9.56);

INSERT INTO SINHVIEN
VALUES ('SV21002787', 'Diya Verma', 'Nam', to_date('2003-11-28', 'YYYY-MM-DD'), '884 Dalal Road Malegaon', '04238476826', 'VP', 'CNTT', 40, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21002788', 'Adira Borra', 'N?', to_date('1983-10-09', 'YYYY-MM-DD'), 'H.No. 56 Bath Ganj Srinagar', '8700219571', 'CQ', 'CNTT', 132, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21002789', 'Azad Dugal', 'Nam', to_date('2021-09-16', 'YYYY-MM-DD'), 'H.No. 452 Keer Road Bettiah', '+918327401499', 'CLC', 'CNPM', 114, 7.97);

INSERT INTO SINHVIEN
VALUES ('SV21002790', 'Neysa Ganesan', 'Nam', to_date('1929-11-28', 'YYYY-MM-DD'), '207 Kala Marg Dibrugarh', '00982027075', 'VP', 'CNPM', 70, 9.83);

INSERT INTO SINHVIEN
VALUES ('SV21002791', 'Elakshi Ramesh', 'N?', to_date('1970-12-16', 'YYYY-MM-DD'), 'H.No. 851 Grover Chowk Silchar', '01916873401', 'CQ', 'CNPM', 51, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21002792', 'Vardaniya Bassi', 'N?', to_date('2021-03-14', 'YYYY-MM-DD'), '02/45 Khalsa Ganj Thrissur', '8251902207', 'CQ', 'CNPM', 47, 4.08);

INSERT INTO SINHVIEN
VALUES ('SV21002793', 'Kaira Chaudhry', 'N?', to_date('1980-08-31', 'YYYY-MM-DD'), '78/57 Baral Marg Durg', '07424485693', 'CLC', 'HTTT', 45, 4.97);

INSERT INTO SINHVIEN
VALUES ('SV21002794', 'Siya Dey', 'Nam', to_date('1999-12-23', 'YYYY-MM-DD'), '50 Gokhale Ganj Jaunpur', '1813284831', 'CQ', 'HTTT', 68, 5.92);

INSERT INTO SINHVIEN
VALUES ('SV21002795', 'Uthkarsh Shere', 'Nam', to_date('1922-07-06', 'YYYY-MM-DD'), '12/58 Kari Circle Kolkata', '+912338590778', 'CLC', 'KHMT', 2, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21002796', 'Dhanuk Saran', 'Nam', to_date('1986-06-28', 'YYYY-MM-DD'), 'H.No. 48 Sami Chowk Sikar', '+912170042762', 'VP', 'CNPM', 38, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21002797', 'Ivana Lalla', 'Nam', to_date('1989-03-04', 'YYYY-MM-DD'), '800 Thaker Path South Dumdum', '+918271365069', 'CTTT', 'CNPM', 111, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21002798', 'Emir Ghose', 'Nam', to_date('1982-02-19', 'YYYY-MM-DD'), 'H.No. 425 Kashyap Nagar Sultan Pur Majra', '5853532615', 'CLC', 'TGMT', 17, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21002799', 'Kavya Tripathi', 'Nam', to_date('1921-07-04', 'YYYY-MM-DD'), '87 Konda Ganj Adoni', '6487112692', 'CLC', 'MMT', 23, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21002800', 'Kanav Ganesh', 'N?', to_date('2023-05-21', 'YYYY-MM-DD'), '66/514 Borde Circle Begusarai', '4708459505', 'VP', 'KHMT', 72, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21002801', 'Pari Trivedi', 'Nam', to_date('1962-10-23', 'YYYY-MM-DD'), 'H.No. 698 Singhal Ghaziabad', '3404884802', 'VP', 'CNPM', 115, 5.46);

INSERT INTO SINHVIEN
VALUES ('SV21002802', 'Aarav Ramaswamy', 'Nam', to_date('1985-03-06', 'YYYY-MM-DD'), 'H.No. 919 Kant Path Morbi', '+912837354942', 'CTTT', 'HTTT', 88, 7.24);

INSERT INTO SINHVIEN
VALUES ('SV21002803', 'Lagan Chokshi', 'N?', to_date('1960-12-01', 'YYYY-MM-DD'), '962 Dass Marg Surendranagar Dudhrej', '3863191069', 'CQ', 'CNPM', 83, 4.84);

INSERT INTO SINHVIEN
VALUES ('SV21002804', 'Eva Ganesan', 'N?', to_date('1931-05-08', 'YYYY-MM-DD'), 'H.No. 75 Kadakia Chowk Bettiah', '03710898661', 'VP', 'CNPM', 133, 7.33);

INSERT INTO SINHVIEN
VALUES ('SV21002805', 'Jayan Kala', 'Nam', to_date('1998-07-08', 'YYYY-MM-DD'), '38/63 Srinivas Marg Jodhpur', '08029813201', 'CQ', 'CNTT', 43, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21002806', 'Zaina Ranganathan', 'N?', to_date('1964-05-14', 'YYYY-MM-DD'), '97/82 Ravel Sambalpur', '+918463728829', 'CLC', 'HTTT', 102, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21002807', 'Khushi Wason', 'Nam', to_date('2019-09-16', 'YYYY-MM-DD'), '82/891 Loyal Circle Bijapur', '+913266331437', 'VP', 'CNTT', 74, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21002808', 'Kartik Ravel', 'Nam', to_date('1998-07-24', 'YYYY-MM-DD'), '93 Kara Bhilai', '08870324039', 'CTTT', 'MMT', 138, 5.11);

INSERT INTO SINHVIEN
VALUES ('SV21002809', 'Jayant Kala', 'N?', to_date('1918-03-22', 'YYYY-MM-DD'), '99/52 Sastry Nagar Guna', '03477327516', 'CLC', 'CNPM', 85, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002810', 'Stuvan Konda', 'N?', to_date('1937-10-21', 'YYYY-MM-DD'), '416 Deshmukh Road Dibrugarh', '+917110835482', 'CTTT', 'CNTT', 43, 9.16);

INSERT INTO SINHVIEN
VALUES ('SV21002811', 'Tanya Jayaraman', 'N?', to_date('1962-11-07', 'YYYY-MM-DD'), '35/72 Sampath Ganj Saharsa', '+917177079384', 'CTTT', 'HTTT', 71, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21002812', 'Amira Kadakia', 'N?', to_date('1987-07-07', 'YYYY-MM-DD'), '492 Saraf Road Pudukkottai', '0312921982', 'VP', 'KHMT', 65, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21002813', 'Navya Din', 'N?', to_date('1990-12-09', 'YYYY-MM-DD'), 'H.No. 993 Mane Circle Ludhiana', '00406625828', 'CQ', 'CNPM', 94, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21002814', 'Anahita Mani', 'N?', to_date('2002-05-26', 'YYYY-MM-DD'), 'H.No. 92 Gandhi Road Bahraich', '+919174172091', 'CLC', 'MMT', 7, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21002815', 'Dhruv Sama', 'N?', to_date('1945-11-29', 'YYYY-MM-DD'), '54/270 Hayre Ganj Raurkela Industrial Township', '05302767298', 'CTTT', 'CNTT', 118, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21002816', 'Baiju Sawhney', 'N?', to_date('1989-08-04', 'YYYY-MM-DD'), 'H.No. 65 Bawa Ganj Shimla', '05455004432', 'CLC', 'HTTT', 106, 8.49);

INSERT INTO SINHVIEN
VALUES ('SV21002817', 'Ira Tandon', 'Nam', to_date('1994-05-25', 'YYYY-MM-DD'), '04 Ravel Ganj Jorhat', '3780478756', 'VP', 'KHMT', 90, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21002818', 'Neysa Madan', 'N?', to_date('1921-12-04', 'YYYY-MM-DD'), '14 Gade Path Ambala', '00659968357', 'CTTT', 'HTTT', 121, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21002819', 'Baiju Kari', 'Nam', to_date('1968-09-30', 'YYYY-MM-DD'), 'H.No. 71 Ramakrishnan Ganj Salem', '+916322277978', 'CQ', 'CNPM', 11, 5.3);

INSERT INTO SINHVIEN
VALUES ('SV21002820', 'Vihaan Devi', 'Nam', to_date('1947-06-12', 'YYYY-MM-DD'), '74/58 Gara Street Aurangabad', '1865673054', 'CTTT', 'MMT', 78, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21002821', 'Shamik Master', 'N?', to_date('1948-12-20', 'YYYY-MM-DD'), '53/248 Gole Path Phusro', '6560002030', 'CLC', 'MMT', 74, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21002822', 'Kavya Sanghvi', 'Nam', to_date('1944-11-07', 'YYYY-MM-DD'), 'H.No. 106 Deshmukh Marg Shimla', '07474889866', 'CTTT', 'HTTT', 79, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21002823', 'Bhavin Sodhi', 'N?', to_date('1929-05-03', 'YYYY-MM-DD'), 'H.No. 13 Shan Road Kalyan-Dombivli', '2741289631', 'CTTT', 'KHMT', 137, 4.2);

INSERT INTO SINHVIEN
VALUES ('SV21002824', 'Aarna Kala', 'N?', to_date('1929-07-24', 'YYYY-MM-DD'), '10/19 Gandhi Zila Alwar', '05086404876', 'CQ', 'MMT', 34, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21002825', 'Kimaya Dhingra', 'Nam', to_date('1975-02-04', 'YYYY-MM-DD'), '00/26 Thaman Street Kurnool', '+918737117471', 'VP', 'HTTT', 53, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21002826', 'Madhav Iyer', 'N?', to_date('1940-09-07', 'YYYY-MM-DD'), 'H.No. 335 Sharma Circle Tirunelveli', '+913995139944', 'CQ', 'KHMT', 64, 5.63);

INSERT INTO SINHVIEN
VALUES ('SV21002827', 'Indrajit Brar', 'Nam', to_date('1943-11-09', 'YYYY-MM-DD'), 'H.No. 78 Guha Street Miryalaguda', '3260415007', 'CTTT', 'CNTT', 5, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21002828', 'Alisha Kala', 'Nam', to_date('1954-05-22', 'YYYY-MM-DD'), 'H.No. 550 Talwar Marg Silchar', '+916819453278', 'CTTT', 'CNPM', 81, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21002829', 'Shaan Vig', 'N?', to_date('1965-06-02', 'YYYY-MM-DD'), 'H.No. 030 Wali Street Vasai-Virar', '07207665538', 'CTTT', 'HTTT', 57, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21002830', 'Elakshi Yohannan', 'N?', to_date('1987-11-08', 'YYYY-MM-DD'), '24 Vora Zila Pondicherry', '01007538725', 'CTTT', 'HTTT', 101, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21002831', 'Nishith Suri', 'Nam', to_date('1921-07-18', 'YYYY-MM-DD'), '23/756 Bajaj Circle Raurkela Industrial Township', '7411683001', 'VP', 'CNPM', 120, 7.04);

INSERT INTO SINHVIEN
VALUES ('SV21002832', 'Hridaan Sood', 'Nam', to_date('2014-02-27', 'YYYY-MM-DD'), '481 Chandra Circle Khora ', '+917645611978', 'VP', 'KHMT', 72, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21002833', 'Ranbir Chandran', 'Nam', to_date('1992-05-30', 'YYYY-MM-DD'), 'H.No. 604 Choudhary Ganj Khora ', '02972986288', 'VP', 'CNPM', 39, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21002834', 'Navya Bakshi', 'Nam', to_date('1988-05-31', 'YYYY-MM-DD'), 'H.No. 723 Banerjee Ganj Serampore', '04843676467', 'CQ', 'MMT', 96, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21002835', 'Indrajit Karpe', 'Nam', to_date('1943-11-25', 'YYYY-MM-DD'), '63 Rege Nagar Berhampore', '2223303515', 'CLC', 'KHMT', 101, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21002836', 'Lakshay Yadav', 'N?', to_date('2001-08-31', 'YYYY-MM-DD'), 'H.No. 264 Rama Chowk Amravati', '+915505970615', 'CLC', 'CNPM', 134, 9.61);

INSERT INTO SINHVIEN
VALUES ('SV21002837', 'Keya Devi', 'N?', to_date('2015-05-09', 'YYYY-MM-DD'), '943 Ganesh Street Bilaspur', '+910517649612', 'CLC', 'HTTT', 135, 8.42);

INSERT INTO SINHVIEN
VALUES ('SV21002838', 'Jayesh Dixit', 'N?', to_date('1988-12-26', 'YYYY-MM-DD'), 'H.No. 85 Gopal Road Gorakhpur', '02543062885', 'CTTT', 'KHMT', 103, 7.68);

INSERT INTO SINHVIEN
VALUES ('SV21002839', 'Shaan Sachdeva', 'Nam', to_date('1942-09-14', 'YYYY-MM-DD'), 'H.No. 23 Gandhi Ganj Vijayawada', '05048644644', 'VP', 'TGMT', 112, 6.38);

INSERT INTO SINHVIEN
VALUES ('SV21002840', 'Arnav Sen', 'N?', to_date('1958-12-01', 'YYYY-MM-DD'), '91/720 Warrior Marg Karawal Nagar', '02709298240', 'CTTT', 'HTTT', 9, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21002841', 'Yuvraj  Solanki', 'Nam', to_date('1976-06-10', 'YYYY-MM-DD'), '566 Ramakrishnan Road Udupi', '08901112306', 'VP', 'TGMT', 64, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21002842', 'Ahana  Jani', 'Nam', to_date('2022-09-26', 'YYYY-MM-DD'), '44/668 Salvi Nagar Jammu', '2090553110', 'CQ', 'HTTT', 101, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21002843', 'Armaan Kata', 'Nam', to_date('1934-09-05', 'YYYY-MM-DD'), '66 Viswanathan Meerut', '+915666805819', 'CTTT', 'CNTT', 57, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21002844', 'Kanav Sur', 'N?', to_date('2022-07-12', 'YYYY-MM-DD'), '42 Krishnan Path Medininagar', '8208163758', 'CLC', 'HTTT', 19, 6.11);

INSERT INTO SINHVIEN
VALUES ('SV21002845', 'Adira Butala', 'N?', to_date('1954-06-29', 'YYYY-MM-DD'), '27 Sarin Patna', '00495657955', 'CLC', 'KHMT', 107, 7.36);

INSERT INTO SINHVIEN
VALUES ('SV21002846', 'Anay Sachdev', 'N?', to_date('1988-05-27', 'YYYY-MM-DD'), '10/47 Chhabra Zila Sambhal', '07873784528', 'CQ', 'CNPM', 90, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21002847', 'Dharmajan Chacko', 'N?', to_date('1964-04-15', 'YYYY-MM-DD'), '04/504 Chaudhari Road Chapra', '01787520692', 'CLC', 'TGMT', 21, 5.11);

INSERT INTO SINHVIEN
VALUES ('SV21002848', 'Miraan Majumdar', 'N?', to_date('1911-01-27', 'YYYY-MM-DD'), '890 Chad Circle Belgaum', '4764387781', 'VP', 'KHMT', 45, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21002849', 'Armaan Amble', 'N?', to_date('1998-04-26', 'YYYY-MM-DD'), '86/66 Ramesh Ganj Tinsukia', '02084863307', 'CTTT', 'CNPM', 101, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21002850', 'Jayesh Sangha', 'Nam', to_date('2013-08-08', 'YYYY-MM-DD'), 'H.No. 209 Vyas Road Kolkata', '1051169573', 'CTTT', 'HTTT', 44, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21002851', 'Tushar Srivastava', 'Nam', to_date('2008-11-12', 'YYYY-MM-DD'), 'H.No. 41 Ganguly Marg Bidar', '+913186891333', 'VP', 'CNTT', 63, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21002852', 'Nirvaan Chandran', 'N?', to_date('1926-12-03', 'YYYY-MM-DD'), '854 Banik Street Durgapur', '05911006413', 'VP', 'KHMT', 130, 6.84);

INSERT INTO SINHVIEN
VALUES ('SV21002853', 'Samaira Sur', 'N?', to_date('1987-10-22', 'YYYY-MM-DD'), 'H.No. 44 Madan Nagar Kumbakonam', '8626611531', 'CTTT', 'CNTT', 65, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21002854', 'Sahil Mann', 'Nam', to_date('1953-08-05', 'YYYY-MM-DD'), '42/16 Madan Marg Bhopal', '07439047949', 'CTTT', 'HTTT', 110, 9.14);

INSERT INTO SINHVIEN
VALUES ('SV21002855', 'Zain Sidhu', 'N?', to_date('1932-07-28', 'YYYY-MM-DD'), 'H.No. 37 Gandhi Zila Dhule', '06090657401', 'CQ', 'HTTT', 14, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21002856', 'Oorja Khanna', 'Nam', to_date('1921-11-30', 'YYYY-MM-DD'), '869 Sehgal Street Moradabad', '+917773957883', 'CQ', 'TGMT', 32, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002857', 'Renee Kala', 'N?', to_date('1983-02-09', 'YYYY-MM-DD'), '21/584 Sule Marg Amravati', '+917483133309', 'CLC', 'CNTT', 104, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21002858', 'Onkar Choudhury', 'Nam', to_date('1935-09-16', 'YYYY-MM-DD'), 'H.No. 241 Kapadia Nagar Machilipatnam', '+912717251820', 'CTTT', 'MMT', 121, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21002859', 'Aayush Sur', 'Nam', to_date('1966-09-28', 'YYYY-MM-DD'), 'H.No. 281 Malhotra Road Gandhidham', '05817975175', 'CLC', 'MMT', 84, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21002860', 'Farhan Wadhwa', 'N?', to_date('2011-04-11', 'YYYY-MM-DD'), '235 Dhar Ganj Meerut', '02874289654', 'CLC', 'CNPM', 67, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21002861', 'Zara Sama', 'Nam', to_date('1974-01-31', 'YYYY-MM-DD'), 'H.No. 735 Barad Chowk Katihar', '04116942013', 'CQ', 'KHMT', 22, 7.19);

INSERT INTO SINHVIEN
VALUES ('SV21002862', 'Bhavin Reddy', 'Nam', to_date('1967-12-17', 'YYYY-MM-DD'), '95/716 Dyal Rohtak', '6952706631', 'CLC', 'MMT', 109, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21002863', 'Miraan Sarkar', 'Nam', to_date('1982-01-27', 'YYYY-MM-DD'), '608 Bala Zila Kirari Suleman Nagar', '02783533057', 'CTTT', 'CNPM', 119, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21002864', 'Arnav Borde', 'Nam', to_date('1952-11-06', 'YYYY-MM-DD'), 'H.No. 54 Bala Circle Eluru', '8543654622', 'CTTT', 'KHMT', 101, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21002865', 'Kimaya Sodhi', 'Nam', to_date('1936-10-03', 'YYYY-MM-DD'), '65/899 Soman Path Tirunelveli', '5446463966', 'VP', 'HTTT', 113, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21002866', 'Alia Agate', 'Nam', to_date('1979-12-11', 'YYYY-MM-DD'), '87 Varghese Path Motihari', '6797680900', 'CTTT', 'CNTT', 24, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21002867', 'Dharmajan Loke', 'Nam', to_date('1994-01-07', 'YYYY-MM-DD'), '35/29 Dhar Path Darbhanga', '+911231989485', 'VP', 'TGMT', 102, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21002868', 'Nirvi Sahota', 'N?', to_date('1957-08-25', 'YYYY-MM-DD'), 'H.No. 459 Dey Ganj Nanded', '06782609235', 'CQ', 'KHMT', 114, 9.56);

INSERT INTO SINHVIEN
VALUES ('SV21002869', 'Dharmajan Kant', 'N?', to_date('1983-09-02', 'YYYY-MM-DD'), '73 Luthra Chowk Sagar', '08568852565', 'CTTT', 'TGMT', 49, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21002870', 'Jayant Jayaraman', 'Nam', to_date('1914-03-06', 'YYYY-MM-DD'), '95 Majumdar Chowk Fatehpur', '+913631030484', 'VP', 'MMT', 41, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21002871', 'Vivaan Saha', 'N?', to_date('1939-11-13', 'YYYY-MM-DD'), '64/55 Goswami Zila Hazaribagh', '6230070303', 'CTTT', 'TGMT', 105, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21002872', 'Shlok Banerjee', 'Nam', to_date('1946-08-31', 'YYYY-MM-DD'), '68/03 Kuruvilla Street Tadipatri', '5241376923', 'CQ', 'CNPM', 110, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21002873', 'Jiya Banerjee', 'N?', to_date('1982-06-17', 'YYYY-MM-DD'), '10 Ray Ganj Panchkula', '03367591162', 'VP', 'KHMT', 47, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21002874', 'Kanav Manda', 'Nam', to_date('1928-11-03', 'YYYY-MM-DD'), '497 Subramaniam Chowk Thrissur', '08742241767', 'CQ', 'CNTT', 129, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21002875', 'Pihu Keer', 'N?', to_date('1909-12-05', 'YYYY-MM-DD'), 'H.No. 18 Jayaraman Ganj Moradabad', '01269269803', 'CTTT', 'CNPM', 94, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21002876', 'Divyansh Viswanathan', 'N?', to_date('2007-01-22', 'YYYY-MM-DD'), 'H.No. 056 Sarin Chowk Firozabad', '+910324091226', 'VP', 'TGMT', 111, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21002877', 'Ivan Kala', 'N?', to_date('1998-06-21', 'YYYY-MM-DD'), '65/576 Sabharwal Ganj Motihari', '8944384467', 'VP', 'CNPM', 58, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002878', 'Seher Johal', 'N?', to_date('1981-04-28', 'YYYY-MM-DD'), '189 Cheema Road Karimnagar', '+910910121875', 'CTTT', 'MMT', 90, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21002879', 'Zara Gole', 'N?', to_date('1935-01-15', 'YYYY-MM-DD'), '26/99 Baral Road Sri Ganganagar', '3856434281', 'CTTT', 'TGMT', 26, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21002880', 'Gokul Dasgupta', 'Nam', to_date('1985-08-28', 'YYYY-MM-DD'), '12/951 Shan Marg Guntur', '00838783339', 'VP', 'CNTT', 65, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21002881', 'Yuvraj  Bala', 'Nam', to_date('2004-03-29', 'YYYY-MM-DD'), '04/95 Gupta Chowk Jaunpur', '+917737935051', 'CQ', 'CNTT', 104, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21002882', 'Vritika Lad', 'N?', to_date('1988-02-26', 'YYYY-MM-DD'), 'H.No. 437 Chhabra Marg Anantapuram', '5636323694', 'CTTT', 'TGMT', 61, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21002883', 'Onkar Sekhon', 'Nam', to_date('1986-11-11', 'YYYY-MM-DD'), 'H.No. 415 Sridhar Zila Thrissur', '05080970484', 'VP', 'CNTT', 127, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21002884', 'Suhana Mann', 'N?', to_date('1985-12-07', 'YYYY-MM-DD'), '95 Ramakrishnan Circle Uluberia', '+913965459247', 'CQ', 'TGMT', 29, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21002885', 'Suhana Venkataraman', 'N?', to_date('1984-08-20', 'YYYY-MM-DD'), '34/70 Chaudhry Nagar Hospet', '+910571745790', 'CLC', 'KHMT', 55, 4.52);

INSERT INTO SINHVIEN
VALUES ('SV21002886', 'Samiha Dar', 'N?', to_date('1983-12-24', 'YYYY-MM-DD'), '90 Saraf Ganj Jalgaon', '+919994332954', 'CTTT', 'KHMT', 101, 4.31);

INSERT INTO SINHVIEN
VALUES ('SV21002887', 'Rohan Dar', 'Nam', to_date('1996-01-08', 'YYYY-MM-DD'), 'H.No. 25 Bajaj Street Delhi', '7580215728', 'CTTT', 'KHMT', 121, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21002888', 'Lavanya Deep', 'N?', to_date('1999-07-10', 'YYYY-MM-DD'), '27/32 Kade Marg Karimnagar', '+911779491450', 'CLC', 'TGMT', 79, 7.99);

INSERT INTO SINHVIEN
VALUES ('SV21002889', 'Nishith Kothari', 'Nam', to_date('1970-12-09', 'YYYY-MM-DD'), '10 Sinha Pune', '+914967361244', 'CQ', 'HTTT', 66, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21002890', 'Hiran Tak', 'N?', to_date('1944-09-01', 'YYYY-MM-DD'), '13 Mann Siliguri', '08404809596', 'VP', 'CNTT', 61, 5.77);

INSERT INTO SINHVIEN
VALUES ('SV21002891', 'Himmat Vaidya', 'N?', to_date('1977-01-29', 'YYYY-MM-DD'), 'H.No. 30 Varty Circle Firozabad', '00356967811', 'CLC', 'CNPM', 137, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21002892', 'Aaina Gopal', 'N?', to_date('2003-09-25', 'YYYY-MM-DD'), '458 Kumer Chowk Saharsa', '4914303626', 'VP', 'CNTT', 135, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21002893', 'Urvi Basu', 'N?', to_date('2022-06-23', 'YYYY-MM-DD'), 'H.No. 301 Upadhyay Street Navi Mumbai', '00236619372', 'VP', 'CNPM', 23, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21002894', 'Emir Gara', 'Nam', to_date('1997-04-22', 'YYYY-MM-DD'), '79/005 Ramanathan Ganj Bhavnagar', '+912735525177', 'CQ', 'MMT', 117, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21002895', 'Vihaan Keer', 'Nam', to_date('1914-03-17', 'YYYY-MM-DD'), '29/375 Barad Chowk Hapur', '00816320680', 'CTTT', 'CNPM', 51, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21002896', 'Samaira Bora', 'Nam', to_date('1909-11-08', 'YYYY-MM-DD'), '20/52 Sankaran Marg Kollam', '0303976162', 'VP', 'HTTT', 72, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21002897', 'Kismat Bansal', 'Nam', to_date('1985-06-30', 'YYYY-MM-DD'), '62 Borra Marg Madhyamgram', '+915301764698', 'CLC', 'CNPM', 111, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21002898', 'Kartik Rastogi', 'N?', to_date('1962-09-27', 'YYYY-MM-DD'), '50/728 Hans Circle Kulti', '+919332227436', 'CLC', 'KHMT', 40, 7.31);

INSERT INTO SINHVIEN
VALUES ('SV21002899', 'Badal Dara', 'N?', to_date('1949-10-04', 'YYYY-MM-DD'), '353 Sangha Road Silchar', '09853581702', 'VP', 'CNPM', 83, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21002900', 'Lavanya Kant', 'Nam', to_date('1970-09-25', 'YYYY-MM-DD'), '427 Shroff Jamalpur', '01473899486', 'CQ', 'HTTT', 113, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21002901', 'Diya Sura', 'N?', to_date('1930-12-01', 'YYYY-MM-DD'), '13/630 Ramachandran Circle Pallavaram', '+914935391200', 'VP', 'KHMT', 90, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21002902', 'Gokul Koshy', 'N?', to_date('1929-06-30', 'YYYY-MM-DD'), 'H.No. 107 Kapoor Street Dehri', '+911336046829', 'VP', 'HTTT', 17, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21002903', 'Aaryahi Bose', 'N?', to_date('1921-05-13', 'YYYY-MM-DD'), 'H.No. 825 Bala Zila Kota', '02713809476', 'VP', 'CNTT', 67, 7.19);

INSERT INTO SINHVIEN
VALUES ('SV21002904', 'Raghav Kibe', 'N?', to_date('1912-12-21', 'YYYY-MM-DD'), '62/179 Chaudhari Path Mango', '3181906235', 'CLC', 'TGMT', 124, 6.89);

INSERT INTO SINHVIEN
VALUES ('SV21002905', 'Heer Chand', 'Nam', to_date('1959-12-28', 'YYYY-MM-DD'), '068 Gandhi Road Maheshtala', '3091232933', 'CTTT', 'MMT', 124, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21002906', 'Samar Bhardwaj', 'N?', to_date('1916-12-11', 'YYYY-MM-DD'), '55/344 Borde Road Unnao', '+917963461769', 'CLC', 'CNTT', 53, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21002907', 'Romil Samra', 'N?', to_date('1972-10-17', 'YYYY-MM-DD'), '13 Chandran Circle Srikakulam', '07286097962', 'CTTT', 'CNTT', 126, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21002908', 'Divij Kata', 'N?', to_date('1998-04-04', 'YYYY-MM-DD'), 'H.No. 07 Batra Chowk Kanpur', '06427272626', 'CLC', 'KHMT', 128, 7.35);

INSERT INTO SINHVIEN
VALUES ('SV21002909', 'Alia Chaudhry', 'Nam', to_date('1915-04-23', 'YYYY-MM-DD'), '17/821 Sule Ganj Hyderabad', '+919265431339', 'CLC', 'HTTT', 42, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21002910', 'Navya Tak', 'N?', to_date('1933-03-15', 'YYYY-MM-DD'), 'H.No. 83 Kale Zila Patna', '+916236679438', 'VP', 'CNTT', 26, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21002911', 'Devansh Sanghvi', 'N?', to_date('2009-11-05', 'YYYY-MM-DD'), '62/558 Hans Bijapur', '02906780838', 'CQ', 'CNTT', 64, 8.58);

INSERT INTO SINHVIEN
VALUES ('SV21002912', 'Tiya Hans', 'N?', to_date('2021-05-17', 'YYYY-MM-DD'), '242 Bansal Zila Kalyan-Dombivli', '8546223957', 'VP', 'MMT', 42, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21002913', 'Saanvi Bakshi', 'Nam', to_date('2002-01-01', 'YYYY-MM-DD'), 'H.No. 37 Jayaraman Road Phagwara', '+914971842621', 'VP', 'CNTT', 80, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21002914', 'Kanav Sarna', 'Nam', to_date('1980-04-24', 'YYYY-MM-DD'), 'H.No. 822 Aggarwal Chowk Bhusawal', '+913625119299', 'VP', 'TGMT', 9, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21002915', 'Reyansh Walia', 'N?', to_date('1926-09-22', 'YYYY-MM-DD'), '45 Rattan Circle Jaunpur', '04236310718', 'CTTT', 'KHMT', 85, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21002916', 'Nehmat Bumb', 'N?', to_date('1990-04-22', 'YYYY-MM-DD'), 'H.No. 238 Varty Marg Ballia', '02690139580', 'CLC', 'MMT', 47, 8.28);

INSERT INTO SINHVIEN
VALUES ('SV21002917', 'Tara Dua', 'Nam', to_date('1965-08-12', 'YYYY-MM-DD'), '72 Gaba Street Khandwa', '2553137921', 'CTTT', 'CNTT', 54, 8.42);

INSERT INTO SINHVIEN
VALUES ('SV21002918', 'Misha Dora', 'Nam', to_date('1982-12-25', 'YYYY-MM-DD'), '684 Madan Nagar Davanagere', '5464413030', 'VP', 'KHMT', 16, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21002919', 'Prerak Baral', 'Nam', to_date('2015-02-25', 'YYYY-MM-DD'), 'H.No. 296 Sandal Ganj Akola', '05013529289', 'CLC', 'HTTT', 20, 9.37);

INSERT INTO SINHVIEN
VALUES ('SV21002920', 'Indrans Biswas', 'N?', to_date('1983-12-05', 'YYYY-MM-DD'), '37/27 Bala Yamunanagar', '06093601218', 'CTTT', 'TGMT', 17, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21002921', 'Saanvi Badal', 'N?', to_date('1914-12-28', 'YYYY-MM-DD'), '89/552 Barad Nagar Patna', '04322564737', 'CTTT', 'CNTT', 115, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21002922', 'Shalv Chaudhry', 'N?', to_date('1985-03-31', 'YYYY-MM-DD'), '86/441 Rama Nagar Uluberia', '0672987797', 'CQ', 'HTTT', 5, 8.02);

INSERT INTO SINHVIEN
VALUES ('SV21002923', 'Lakshit Choudhry', 'Nam', to_date('1972-01-27', 'YYYY-MM-DD'), '66/263 Bhatnagar Zila Nanded', '+916707309554', 'CTTT', 'MMT', 73, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21002924', 'Jayesh Mand', 'Nam', to_date('2003-01-30', 'YYYY-MM-DD'), 'H.No. 57 Guha Marg Muzaffarnagar', '01387225011', 'CTTT', 'HTTT', 30, 8.15);

INSERT INTO SINHVIEN
VALUES ('SV21002925', 'Zeeshan Khalsa', 'Nam', to_date('1951-09-12', 'YYYY-MM-DD'), '13 Bhargava Nagar Hospet', '+911685750992', 'CQ', 'KHMT', 40, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21002926', 'Nitara Dara', 'Nam', to_date('1992-11-02', 'YYYY-MM-DD'), '82/531 Ranganathan Bhiwani', '4149073540', 'CQ', 'CNPM', 126, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21002927', 'Drishya Dutt', 'N?', to_date('2016-07-01', 'YYYY-MM-DD'), '179 Dyal Chowk Raebareli', '8066148478', 'CTTT', 'HTTT', 104, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21002928', 'Bhamini Mani', 'N?', to_date('1939-06-22', 'YYYY-MM-DD'), '03/424 Andra Circle Latur', '6158934161', 'CQ', 'HTTT', 9, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21002929', 'Nayantara Devi', 'Nam', to_date('1990-07-21', 'YYYY-MM-DD'), 'H.No. 01 Chowdhury Nagar Madhyamgram', '+912227917420', 'CQ', 'CNPM', 90, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21002930', 'Mahika Ram', 'N?', to_date('1935-03-01', 'YYYY-MM-DD'), '59 Dar Ganj Nanded', '6439195310', 'CLC', 'CNPM', 126, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21002931', 'Ishaan Som', 'Nam', to_date('1915-08-26', 'YYYY-MM-DD'), 'H.No. 531 Raja Ganj Delhi', '+918678784615', 'CQ', 'CNTT', 131, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21002932', 'Miraan Sachdev', 'Nam', to_date('1942-03-12', 'YYYY-MM-DD'), '445 Balan Rewa', '00531335928', 'CLC', 'HTTT', 16, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21002933', 'Nitya Bala', 'N?', to_date('1937-08-17', 'YYYY-MM-DD'), '42 Khalsa Path Bhubaneswar', '03202765139', 'VP', 'CNTT', 95, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21002934', 'Mahika Deep', 'N?', to_date('1988-03-05', 'YYYY-MM-DD'), '13/78 Seth Nagar Vellore', '4637114320', 'VP', 'CNTT', 74, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21002935', 'Vedika Mani', 'Nam', to_date('1947-09-30', 'YYYY-MM-DD'), 'H.No. 74 Som Circle Ahmednagar', '08287843532', 'CTTT', 'HTTT', 58, 6.13);

INSERT INTO SINHVIEN
VALUES ('SV21002936', 'Jiya Chander', 'N?', to_date('1925-10-03', 'YYYY-MM-DD'), '64/46 Dugar Ganj Tirunelveli', '1107857293', 'CTTT', 'CNTT', 46, 4.34);

INSERT INTO SINHVIEN
VALUES ('SV21002937', 'Rasha Vasa', 'Nam', to_date('1934-06-03', 'YYYY-MM-DD'), '006 Raj Nagar Muzaffarpur', '04746046899', 'VP', 'HTTT', 49, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21002938', 'Shanaya Shanker', 'N?', to_date('1951-12-16', 'YYYY-MM-DD'), '77 Chandra Path Howrah', '+916422614576', 'CQ', 'CNPM', 15, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21002939', 'Vanya Kara', 'Nam', to_date('1929-11-24', 'YYYY-MM-DD'), '04 Kurian Zila Allahabad', '+910408805233', 'VP', 'CNTT', 122, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21002940', 'Navya Chaudry', 'Nam', to_date('2023-06-11', 'YYYY-MM-DD'), '44/949 Shroff Marg Rajpur Sonarpur', '08701541467', 'CLC', 'KHMT', 27, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21002941', 'Kiaan Shukla', 'Nam', to_date('2010-02-27', 'YYYY-MM-DD'), '86/02 Kapoor Circle Pimpri-Chinchwad', '+918763608931', 'CTTT', 'CNTT', 135, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21002942', 'Dhanuk Goyal', 'Nam', to_date('1965-10-17', 'YYYY-MM-DD'), 'H.No. 72 Mani Ganj Thrissur', '7661389509', 'VP', 'MMT', 82, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21002943', 'Aniruddh Amble', 'Nam', to_date('1998-01-09', 'YYYY-MM-DD'), 'H.No. 720 Rajagopalan Road Shahjahanpur', '+915254325915', 'VP', 'TGMT', 37, 4.93);

INSERT INTO SINHVIEN
VALUES ('SV21002944', 'Vardaniya Kalita', 'N?', to_date('1935-05-16', 'YYYY-MM-DD'), '45/644 Sagar Street Pondicherry', '1528333783', 'CQ', 'CNPM', 38, 9.24);

INSERT INTO SINHVIEN
VALUES ('SV21002945', 'Ela Iyer', 'Nam', to_date('1976-06-18', 'YYYY-MM-DD'), '33/455 Bobal Thanjavur', '05872159919', 'CTTT', 'CNPM', 56, 4.48);

INSERT INTO SINHVIEN
VALUES ('SV21002946', 'Eshani Sandhu', 'Nam', to_date('2022-06-29', 'YYYY-MM-DD'), 'H.No. 882 Rao Street Tirupati', '00747141689', 'CLC', 'CNTT', 64, 8.29);

INSERT INTO SINHVIEN
VALUES ('SV21002947', 'Gokul Sama', 'N?', to_date('1917-05-28', 'YYYY-MM-DD'), 'H.No. 939 Bhakta Ganj Latur', '8964880923', 'CQ', 'HTTT', 113, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21002948', 'Rhea Divan', 'N?', to_date('1937-01-24', 'YYYY-MM-DD'), '00/14 Subramaniam Ganj Madanapalle', '00423953408', 'CQ', 'TGMT', 56, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21002949', 'Inaaya  Chaudhari', 'Nam', to_date('1973-11-24', 'YYYY-MM-DD'), '21/514 Sankaran Chowk Berhampur', '04525855609', 'CLC', 'TGMT', 47, 8.55);

INSERT INTO SINHVIEN
VALUES ('SV21002950', 'Seher Sharaf', 'Nam', to_date('1977-11-24', 'YYYY-MM-DD'), 'H.No. 287 Dora Zila Kota', '+911546619661', 'VP', 'TGMT', 100, 7.35);

INSERT INTO SINHVIEN
VALUES ('SV21002951', 'Navya Kalita', 'Nam', to_date('1991-06-08', 'YYYY-MM-DD'), 'H.No. 19 Borah Ganj Hubli�CDharwad', '7680945718', 'VP', 'MMT', 119, 6.58);

INSERT INTO SINHVIEN
VALUES ('SV21002952', 'Rania Sarna', 'N?', to_date('1994-10-02', 'YYYY-MM-DD'), 'H.No. 468 Vaidya Street Aizawl', '06310463527', 'VP', 'MMT', 31, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21002953', 'Riaan Kannan', 'N?', to_date('1980-03-20', 'YYYY-MM-DD'), '05/416 Salvi Path Panipat', '02674175563', 'VP', 'MMT', 41, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21002954', 'Rati Rout', 'N?', to_date('1921-12-07', 'YYYY-MM-DD'), 'H.No. 734 Basu Street Darbhanga', '8436093954', 'CLC', 'HTTT', 38, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21002955', 'Bhamini Solanki', 'Nam', to_date('1997-01-15', 'YYYY-MM-DD'), '24 Ghosh Ganj Raichur', '06705733377', 'CTTT', 'CNPM', 10, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21002956', 'Veer Rattan', 'N?', to_date('1964-10-26', 'YYYY-MM-DD'), 'H.No. 97 Shukla Street Bhilwara', '6617509686', 'VP', 'CNPM', 15, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21002957', 'Arhaan Thaker', 'N?', to_date('1973-09-19', 'YYYY-MM-DD'), '279 Ratta Chowk Eluru', '0894028949', 'CTTT', 'CNPM', 58, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21002958', 'Ehsaan Khurana', 'Nam', to_date('1984-01-27', 'YYYY-MM-DD'), '577 Khurana Nagar Gwalior', '00776140537', 'CTTT', 'HTTT', 38, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21002959', 'Aarna Sen', 'N?', to_date('2021-08-07', 'YYYY-MM-DD'), 'H.No. 90 Bhalla Nagar Dindigul', '7341437007', 'CLC', 'KHMT', 122, 4.67);

INSERT INTO SINHVIEN
VALUES ('SV21002960', 'Sahil Divan', 'Nam', to_date('1923-01-20', 'YYYY-MM-DD'), 'H.No. 68 Banik Circle Bihar Sharif', '+919875916910', 'CQ', 'CNPM', 137, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21002961', 'Diya Handa', 'Nam', to_date('1919-07-21', 'YYYY-MM-DD'), 'H.No. 577 Barman Marg Ujjain', '02796845857', 'CQ', 'MMT', 89, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21002962', 'Rati Dutt', 'N?', to_date('2020-05-13', 'YYYY-MM-DD'), 'H.No. 102 Varty Vasai-Virar', '06130386124', 'CQ', 'MMT', 105, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21002963', 'Yakshit Chaudhry', 'Nam', to_date('1935-06-16', 'YYYY-MM-DD'), 'H.No. 14 Devan Chowk Parbhani', '00751115305', 'CTTT', 'MMT', 120, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21002964', 'Navya Bhalla', 'Nam', to_date('2013-08-01', 'YYYY-MM-DD'), 'H.No. 341 Shankar Kumbakonam', '7214255770', 'CTTT', 'MMT', 39, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21002965', 'Aaryahi Mann', 'Nam', to_date('1939-03-26', 'YYYY-MM-DD'), '21 Cherian Marg Jhansi', '8037451449', 'CLC', 'HTTT', 52, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21002966', 'Lagan Lala', 'Nam', to_date('1986-10-12', 'YYYY-MM-DD'), '68 Din Nagar Cuttack', '0400680192', 'CTTT', 'KHMT', 40, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21002967', 'Kavya Basak', 'Nam', to_date('1917-10-03', 'YYYY-MM-DD'), 'H.No. 84 Saini Ganj Ichalkaranji', '03492710565', 'VP', 'CNTT', 117, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21002968', 'Onkar Sachdev', 'Nam', to_date('1944-10-31', 'YYYY-MM-DD'), '27/02 Chatterjee Nagar Deoghar', '7014824317', 'VP', 'KHMT', 16, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21002969', 'Priyansh Thakur', 'N?', to_date('1962-06-06', 'YYYY-MM-DD'), '52 Mahajan Ganj Madhyamgram', '+913710840902', 'VP', 'KHMT', 56, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21002970', 'Lavanya Kapur', 'Nam', to_date('1940-03-15', 'YYYY-MM-DD'), '756 Sampath Ganj Machilipatnam', '01293570859', 'CQ', 'CNPM', 23, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21002971', 'Priyansh Bhagat', 'N?', to_date('1972-09-18', 'YYYY-MM-DD'), 'H.No. 010 Issac Chowk Bhatpara', '0842453364', 'CLC', 'HTTT', 55, 7.69);

INSERT INTO SINHVIEN
VALUES ('SV21002972', 'Anay Kadakia', 'Nam', to_date('1980-01-07', 'YYYY-MM-DD'), 'H.No. 307 Agate Bidar', '4052273425', 'CQ', 'CNTT', 120, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21002973', 'Ritvik Arya', 'Nam', to_date('1914-08-15', 'YYYY-MM-DD'), 'H.No. 43 Bhavsar Zila Amaravati', '2829078140', 'VP', 'MMT', 95, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21002974', 'Drishya Iyengar', 'N?', to_date('1976-01-14', 'YYYY-MM-DD'), '49 Chawla Street Shimla', '04951131190', 'CTTT', 'KHMT', 41, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21002975', 'Shlok Sahni', 'Nam', to_date('1979-06-21', 'YYYY-MM-DD'), 'H.No. 48 Ram Zila Rourkela', '01620010950', 'VP', 'CNPM', 84, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21002976', 'Romil Basak', 'Nam', to_date('1914-07-21', 'YYYY-MM-DD'), '82 Randhawa Erode', '9266834589', 'CQ', 'MMT', 1, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21002977', 'Vidur Karpe', 'N?', to_date('1963-11-16', 'YYYY-MM-DD'), 'H.No. 41 Bhatti Thoothukudi', '4738923213', 'CQ', 'KHMT', 112, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21002978', 'Anya Agarwal', 'N?', to_date('1957-03-18', 'YYYY-MM-DD'), '96/44 Koshy Street Bulandshahr', '3235893779', 'CTTT', 'KHMT', 55, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21002979', 'Zain Golla', 'N?', to_date('1976-07-16', 'YYYY-MM-DD'), '329 Sami Circle Avadi', '2060750557', 'CQ', 'MMT', 22, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21002980', 'Krish Brar', 'Nam', to_date('1995-03-16', 'YYYY-MM-DD'), '73 Bal Sultan Pur Majra', '05299693697', 'CLC', 'HTTT', 38, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21002981', 'Hunar Sunder', 'N?', to_date('1966-06-20', 'YYYY-MM-DD'), 'H.No. 88 Viswanathan Street Howrah', '+919240657735', 'CQ', 'MMT', 26, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21002982', 'Kimaya Bava', 'Nam', to_date('1940-09-19', 'YYYY-MM-DD'), 'H.No. 868 Vyas Nagar Jhansi', '9183537546', 'VP', 'CNPM', 74, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21002983', 'Lagan Johal', 'Nam', to_date('1934-08-10', 'YYYY-MM-DD'), '57 Kuruvilla Path Burhanpur', '8857829492', 'CQ', 'TGMT', 14, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21002984', 'Divit Ratti', 'N?', to_date('1985-07-27', 'YYYY-MM-DD'), '301 Devi Zila Udupi', '04028958127', 'CQ', 'MMT', 98, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21002985', 'Vivaan Biswas', 'N?', to_date('1994-10-21', 'YYYY-MM-DD'), '75/05 Lad Path Tirunelveli', '09976758830', 'VP', 'CNPM', 135, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21002986', 'Arhaan Shankar', 'N?', to_date('1975-06-05', 'YYYY-MM-DD'), '05 Sane Bilaspur', '07684421964', 'CTTT', 'MMT', 89, 5.21);

INSERT INTO SINHVIEN
VALUES ('SV21002987', 'Divit Krish', 'Nam', to_date('1909-03-16', 'YYYY-MM-DD'), 'H.No. 960 Sani Marg Thrissur', '5432184536', 'VP', 'CNTT', 81, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21002988', 'Sumer Mani', 'N?', to_date('1936-11-20', 'YYYY-MM-DD'), 'H.No. 324 Chawla Nagar Silchar', '+910236912734', 'VP', 'TGMT', 124, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21002989', 'Armaan Lad', 'N?', to_date('1933-06-16', 'YYYY-MM-DD'), 'H.No. 51 Bail Road Vadodara', '2429441362', 'CLC', 'MMT', 135, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21002990', 'Anahi Thaman', 'Nam', to_date('1996-06-26', 'YYYY-MM-DD'), '253 Chaudhuri Path Korba', '+913407953358', 'CQ', 'HTTT', 14, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21002991', 'Yuvaan Krish', 'Nam', to_date('1939-02-01', 'YYYY-MM-DD'), '82 Brahmbhatt Path Thiruvananthapuram', '06708628515', 'CLC', 'HTTT', 85, 6.41);

INSERT INTO SINHVIEN
VALUES ('SV21002992', 'Prerak Sinha', 'Nam', to_date('1999-09-30', 'YYYY-MM-DD'), 'H.No. 00 Bhavsar Chowk Shimoga', '+910930671670', 'CQ', 'TGMT', 137, 4.67);

INSERT INTO SINHVIEN
VALUES ('SV21002993', 'Tara Bassi', 'Nam', to_date('1914-12-20', 'YYYY-MM-DD'), '51/522 Sengupta Circle Satna', '06321494837', 'CLC', 'HTTT', 27, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21002994', 'Samarth Saha', 'Nam', to_date('1962-07-11', 'YYYY-MM-DD'), 'H.No. 875 Bhatt Marg Ranchi', '9814093904', 'CLC', 'MMT', 115, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21002995', 'Biju Kakar', 'Nam', to_date('1972-11-11', 'YYYY-MM-DD'), '55 Goda Marg Kulti', '05782667923', 'CQ', 'HTTT', 30, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21002996', 'Aayush Dar', 'N?', to_date('1927-03-22', 'YYYY-MM-DD'), 'H.No. 384 Kaur Path Sangli-Miraj', '2746436660', 'CQ', 'HTTT', 89, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21002997', 'Dhruv Dalal', 'N?', to_date('1973-09-08', 'YYYY-MM-DD'), 'H.No. 45 Sant Circle Arrah', '4724698984', 'CLC', 'HTTT', 127, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21002998', 'Siya Dugal', 'Nam', to_date('2000-03-07', 'YYYY-MM-DD'), '28 Ramachandran Chowk Bhagalpur', '00856392041', 'CQ', 'CNPM', 87, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21002999', 'Tara Dar', 'Nam', to_date('1968-10-25', 'YYYY-MM-DD'), '94/770 Kurian Road Hindupur', '02016177702', 'CTTT', 'HTTT', 101, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21003000', 'Biju Sura', 'Nam', to_date('1942-06-20', 'YYYY-MM-DD'), '203 Kadakia Circle Thoothukudi', '+913821072716', 'CTTT', 'MMT', 112, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21003001', 'Aarav Kapur', 'N?', to_date('1989-01-09', 'YYYY-MM-DD'), '23/995 Kale Howrah', '04691779715', 'VP', 'MMT', 124, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21003002', 'Shaan Ghose', 'Nam', to_date('2015-02-20', 'YYYY-MM-DD'), '40/835 Kalita Marg Ahmednagar', '+919605995481', 'CQ', 'MMT', 33, 8.91);

INSERT INTO SINHVIEN
VALUES ('SV21003003', 'Tejas Sarna', 'N?', to_date('2006-03-29', 'YYYY-MM-DD'), '15/702 Chatterjee Road Madurai', '+916034520425', 'CQ', 'CNPM', 34, 8.54);

INSERT INTO SINHVIEN
VALUES ('SV21003004', 'Pari Gandhi', 'N?', to_date('1940-04-28', 'YYYY-MM-DD'), '72/13 Gade Katni', '6116428405', 'CLC', 'HTTT', 115, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21003005', 'Manikya Krish', 'N?', to_date('1941-06-08', 'YYYY-MM-DD'), '80/775 Savant Chowk Dibrugarh', '01430026463', 'VP', 'HTTT', 50, 9.64);

INSERT INTO SINHVIEN
VALUES ('SV21003006', 'Dhruv Bhatia', 'N?', to_date('1959-12-25', 'YYYY-MM-DD'), 'H.No. 34 Divan Baranagar', '+917805495522', 'VP', 'MMT', 39, 5.59);

INSERT INTO SINHVIEN
VALUES ('SV21003007', 'Tanya Sachdev', 'Nam', to_date('1937-06-12', 'YYYY-MM-DD'), '30 Krishnamurthy Tenali', '6514165136', 'CTTT', 'MMT', 37, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21003008', 'Zara Chakraborty', 'Nam', to_date('1992-01-11', 'YYYY-MM-DD'), '11/171 Jhaveri Circle Tumkur', '5751773482', 'VP', 'MMT', 129, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21003009', 'Keya Mangat', 'N?', to_date('1968-12-29', 'YYYY-MM-DD'), '72/063 Wali Circle Chinsurah', '+911083747727', 'CQ', 'CNTT', 13, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003010', 'Divij Dua', 'Nam', to_date('1964-01-28', 'YYYY-MM-DD'), '417 Krishnamurthy Ganj Katni', '00708527379', 'CTTT', 'CNPM', 72, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21003011', 'Anvi Choudhury', 'Nam', to_date('1957-02-03', 'YYYY-MM-DD'), '754 Bhatti Chowk Khandwa', '2936682420', 'CLC', 'MMT', 4, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21003012', 'Dhanuk Krish', 'Nam', to_date('1967-05-31', 'YYYY-MM-DD'), '850 Dixit Korba', '04829599237', 'CTTT', 'TGMT', 64, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21003013', 'Anika Dugar', 'Nam', to_date('1935-03-25', 'YYYY-MM-DD'), '27 Swaminathan Circle Allahabad', '09628052432', 'VP', 'CNTT', 137, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21003014', 'Myra Vohra', 'Nam', to_date('1939-06-04', 'YYYY-MM-DD'), '27 Banerjee Marg Tiruppur', '04115485412', 'CTTT', 'KHMT', 27, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21003015', 'Badal Jha', 'Nam', to_date('2011-01-29', 'YYYY-MM-DD'), '201 Mammen Nagar Jamshedpur', '4552776451', 'CLC', 'CNTT', 59, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21003016', 'Arnav Rajan', 'Nam', to_date('1961-02-21', 'YYYY-MM-DD'), 'H.No. 191 Bora Nagar Malegaon', '6358987530', 'CQ', 'KHMT', 110, 6.72);

INSERT INTO SINHVIEN
VALUES ('SV21003017', 'Nirvaan Sachar', 'N?', to_date('1998-04-03', 'YYYY-MM-DD'), '89 Vyas Circle Ratlam', '+918500908856', 'CTTT', 'KHMT', 37, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21003018', 'Ira Bawa', 'Nam', to_date('1959-07-08', 'YYYY-MM-DD'), '010 Mand Bangalore', '00103435518', 'CTTT', 'CNTT', 35, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21003019', 'Krish Reddy', 'Nam', to_date('1954-09-01', 'YYYY-MM-DD'), '21/35 Ratta Dhanbad', '05194462946', 'CQ', 'MMT', 131, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21003020', 'Ishita Hayer', 'N?', to_date('1920-03-04', 'YYYY-MM-DD'), '79 Kuruvilla Marg Alwar', '07414496306', 'CTTT', 'TGMT', 99, 4.82);

INSERT INTO SINHVIEN
VALUES ('SV21003021', 'Purab Shankar', 'Nam', to_date('2006-10-23', 'YYYY-MM-DD'), 'H.No. 091 Garde Chowk Tiruvottiyur', '1927913322', 'CQ', 'MMT', 49, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21003022', 'Yasmin Chokshi', 'N?', to_date('1962-01-10', 'YYYY-MM-DD'), '22 Grewal Path Sambalpur', '+916225880853', 'VP', 'KHMT', 111, 4.55);

INSERT INTO SINHVIEN
VALUES ('SV21003023', 'Mehul Dutt', 'Nam', to_date('1925-11-11', 'YYYY-MM-DD'), '744 Suresh Chowk North Dumdum', '06772232935', 'CLC', 'CNPM', 92, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21003024', 'Stuvan Gera', 'N?', to_date('1980-08-24', 'YYYY-MM-DD'), '15/07 Iyer Chowk Phagwara', '+910816846188', 'CLC', 'KHMT', 92, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21003025', 'Ehsaan Chander', 'Nam', to_date('2002-11-17', 'YYYY-MM-DD'), '04 Mann Ganj Raiganj', '09311474746', 'CTTT', 'HTTT', 9, 9.43);

INSERT INTO SINHVIEN
VALUES ('SV21003026', 'Aarna Jhaveri', 'N?', to_date('1982-11-11', 'YYYY-MM-DD'), '791 Krish Marg Gaya', '02809932431', 'VP', 'CNPM', 47, 9.33);

INSERT INTO SINHVIEN
VALUES ('SV21003027', 'Samaira Vora', 'Nam', to_date('1978-06-21', 'YYYY-MM-DD'), '349 Sethi Jamnagar', '02888960136', 'CQ', 'HTTT', 23, 8.77);

INSERT INTO SINHVIEN
VALUES ('SV21003028', 'Himmat Mann', 'Nam', to_date('1996-07-11', 'YYYY-MM-DD'), '17 Sura Ganj Adoni', '+912620154300', 'CTTT', 'CNPM', 57, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21003029', 'Taimur Kara', 'N?', to_date('1937-04-01', 'YYYY-MM-DD'), '97/793 Rege Amravati', '04943962647', 'CQ', 'MMT', 95, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21003030', 'Aarna Ram', 'N?', to_date('1997-09-25', 'YYYY-MM-DD'), 'H.No. 24 Toor Rourkela', '02516612310', 'CTTT', 'MMT', 110, 4.2);

INSERT INTO SINHVIEN
VALUES ('SV21003031', 'Rania Gara', 'N?', to_date('2023-02-01', 'YYYY-MM-DD'), 'H.No. 92 Das Street Purnia', '3923291594', 'VP', 'MMT', 25, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21003032', 'Tarini Sekhon', 'N?', to_date('1937-07-02', 'YYYY-MM-DD'), 'H.No. 79 Acharya Road Shivpuri', '0385246617', 'CQ', 'KHMT', 25, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21003033', 'Kartik Hora', 'N?', to_date('2008-12-06', 'YYYY-MM-DD'), 'H.No. 134 Char Ganj Sri Ganganagar', '+910408540640', 'VP', 'MMT', 44, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21003034', 'Priyansh Mangat', 'Nam', to_date('2008-06-07', 'YYYY-MM-DD'), '00 Bhardwaj Circle Bhagalpur', '+916226819425', 'CQ', 'KHMT', 115, 4.11);

INSERT INTO SINHVIEN
VALUES ('SV21003035', 'Azad Hari', 'Nam', to_date('1947-02-21', 'YYYY-MM-DD'), 'H.No. 62 Rau Street Thoothukudi', '05151355309', 'CLC', 'CNTT', 129, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21003036', 'Nitya Saran', 'N?', to_date('1943-03-10', 'YYYY-MM-DD'), '85/00 Mand Chowk Latur', '+917538829811', 'CTTT', 'KHMT', 77, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21003037', 'Siya Shan', 'N?', to_date('2022-10-11', 'YYYY-MM-DD'), 'H.No. 62 Suri Noida', '3343251752', 'CQ', 'CNTT', 104, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21003038', 'Umang Raval', 'Nam', to_date('1912-09-25', 'YYYY-MM-DD'), 'H.No. 446 Karan Sultan Pur Majra', '1710650103', 'CTTT', 'MMT', 21, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21003039', 'Nishith Sidhu', 'N?', to_date('1998-11-26', 'YYYY-MM-DD'), '74/72 Gala Marg Aurangabad', '07304250603', 'CQ', 'HTTT', 75, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21003040', 'Pihu Butala', 'N?', to_date('1953-07-21', 'YYYY-MM-DD'), 'H.No. 713 Sharma Street Tinsukia', '02024076993', 'CQ', 'KHMT', 116, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21003041', 'Kartik Soman', 'N?', to_date('1968-05-14', 'YYYY-MM-DD'), '90/831 Thaker Meerut', '+916304075648', 'VP', 'MMT', 117, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003042', 'Kartik Chand', 'Nam', to_date('1974-10-29', 'YYYY-MM-DD'), 'H.No. 16 Shroff Chowk Agra', '+919323593144', 'CLC', 'TGMT', 64, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003043', 'Hunar Sandhu', 'N?', to_date('1943-02-23', 'YYYY-MM-DD'), '43 Kara Chowk Nagaon', '+917617071999', 'VP', 'KHMT', 64, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21003044', 'Fateh Rao', 'N?', to_date('1912-08-17', 'YYYY-MM-DD'), '85/478 Ramaswamy Marg Jaunpur', '09027551538', 'CTTT', 'TGMT', 15, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21003045', 'Badal Rama', 'N?', to_date('1929-07-06', 'YYYY-MM-DD'), 'H.No. 20 Deep Hajipur', '3717145244', 'VP', 'MMT', 104, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21003046', 'Prerak Joshi', 'N?', to_date('1938-08-28', 'YYYY-MM-DD'), '80 Venkataraman Road Kozhikode', '8041112544', 'CQ', 'TGMT', 3, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21003047', 'Lavanya Bhalla', 'Nam', to_date('1960-02-29', 'YYYY-MM-DD'), '36 Gade Path Jamalpur', '6651190338', 'CLC', 'HTTT', 95, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21003048', 'Adah Rana', 'Nam', to_date('2014-04-03', 'YYYY-MM-DD'), '105 Sundaram Street Ghaziabad', '4351633505', 'CTTT', 'HTTT', 28, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21003049', 'Umang Saran', 'Nam', to_date('2014-05-03', 'YYYY-MM-DD'), 'H.No. 604 Mander Road Kumbakonam', '07665751479', 'CLC', 'TGMT', 90, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21003050', 'Jivin Tara', 'Nam', to_date('1952-11-18', 'YYYY-MM-DD'), 'H.No. 205 Khatri Ganj Chandrapur', '+913811578764', 'VP', 'HTTT', 50, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21003051', 'Riya Jain', 'Nam', to_date('1930-08-01', 'YYYY-MM-DD'), '90 Bhatt Zila Tiruppur', '9215195258', 'VP', 'HTTT', 60, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21003052', 'Kimaya Lalla', 'Nam', to_date('1929-03-29', 'YYYY-MM-DD'), '911 Suresh Ganj Motihari', '1936070897', 'CTTT', 'CNTT', 94, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21003053', 'Shray Tank', 'N?', to_date('1939-11-20', 'YYYY-MM-DD'), '42 Kapadia Zila Chapra', '1208567821', 'CQ', 'TGMT', 0, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21003054', 'Ishita Hayer', 'N?', to_date('2013-06-02', 'YYYY-MM-DD'), '75/53 Banik Nagar Phagwara', '05145400028', 'CLC', 'CNPM', 8, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003055', 'Nitara Sami', 'Nam', to_date('1936-07-10', 'YYYY-MM-DD'), 'H.No. 726 Chanda Chowk Machilipatnam', '09140707301', 'VP', 'CNTT', 96, 6.46);

INSERT INTO SINHVIEN
VALUES ('SV21003056', 'Shanaya Wagle', 'Nam', to_date('1939-07-26', 'YYYY-MM-DD'), 'H.No. 93 Loke Circle Motihari', '04866451693', 'CLC', 'CNPM', 3, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21003057', 'Vidur Sha', 'Nam', to_date('2013-05-04', 'YYYY-MM-DD'), 'H.No. 87 Mander Nagar Allahabad', '+919246022370', 'CQ', 'HTTT', 100, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21003058', 'Samarth Mander', 'Nam', to_date('1995-07-18', 'YYYY-MM-DD'), '11/25 Chaudhry Marg Kirari Suleman Nagar', '04711473430', 'CTTT', 'HTTT', 55, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21003059', 'Shalv Bava', 'N?', to_date('1973-11-29', 'YYYY-MM-DD'), '23/489 Roy Chowk Dewas', '02336735416', 'CTTT', 'CNPM', 120, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21003060', 'Kimaya Sampath', 'N?', to_date('1996-12-13', 'YYYY-MM-DD'), '09 Deol Ganj Jamshedpur', '0852527396', 'CQ', 'CNPM', 100, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21003061', 'Jayan Bhargava', 'N?', to_date('1995-05-19', 'YYYY-MM-DD'), '78/560 Dora Marg Salem', '07195183755', 'CQ', 'CNPM', 12, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21003062', 'Khushi Solanki', 'Nam', to_date('1926-04-02', 'YYYY-MM-DD'), '27/25 Grover Circle Nellore', '6120269364', 'CTTT', 'HTTT', 75, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21003063', 'Kavya Gaba', 'N?', to_date('1946-05-30', 'YYYY-MM-DD'), 'H.No. 797 Varty Marg Sultan Pur Majra', '05795597651', 'VP', 'CNTT', 57, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21003064', 'Mamooty Mani', 'Nam', to_date('1943-05-13', 'YYYY-MM-DD'), '35/953 Raj Nagar Bidar', '00688438416', 'CLC', 'KHMT', 22, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21003065', 'Shanaya Konda', 'Nam', to_date('2014-02-20', 'YYYY-MM-DD'), '74/028 Setty Street Hapur', '08278865455', 'VP', 'CNTT', 20, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21003066', 'Aarav Mani', 'N?', to_date('1912-06-20', 'YYYY-MM-DD'), 'H.No. 83 Varma Ganj Gangtok', '3496807295', 'CTTT', 'HTTT', 126, 4.52);

INSERT INTO SINHVIEN
VALUES ('SV21003067', 'Prisha Aggarwal', 'N?', to_date('1927-09-03', 'YYYY-MM-DD'), '17 Mand Ganj Berhampore', '00481909621', 'VP', 'HTTT', 69, 8.04);

INSERT INTO SINHVIEN
VALUES ('SV21003068', 'Rania Ben', 'Nam', to_date('2011-06-15', 'YYYY-MM-DD'), '19/56 Devi Ganj Kota', '04075320886', 'CLC', 'CNTT', 90, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21003069', 'Charvi Buch', 'N?', to_date('1962-05-18', 'YYYY-MM-DD'), '759 Kamdar Chowk Junagadh', '+912749431558', 'CLC', 'MMT', 124, 5.68);

INSERT INTO SINHVIEN
VALUES ('SV21003070', 'Vaibhav Wason', 'Nam', to_date('1944-09-07', 'YYYY-MM-DD'), '58/34 Dani Zila Raurkela Industrial Township', '07204365048', 'VP', 'TGMT', 84, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21003071', 'Anay Batta', 'N?', to_date('1986-10-18', 'YYYY-MM-DD'), '29/69 Gupta Bharatpur', '7530296140', 'CQ', 'CNTT', 58, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21003072', 'Riaan Ray', 'N?', to_date('1912-09-21', 'YYYY-MM-DD'), '024 Barman Ganj Kakinada', '07024110311', 'VP', 'MMT', 25, 5.57);

INSERT INTO SINHVIEN
VALUES ('SV21003073', 'Aaryahi Saran', 'N?', to_date('1926-05-19', 'YYYY-MM-DD'), 'H.No. 03 Tank Nagar Hubli�CDharwad', '05969058083', 'CTTT', 'MMT', 130, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21003074', 'Drishya Sura', 'Nam', to_date('2019-01-05', 'YYYY-MM-DD'), '25 Bali Ganj Bhiwandi', '1002147872', 'CLC', 'MMT', 90, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21003075', 'Jayant Varughese', 'Nam', to_date('2022-10-11', 'YYYY-MM-DD'), '62/99 Majumdar Chowk Bijapur', '+916056966644', 'CTTT', 'HTTT', 137, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21003076', 'Manjari Arora', 'N?', to_date('1931-12-13', 'YYYY-MM-DD'), 'H.No. 16 Hari Road Buxar', '6951939501', 'VP', 'KHMT', 55, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21003077', 'Anahi Saxena', 'Nam', to_date('2000-03-31', 'YYYY-MM-DD'), '88/82 Dhar Road Karnal', '02452292401', 'CTTT', 'MMT', 135, 7.5);

INSERT INTO SINHVIEN
VALUES ('SV21003078', 'Raghav Jain', 'N?', to_date('2004-05-20', 'YYYY-MM-DD'), '830 Kalla Street North Dumdum', '+914700699397', 'CLC', 'CNTT', 103, 5.61);

INSERT INTO SINHVIEN
VALUES ('SV21003079', 'Devansh Samra', 'N?', to_date('1996-01-25', 'YYYY-MM-DD'), '15 Srinivas Street Jhansi', '01885278000', 'CLC', 'CNTT', 104, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21003080', 'Indrans Wali', 'N?', to_date('1972-11-18', 'YYYY-MM-DD'), '41 Walla Path Erode', '05059925105', 'CTTT', 'CNTT', 19, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21003081', 'Damini Bhat', 'N?', to_date('2002-12-27', 'YYYY-MM-DD'), '94 Chakraborty Ganj Rohtak', '+915245097213', 'VP', 'CNPM', 111, 6.14);

INSERT INTO SINHVIEN
VALUES ('SV21003082', 'Yuvaan Dugar', 'Nam', to_date('1916-08-13', 'YYYY-MM-DD'), '32 Ghose Road Nizamabad', '+910001041740', 'CLC', 'KHMT', 43, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21003083', 'Ishita Ramesh', 'Nam', to_date('1974-09-01', 'YYYY-MM-DD'), '613 Shan Chowk Patiala', '+913888113535', 'VP', 'CNTT', 10, 7.1);

INSERT INTO SINHVIEN
VALUES ('SV21003084', 'Dhanuk Savant', 'N?', to_date('2003-12-23', 'YYYY-MM-DD'), 'H.No. 331 Khurana Circle Buxar', '+915958155541', 'CQ', 'KHMT', 135, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21003085', 'Vaibhav Kannan', 'N?', to_date('2010-02-01', 'YYYY-MM-DD'), 'H.No. 240 Bala Zila Anantapur', '+913987113723', 'VP', 'TGMT', 51, 8.31);

INSERT INTO SINHVIEN
VALUES ('SV21003086', 'Tushar Garg', 'Nam', to_date('1973-05-13', 'YYYY-MM-DD'), '69 Rout Road Gopalpur', '07194418123', 'CTTT', 'MMT', 122, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21003087', 'Armaan Sankar', 'Nam', to_date('1959-08-23', 'YYYY-MM-DD'), '570 Divan Nagar Kollam', '03984408168', 'CLC', 'CNPM', 99, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21003088', 'Vritika Tailor', 'Nam', to_date('2014-10-23', 'YYYY-MM-DD'), '07/92 Ramakrishnan Ganj Mau', '08132050429', 'CQ', 'KHMT', 124, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21003089', 'Vaibhav Sethi', 'Nam', to_date('1976-10-17', 'YYYY-MM-DD'), '52 Kashyap Chowk Kollam', '09454952736', 'CQ', 'CNTT', 56, 6.2);

INSERT INTO SINHVIEN
VALUES ('SV21003090', 'Lakshit Vasa', 'N?', to_date('1962-06-25', 'YYYY-MM-DD'), '57 Datta Chowk Shivpuri', '02328076401', 'CQ', 'CNPM', 61, 5.77);

INSERT INTO SINHVIEN
VALUES ('SV21003091', 'Kiara Vora', 'Nam', to_date('1976-12-08', 'YYYY-MM-DD'), '29/433 Tailor Marg Rajkot', '09237725337', 'CTTT', 'CNPM', 86, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21003092', 'Anaya Ramaswamy', 'N?', to_date('1945-01-05', 'YYYY-MM-DD'), '76/612 Chadha Path Khammam', '07094376146', 'CTTT', 'TGMT', 27, 4.58);

INSERT INTO SINHVIEN
VALUES ('SV21003093', 'Zain Maharaj', 'N?', to_date('1938-11-09', 'YYYY-MM-DD'), '28/209 Krishnamurthy Road Thiruvananthapuram', '3807282574', 'CLC', 'CNTT', 26, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21003094', 'Baiju Chowdhury', 'N?', to_date('1913-11-24', 'YYYY-MM-DD'), '98/75 Behl Marg Bettiah', '08377456999', 'VP', 'KHMT', 23, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21003095', 'Samaira Devi', 'Nam', to_date('1999-11-29', 'YYYY-MM-DD'), '781 Setty Circle Dhanbad', '+912230678753', 'VP', 'TGMT', 119, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21003096', 'Manikya Sama', 'N?', to_date('1917-09-22', 'YYYY-MM-DD'), '26 Dalal Vijayawada', '+917825568151', 'CQ', 'CNTT', 90, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21003097', 'Manikya Hora', 'N?', to_date('1971-04-10', 'YYYY-MM-DD'), 'H.No. 839 Saraf Path Mathura', '+915500761152', 'CTTT', 'HTTT', 79, 7.14);

INSERT INTO SINHVIEN
VALUES ('SV21003098', 'Armaan Seth', 'N?', to_date('1912-04-15', 'YYYY-MM-DD'), 'H.No. 65 Gaba Path Berhampore', '8575599583', 'VP', 'HTTT', 26, 9.25);

INSERT INTO SINHVIEN
VALUES ('SV21003099', 'Aarav Lal', 'Nam', to_date('2013-08-19', 'YYYY-MM-DD'), '396 Gole Nagar Mau', '01675267178', 'CQ', 'KHMT', 72, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21003100', 'Armaan Subramaniam', 'N?', to_date('1957-05-05', 'YYYY-MM-DD'), '78/636 Khalsa Durgapur', '05278415644', 'CLC', 'TGMT', 79, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21003101', 'Ira Ramesh', 'N?', to_date('2002-09-10', 'YYYY-MM-DD'), '828 Talwar Chowk Tadipatri', '+914246775911', 'CLC', 'CNPM', 3, 6.02);

INSERT INTO SINHVIEN
VALUES ('SV21003102', 'Jayesh Sinha', 'N?', to_date('1948-02-08', 'YYYY-MM-DD'), 'H.No. 914 Manda Chowk Allahabad', '4481322683', 'CLC', 'CNPM', 10, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21003103', 'Vritika Ghosh', 'Nam', to_date('2006-03-01', 'YYYY-MM-DD'), '50/12 Deo Zila Bellary', '08704697513', 'CTTT', 'CNTT', 80, 8.39);

INSERT INTO SINHVIEN
VALUES ('SV21003104', 'Mannat Sangha', 'N?', to_date('1950-10-22', 'YYYY-MM-DD'), 'H.No. 034 Jain Nagar Ichalkaranji', '03701272690', 'VP', 'HTTT', 104, 8.03);

INSERT INTO SINHVIEN
VALUES ('SV21003105', 'Shlok Rout', 'Nam', to_date('2016-05-31', 'YYYY-MM-DD'), '104 Date Zila Udupi', '2682468133', 'VP', 'TGMT', 96, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21003106', 'Piya Kala', 'N?', to_date('1966-09-12', 'YYYY-MM-DD'), 'H.No. 997 Bhat Nagar Tezpur', '05044732157', 'VP', 'TGMT', 22, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21003107', 'Hunar Sagar', 'Nam', to_date('2005-03-12', 'YYYY-MM-DD'), '96 Sandal Road Bhavnagar', '09804512319', 'CQ', 'KHMT', 115, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21003108', 'Rasha Sidhu', 'Nam', to_date('1958-11-15', 'YYYY-MM-DD'), 'H.No. 68 Kapur Circle Raichur', '6077402616', 'CLC', 'CNPM', 67, 6.87);

INSERT INTO SINHVIEN
VALUES ('SV21003109', 'Madhup Raju', 'N?', to_date('1981-12-06', 'YYYY-MM-DD'), 'H.No. 310 Bassi Zila Tirunelveli', '+918852275564', 'CQ', 'KHMT', 28, 9.33);

INSERT INTO SINHVIEN
VALUES ('SV21003110', 'Purab Krishnan', 'Nam', to_date('1921-10-11', 'YYYY-MM-DD'), 'H.No. 685 Deshpande Marg Kozhikode', '03896020039', 'CLC', 'MMT', 7, 6.89);

INSERT INTO SINHVIEN
VALUES ('SV21003111', 'Jivin Bath', 'Nam', to_date('1961-11-23', 'YYYY-MM-DD'), '50/26 Sahni Marg Tirupati', '0293119218', 'VP', 'HTTT', 55, 5.31);

INSERT INTO SINHVIEN
VALUES ('SV21003112', 'Amira Vohra', 'Nam', to_date('1964-11-14', 'YYYY-MM-DD'), '15/707 Bhat Zila Bidhannagar', '+917918529497', 'CLC', 'CNPM', 109, 8.65);

INSERT INTO SINHVIEN
VALUES ('SV21003113', 'Lakshay Karnik', 'Nam', to_date('1979-04-27', 'YYYY-MM-DD'), '086 Warrior Chowk Hubli�CDharwad', '+913209736276', 'CLC', 'TGMT', 79, 5.22);

INSERT INTO SINHVIEN
VALUES ('SV21003114', 'Sumer Balan', 'Nam', to_date('2005-11-12', 'YYYY-MM-DD'), 'H.No. 30 Kaul Road Khammam', '06222115108', 'CLC', 'CNPM', 103, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21003115', 'Diya Johal', 'Nam', to_date('1959-03-02', 'YYYY-MM-DD'), '28/814 Chandran Street Mysore', '04466162064', 'CLC', 'CNPM', 20, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21003116', 'Vanya Rajagopal', 'N?', to_date('1932-04-18', 'YYYY-MM-DD'), 'H.No. 24 Ahuja Gandhinagar', '5181552178', 'CQ', 'TGMT', 103, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21003117', 'Yuvraj  Joshi', 'Nam', to_date('1913-03-20', 'YYYY-MM-DD'), '26 Kaur Ganj Berhampore', '3504619909', 'CLC', 'CNTT', 108, 4.33);

INSERT INTO SINHVIEN
VALUES ('SV21003118', 'Chirag Kata', 'N?', to_date('1990-02-21', 'YYYY-MM-DD'), '090 Sunder Ganj Agra', '9195196614', 'CQ', 'HTTT', 83, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21003119', 'Misha Buch', 'Nam', to_date('1935-08-31', 'YYYY-MM-DD'), '16 Tak Bhimavaram', '+914458497307', 'VP', 'CNPM', 134, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21003120', 'Trisha Kulkarni', 'Nam', to_date('2016-02-14', 'YYYY-MM-DD'), '13/039 Sule Ganj Navi Mumbai', '9554477455', 'VP', 'CNPM', 56, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21003121', 'Devansh Krish', 'Nam', to_date('1956-02-05', 'YYYY-MM-DD'), '70/98 Khatri Marg Kulti', '8130617346', 'CQ', 'TGMT', 89, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21003122', 'Saanvi Ramesh', 'Nam', to_date('1957-07-05', 'YYYY-MM-DD'), '842 Upadhyay Zila Orai', '5857869144', 'CTTT', 'MMT', 134, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21003123', 'Advik Sha', 'N?', to_date('1966-02-06', 'YYYY-MM-DD'), 'H.No. 219 Vohra Chowk Panvel', '+911736624908', 'VP', 'CNTT', 121, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21003124', 'Alisha Shankar', 'N?', to_date('1942-04-04', 'YYYY-MM-DD'), '46 Jaggi Mehsana', '+910741697213', 'VP', 'KHMT', 104, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21003125', 'Anahi Agarwal', 'Nam', to_date('2011-08-05', 'YYYY-MM-DD'), '13/074 Mammen Marg Hyderabad', '00874564973', 'CQ', 'MMT', 136, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21003126', 'Dhanuk Mandal', 'N?', to_date('2012-09-21', 'YYYY-MM-DD'), '40/370 Boase Ganj Shahjahanpur', '+919539096243', 'VP', 'TGMT', 83, 8.43);

INSERT INTO SINHVIEN
VALUES ('SV21003127', 'Faiyaz Wagle', 'Nam', to_date('1943-08-14', 'YYYY-MM-DD'), 'H.No. 346 Tara Ganj Jamalpur', '02494212304', 'VP', 'TGMT', 119, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21003128', 'Pranay Chadha', 'N?', to_date('2001-10-02', 'YYYY-MM-DD'), 'H.No. 159 Raman Path Etawah', '0848191138', 'CQ', 'HTTT', 130, 7.43);

INSERT INTO SINHVIEN
VALUES ('SV21003129', 'Faiyaz Johal', 'N?', to_date('2001-01-29', 'YYYY-MM-DD'), '876 Malhotra Marg Moradabad', '04232319241', 'CQ', 'KHMT', 58, 9.25);

INSERT INTO SINHVIEN
VALUES ('SV21003130', 'Kimaya Trivedi', 'N?', to_date('1965-09-14', 'YYYY-MM-DD'), '03 Sem Zila Panipat', '+917508965453', 'VP', 'CNPM', 52, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21003131', 'Tanya Shetty', 'N?', to_date('1969-06-04', 'YYYY-MM-DD'), 'H.No. 68 Mangat Street Vellore', '+918831910095', 'CTTT', 'MMT', 31, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21003132', 'Hiran Wagle', 'Nam', to_date('1952-09-02', 'YYYY-MM-DD'), '14/94 Sule Zila Pali', '06002178798', 'CQ', 'TGMT', 24, 6.47);

INSERT INTO SINHVIEN
VALUES ('SV21003133', 'Faiyaz Zachariah', 'N?', to_date('1935-03-17', 'YYYY-MM-DD'), 'H.No. 40 Sanghvi Circle Pimpri-Chinchwad', '+916266144135', 'CTTT', 'MMT', 88, 5.81);

INSERT INTO SINHVIEN
VALUES ('SV21003134', 'Rohan Rege', 'N?', to_date('1970-01-12', 'YYYY-MM-DD'), '224 Gara Nagar Bathinda', '+912935287914', 'CLC', 'KHMT', 86, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21003135', 'Aaina Shukla', 'Nam', to_date('2018-03-29', 'YYYY-MM-DD'), '00/47 Dey Chowk Bhiwani', '+916932767828', 'CLC', 'KHMT', 58, 6.4);

INSERT INTO SINHVIEN
VALUES ('SV21003136', 'Taimur Mani', 'Nam', to_date('1979-01-13', 'YYYY-MM-DD'), '39/92 Vyas Chowk Firozabad', '7455918327', 'CTTT', 'MMT', 44, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21003137', 'Manjari Jayaraman', 'Nam', to_date('1985-10-05', 'YYYY-MM-DD'), '800 Sarna Chowk Tirunelveli', '06450009063', 'CQ', 'TGMT', 123, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21003138', 'Jayan Vala', 'N?', to_date('1942-04-22', 'YYYY-MM-DD'), '14/94 Gaba Jamnagar', '05329674483', 'VP', 'CNTT', 23, 8.91);

INSERT INTO SINHVIEN
VALUES ('SV21003139', 'Tanya Shukla', 'N?', to_date('1958-02-07', 'YYYY-MM-DD'), 'H.No. 640 Sule Baranagar', '+910192493551', 'CLC', 'CNPM', 44, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21003140', 'Purab Raman', 'N?', to_date('1917-03-19', 'YYYY-MM-DD'), 'H.No. 09 Shetty Street Machilipatnam', '+919184692767', 'CLC', 'CNTT', 24, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21003141', 'Eva Kala', 'Nam', to_date('1983-09-21', 'YYYY-MM-DD'), 'H.No. 01 Bedi Zila Bharatpur', '09667646091', 'CTTT', 'HTTT', 90, 5.22);

INSERT INTO SINHVIEN
VALUES ('SV21003142', 'Anahita Bala', 'N?', to_date('2017-01-25', 'YYYY-MM-DD'), 'H.No. 43 Apte Street Hospet', '+914782016670', 'CTTT', 'CNTT', 129, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21003143', 'Dhanush Gaba', 'N?', to_date('2009-12-21', 'YYYY-MM-DD'), '07/412 Konda Ganj Asansol', '+917437278354', 'CLC', 'CNPM', 14, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21003144', 'Kashvi Ganesh', 'N?', to_date('2002-01-17', 'YYYY-MM-DD'), 'H.No. 11 Srinivas Ganj Muzaffarpur', '+919828494481', 'CLC', 'CNPM', 1, 8.32);

INSERT INTO SINHVIEN
VALUES ('SV21003145', 'Krish Sheth', 'N?', to_date('2005-09-30', 'YYYY-MM-DD'), '63/82 Ravi Street Tadipatri', '09973306756', 'CLC', 'CNPM', 103, 5.1);

INSERT INTO SINHVIEN
VALUES ('SV21003146', 'Badal Dhingra', 'N?', to_date('1958-12-27', 'YYYY-MM-DD'), '92/41 Wason Chowk Kochi', '7544758305', 'CLC', 'CNPM', 43, 7.24);

INSERT INTO SINHVIEN
VALUES ('SV21003147', 'Taran Wagle', 'Nam', to_date('1916-04-10', 'YYYY-MM-DD'), 'H.No. 60 Das Ganj Ozhukarai', '06581069457', 'CLC', 'CNTT', 48, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21003148', 'Purab Biswas', 'Nam', to_date('1996-08-25', 'YYYY-MM-DD'), '02/450 Badami Ganj Surendranagar Dudhrej', '+919393147850', 'CLC', 'CNPM', 99, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21003149', 'Mishti Sant', 'Nam', to_date('1944-09-13', 'YYYY-MM-DD'), '41 Savant Circle Kurnool', '9521172285', 'CLC', 'CNTT', 64, 7.02);

INSERT INTO SINHVIEN
VALUES ('SV21003150', 'Kiara Sathe', 'N?', to_date('1929-05-04', 'YYYY-MM-DD'), '93/493 Hayer Nagar Pudukkottai', '+915621571538', 'CLC', 'CNTT', 29, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21003151', 'Navya Raman', 'N?', to_date('1931-04-21', 'YYYY-MM-DD'), '093 Dugal Path Muzaffarpur', '7144560394', 'CQ', 'CNTT', 15, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21003152', 'Jivika Balasubramanian', 'Nam', to_date('1999-03-12', 'YYYY-MM-DD'), 'H.No. 435 Dugar Road Madanapalle', '+912932934507', 'CQ', 'TGMT', 38, 5.83);

INSERT INTO SINHVIEN
VALUES ('SV21003153', 'Anya Rege', 'N?', to_date('1925-06-01', 'YYYY-MM-DD'), '25/820 Suresh Zila Jaipur', '01067942169', 'CQ', 'MMT', 83, 6.45);

INSERT INTO SINHVIEN
VALUES ('SV21003154', 'Saksham Dixit', 'N?', to_date('1912-01-28', 'YYYY-MM-DD'), '17/079 Batta Street Jalandhar', '+912333496657', 'CLC', 'KHMT', 56, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21003155', 'Samarth Kashyap', 'Nam', to_date('1972-02-05', 'YYYY-MM-DD'), '01 Buch Ganj Phagwara', '+914112225926', 'CTTT', 'CNPM', 48, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21003156', 'Hunar Sampath', 'Nam', to_date('1988-06-11', 'YYYY-MM-DD'), 'H.No. 612 Rout Chowk Mathura', '9001288601', 'CQ', 'CNPM', 46, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21003157', 'Hunar Sanghvi', 'Nam', to_date('1925-09-06', 'YYYY-MM-DD'), '55/034 Varghese Ganj Panvel', '+919946654487', 'VP', 'TGMT', 137, 5.65);

INSERT INTO SINHVIEN
VALUES ('SV21003158', 'Vihaan Sinha', 'N?', to_date('2008-09-12', 'YYYY-MM-DD'), 'H.No. 37 Bhavsar Nagar Rajkot', '1370989176', 'CTTT', 'CNPM', 7, 4.33);

INSERT INTO SINHVIEN
VALUES ('SV21003159', 'Hiran Deep', 'Nam', to_date('1949-06-08', 'YYYY-MM-DD'), 'H.No. 53 Baria Circle Raurkela Industrial Township', '00057689407', 'CLC', 'HTTT', 53, 6.63);

INSERT INTO SINHVIEN
VALUES ('SV21003160', 'Hrishita Kashyap', 'N?', to_date('2001-09-10', 'YYYY-MM-DD'), '41/31 Sama Path Bathinda', '0701033561', 'CQ', 'HTTT', 129, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21003161', 'Azad Ratta', 'Nam', to_date('2006-10-14', 'YYYY-MM-DD'), '24/642 Ahuja Path Davanagere', '3000141841', 'CLC', 'KHMT', 105, 6.34);

INSERT INTO SINHVIEN
VALUES ('SV21003162', 'Kismat Tiwari', 'Nam', to_date('1923-08-07', 'YYYY-MM-DD'), '75/129 Mahal Road Raipur', '07577397693', 'CLC', 'TGMT', 50, 5.57);

INSERT INTO SINHVIEN
VALUES ('SV21003163', 'Neysa Dar', 'N?', to_date('1985-11-05', 'YYYY-MM-DD'), 'H.No. 715 Varma Zila Shimoga', '06617350563', 'CLC', 'CNPM', 133, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21003164', 'Reyansh Subramanian', 'Nam', to_date('1997-07-15', 'YYYY-MM-DD'), '93/67 Saini Road Nagpur', '02121547060', 'VP', 'CNTT', 86, 4.68);

INSERT INTO SINHVIEN
VALUES ('SV21003165', 'Suhana Gera', 'N?', to_date('1991-05-04', 'YYYY-MM-DD'), 'H.No. 55 Kanda Jehanabad', '3820499176', 'CTTT', 'HTTT', 16, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21003166', 'Riya Sundaram', 'Nam', to_date('1963-05-20', 'YYYY-MM-DD'), '66/812 Mangat Path Rajkot', '2765339213', 'CLC', 'CNPM', 91, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21003167', 'Darshit Vohra', 'Nam', to_date('1939-02-12', 'YYYY-MM-DD'), '66/722 Mallick Rourkela', '6039579648', 'CTTT', 'CNTT', 123, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003168', 'Uthkarsh Chaudhari', 'Nam', to_date('1951-11-18', 'YYYY-MM-DD'), '17/246 Gopal Chittoor', '09816029548', 'CQ', 'CNTT', 90, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21003169', 'Adah Kalita', 'Nam', to_date('1965-02-06', 'YYYY-MM-DD'), '65 Vora Chowk Bhatpara', '+911270924008', 'CQ', 'CNTT', 126, 7.83);

INSERT INTO SINHVIEN
VALUES ('SV21003170', 'Aaina Shan', 'Nam', to_date('2007-01-27', 'YYYY-MM-DD'), '67 Rout Road Guntur', '04481162634', 'CTTT', 'HTTT', 86, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21003171', 'Aarna Rege', 'N?', to_date('1914-11-03', 'YYYY-MM-DD'), '705 Sridhar Ganj Proddatur', '03148773232', 'CQ', 'HTTT', 134, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003172', 'Pranay Bhatt', 'Nam', to_date('1921-03-05', 'YYYY-MM-DD'), 'H.No. 340 Das Circle Pudukkottai', '3400637063', 'VP', 'CNTT', 126, 4.8);

INSERT INTO SINHVIEN
VALUES ('SV21003173', 'Kiaan Kakar', 'N?', to_date('1955-02-18', 'YYYY-MM-DD'), '893 Bhatia Chowk Kurnool', '06993001054', 'CLC', 'CNPM', 89, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21003174', 'Alia Yadav', 'N?', to_date('1977-07-08', 'YYYY-MM-DD'), 'H.No. 478 Ganesh Circle Panvel', '09957435232', 'VP', 'KHMT', 130, 4.21);

INSERT INTO SINHVIEN
VALUES ('SV21003175', 'Elakshi Wason', 'N?', to_date('2007-04-02', 'YYYY-MM-DD'), '59/97 Chada Circle Jabalpur', '09927460330', 'VP', 'MMT', 31, 4.27);

INSERT INTO SINHVIEN
VALUES ('SV21003176', 'Madhav Krishnamurthy', 'N?', to_date('1935-06-13', 'YYYY-MM-DD'), '61/76 Keer Street Mirzapur', '+915119794729', 'CLC', 'CNTT', 12, 6.31);

INSERT INTO SINHVIEN
VALUES ('SV21003177', 'Manikya Dar', 'Nam', to_date('1982-08-14', 'YYYY-MM-DD'), 'H.No. 48 Sachar Path Ballia', '+916306417859', 'CLC', 'KHMT', 45, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21003178', 'Ehsaan Bhakta', 'Nam', to_date('1978-03-30', 'YYYY-MM-DD'), '079 Vig Circle Gaya', '8272775169', 'CTTT', 'CNPM', 66, 8.49);

INSERT INTO SINHVIEN
VALUES ('SV21003179', 'Samarth Venkatesh', 'N?', to_date('1968-08-23', 'YYYY-MM-DD'), 'H.No. 98 Viswanathan Circle Rohtak', '+910005000601', 'CTTT', 'MMT', 67, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21003180', 'Dishani Krishna', 'Nam', to_date('1916-06-14', 'YYYY-MM-DD'), '93 Mannan Circle Sambhal', '01790126783', 'CLC', 'MMT', 120, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21003181', 'Charvi Subramanian', 'N?', to_date('1934-02-11', 'YYYY-MM-DD'), '98 Dixit Zila Surat', '03090083636', 'CQ', 'MMT', 69, 5.8);

INSERT INTO SINHVIEN
VALUES ('SV21003182', 'Vanya De', 'N?', to_date('1996-05-10', 'YYYY-MM-DD'), '78 Chaudry Road Secunderabad', '07170508499', 'VP', 'CNPM', 105, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21003183', 'Yuvraj  Mander', 'Nam', to_date('1965-04-21', 'YYYY-MM-DD'), '97/21 Shetty Nagar Thiruvananthapuram', '5677076249', 'VP', 'CNPM', 1, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21003184', 'Inaaya  Kunda', 'Nam', to_date('1928-10-27', 'YYYY-MM-DD'), '559 Dhingra Path Saharanpur', '3871680161', 'CQ', 'CNPM', 84, 6.75);

INSERT INTO SINHVIEN
VALUES ('SV21003185', 'Tara Bassi', 'N?', to_date('1948-08-16', 'YYYY-MM-DD'), '71 Sangha Street Machilipatnam', '05873971369', 'CLC', 'MMT', 85, 4.39);

INSERT INTO SINHVIEN
VALUES ('SV21003186', 'Farhan Saini', 'N?', to_date('2003-10-26', 'YYYY-MM-DD'), 'H.No. 13 Cheema Chowk Anand', '0517649981', 'VP', 'KHMT', 137, 5.82);

INSERT INTO SINHVIEN
VALUES ('SV21003187', 'Ayesha Virk', 'N?', to_date('2006-07-02', 'YYYY-MM-DD'), 'H.No. 25 Barad Circle Mango', '07209466732', 'CLC', 'MMT', 98, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21003188', 'Eshani Kakar', 'N?', to_date('1972-11-30', 'YYYY-MM-DD'), '76/69 Gole Street Ajmer', '2371036074', 'CQ', 'KHMT', 53, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21003189', 'Sana Sawhney', 'N?', to_date('1998-02-01', 'YYYY-MM-DD'), 'H.No. 057 Singhal Guntur', '+911439520970', 'CTTT', 'MMT', 56, 6.69);

INSERT INTO SINHVIEN
VALUES ('SV21003190', 'Lakshit Bhatt', 'Nam', to_date('1916-01-31', 'YYYY-MM-DD'), 'H.No. 671 Jha Path Kozhikode', '+914209240862', 'VP', 'KHMT', 94, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21003191', 'Kavya Gill', 'N?', to_date('1926-07-03', 'YYYY-MM-DD'), 'H.No. 63 Uppal Street Durgapur', '+919944016023', 'CLC', 'KHMT', 20, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21003192', 'Myra Ramachandran', 'Nam', to_date('2000-11-14', 'YYYY-MM-DD'), '089 Uppal Nagar North Dumdum', '+911882634526', 'CTTT', 'TGMT', 30, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21003193', 'Kiaan Sheth', 'N?', to_date('1949-07-18', 'YYYY-MM-DD'), 'H.No. 44 Mammen Road Karaikudi', '3560376107', 'CLC', 'TGMT', 107, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21003194', 'Onkar Gulati', 'Nam', to_date('2018-12-29', 'YYYY-MM-DD'), '61/866 D��Alia Zila Sikar', '04180993590', 'VP', 'KHMT', 46, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21003195', 'Dhanush Mangat', 'N?', to_date('1971-07-12', 'YYYY-MM-DD'), 'H.No. 55 Kanda Chowk Pondicherry', '08685651714', 'CTTT', 'HTTT', 47, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21003196', 'Tushar Lata', 'N?', to_date('2004-03-25', 'YYYY-MM-DD'), '360 Goyal Narasaraopet', '05671146463', 'VP', 'TGMT', 3, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21003197', 'Devansh Bhatnagar', 'Nam', to_date('2001-10-12', 'YYYY-MM-DD'), '450 Chawla Circle Jalna', '9895630527', 'CTTT', 'KHMT', 48, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21003198', 'Samiha Tripathi', 'Nam', to_date('2005-05-29', 'YYYY-MM-DD'), '99/021 Kalita Chowk Bihar Sharif', '1962812065', 'CQ', 'CNTT', 29, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21003199', 'Fateh Kalla', 'N?', to_date('1911-11-24', 'YYYY-MM-DD'), '85 Toor Nagar Aizawl', '05690127147', 'CLC', 'CNPM', 8, 5.63);

INSERT INTO SINHVIEN
VALUES ('SV21003200', 'Dhanush Singhal', 'Nam', to_date('2018-03-05', 'YYYY-MM-DD'), '17/947 Raval Circle Kurnool', '2619083186', 'VP', 'HTTT', 131, 9.19);

INSERT INTO SINHVIEN
VALUES ('SV21003201', 'Tara Sarin', 'N?', to_date('1989-08-12', 'YYYY-MM-DD'), '67 Dua Zila Khora ', '5540697914', 'VP', 'KHMT', 90, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21003202', 'Krish Jaggi', 'Nam', to_date('1921-10-06', 'YYYY-MM-DD'), '80 Dora Marg Madhyamgram', '8831424972', 'VP', 'TGMT', 56, 6.12);

INSERT INTO SINHVIEN
VALUES ('SV21003203', 'Riya Bajwa', 'N?', to_date('1929-09-04', 'YYYY-MM-DD'), '42 Anne Street Nagaon', '7385538189', 'CLC', 'CNTT', 117, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21003204', 'Ivana Ramakrishnan', 'Nam', to_date('1937-01-12', 'YYYY-MM-DD'), 'H.No. 622 Venkatesh Street Bhusawal', '05733652988', 'CLC', 'KHMT', 21, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21003205', 'Saksham Khanna', 'Nam', to_date('1994-01-09', 'YYYY-MM-DD'), 'H.No. 703 Char Road Kakinada', '+910776598612', 'VP', 'TGMT', 105, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21003206', 'Onkar Wadhwa', 'Nam', to_date('1909-04-26', 'YYYY-MM-DD'), '04/065 Sridhar Zila Hajipur', '+912574450937', 'CQ', 'TGMT', 6, 5.27);

INSERT INTO SINHVIEN
VALUES ('SV21003207', 'Mehul Dalal', 'Nam', to_date('1971-10-22', 'YYYY-MM-DD'), '60 Sridhar Circle Dewas', '09358062380', 'CTTT', 'CNPM', 132, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21003208', 'Akarsh Bhatia', 'Nam', to_date('1922-06-03', 'YYYY-MM-DD'), 'H.No. 193 Solanki Chowk Motihari', '06521510327', 'CTTT', 'HTTT', 129, 8.62);

INSERT INTO SINHVIEN
VALUES ('SV21003209', 'Samar Sane', 'N?', to_date('1962-04-03', 'YYYY-MM-DD'), '26/713 Dar Road Kozhikode', '9676697218', 'VP', 'CNPM', 94, 7.53);

INSERT INTO SINHVIEN
VALUES ('SV21003210', 'Lavanya Chander', 'N?', to_date('1923-05-03', 'YYYY-MM-DD'), '93/64 Desai Street Dehri', '05450258815', 'CTTT', 'HTTT', 87, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21003211', 'Indrans Ben', 'Nam', to_date('1955-04-26', 'YYYY-MM-DD'), '204 Kale Zila Begusarai', '+919576537499', 'CQ', 'CNTT', 9, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21003212', 'Rohan Mannan', 'Nam', to_date('2004-10-24', 'YYYY-MM-DD'), 'H.No. 310 Cheema Road Nadiad', '9466188271', 'VP', 'CNPM', 104, 4.72);

INSERT INTO SINHVIEN
VALUES ('SV21003213', 'Dishani Batra', 'Nam', to_date('1912-03-06', 'YYYY-MM-DD'), '48 Maharaj Path Unnao', '05015600705', 'CTTT', 'HTTT', 134, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21003214', 'Alisha Kashyap', 'N?', to_date('1968-03-26', 'YYYY-MM-DD'), 'H.No. 498 Lala Path Tadepalligudem', '01428386292', 'CQ', 'MMT', 43, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21003215', 'Vardaniya Magar', 'Nam', to_date('1920-12-07', 'YYYY-MM-DD'), 'H.No. 09 Dora Nagar Muzaffarpur', '1343106506', 'CQ', 'TGMT', 35, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21003216', 'Himmat Sunder', 'N?', to_date('2006-12-09', 'YYYY-MM-DD'), 'H.No. 74 Bhatti Street Allahabad', '+911293438715', 'CQ', 'TGMT', 45, 8.02);

INSERT INTO SINHVIEN
VALUES ('SV21003217', 'Madhav Baral', 'N?', to_date('1978-04-03', 'YYYY-MM-DD'), '10/98 Sarma Path Motihari', '6275462582', 'CQ', 'CNTT', 122, 4.74);

INSERT INTO SINHVIEN
VALUES ('SV21003218', 'Aarav Vala', 'Nam', to_date('1950-01-01', 'YYYY-MM-DD'), 'H.No. 01 Virk Marg Mumbai', '07279285232', 'VP', 'TGMT', 73, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21003219', 'Reyansh Sura', 'N?', to_date('1992-01-20', 'YYYY-MM-DD'), 'H.No. 55 Maharaj Zila Khora ', '+919927431112', 'VP', 'MMT', 15, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21003220', 'Renee Acharya', 'N?', to_date('1923-02-07', 'YYYY-MM-DD'), 'H.No. 21 Bajwa Zila Phagwara', '00742504943', 'CQ', 'CNPM', 83, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21003221', 'Fateh Mangat', 'Nam', to_date('1910-06-03', 'YYYY-MM-DD'), 'H.No. 957 Bedi Road Malegaon', '5062140796', 'CQ', 'HTTT', 71, 8.16);

INSERT INTO SINHVIEN
VALUES ('SV21003222', 'Neelofar Thakur', 'Nam', to_date('1928-06-17', 'YYYY-MM-DD'), '08 Bakshi Circle Surendranagar Dudhrej', '+915042816720', 'VP', 'MMT', 11, 9.15);

INSERT INTO SINHVIEN
VALUES ('SV21003223', 'Navya Vohra', 'Nam', to_date('2002-08-02', 'YYYY-MM-DD'), '32 Das Nagar Hazaribagh', '04146111499', 'CQ', 'KHMT', 133, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21003224', 'Biju Dixit', 'N?', to_date('1939-04-02', 'YYYY-MM-DD'), '615 Kurian Nagar Chennai', '0511371501', 'VP', 'KHMT', 17, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21003225', 'Rhea Kapoor', 'N?', to_date('1958-03-11', 'YYYY-MM-DD'), '269 Bhagat Zila Begusarai', '6009492766', 'CTTT', 'TGMT', 10, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003226', 'Seher Raju', 'Nam', to_date('1919-02-02', 'YYYY-MM-DD'), 'H.No. 42 Soman Ganj Saharanpur', '08920612363', 'VP', 'CNTT', 68, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21003227', 'Fateh Sha', 'Nam', to_date('1996-09-09', 'YYYY-MM-DD'), '64/25 Kunda Nagar Madurai', '+910540064907', 'CQ', 'CNPM', 25, 5.53);

INSERT INTO SINHVIEN
VALUES ('SV21003228', 'Madhav Lad', 'Nam', to_date('1972-05-28', 'YYYY-MM-DD'), 'H.No. 01 Saran Street Etawah', '+915320992028', 'CLC', 'TGMT', 103, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21003229', 'Sana Mandal', 'Nam', to_date('1958-05-29', 'YYYY-MM-DD'), 'H.No. 797 Shan Path Latur', '05133567693', 'CLC', 'CNTT', 121, 5.91);

INSERT INTO SINHVIEN
VALUES ('SV21003230', 'Drishya Bhavsar', 'Nam', to_date('2023-08-20', 'YYYY-MM-DD'), '569 Dhar Nagar Kulti', '02330639149', 'CTTT', 'CNTT', 38, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21003231', 'Aarav Thakkar', 'Nam', to_date('1962-08-28', 'YYYY-MM-DD'), 'H.No. 733 Hayre Marg Junagadh', '02062061948', 'CQ', 'CNPM', 49, 9.55);

INSERT INTO SINHVIEN
VALUES ('SV21003232', 'Seher Sandhu', 'Nam', to_date('1958-07-02', 'YYYY-MM-DD'), '43/765 Banik Road Allahabad', '06059020598', 'VP', 'MMT', 71, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21003233', 'Jayesh Kaur', 'Nam', to_date('2003-10-15', 'YYYY-MM-DD'), 'H.No. 914 Sachar Nagar Dibrugarh', '+918766069907', 'CLC', 'TGMT', 101, 4.96);

INSERT INTO SINHVIEN
VALUES ('SV21003234', 'Urvi Sarma', 'N?', to_date('1953-08-19', 'YYYY-MM-DD'), '19/04 Balan Nagar Sambhal', '1750632917', 'CQ', 'CNTT', 9, 5.76);

INSERT INTO SINHVIEN
VALUES ('SV21003235', 'Vardaniya Kurian', 'Nam', to_date('1938-04-05', 'YYYY-MM-DD'), 'H.No. 293 Sandal Circle Jehanabad', '6634755572', 'VP', 'MMT', 26, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21003236', 'Vidur Gaba', 'Nam', to_date('1963-02-05', 'YYYY-MM-DD'), 'H.No. 57 Sekhon Ganj Vadodara', '01507259239', 'VP', 'MMT', 73, 8.38);

INSERT INTO SINHVIEN
VALUES ('SV21003237', 'Ayesha Bath', 'Nam', to_date('1998-02-03', 'YYYY-MM-DD'), '45 Swaminathan Path Bareilly', '07980344341', 'VP', 'MMT', 26, 5.38);

INSERT INTO SINHVIEN
VALUES ('SV21003238', 'Pihu Gade', 'N?', to_date('2010-02-06', 'YYYY-MM-DD'), 'H.No. 730 Sinha Path Unnao', '09775308654', 'VP', 'MMT', 98, 8.39);

INSERT INTO SINHVIEN
VALUES ('SV21003239', 'Nitya Gara', 'Nam', to_date('1974-10-08', 'YYYY-MM-DD'), '02 Chad Circle Bidar', '8687089020', 'CQ', 'MMT', 112, 4.0);

INSERT INTO SINHVIEN
VALUES ('SV21003240', 'Hiran Taneja', 'N?', to_date('1966-11-09', 'YYYY-MM-DD'), 'H.No. 169 Goel Road Kurnool', '0598521788', 'VP', 'MMT', 116, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21003241', 'Shayak Kibe', 'Nam', to_date('1926-07-13', 'YYYY-MM-DD'), '13 Bandi Nagar Dewas', '1797520217', 'VP', 'KHMT', 39, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21003242', 'Heer Gulati', 'Nam', to_date('1917-06-27', 'YYYY-MM-DD'), '476 Zachariah Ganj Erode', '02379780439', 'VP', 'TGMT', 15, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21003243', 'Aradhya Sarma', 'Nam', to_date('1966-10-16', 'YYYY-MM-DD'), '44/596 Dass Ganj Nadiad', '8164465787', 'CTTT', 'TGMT', 72, 6.88);

INSERT INTO SINHVIEN
VALUES ('SV21003244', 'Romil Sule', 'N?', to_date('1914-11-23', 'YYYY-MM-DD'), '630 Boase Marg Kalyan-Dombivli', '1497954804', 'VP', 'CNPM', 63, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21003245', 'Dhruv Madan', 'N?', to_date('1950-12-22', 'YYYY-MM-DD'), 'H.No. 920 Mangat Nagar Nellore', '0281387565', 'CQ', 'MMT', 22, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21003246', 'Drishya Keer', 'N?', to_date('2022-07-20', 'YYYY-MM-DD'), 'H.No. 59 Dayal Zila Kamarhati', '03850176402', 'CTTT', 'CNTT', 4, 7.86);

INSERT INTO SINHVIEN
VALUES ('SV21003247', 'Sara Sidhu', 'N?', to_date('2015-07-10', 'YYYY-MM-DD'), '08 Lata Road Mirzapur', '+918046762177', 'VP', 'MMT', 11, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21003248', 'Tejas Wagle', 'Nam', to_date('1951-05-24', 'YYYY-MM-DD'), 'H.No. 939 Srinivas Ganj Faridabad', '+917470214744', 'CTTT', 'MMT', 65, 5.2);

INSERT INTO SINHVIEN
VALUES ('SV21003249', 'Divit Sheth', 'N?', to_date('1962-10-05', 'YYYY-MM-DD'), 'H.No. 672 Comar Ganj Pimpri-Chinchwad', '+919071350215', 'CLC', 'CNPM', 111, 5.97);

INSERT INTO SINHVIEN
VALUES ('SV21003250', 'Baiju Tandon', 'N?', to_date('1966-03-02', 'YYYY-MM-DD'), 'H.No. 652 Ramanathan Marg Jhansi', '03717435719', 'VP', 'KHMT', 43, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21003251', 'Prisha Arora', 'Nam', to_date('2003-09-25', 'YYYY-MM-DD'), 'H.No. 97 Varma Path Jehanabad', '+911572996564', 'CLC', 'CNTT', 48, 8.6);

INSERT INTO SINHVIEN
VALUES ('SV21003252', 'Ojas Ahuja', 'Nam', to_date('1908-09-09', 'YYYY-MM-DD'), '23/280 Shenoy Chowk Hapur', '+917386032819', 'CLC', 'TGMT', 6, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21003253', 'Pari Gill', 'Nam', to_date('1912-02-16', 'YYYY-MM-DD'), '55 Barman Ganj Raebareli', '7326478590', 'CTTT', 'CNTT', 32, 9.26);

INSERT INTO SINHVIEN
VALUES ('SV21003254', 'Prerak Bajwa', 'Nam', to_date('1940-02-11', 'YYYY-MM-DD'), '23/66 Golla Bilaspur', '2365214341', 'CLC', 'TGMT', 23, 6.97);

INSERT INTO SINHVIEN
VALUES ('SV21003255', 'Keya Char', 'N?', to_date('1996-07-01', 'YYYY-MM-DD'), '19/51 Tandon Circle Junagadh', '+917444957302', 'CTTT', 'TGMT', 85, 9.63);

INSERT INTO SINHVIEN
VALUES ('SV21003256', 'Ryan Khosla', 'N?', to_date('2010-12-31', 'YYYY-MM-DD'), 'H.No. 54 Bava Nagar Avadi', '+917335854799', 'CQ', 'MMT', 63, 9.22);

INSERT INTO SINHVIEN
VALUES ('SV21003257', 'Rhea Tak', 'N?', to_date('1921-10-16', 'YYYY-MM-DD'), '74/754 Tripathi Road Kanpur', '1262539294', 'VP', 'CNPM', 13, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21003258', 'Riaan Chawla', 'N?', to_date('1938-12-22', 'YYYY-MM-DD'), 'H.No. 45 Varghese Ganj Ujjain', '1954919211', 'CTTT', 'MMT', 137, 9.15);

INSERT INTO SINHVIEN
VALUES ('SV21003259', 'Aarush Grover', 'N?', to_date('1917-05-18', 'YYYY-MM-DD'), '51 Deep Chowk Aurangabad', '2567073424', 'CQ', 'TGMT', 41, 7.35);

INSERT INTO SINHVIEN
VALUES ('SV21003260', 'Gatik Gupta', 'Nam', to_date('2018-03-16', 'YYYY-MM-DD'), 'H.No. 01 Thakur Circle Mangalore', '+913175175460', 'CQ', 'MMT', 68, 9.93);

INSERT INTO SINHVIEN
VALUES ('SV21003261', 'Advik Gade', 'Nam', to_date('1995-03-23', 'YYYY-MM-DD'), 'H.No. 481 Chokshi Circle Tadepalligudem', '00394722090', 'CQ', 'CNPM', 47, 8.16);

INSERT INTO SINHVIEN
VALUES ('SV21003262', 'Saanvi Tank', 'Nam', to_date('1959-04-09', 'YYYY-MM-DD'), '85 Dua Road Salem', '+911451084220', 'CLC', 'MMT', 121, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21003263', 'Raunak Babu', 'Nam', to_date('1976-10-01', 'YYYY-MM-DD'), 'H.No. 989 Mander Path Kollam', '6554072910', 'CLC', 'TGMT', 101, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21003264', 'Tarini Bose', 'Nam', to_date('1993-09-18', 'YYYY-MM-DD'), '61/011 Chaudry Road Berhampur', '5733700535', 'CLC', 'CNPM', 90, 5.49);

INSERT INTO SINHVIEN
VALUES ('SV21003265', 'Kavya Sule', 'Nam', to_date('2010-02-22', 'YYYY-MM-DD'), '08/17 Mani Nagar Guntur', '+919860876432', 'CLC', 'KHMT', 44, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21003266', 'Diya Saraf', 'N?', to_date('1965-01-09', 'YYYY-MM-DD'), '80/965 Brahmbhatt Chowk Sambalpur', '7349576166', 'VP', 'CNPM', 58, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21003267', 'Bhamini Kanda', 'N?', to_date('2014-11-04', 'YYYY-MM-DD'), '90/382 Zacharia Ganj Srikakulam', '07653719267', 'CTTT', 'HTTT', 24, 4.69);

INSERT INTO SINHVIEN
VALUES ('SV21003268', 'Keya Sawhney', 'N?', to_date('1922-04-11', 'YYYY-MM-DD'), '06/809 Doctor Warangal', '9879413471', 'CQ', 'CNPM', 11, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21003269', 'Miraan Wali', 'Nam', to_date('1935-01-04', 'YYYY-MM-DD'), '96/143 Grewal Road Katni', '+911352083284', 'CTTT', 'TGMT', 57, 9.13);

INSERT INTO SINHVIEN
VALUES ('SV21003270', 'Rhea Sane', 'N?', to_date('1961-09-26', 'YYYY-MM-DD'), 'H.No. 57 Majumdar Rajpur Sonarpur', '06487785300', 'CTTT', 'CNTT', 111, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21003271', 'Keya Sant', 'N?', to_date('1911-03-28', 'YYYY-MM-DD'), '196 Balasubramanian Marg Siwan', '06966104132', 'CLC', 'HTTT', 114, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21003272', 'Kartik Vaidya', 'Nam', to_date('1992-08-09', 'YYYY-MM-DD'), '785 Kant Path Sri Ganganagar', '05453218837', 'VP', 'KHMT', 2, 7.95);

INSERT INTO SINHVIEN
VALUES ('SV21003273', 'Abram Rege', 'Nam', to_date('1955-12-25', 'YYYY-MM-DD'), '83/88 Mani Nagar Raurkela Industrial Township', '+918178334899', 'CQ', 'TGMT', 3, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21003274', 'Yuvraj  Kapoor', 'Nam', to_date('1979-02-18', 'YYYY-MM-DD'), 'H.No. 357 Johal Zila Eluru', '02537126883', 'CQ', 'CNPM', 88, 8.63);

INSERT INTO SINHVIEN
VALUES ('SV21003275', 'Ishaan Ratti', 'Nam', to_date('1958-04-05', 'YYYY-MM-DD'), 'H.No. 81 Golla Zila Kadapa', '07032827240', 'VP', 'HTTT', 49, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21003276', 'Aarav Borah', 'Nam', to_date('2010-11-13', 'YYYY-MM-DD'), '707 Chacko Street Madurai', '+916467084597', 'VP', 'TGMT', 50, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21003277', 'Ivan Kamdar', 'N?', to_date('1941-02-21', 'YYYY-MM-DD'), 'H.No. 808 Suresh Ganj Jaipur', '05961356406', 'CTTT', 'HTTT', 34, 6.81);

INSERT INTO SINHVIEN
VALUES ('SV21003278', 'Uthkarsh Sanghvi', 'Nam', to_date('1908-12-11', 'YYYY-MM-DD'), '130 Sen Street Dewas', '+913685170943', 'VP', 'HTTT', 17, 6.8);

INSERT INTO SINHVIEN
VALUES ('SV21003279', 'Raunak Chanda', 'Nam', to_date('1994-10-22', 'YYYY-MM-DD'), '99 Divan Kamarhati', '+917181092335', 'CLC', 'HTTT', 106, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21003280', 'Faiyaz Bajaj', 'Nam', to_date('1932-10-05', 'YYYY-MM-DD'), '413 Wali Bulandshahr', '01393422341', 'CLC', 'CNPM', 101, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21003281', 'Aarush Sheth', 'N?', to_date('1922-05-19', 'YYYY-MM-DD'), '174 Bandi Street Aizawl', '03167443919', 'VP', 'CNPM', 50, 8.49);

INSERT INTO SINHVIEN
VALUES ('SV21003282', 'Anay Dasgupta', 'N?', to_date('1967-10-13', 'YYYY-MM-DD'), '99 Mannan Gangtok', '+910529179742', 'CTTT', 'CNPM', 54, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21003283', 'Lavanya Maharaj', 'N?', to_date('1976-12-09', 'YYYY-MM-DD'), 'H.No. 412 Kunda Chowk Sonipat', '05364937451', 'CQ', 'MMT', 7, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21003284', 'Farhan Sur', 'Nam', to_date('1925-01-17', 'YYYY-MM-DD'), '240 Kaur Circle Raiganj', '+913906466069', 'CTTT', 'HTTT', 68, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21003285', 'Renee Walla', 'Nam', to_date('1992-11-22', 'YYYY-MM-DD'), 'H.No. 35 Saha Aizawl', '03588403549', 'VP', 'MMT', 135, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21003286', 'Jhanvi Shah', 'Nam', to_date('1954-11-17', 'YYYY-MM-DD'), '79/32 Ram Circle Jabalpur', '+914226367092', 'CTTT', 'KHMT', 52, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21003287', 'Vardaniya Borah', 'N?', to_date('1973-10-08', 'YYYY-MM-DD'), 'H.No. 19 Kohli Marg Satara', '09353621336', 'CQ', 'MMT', 22, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21003288', 'Hazel Basu', 'N?', to_date('1922-04-05', 'YYYY-MM-DD'), '54/95 Yadav Path Bettiah', '7754485779', 'CTTT', 'CNPM', 45, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21003289', 'Damini Virk', 'Nam', to_date('1957-08-17', 'YYYY-MM-DD'), 'H.No. 41 Devi Road Mysore', '01606877732', 'VP', 'HTTT', 15, 6.44);

INSERT INTO SINHVIEN
VALUES ('SV21003290', 'Kartik Sankaran', 'N?', to_date('1987-11-14', 'YYYY-MM-DD'), '07 Gandhi Ganj Suryapet', '+918607117008', 'CQ', 'TGMT', 39, 9.34);

INSERT INTO SINHVIEN
VALUES ('SV21003291', 'Jhanvi Bandi', 'N?', to_date('1950-03-02', 'YYYY-MM-DD'), 'H.No. 78 Chaudry Nagar Bhusawal', '1666745411', 'CQ', 'HTTT', 11, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21003292', 'Kiara Kashyap', 'Nam', to_date('2021-11-05', 'YYYY-MM-DD'), 'H.No. 72 Bhasin Marg Agartala', '09743732136', 'VP', 'TGMT', 39, 6.55);

INSERT INTO SINHVIEN
VALUES ('SV21003293', 'Shray Singh', 'Nam', to_date('1944-01-25', 'YYYY-MM-DD'), '291 Hora Path Haridwar', '01601779021', 'CLC', 'CNTT', 29, 7.45);

INSERT INTO SINHVIEN
VALUES ('SV21003294', 'Tiya Bumb', 'N?', to_date('1931-12-14', 'YYYY-MM-DD'), '76 Gara Zila Arrah', '+910896708346', 'CQ', 'CNPM', 19, 9.74);

INSERT INTO SINHVIEN
VALUES ('SV21003295', 'Keya Madan', 'N?', to_date('1971-05-01', 'YYYY-MM-DD'), '63/404 Mall Ganj Bidar', '9228792684', 'CTTT', 'KHMT', 122, 4.92);

INSERT INTO SINHVIEN
VALUES ('SV21003296', 'Aradhya Mallick', 'Nam', to_date('1973-04-29', 'YYYY-MM-DD'), 'H.No. 852 Lala Chowk Delhi', '9762224895', 'CLC', 'HTTT', 65, 6.43);

INSERT INTO SINHVIEN
VALUES ('SV21003297', 'Kavya Sabharwal', 'N?', to_date('1967-08-03', 'YYYY-MM-DD'), '82 Sarna Chowk Purnia', '+917925251359', 'CQ', 'TGMT', 133, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21003298', 'Vedika Koshy', 'Nam', to_date('1984-07-12', 'YYYY-MM-DD'), '29/88 Karnik Road Berhampore', '06219815297', 'CLC', 'TGMT', 92, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21003299', 'Zaina Rege', 'N?', to_date('1989-07-26', 'YYYY-MM-DD'), 'H.No. 63 Karan Chowk Mahbubnagar', '+912539974100', 'CTTT', 'HTTT', 10, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21003300', 'Keya Sankar', 'Nam', to_date('2005-04-06', 'YYYY-MM-DD'), '82 Doshi Zila Sasaram', '+910075445441', 'CQ', 'CNPM', 110, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21003301', 'Nayantara Sule', 'N?', to_date('1926-02-28', 'YYYY-MM-DD'), '55 Swaminathan Path Machilipatnam', '+912338312699', 'VP', 'KHMT', 86, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21003302', 'Yasmin Goel', 'N?', to_date('1950-10-11', 'YYYY-MM-DD'), '47 Uppal Tirupati', '+917262599861', 'CTTT', 'CNPM', 113, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21003303', 'Vanya Ganesh', 'N?', to_date('1968-03-22', 'YYYY-MM-DD'), '23 Bora Ganj Satna', '8026475757', 'VP', 'TGMT', 47, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21003304', 'Akarsh Swamy', 'N?', to_date('1938-06-14', 'YYYY-MM-DD'), '988 Raja Zila Ambattur', '3392930414', 'VP', 'TGMT', 30, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21003305', 'Rasha Mammen', 'N?', to_date('2012-11-23', 'YYYY-MM-DD'), 'H.No. 30 Mani Nagar Warangal', '+911692323787', 'CTTT', 'CNPM', 11, 7.82);

INSERT INTO SINHVIEN
VALUES ('SV21003306', 'Emir Mane', 'N?', to_date('1928-10-03', 'YYYY-MM-DD'), '59/993 Andra Jamnagar', '+910099342284', 'CTTT', 'CNPM', 48, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21003307', 'Emir Baria', 'Nam', to_date('2010-07-16', 'YYYY-MM-DD'), '43/00 Comar Circle Danapur', '+913960332134', 'CTTT', 'CNPM', 115, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21003308', 'Gatik Chad', 'Nam', to_date('2002-06-20', 'YYYY-MM-DD'), '94/636 Upadhyay Chowk Jalgaon', '+911245660151', 'CTTT', 'TGMT', 10, 5.85);

INSERT INTO SINHVIEN
VALUES ('SV21003309', 'Nishith Rastogi', 'N?', to_date('2013-06-19', 'YYYY-MM-DD'), '93/109 Kata Ganj Silchar', '4697932794', 'CQ', 'MMT', 85, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21003310', 'Yuvaan Dhar', 'Nam', to_date('1939-04-13', 'YYYY-MM-DD'), 'H.No. 25 Thaman Circle Guwahati', '05827080415', 'CTTT', 'MMT', 37, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21003311', 'Aradhya Bhatti', 'N?', to_date('1951-11-13', 'YYYY-MM-DD'), '08/89 Bahri Marg Kochi', '0135819508', 'CTTT', 'HTTT', 132, 9.85);

INSERT INTO SINHVIEN
VALUES ('SV21003312', 'Aniruddh Varghese', 'Nam', to_date('1925-11-27', 'YYYY-MM-DD'), '58/808 Randhawa Zila Muzaffarpur', '1701455698', 'VP', 'HTTT', 32, 9.87);

INSERT INTO SINHVIEN
VALUES ('SV21003313', 'Divij Balakrishnan', 'N?', to_date('1983-09-14', 'YYYY-MM-DD'), '634 Maharaj Zila Patna', '+918188110868', 'CLC', 'CNPM', 66, 6.32);

INSERT INTO SINHVIEN
VALUES ('SV21003314', 'Vanya Sengupta', 'N?', to_date('1983-02-18', 'YYYY-MM-DD'), '814 Sule Road Udaipur', '06545793731', 'CQ', 'MMT', 124, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21003315', 'Vaibhav Walia', 'N?', to_date('1937-02-17', 'YYYY-MM-DD'), '96/03 Handa Chowk Hospet', '+911108972012', 'CQ', 'CNTT', 113, 5.73);

INSERT INTO SINHVIEN
VALUES ('SV21003316', 'Diya Buch', 'Nam', to_date('1923-05-09', 'YYYY-MM-DD'), '383 Kohli Street Durg', '00457682321', 'VP', 'CNTT', 9, 7.59);

INSERT INTO SINHVIEN
VALUES ('SV21003317', 'Tejas Din', 'N?', to_date('1989-10-07', 'YYYY-MM-DD'), 'H.No. 96 Dhingra Nagar Morbi', '4046959795', 'VP', 'HTTT', 30, 8.34);

INSERT INTO SINHVIEN
VALUES ('SV21003318', 'Bhavin Bahl', 'Nam', to_date('1920-04-24', 'YYYY-MM-DD'), 'H.No. 784 Toor Ratlam', '+914123827178', 'VP', 'KHMT', 92, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21003319', 'Riya Shetty', 'Nam', to_date('1966-09-22', 'YYYY-MM-DD'), 'H.No. 52 Din Anantapur', '06570258768', 'CLC', 'TGMT', 79, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21003320', 'Mehul Balan', 'Nam', to_date('1973-06-08', 'YYYY-MM-DD'), '22/13 Rajagopalan Chowk Mira-Bhayandar', '08182680432', 'CQ', 'CNPM', 36, 4.12);

INSERT INTO SINHVIEN
VALUES ('SV21003321', 'Vivaan Tak', 'N?', to_date('1972-05-29', 'YYYY-MM-DD'), '59 Dave Nagar Begusarai', '0464736764', 'VP', 'TGMT', 106, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21003322', 'Anvi Toor', 'Nam', to_date('1991-09-07', 'YYYY-MM-DD'), 'H.No. 25 Grover Path Panipat', '09368965960', 'CTTT', 'CNPM', 124, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21003323', 'Dhanush Bakshi', 'N?', to_date('2004-11-06', 'YYYY-MM-DD'), 'H.No. 225 Shah Marg Kanpur', '+912116345550', 'CTTT', 'CNPM', 83, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21003324', 'Lakshay Jhaveri', 'Nam', to_date('1976-06-07', 'YYYY-MM-DD'), '92/013 Deshmukh Path Nadiad', '3688494662', 'CQ', 'KHMT', 10, 7.12);

INSERT INTO SINHVIEN
VALUES ('SV21003325', 'Hrishita Dugar', 'N?', to_date('2007-06-12', 'YYYY-MM-DD'), 'H.No. 801 Kohli Street Sultan Pur Majra', '2526785871', 'VP', 'TGMT', 27, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003326', 'Vardaniya Uppal', 'Nam', to_date('1920-05-23', 'YYYY-MM-DD'), 'H.No. 086 Date Zila Junagadh', '+917420686011', 'CLC', 'HTTT', 24, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21003327', 'Himmat Joshi', 'N?', to_date('1911-08-08', 'YYYY-MM-DD'), 'H.No. 673 Soni Nagar Alwar', '+916527296876', 'CLC', 'CNTT', 68, 7.17);

INSERT INTO SINHVIEN
VALUES ('SV21003328', 'Emir Kakar', 'Nam', to_date('1982-04-25', 'YYYY-MM-DD'), '371 Kamdar Tenali', '+910105876097', 'CTTT', 'TGMT', 91, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21003329', 'Renee Behl', 'Nam', to_date('2013-11-19', 'YYYY-MM-DD'), '36 Saraf Road Unnao', '0317349855', 'CLC', 'CNTT', 89, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21003330', 'Biju Ahuja', 'N?', to_date('1963-05-08', 'YYYY-MM-DD'), 'H.No. 87 Boase Chowk Chandigarh', '+918864239434', 'CLC', 'TGMT', 70, 6.62);

INSERT INTO SINHVIEN
VALUES ('SV21003331', 'Devansh Buch', 'N?', to_date('1925-01-27', 'YYYY-MM-DD'), '713 Buch Chowk Kharagpur', '09134113091', 'CTTT', 'TGMT', 109, 6.2);

INSERT INTO SINHVIEN
VALUES ('SV21003332', 'Eva Ram', 'Nam', to_date('1991-01-16', 'YYYY-MM-DD'), '77 Mangat Path Mumbai', '01804797847', 'VP', 'CNPM', 67, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21003333', 'Ela Thakur', 'N?', to_date('1930-08-16', 'YYYY-MM-DD'), 'H.No. 834 Sami Ganj Orai', '3067546057', 'VP', 'KHMT', 112, 5.9);

INSERT INTO SINHVIEN
VALUES ('SV21003334', 'Samaira Brar', 'N?', to_date('1965-03-22', 'YYYY-MM-DD'), 'H.No. 994 Dhawan Chowk Bardhaman', '+913685238138', 'CTTT', 'CNPM', 98, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21003335', 'Bhamini Aggarwal', 'Nam', to_date('1921-01-12', 'YYYY-MM-DD'), 'H.No. 920 Bansal Marg Akola', '+915182063418', 'CLC', 'CNPM', 88, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21003336', 'Anvi Thakkar', 'N?', to_date('1929-06-29', 'YYYY-MM-DD'), '14/464 Amble Chowk Yamunanagar', '0454924688', 'CTTT', 'HTTT', 2, 5.23);

INSERT INTO SINHVIEN
VALUES ('SV21003337', 'Gokul Gopal', 'N?', to_date('1995-07-03', 'YYYY-MM-DD'), 'H.No. 93 Banerjee Street Kadapa', '+916544242035', 'CLC', 'CNTT', 56, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21003338', 'Anahi Barad', 'N?', to_date('1976-05-03', 'YYYY-MM-DD'), 'H.No. 14 Dass Marg Faridabad', '7938195830', 'CLC', 'KHMT', 90, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21003339', 'Divyansh Hayer', 'Nam', to_date('1919-04-05', 'YYYY-MM-DD'), 'H.No. 657 Rastogi Circle Hubli�CDharwad', '04606439381', 'CLC', 'TGMT', 60, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21003340', 'Tushar Mallick', 'N?', to_date('1939-07-21', 'YYYY-MM-DD'), '65 Karan Ganj Pondicherry', '8114168714', 'CTTT', 'KHMT', 11, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21003341', 'Divij Vyas', 'Nam', to_date('1970-07-09', 'YYYY-MM-DD'), '95 Mangat Nagar Belgaum', '5072442927', 'CTTT', 'HTTT', 51, 9.77);

INSERT INTO SINHVIEN
VALUES ('SV21003342', 'Adira Ranganathan', 'Nam', to_date('1927-04-20', 'YYYY-MM-DD'), 'H.No. 962 Dua Road Coimbatore', '2340787578', 'CQ', 'MMT', 39, 7.59);

INSERT INTO SINHVIEN
VALUES ('SV21003343', 'Manikya Thaker', 'N?', to_date('1927-03-25', 'YYYY-MM-DD'), 'H.No. 41 Sidhu Street Patiala', '01298935773', 'CLC', 'CNPM', 50, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21003344', 'Reyansh Kar', 'N?', to_date('2009-11-17', 'YYYY-MM-DD'), '34 Biswas Ganj Sikar', '+915504200676', 'CTTT', 'MMT', 136, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21003345', 'Shayak Vig', 'Nam', to_date('1992-12-26', 'YYYY-MM-DD'), '43 Baria Sasaram', '03017862293', 'CTTT', 'KHMT', 68, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21003346', 'Baiju Kothari', 'N?', to_date('2019-07-19', 'YYYY-MM-DD'), '199 Choudhury Circle Muzaffarnagar', '+914047164388', 'CQ', 'HTTT', 118, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21003347', 'Piya Arora', 'N?', to_date('1971-07-12', 'YYYY-MM-DD'), '503 Sampath Road Bongaigaon', '+916655958101', 'CQ', 'CNTT', 2, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003348', 'Mehul Malhotra', 'N?', to_date('1994-04-27', 'YYYY-MM-DD'), '89/612 Vora Ganj Karaikudi', '+913766359797', 'CTTT', 'CNPM', 40, 7.35);

INSERT INTO SINHVIEN
VALUES ('SV21003349', 'Farhan Balasubramanian', 'Nam', to_date('1943-03-14', 'YYYY-MM-DD'), 'H.No. 92 Dass Panihati', '03688139545', 'VP', 'CNTT', 104, 4.64);

INSERT INTO SINHVIEN
VALUES ('SV21003350', 'Ira Comar', 'N?', to_date('1955-05-01', 'YYYY-MM-DD'), 'H.No. 81 Chanda Bareilly', '+910371770662', 'CTTT', 'MMT', 131, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21003351', 'Hansh Bath', 'Nam', to_date('1927-10-19', 'YYYY-MM-DD'), '03/633 Garg Circle Karawal Nagar', '7253015877', 'CLC', 'CNTT', 117, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21003352', 'Myra Bhavsar', 'Nam', to_date('1995-01-09', 'YYYY-MM-DD'), 'H.No. 250 Vyas Chowk Panipat', '3255008699', 'VP', 'MMT', 105, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21003353', 'Shamik Krishna', 'Nam', to_date('1925-09-02', 'YYYY-MM-DD'), '12 Kari Circle Katni', '4679162107', 'CLC', 'HTTT', 131, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21003354', 'Amira Sarna', 'Nam', to_date('2006-09-20', 'YYYY-MM-DD'), 'H.No. 936 Sarma Chowk Katihar', '0584485191', 'CTTT', 'MMT', 57, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21003355', 'Indranil Kapoor', 'Nam', to_date('1930-10-06', 'YYYY-MM-DD'), 'H.No. 07 Virk Marg Jhansi', '08328878017', 'CQ', 'HTTT', 101, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21003356', 'Drishya Sood', 'Nam', to_date('1912-01-12', 'YYYY-MM-DD'), 'H.No. 523 Chaudry Nagar Imphal', '+913105479658', 'VP', 'HTTT', 116, 9.32);

INSERT INTO SINHVIEN
VALUES ('SV21003357', 'Dishani Doshi', 'Nam', to_date('1909-03-18', 'YYYY-MM-DD'), 'H.No. 639 Sen Nagar Mehsana', '+917976439980', 'CTTT', 'MMT', 106, 8.73);

INSERT INTO SINHVIEN
VALUES ('SV21003358', 'Indrajit Bahri', 'Nam', to_date('1936-06-04', 'YYYY-MM-DD'), 'H.No. 40 Wable Ambattur', '+911899467878', 'CTTT', 'HTTT', 109, 7.46);

INSERT INTO SINHVIEN
VALUES ('SV21003359', 'Ojas Dar', 'Nam', to_date('1924-06-05', 'YYYY-MM-DD'), '919 Anne Path Ahmedabad', '03390258761', 'CTTT', 'CNPM', 118, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21003360', 'Armaan Maharaj', 'N?', to_date('1969-10-03', 'YYYY-MM-DD'), '544 Kapadia Sambalpur', '+914402398529', 'CLC', 'KHMT', 22, 9.16);

INSERT INTO SINHVIEN
VALUES ('SV21003361', 'Shamik Koshy', 'Nam', to_date('1955-11-10', 'YYYY-MM-DD'), '75 Chaudhari Chowk Rajpur Sonarpur', '01916223521', 'CLC', 'CNTT', 74, 9.82);

INSERT INTO SINHVIEN
VALUES ('SV21003362', 'Adira Sabharwal', 'N?', to_date('1942-05-15', 'YYYY-MM-DD'), '60 Wali Street Baranagar', '05438168875', 'CLC', 'HTTT', 92, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21003363', 'Vedika Korpal', 'N?', to_date('1953-12-19', 'YYYY-MM-DD'), '73 Bora Chowk Madhyamgram', '02522082021', 'CLC', 'HTTT', 21, 7.89);

INSERT INTO SINHVIEN
VALUES ('SV21003364', 'Tara Bhat', 'Nam', to_date('1957-10-19', 'YYYY-MM-DD'), '45/37 Raju Path Shimoga', '+916288362784', 'CQ', 'MMT', 65, 6.37);

INSERT INTO SINHVIEN
VALUES ('SV21003365', 'Mannat Master', 'Nam', to_date('1930-08-06', 'YYYY-MM-DD'), '667 Deol Marg Sasaram', '07296988036', 'CQ', 'TGMT', 70, 8.11);

INSERT INTO SINHVIEN
VALUES ('SV21003366', 'Shalv Vora', 'Nam', to_date('2008-04-28', 'YYYY-MM-DD'), 'H.No. 163 Contractor Marg Ambala', '09139595081', 'CQ', 'MMT', 82, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21003367', 'Zoya Saxena', 'N?', to_date('1942-06-24', 'YYYY-MM-DD'), '074 Kibe Circle Secunderabad', '05223514211', 'CTTT', 'CNPM', 72, 8.66);

INSERT INTO SINHVIEN
VALUES ('SV21003368', 'Ryan Bath', 'N?', to_date('1928-07-25', 'YYYY-MM-DD'), 'H.No. 835 Bhatia Circle Saharanpur', '7349557397', 'CQ', 'TGMT', 115, 8.39);

INSERT INTO SINHVIEN
VALUES ('SV21003369', 'Nirvi Bora', 'Nam', to_date('1948-07-07', 'YYYY-MM-DD'), 'H.No. 75 Rattan Road Kavali', '8719784899', 'CLC', 'KHMT', 53, 7.3);

INSERT INTO SINHVIEN
VALUES ('SV21003370', 'Riya Wason', 'Nam', to_date('1934-12-05', 'YYYY-MM-DD'), '21 Thaman Circle Hindupur', '06478748665', 'VP', 'CNPM', 94, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21003371', 'Miraan Aggarwal', 'N?', to_date('1962-08-25', 'YYYY-MM-DD'), '29 Datta Street Nandyal', '5371851929', 'CLC', 'HTTT', 82, 6.27);

INSERT INTO SINHVIEN
VALUES ('SV21003372', 'Neelofar Tara', 'Nam', to_date('1951-08-19', 'YYYY-MM-DD'), '98/893 Loke Sikar', '+915933852925', 'VP', 'CNTT', 61, 4.69);

INSERT INTO SINHVIEN
VALUES ('SV21003373', 'Hansh Uppal', 'N?', to_date('1973-03-11', 'YYYY-MM-DD'), '98/18 Choudhury Road Mau', '+913159991625', 'CTTT', 'HTTT', 12, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21003374', 'Shlok Shetty', 'N?', to_date('1994-05-27', 'YYYY-MM-DD'), '76 Dar Nagar Miryalaguda', '+915231989676', 'CQ', 'CNTT', 11, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21003375', 'Ranbir Sastry', 'N?', to_date('1954-10-14', 'YYYY-MM-DD'), '815 Lala Street Gaya', '02352957156', 'CQ', 'CNPM', 25, 6.56);

INSERT INTO SINHVIEN
VALUES ('SV21003376', 'Renee Anne', 'Nam', to_date('1929-07-09', 'YYYY-MM-DD'), '04 Kale Marg Ballia', '+917504712033', 'CTTT', 'HTTT', 74, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21003377', 'Dhruv Kunda', 'Nam', to_date('2001-12-14', 'YYYY-MM-DD'), '33/63 Lad Nagar Ambattur', '04528048070', 'VP', 'MMT', 130, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21003378', 'Onkar Sandhu', 'Nam', to_date('2014-02-12', 'YYYY-MM-DD'), '326 Kanda Path Proddatur', '6878529925', 'CLC', 'CNPM', 89, 8.79);

INSERT INTO SINHVIEN
VALUES ('SV21003379', 'Sara Mannan', 'N?', to_date('1974-03-22', 'YYYY-MM-DD'), '30/781 Virk Ganj Muzaffarnagar', '05982854664', 'CTTT', 'CNPM', 129, 5.56);

INSERT INTO SINHVIEN
VALUES ('SV21003380', 'Emir Bhattacharyya', 'N?', to_date('1961-08-13', 'YYYY-MM-DD'), 'H.No. 78 Sule Path Alwar', '6679747275', 'CTTT', 'CNTT', 87, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21003381', 'Pranay Vyas', 'Nam', to_date('1925-11-26', 'YYYY-MM-DD'), '33/21 Goyal Circle Raichur', '05041315354', 'CLC', 'CNPM', 69, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21003382', 'Azad Ranganathan', 'N?', to_date('1923-12-24', 'YYYY-MM-DD'), '66/046 Sundaram Path Anantapuram', '01156015496', 'CQ', 'CNTT', 107, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21003383', 'Arhaan Zachariah', 'Nam', to_date('1995-08-22', 'YYYY-MM-DD'), 'H.No. 20 Sastry Marg Bareilly', '02497951892', 'CTTT', 'MMT', 84, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21003384', 'Samar Yohannan', 'N?', to_date('1997-11-16', 'YYYY-MM-DD'), '95 Grewal Ganj Jamnagar', '01239025925', 'VP', 'HTTT', 25, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21003385', 'Nitya Agarwal', 'N?', to_date('1923-06-27', 'YYYY-MM-DD'), 'H.No. 675 Chaudhary Marg Bhalswa Jahangir Pur', '9837013074', 'VP', 'MMT', 120, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21003386', 'Jayant Ramakrishnan', 'N?', to_date('2016-01-01', 'YYYY-MM-DD'), '00/098 Banik Path Erode', '09967544022', 'CTTT', 'KHMT', 52, 5.03);

INSERT INTO SINHVIEN
VALUES ('SV21003387', 'Hunar Bhatti', 'N?', to_date('1913-08-23', 'YYYY-MM-DD'), '18/77 D��Alia Zila Bhalswa Jahangir Pur', '+919530097940', 'CLC', 'KHMT', 45, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21003388', 'Mahika Bera', 'Nam', to_date('1937-11-28', 'YYYY-MM-DD'), 'H.No. 366 Guha Road Gopalpur', '00949594663', 'CQ', 'KHMT', 0, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21003389', 'Anahita Bhatnagar', 'N?', to_date('1928-12-04', 'YYYY-MM-DD'), '054 Thaman Street Hosur', '00720807414', 'CQ', 'CNTT', 109, 9.68);

INSERT INTO SINHVIEN
VALUES ('SV21003390', 'Madhup Chopra', 'N?', to_date('1923-04-02', 'YYYY-MM-DD'), 'H.No. 261 Rama Road Bikaner', '06312432050', 'CLC', 'KHMT', 43, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21003391', 'Arnav Choudhary', 'Nam', to_date('1966-04-09', 'YYYY-MM-DD'), 'H.No. 955 Karpe Marg Bhusawal', '+919512786451', 'VP', 'CNPM', 0, 6.13);

INSERT INTO SINHVIEN
VALUES ('SV21003392', 'Ojas Lal', 'N?', to_date('2002-11-09', 'YYYY-MM-DD'), '50/614 Kunda Road Gurgaon', '00828297457', 'CQ', 'CNTT', 111, 6.47);

INSERT INTO SINHVIEN
VALUES ('SV21003393', 'Oorja Goyal', 'N?', to_date('2016-08-08', 'YYYY-MM-DD'), '248 Dani Dewas', '+910829490482', 'VP', 'MMT', 124, 9.91);

INSERT INTO SINHVIEN
VALUES ('SV21003394', 'Taran Bath', 'N?', to_date('1908-08-01', 'YYYY-MM-DD'), '19/87 Kala Path Firozabad', '6208460453', 'CTTT', 'CNPM', 87, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21003395', 'Rania Butala', 'Nam', to_date('1930-08-16', 'YYYY-MM-DD'), '44 Bhardwaj Road Hubli�CDharwad', '05170950058', 'CLC', 'TGMT', 90, 5.34);

INSERT INTO SINHVIEN
VALUES ('SV21003396', 'Neysa Lanka', 'Nam', to_date('1923-07-30', 'YYYY-MM-DD'), 'H.No. 578 Jayaraman Street Allahabad', '+910741701780', 'VP', 'HTTT', 96, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21003397', 'Vedika Sunder', 'N?', to_date('1999-05-08', 'YYYY-MM-DD'), '40/555 Lalla Road Rampur', '03666182892', 'VP', 'KHMT', 78, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21003398', 'Inaaya  Lall', 'N?', to_date('1914-01-26', 'YYYY-MM-DD'), 'H.No. 209 Iyer Street Sambalpur', '08308142678', 'CTTT', 'TGMT', 0, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21003399', 'Vaibhav Krishna', 'Nam', to_date('2001-11-15', 'YYYY-MM-DD'), '805 Srinivas Silchar', '06517967017', 'CQ', 'KHMT', 121, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21003400', 'Reyansh Chad', 'N?', to_date('2011-07-27', 'YYYY-MM-DD'), '67/756 Grover Path Ahmedabad', '7336560112', 'CQ', 'TGMT', 122, 8.38);

INSERT INTO SINHVIEN
VALUES ('SV21003401', 'Faiyaz Dhingra', 'N?', to_date('1937-09-17', 'YYYY-MM-DD'), '66/80 Yadav Circle Kharagpur', '+917112549484', 'CLC', 'HTTT', 69, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21003402', 'Arnav Bhandari', 'N?', to_date('1970-07-31', 'YYYY-MM-DD'), '38/679 Goda Road Karnal', '+913126590238', 'CTTT', 'CNPM', 21, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21003403', 'Anahi Kapur', 'Nam', to_date('1966-01-03', 'YYYY-MM-DD'), 'H.No. 054 Gill Chowk Sri Ganganagar', '1333883326', 'VP', 'HTTT', 130, 9.06);

INSERT INTO SINHVIEN
VALUES ('SV21003404', 'Prerak Edwin', 'N?', to_date('2004-12-28', 'YYYY-MM-DD'), '151 Saraf Path Deoghar', '8950602933', 'VP', 'KHMT', 59, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21003405', 'Kashvi Kari', 'Nam', to_date('2010-06-08', 'YYYY-MM-DD'), '20/30 Aggarwal Street Dibrugarh', '7465612062', 'VP', 'CNPM', 99, 9.45);

INSERT INTO SINHVIEN
VALUES ('SV21003406', 'Mamooty Arora', 'N?', to_date('2012-11-12', 'YYYY-MM-DD'), 'H.No. 89 Ramaswamy Road Kota', '+918195057882', 'CQ', 'TGMT', 54, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21003407', 'Khushi Goyal', 'N?', to_date('1948-06-09', 'YYYY-MM-DD'), '46/39 Kadakia Zila Tumkur', '05991270591', 'VP', 'CNPM', 21, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21003408', 'Alisha Chaudhari', 'Nam', to_date('1917-08-05', 'YYYY-MM-DD'), '06 Warrior Road Bhavnagar', '02566856152', 'VP', 'HTTT', 48, 7.77);

INSERT INTO SINHVIEN
VALUES ('SV21003409', 'Oorja Bandi', 'N?', to_date('1942-12-30', 'YYYY-MM-DD'), 'H.No. 22 Basu Circle Fatehpur', '03646599183', 'VP', 'CNTT', 78, 7.64);

INSERT INTO SINHVIEN
VALUES ('SV21003410', 'Siya Keer', 'Nam', to_date('1981-12-23', 'YYYY-MM-DD'), 'H.No. 223 Rastogi Chowk Bharatpur', '+915755842517', 'CTTT', 'TGMT', 59, 5.35);

INSERT INTO SINHVIEN
VALUES ('SV21003411', 'Purab Choudhry', 'N?', to_date('1944-03-10', 'YYYY-MM-DD'), '41/99 Ahluwalia Marg Ahmednagar', '00504634015', 'CQ', 'KHMT', 104, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21003412', 'Dhanush Ghose', 'N?', to_date('1909-11-29', 'YYYY-MM-DD'), 'H.No. 02 Banerjee Ganj Bharatpur', '5404947153', 'CTTT', 'CNPM', 127, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21003413', 'Mehul Balakrishnan', 'N?', to_date('1934-01-04', 'YYYY-MM-DD'), '906 Jain Circle Chennai', '9230868216', 'CTTT', 'MMT', 42, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21003414', 'Azad Malhotra', 'N?', to_date('2008-11-16', 'YYYY-MM-DD'), 'H.No. 897 Bhat Street Visakhapatnam', '03214584261', 'CQ', 'HTTT', 16, 8.59);

INSERT INTO SINHVIEN
VALUES ('SV21003415', 'Piya Goswami', 'Nam', to_date('1936-10-15', 'YYYY-MM-DD'), '70 Baria Jamalpur', '02122056598', 'CTTT', 'CNTT', 106, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21003416', 'Anvi Raval', 'N?', to_date('1974-10-04', 'YYYY-MM-DD'), '28 Reddy Marg Bhagalpur', '5739606117', 'CLC', 'TGMT', 92, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21003417', 'Kartik Ramanathan', 'N?', to_date('1908-12-31', 'YYYY-MM-DD'), '66/42 Gill Marg Gopalpur', '03033456860', 'VP', 'HTTT', 70, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21003418', 'Renee Gopal', 'N?', to_date('2013-04-10', 'YYYY-MM-DD'), 'H.No. 32 Dash Chowk North Dumdum', '02618371593', 'CQ', 'CNPM', 55, 6.12);

INSERT INTO SINHVIEN
VALUES ('SV21003419', 'Riaan Chakrabarti', 'Nam', to_date('1927-11-03', 'YYYY-MM-DD'), 'H.No. 571 Kala Zila Sikar', '5301875146', 'CLC', 'MMT', 100, 8.74);

INSERT INTO SINHVIEN
VALUES ('SV21003420', 'Mehul Goel', 'Nam', to_date('1963-08-30', 'YYYY-MM-DD'), '73 Gaba Ganj Ramagundam', '01385541543', 'VP', 'MMT', 107, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21003421', 'Suhana Singhal', 'N?', to_date('1920-07-24', 'YYYY-MM-DD'), '319 Raj Gangtok', '04513963900', 'CLC', 'HTTT', 53, 4.91);

INSERT INTO SINHVIEN
VALUES ('SV21003422', 'Jivin Sandhu', 'N?', to_date('2008-12-07', 'YYYY-MM-DD'), '669 Maharaj Marg Ambarnath', '+918446841985', 'CLC', 'CNTT', 124, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21003423', 'Vivaan Acharya', 'N?', to_date('1961-03-28', 'YYYY-MM-DD'), 'H.No. 63 Garg Aurangabad', '09350632177', 'CLC', 'KHMT', 9, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21003424', 'Trisha Devi', 'Nam', to_date('1961-10-04', 'YYYY-MM-DD'), '25/508 Chana Nagar Raipur', '+919597944343', 'CQ', 'CNPM', 43, 7.53);

INSERT INTO SINHVIEN
VALUES ('SV21003425', 'Samaira Choudhry', 'Nam', to_date('1949-12-06', 'YYYY-MM-DD'), '88/427 Doctor Marg Kadapa', '+913400246675', 'CLC', 'CNPM', 102, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21003426', 'Adah Chaudhuri', 'N?', to_date('1925-12-30', 'YYYY-MM-DD'), '30/85 Saxena Marg Fatehpur', '+911298130460', 'VP', 'MMT', 76, 7.48);

INSERT INTO SINHVIEN
VALUES ('SV21003427', 'Anika Bains', 'Nam', to_date('1946-11-29', 'YYYY-MM-DD'), 'H.No. 644 Dugar Nagar Kolkata', '7413336105', 'CQ', 'CNPM', 74, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21003428', 'Rati Mand', 'N?', to_date('1983-08-09', 'YYYY-MM-DD'), '44 Keer Street Chittoor', '09170695246', 'CLC', 'CNTT', 71, 8.91);

INSERT INTO SINHVIEN
VALUES ('SV21003429', 'Kiaan Shere', 'Nam', to_date('1921-04-12', 'YYYY-MM-DD'), '46/99 Rao Circle Alwar', '+915164534566', 'VP', 'CNTT', 69, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21003430', 'Emir Viswanathan', 'N?', to_date('2010-09-02', 'YYYY-MM-DD'), '23/343 Bakshi Zila Bokaro', '05000275780', 'VP', 'MMT', 19, 9.67);

INSERT INTO SINHVIEN
VALUES ('SV21003431', 'Madhav Dugar', 'N?', to_date('1988-04-13', 'YYYY-MM-DD'), 'H.No. 90 Mani Road Nagaon', '03584026699', 'VP', 'KHMT', 61, 8.95);

INSERT INTO SINHVIEN
VALUES ('SV21003432', 'Vanya Wali', 'Nam', to_date('1987-05-18', 'YYYY-MM-DD'), 'H.No. 40 Bail Path Salem', '01754854211', 'CQ', 'MMT', 106, 7.07);

INSERT INTO SINHVIEN
VALUES ('SV21003433', 'Seher Joshi', 'N?', to_date('1934-09-14', 'YYYY-MM-DD'), '64/572 Goswami Nagar Gwalior', '+914703533158', 'VP', 'MMT', 42, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21003434', 'Anvi Gaba', 'N?', to_date('1968-01-29', 'YYYY-MM-DD'), 'H.No. 036 Raman Zila Kumbakonam', '+911651214033', 'CQ', 'HTTT', 9, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21003435', 'Vritika Rama', 'Nam', to_date('1933-05-29', 'YYYY-MM-DD'), '90/568 Dube Street Yamunanagar', '+917161649012', 'CLC', 'MMT', 56, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21003436', 'Kabir Gulati', 'N?', to_date('1918-10-26', 'YYYY-MM-DD'), '84/34 Swamy Marg Nandyal', '7769832503', 'CQ', 'MMT', 14, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003437', 'Hridaan Dasgupta', 'Nam', to_date('1962-12-24', 'YYYY-MM-DD'), 'H.No. 69 Kale Zila Ahmedabad', '1979104515', 'CLC', 'TGMT', 37, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21003438', 'Saksham Singh', 'Nam', to_date('1965-10-30', 'YYYY-MM-DD'), '87/027 Gala Zila Tiruvottiyur', '06362707031', 'CQ', 'KHMT', 26, 6.9);

INSERT INTO SINHVIEN
VALUES ('SV21003439', 'Indrans Dhar', 'Nam', to_date('2000-07-29', 'YYYY-MM-DD'), 'H.No. 035 Chawla Street Bardhaman', '06364756494', 'VP', 'HTTT', 120, 8.94);

INSERT INTO SINHVIEN
VALUES ('SV21003440', 'Drishya Manda', 'N?', to_date('1919-06-08', 'YYYY-MM-DD'), 'H.No. 671 Rastogi Path Kharagpur', '8211777111', 'CQ', 'KHMT', 99, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21003441', 'Aradhya Bajaj', 'Nam', to_date('1956-10-30', 'YYYY-MM-DD'), '09/021 Baria Street Korba', '6698189099', 'CTTT', 'HTTT', 67, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21003442', 'Stuvan Sandal', 'N?', to_date('1962-10-21', 'YYYY-MM-DD'), '78/214 Chander Ganj Latur', '+912530135985', 'CQ', 'CNPM', 59, 6.1);

INSERT INTO SINHVIEN
VALUES ('SV21003443', 'Himmat Sunder', 'N?', to_date('1963-06-28', 'YYYY-MM-DD'), '348 Rajagopal Haridwar', '08025399910', 'CQ', 'HTTT', 71, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21003444', 'Eshani Johal', 'N?', to_date('1969-05-23', 'YYYY-MM-DD'), 'H.No. 246 Jayaraman Path Singrauli', '08921069345', 'CQ', 'CNPM', 15, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21003445', 'Akarsh Swaminathan', 'Nam', to_date('1948-08-02', 'YYYY-MM-DD'), 'H.No. 587 Sehgal Nagar Miryalaguda', '9691937569', 'CQ', 'MMT', 49, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21003446', 'Faiyaz Choudhry', 'Nam', to_date('1973-12-08', 'YYYY-MM-DD'), '86 Toor Zila Proddatur', '09871454121', 'CLC', 'MMT', 43, 6.67);

INSERT INTO SINHVIEN
VALUES ('SV21003447', 'Dhanush Gera', 'Nam', to_date('1921-09-04', 'YYYY-MM-DD'), '845 Kanda Zila Alwar', '8339616661', 'VP', 'KHMT', 114, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21003448', 'Zara Toor', 'N?', to_date('2012-06-30', 'YYYY-MM-DD'), '99/71 Mahal Nagar Gurgaon', '06381536943', 'CQ', 'MMT', 111, 4.9);

INSERT INTO SINHVIEN
VALUES ('SV21003449', 'Ojas Kuruvilla', 'N?', to_date('1967-09-27', 'YYYY-MM-DD'), 'H.No. 383 Kade Ganj Chittoor', '08367626747', 'VP', 'CNPM', 74, 6.07);

INSERT INTO SINHVIEN
VALUES ('SV21003450', 'Nirvi Gill', 'N?', to_date('1928-10-09', 'YYYY-MM-DD'), '57/75 Ghosh Chowk Guntur', '0182521564', 'CQ', 'CNTT', 97, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21003451', 'Rasha Kapur', 'Nam', to_date('1992-09-22', 'YYYY-MM-DD'), '88/818 Mall Chowk Chittoor', '+914433310068', 'CLC', 'CNTT', 93, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21003452', 'Drishya Ray', 'Nam', to_date('2008-01-12', 'YYYY-MM-DD'), '67/811 Bose Path Khora ', '07969666939', 'VP', 'TGMT', 119, 9.01);

INSERT INTO SINHVIEN
VALUES ('SV21003453', 'Trisha Sastry', 'N?', to_date('2002-02-26', 'YYYY-MM-DD'), '291 Arya Marg Tirupati', '7099429985', 'VP', 'CNPM', 92, 8.24);

INSERT INTO SINHVIEN
VALUES ('SV21003454', 'Shamik Rajagopalan', 'N?', to_date('1921-02-23', 'YYYY-MM-DD'), '59/84 Bath Circle Guwahati', '+910811747735', 'CTTT', 'MMT', 59, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003455', 'Hansh Sachar', 'N?', to_date('2016-02-06', 'YYYY-MM-DD'), '23 Varkey Kolhapur', '02300147120', 'CTTT', 'HTTT', 44, 6.79);

INSERT INTO SINHVIEN
VALUES ('SV21003456', 'Tarini Sarma', 'N?', to_date('1948-08-01', 'YYYY-MM-DD'), '22 Barad Road Parbhani', '0436191170', 'CLC', 'CNTT', 2, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21003457', 'Armaan Bhavsar', 'Nam', to_date('1964-04-16', 'YYYY-MM-DD'), '53/339 Aggarwal Chowk Gandhinagar', '+915110450567', 'VP', 'MMT', 81, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21003458', 'Dhanush Mangat', 'Nam', to_date('1961-06-04', 'YYYY-MM-DD'), '42/08 Tak Circle Chandrapur', '06903927688', 'CQ', 'HTTT', 41, 8.91);

INSERT INTO SINHVIEN
VALUES ('SV21003459', 'Zara Borde', 'Nam', to_date('1939-08-11', 'YYYY-MM-DD'), '97/56 Dewan Chowk Jamshedpur', '+917756969961', 'CTTT', 'MMT', 57, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21003460', 'Anaya Ramanathan', 'N?', to_date('1941-07-13', 'YYYY-MM-DD'), '87 Mall Kadapa', '08395174718', 'CQ', 'KHMT', 17, 4.75);

INSERT INTO SINHVIEN
VALUES ('SV21003461', 'Nirvaan De', 'N?', to_date('1928-04-02', 'YYYY-MM-DD'), '38/54 Suri Street Vellore', '+911945685553', 'CLC', 'CNTT', 68, 5.22);

INSERT INTO SINHVIEN
VALUES ('SV21003462', 'Yakshit Raman', 'Nam', to_date('1986-04-17', 'YYYY-MM-DD'), 'H.No. 18 Gour Siwan', '00332507684', 'CLC', 'KHMT', 24, 5.69);

INSERT INTO SINHVIEN
VALUES ('SV21003463', 'Aarav Swaminathan', 'N?', to_date('1954-12-29', 'YYYY-MM-DD'), '39 Bumb Marg Thiruvananthapuram', '09886500186', 'CTTT', 'CNPM', 18, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21003464', 'Aaryahi Halder', 'Nam', to_date('1924-08-27', 'YYYY-MM-DD'), 'H.No. 29 Sankar Ganj Mango', '+918372071438', 'CTTT', 'CNPM', 106, 4.36);

INSERT INTO SINHVIEN
VALUES ('SV21003465', 'Hridaan Bhatia', 'N?', to_date('1969-10-30', 'YYYY-MM-DD'), 'H.No. 203 Bobal Dhanbad', '+912028545879', 'VP', 'HTTT', 110, 7.94);

INSERT INTO SINHVIEN
VALUES ('SV21003466', 'Kanav Raman', 'Nam', to_date('2023-09-04', 'YYYY-MM-DD'), '00/09 Reddy Ganj Faridabad', '4399486239', 'CQ', 'CNPM', 81, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21003467', 'Tarini Sarna', 'Nam', to_date('1957-07-28', 'YYYY-MM-DD'), '46/11 Singh Ganj Shahjahanpur', '8502706679', 'CLC', 'KHMT', 82, 4.26);

INSERT INTO SINHVIEN
VALUES ('SV21003468', 'Tushar Choudhury', 'Nam', to_date('1955-08-01', 'YYYY-MM-DD'), '13 Sood Ganj Deoghar', '+915336094115', 'CLC', 'MMT', 12, 8.17);

INSERT INTO SINHVIEN
VALUES ('SV21003469', 'Vedika Tak', 'N?', to_date('1911-04-17', 'YYYY-MM-DD'), 'H.No. 477 Hegde Maheshtala', '+913791722451', 'CTTT', 'CNTT', 110, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21003470', 'Mamooty Lalla', 'N?', to_date('2002-08-10', 'YYYY-MM-DD'), '04/398 Madan Street Varanasi', '2355880037', 'VP', 'HTTT', 57, 9.73);

INSERT INTO SINHVIEN
VALUES ('SV21003471', 'Aayush Saha', 'N?', to_date('1963-05-09', 'YYYY-MM-DD'), '12 Ramesh Circle Jodhpur', '05501848878', 'CQ', 'CNPM', 34, 7.88);

INSERT INTO SINHVIEN
VALUES ('SV21003472', 'Tara Magar', 'N?', to_date('2012-10-29', 'YYYY-MM-DD'), '96 Buch Circle Jhansi', '+917360756726', 'CLC', 'CNPM', 125, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21003473', 'Jivika Badal', 'N?', to_date('1966-07-11', 'YYYY-MM-DD'), '15/675 Randhawa Street Bellary', '6766063823', 'VP', 'HTTT', 138, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21003474', 'Madhup Sen', 'N?', to_date('2001-09-20', 'YYYY-MM-DD'), 'H.No. 76 Balay Nagar Bilaspur', '6517284546', 'CTTT', 'CNPM', 88, 4.29);

INSERT INTO SINHVIEN
VALUES ('SV21003475', 'Pranay Lall', 'Nam', to_date('2022-12-26', 'YYYY-MM-DD'), 'H.No. 77 Saini Chowk Raichur', '01437448912', 'CQ', 'TGMT', 102, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21003476', 'Nishith Lall', 'N?', to_date('1942-05-13', 'YYYY-MM-DD'), 'H.No. 24 Saran Marg Etawah', '+916678373372', 'VP', 'MMT', 42, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21003477', 'Zara Dube', 'N?', to_date('1962-11-30', 'YYYY-MM-DD'), '286 Cheema Nagar Rampur', '5151267608', 'CTTT', 'KHMT', 43, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21003478', 'Nirvaan Sachdeva', 'Nam', to_date('1976-08-15', 'YYYY-MM-DD'), 'H.No. 00 Choudhry Circle Kishanganj', '4486327122', 'VP', 'MMT', 9, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21003479', 'Nirvaan Sura', 'N?', to_date('2022-02-08', 'YYYY-MM-DD'), '870 Wali Path Malda', '00178012731', 'CTTT', 'CNTT', 116, 7.34);

INSERT INTO SINHVIEN
VALUES ('SV21003480', 'Hridaan Gala', 'N?', to_date('1953-10-26', 'YYYY-MM-DD'), '88/324 Sarin Ganj Kishanganj', '+911304922451', 'CLC', 'HTTT', 78, 7.4);

INSERT INTO SINHVIEN
VALUES ('SV21003481', 'Divij Thakkar', 'Nam', to_date('1973-09-10', 'YYYY-MM-DD'), '74/472 Vig Path Bhiwandi', '04429913886', 'VP', 'CNPM', 111, 8.75);

INSERT INTO SINHVIEN
VALUES ('SV21003482', 'Zaina Karan', 'Nam', to_date('1938-11-30', 'YYYY-MM-DD'), '41/29 Hegde Circle Hospet', '01895082551', 'CQ', 'HTTT', 48, 5.71);

INSERT INTO SINHVIEN
VALUES ('SV21003483', 'Nirvaan Gulati', 'N?', to_date('1977-12-17', 'YYYY-MM-DD'), '61 Banerjee Marg Sambalpur', '+914304304830', 'CTTT', 'TGMT', 85, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21003484', 'Lagan Chandra', 'Nam', to_date('1987-11-02', 'YYYY-MM-DD'), '001 Kari Circle Kirari Suleman Nagar', '+913228020131', 'CLC', 'CNTT', 13, 9.09);

INSERT INTO SINHVIEN
VALUES ('SV21003485', 'Biju Bhatti', 'N?', to_date('1971-03-07', 'YYYY-MM-DD'), '72 Mani Chowk Delhi', '7991992384', 'CLC', 'CNPM', 128, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21003486', 'Hazel Dayal', 'Nam', to_date('1963-08-18', 'YYYY-MM-DD'), 'H.No. 84 Shroff Circle Rohtak', '+912459831422', 'VP', 'TGMT', 82, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21003487', 'Damini Shroff', 'N?', to_date('1914-10-11', 'YYYY-MM-DD'), '78/443 Sastry Ratlam', '04104296349', 'CQ', 'CNTT', 72, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21003488', 'Samiha Banik', 'Nam', to_date('1957-08-18', 'YYYY-MM-DD'), '119 Sant Circle Bardhaman', '09572019835', 'CLC', 'TGMT', 12, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21003489', 'Hridaan Kar', 'Nam', to_date('2008-05-19', 'YYYY-MM-DD'), '231 Bora Bhopal', '3541084260', 'CQ', 'HTTT', 1, 6.83);

INSERT INTO SINHVIEN
VALUES ('SV21003490', 'Jivika Uppal', 'Nam', to_date('1930-01-13', 'YYYY-MM-DD'), 'H.No. 110 Bala Zila Siwan', '2045819014', 'CTTT', 'CNTT', 85, 7.09);

INSERT INTO SINHVIEN
VALUES ('SV21003491', 'Nakul Koshy', 'N?', to_date('1938-01-01', 'YYYY-MM-DD'), 'H.No. 62 Kamdar Sangli-Miraj', '+918466810452', 'CQ', 'TGMT', 77, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21003492', 'Bhavin Varkey', 'Nam', to_date('1948-12-04', 'YYYY-MM-DD'), '296 Ramanathan Road Begusarai', '4024645592', 'CLC', 'MMT', 79, 5.01);

INSERT INTO SINHVIEN
VALUES ('SV21003493', 'Bhavin Tiwari', 'N?', to_date('1928-07-24', 'YYYY-MM-DD'), '50 Kothari Path Alappuzha', '5680180425', 'CQ', 'MMT', 94, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21003494', 'Tejas Goel', 'Nam', to_date('1999-11-23', 'YYYY-MM-DD'), '54 Bumb Nagar Maheshtala', '1856961786', 'VP', 'CNTT', 41, 5.13);

INSERT INTO SINHVIEN
VALUES ('SV21003495', 'Saira Subramaniam', 'N?', to_date('1909-09-07', 'YYYY-MM-DD'), '27/978 Kurian Road Aizawl', '06913554319', 'CLC', 'MMT', 96, 4.13);

INSERT INTO SINHVIEN
VALUES ('SV21003496', 'Badal Loyal', 'N?', to_date('2005-08-29', 'YYYY-MM-DD'), '69/690 Cherian Road Ichalkaranji', '06467867768', 'CLC', 'CNPM', 53, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21003497', 'Uthkarsh Yohannan', 'N?', to_date('1949-12-14', 'YYYY-MM-DD'), 'H.No. 07 Sathe Marg Jodhpur', '+911462597274', 'CQ', 'MMT', 19, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21003498', 'Inaaya  Chaudry', 'N?', to_date('1945-01-29', 'YYYY-MM-DD'), '391 Dube Road Warangal', '2805473673', 'VP', 'TGMT', 53, 6.66);

INSERT INTO SINHVIEN
VALUES ('SV21003499', 'Oorja Bhalla', 'Nam', to_date('2008-12-22', 'YYYY-MM-DD'), '879 Warrior Chowk Raurkela Industrial Township', '+918295154142', 'CLC', 'MMT', 1, 10.0);

INSERT INTO SINHVIEN
VALUES ('SV21003500', 'Zaina Lalla', 'Nam', to_date('1996-07-17', 'YYYY-MM-DD'), 'H.No. 44 Lala Chowk Nagercoil', '2641462497', 'CQ', 'HTTT', 10, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21003501', 'Vardaniya Singh', 'Nam', to_date('1912-09-28', 'YYYY-MM-DD'), '659 Swamy Street Sasaram', '02640416282', 'CQ', 'HTTT', 77, 9.15);

INSERT INTO SINHVIEN
VALUES ('SV21003502', 'Neelofar Lad', 'N?', to_date('1940-10-07', 'YYYY-MM-DD'), '87/77 Shroff Kharagpur', '+911577805104', 'CTTT', 'HTTT', 38, 7.84);

INSERT INTO SINHVIEN
VALUES ('SV21003503', 'Chirag Datta', 'Nam', to_date('1980-02-20', 'YYYY-MM-DD'), '94/774 Aggarwal Circle Phusro', '+913964140951', 'VP', 'MMT', 45, 9.78);

INSERT INTO SINHVIEN
VALUES ('SV21003504', 'Heer Ramaswamy', 'Nam', to_date('1910-11-25', 'YYYY-MM-DD'), 'H.No. 610 Baria Marg Amritsar', '+917797154374', 'VP', 'CNTT', 15, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21003505', 'Zaina Bahl', 'Nam', to_date('2006-11-11', 'YYYY-MM-DD'), '55/016 Loke Zila Aizawl', '04021886083', 'CLC', 'MMT', 80, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21003506', 'Farhan Badami', 'Nam', to_date('1951-09-23', 'YYYY-MM-DD'), 'H.No. 03 Banerjee Ganj Bhubaneswar', '00217806294', 'CTTT', 'CNPM', 65, 7.29);

INSERT INTO SINHVIEN
VALUES ('SV21003507', 'Aarush Setty', 'N?', to_date('2016-06-29', 'YYYY-MM-DD'), 'H.No. 42 Atwal Nagar Kochi', '8124503052', 'VP', 'TGMT', 53, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21003508', 'Veer Bhatt', 'Nam', to_date('1957-12-03', 'YYYY-MM-DD'), '42/71 Lall Ganj Muzaffarpur', '00534609558', 'VP', 'HTTT', 97, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21003509', 'Samaira Setty', 'Nam', to_date('1962-02-15', 'YYYY-MM-DD'), '08/84 Anne Marg Shahjahanpur', '08971915527', 'VP', 'TGMT', 89, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21003510', 'Charvi Vasa', 'N?', to_date('1917-02-25', 'YYYY-MM-DD'), 'H.No. 879 Sunder Marg Katni', '7625697953', 'CLC', 'MMT', 11, 9.22);

INSERT INTO SINHVIEN
VALUES ('SV21003511', 'Manikya Shan', 'N?', to_date('1911-05-25', 'YYYY-MM-DD'), 'H.No. 88 Saha Street Mangalore', '08025394431', 'VP', 'MMT', 118, 9.35);

INSERT INTO SINHVIEN
VALUES ('SV21003512', 'Kaira Venkataraman', 'Nam', to_date('1976-07-30', 'YYYY-MM-DD'), '32/001 Loke Pondicherry', '+916173872913', 'CQ', 'CNTT', 121, 7.76);

INSERT INTO SINHVIEN
VALUES ('SV21003513', 'Madhup Lalla', 'N?', to_date('2019-06-15', 'YYYY-MM-DD'), '33/861 Jaggi Ganj Panipat', '6909230466', 'VP', 'KHMT', 49, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21003514', 'Dhanush Kala', 'N?', to_date('1978-04-11', 'YYYY-MM-DD'), '66/836 Sankaran Chowk Vadodara', '8557739033', 'CLC', 'MMT', 136, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21003515', 'Aniruddh Sridhar', 'Nam', to_date('1986-10-28', 'YYYY-MM-DD'), '843 Sunder Road Hindupur', '06569886753', 'CLC', 'TGMT', 127, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21003516', 'Hazel Bath', 'N?', to_date('1995-05-19', 'YYYY-MM-DD'), '41 Bhalla Path Agartala', '+912194290995', 'CQ', 'KHMT', 29, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21003517', 'Sumer Srinivas', 'Nam', to_date('1950-09-30', 'YYYY-MM-DD'), '09/47 Goel Ganj Purnia', '+911059005747', 'CQ', 'TGMT', 88, 6.83);

INSERT INTO SINHVIEN
VALUES ('SV21003518', 'Myra Borra', 'Nam', to_date('1950-06-01', 'YYYY-MM-DD'), 'H.No. 36 Vohra Marg Madanapalle', '+918293026096', 'CLC', 'MMT', 62, 8.01);

INSERT INTO SINHVIEN
VALUES ('SV21003519', 'Ela Toor', 'Nam', to_date('1978-04-03', 'YYYY-MM-DD'), '440 Lad Path Imphal', '08315453877', 'CTTT', 'MMT', 15, 8.05);

INSERT INTO SINHVIEN
VALUES ('SV21003520', 'Aayush Madan', 'Nam', to_date('1983-05-07', 'YYYY-MM-DD'), '89/23 Jayaraman Zila Sambalpur', '1504703462', 'CLC', 'CNPM', 18, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21003521', 'Vedika Dhingra', 'N?', to_date('1943-01-18', 'YYYY-MM-DD'), '85/954 Mangal Marg Gangtok', '07540841048', 'CQ', 'CNTT', 37, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21003522', 'Hridaan Sani', 'N?', to_date('1910-10-23', 'YYYY-MM-DD'), '02 Subramanian Circle Bhilai', '04068257835', 'VP', 'CNTT', 46, 5.42);

INSERT INTO SINHVIEN
VALUES ('SV21003523', 'Vaibhav Rau', 'Nam', to_date('2014-11-29', 'YYYY-MM-DD'), '406 Raja Street Amroha', '+915121595023', 'CTTT', 'KHMT', 37, 4.76);

INSERT INTO SINHVIEN
VALUES ('SV21003524', 'Gatik Chacko', 'Nam', to_date('1955-03-22', 'YYYY-MM-DD'), '602 Setty Nagar Bangalore', '5461350683', 'VP', 'KHMT', 104, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21003525', 'Khushi Krishna', 'Nam', to_date('1915-12-13', 'YYYY-MM-DD'), '51 Das Street Tinsukia', '03164511973', 'CQ', 'HTTT', 131, 6.0);

INSERT INTO SINHVIEN
VALUES ('SV21003526', 'Lagan Dass', 'N?', to_date('2023-03-03', 'YYYY-MM-DD'), 'H.No. 075 Varkey Chowk Mahbubnagar', '+919393149986', 'CLC', 'KHMT', 129, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21003527', 'Tiya Chowdhury', 'N?', to_date('2015-07-04', 'YYYY-MM-DD'), '32/294 Bansal Nagar Tinsukia', '+911823568966', 'VP', 'KHMT', 136, 5.0);

INSERT INTO SINHVIEN
VALUES ('SV21003528', 'Dhanush Chahal', 'N?', to_date('1971-11-03', 'YYYY-MM-DD'), '99/660 Yogi Ganj Anand', '+917130341533', 'VP', 'CNTT', 11, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21003529', 'Ela Bhavsar', 'N?', to_date('1977-03-13', 'YYYY-MM-DD'), 'H.No. 81 Bandi Marg Nagaon', '+916347581864', 'CQ', 'CNPM', 23, 8.65);

INSERT INTO SINHVIEN
VALUES ('SV21003530', 'Nirvaan Varma', 'N?', to_date('1961-11-02', 'YYYY-MM-DD'), '93/517 Arora Path Bikaner', '+916641459253', 'CQ', 'KHMT', 42, 6.95);

INSERT INTO SINHVIEN
VALUES ('SV21003531', 'Keya Randhawa', 'Nam', to_date('1931-08-17', 'YYYY-MM-DD'), 'H.No. 92 Ratti Marg Burhanpur', '+916209704942', 'CTTT', 'MMT', 49, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21003532', 'Vivaan Ram', 'N?', to_date('1936-10-12', 'YYYY-MM-DD'), '625 Garg Zila Bharatpur', '+916807683616', 'CQ', 'TGMT', 18, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21003533', 'Ranbir Comar', 'Nam', to_date('2016-11-18', 'YYYY-MM-DD'), 'H.No. 02 Brahmbhatt Street Bhiwani', '04769853099', 'CTTT', 'HTTT', 68, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21003534', 'Dharmajan Bains', 'Nam', to_date('2007-01-11', 'YYYY-MM-DD'), '14/498 Shah Path Kakinada', '8014717830', 'VP', 'HTTT', 8, 5.48);

INSERT INTO SINHVIEN
VALUES ('SV21003535', 'Kaira Warrior', 'N?', to_date('1949-04-08', 'YYYY-MM-DD'), '15/84 Choudhury Circle Meerut', '08630096786', 'VP', 'TGMT', 122, 7.7);

INSERT INTO SINHVIEN
VALUES ('SV21003536', 'Piya Sami', 'N?', to_date('1945-11-26', 'YYYY-MM-DD'), 'H.No. 79 Konda Circle Jaunpur', '8008987847', 'CQ', 'CNTT', 0, 5.92);

INSERT INTO SINHVIEN
VALUES ('SV21003537', 'Riya Gera', 'N?', to_date('2018-04-28', 'YYYY-MM-DD'), '972 Bhatti Circle Rajkot', '06267711548', 'CLC', 'CNPM', 34, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21003538', 'Kiaan Kuruvilla', 'N?', to_date('1980-05-24', 'YYYY-MM-DD'), 'H.No. 71 Dugar Road Amravati', '9033125709', 'CTTT', 'CNTT', 24, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21003539', 'Lavanya Mallick', 'N?', to_date('1965-01-05', 'YYYY-MM-DD'), '08/910 Kade Marg Howrah', '8326373060', 'CLC', 'CNPM', 117, 7.78);

INSERT INTO SINHVIEN
VALUES ('SV21003540', 'Anaya Kothari', 'N?', to_date('1984-11-29', 'YYYY-MM-DD'), 'H.No. 84 Banerjee Rajkot', '+916059967921', 'CTTT', 'HTTT', 69, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21003541', 'Zaina Doctor', 'N?', to_date('1955-02-03', 'YYYY-MM-DD'), '32 Kade Pondicherry', '01591133291', 'VP', 'CNPM', 0, 9.89);

INSERT INTO SINHVIEN
VALUES ('SV21003542', 'Mannat Dalal', 'Nam', to_date('1978-06-19', 'YYYY-MM-DD'), 'H.No. 443 Acharya Zila Dehradun', '05169307110', 'CLC', 'MMT', 111, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21003543', 'Ivan Goel', 'Nam', to_date('1956-11-26', 'YYYY-MM-DD'), '23 Som Road Shahjahanpur', '+917324472612', 'CLC', 'KHMT', 33, 9.3);

INSERT INTO SINHVIEN
VALUES ('SV21003544', 'Arnav Bava', 'N?', to_date('1997-01-12', 'YYYY-MM-DD'), '577 Rastogi Marg Nizamabad', '+913427142204', 'VP', 'TGMT', 89, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21003545', 'Advika Talwar', 'N?', to_date('1941-01-31', 'YYYY-MM-DD'), '432 Gokhale Road Kirari Suleman Nagar', '+913608149679', 'VP', 'KHMT', 118, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21003546', 'Khushi Rajan', 'N?', to_date('1977-10-11', 'YYYY-MM-DD'), 'H.No. 235 Gola Marg Bhubaneswar', '+913931136390', 'CQ', 'MMT', 72, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21003547', 'Amani Ravel', 'N?', to_date('1980-08-18', 'YYYY-MM-DD'), '57/034 Keer Ranchi', '+911421027566', 'CQ', 'CNTT', 65, 6.49);

INSERT INTO SINHVIEN
VALUES ('SV21003548', 'Aarna Kurian', 'N?', to_date('1998-02-02', 'YYYY-MM-DD'), '88/900 Tiwari Chowk Amaravati', '09115528484', 'CQ', 'TGMT', 3, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21003549', 'Lakshit Choudhry', 'Nam', to_date('1985-07-15', 'YYYY-MM-DD'), 'H.No. 01 Bail Road Arrah', '+918616697816', 'CTTT', 'MMT', 123, 5.95);

INSERT INTO SINHVIEN
VALUES ('SV21003550', 'Arnav Ravel', 'N?', to_date('1935-08-20', 'YYYY-MM-DD'), 'H.No. 21 Sanghvi Ganj Gulbarga', '+912040144378', 'VP', 'CNPM', 2, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21003551', 'Parinaaz Gill', 'Nam', to_date('1963-06-27', 'YYYY-MM-DD'), '53 Kumar Guwahati', '1495663460', 'CQ', 'TGMT', 101, 7.45);

INSERT INTO SINHVIEN
VALUES ('SV21003552', 'Keya Sathe', 'N?', to_date('2021-04-20', 'YYYY-MM-DD'), '307 Dani Path Kottayam', '+914283145584', 'CQ', 'HTTT', 75, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21003553', 'Lavanya Kapoor', 'N?', to_date('2002-04-16', 'YYYY-MM-DD'), '45 Halder Zila Mau', '03025426043', 'VP', 'CNPM', 3, 7.08);

INSERT INTO SINHVIEN
VALUES ('SV21003554', 'Damini Sharma', 'N?', to_date('1943-06-10', 'YYYY-MM-DD'), '364 Cherian Road Jammu', '+910551357977', 'VP', 'HTTT', 26, 4.03);

INSERT INTO SINHVIEN
VALUES ('SV21003555', 'Inaaya  Solanki', 'Nam', to_date('1953-01-21', 'YYYY-MM-DD'), '05/79 Basak Path Ichalkaranji', '+910690711866', 'CLC', 'TGMT', 95, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21003556', 'Shanaya Upadhyay', 'Nam', to_date('1974-11-16', 'YYYY-MM-DD'), 'H.No. 94 Badal Marg Bhilwara', '+915202651104', 'VP', 'HTTT', 21, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21003557', 'Raghav Kata', 'Nam', to_date('1975-11-29', 'YYYY-MM-DD'), 'H.No. 87 Luthra Circle Firozabad', '08707808005', 'CLC', 'CNTT', 63, 4.65);

INSERT INTO SINHVIEN
VALUES ('SV21003558', 'Arnav Date', 'Nam', to_date('1959-04-15', 'YYYY-MM-DD'), 'H.No. 267 Lall Street Kurnool', '08895565243', 'CLC', 'MMT', 132, 7.9);

INSERT INTO SINHVIEN
VALUES ('SV21003559', 'Taran Swaminathan', 'Nam', to_date('2014-06-24', 'YYYY-MM-DD'), '652 Ahuja Chowk Satara', '07935933628', 'CLC', 'MMT', 83, 8.1);

INSERT INTO SINHVIEN
VALUES ('SV21003560', 'Diya Ram', 'Nam', to_date('2013-07-26', 'YYYY-MM-DD'), '54 Gill Street Imphal', '01368822251', 'CLC', 'TGMT', 60, 7.81);

INSERT INTO SINHVIEN
VALUES ('SV21003561', 'Vardaniya Gill', 'N?', to_date('1954-09-14', 'YYYY-MM-DD'), 'H.No. 97 Edwin Marg Miryalaguda', '9757981156', 'CLC', 'TGMT', 121, 6.3);

INSERT INTO SINHVIEN
VALUES ('SV21003562', 'Renee Chhabra', 'Nam', to_date('1962-09-24', 'YYYY-MM-DD'), 'H.No. 28 Dave Nagar Farrukhabad', '03319900542', 'CLC', 'MMT', 136, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21003563', 'Myra Sharma', 'N?', to_date('1990-08-20', 'YYYY-MM-DD'), '27/38 Gole Circle Fatehpur', '9253764092', 'CLC', 'CNTT', 45, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21003564', 'Vardaniya Kamdar', 'N?', to_date('1987-08-01', 'YYYY-MM-DD'), '886 Bhardwaj Zila Hosur', '00959886444', 'CTTT', 'HTTT', 49, 4.35);

INSERT INTO SINHVIEN
VALUES ('SV21003565', 'Tiya Badal', 'N?', to_date('2011-02-09', 'YYYY-MM-DD'), '735 Badami Patna', '02728864908', 'CTTT', 'CNPM', 79, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21003566', 'Divit Batta', 'N?', to_date('1995-02-08', 'YYYY-MM-DD'), '28/903 Sahni Circle Maheshtala', '+912862366841', 'VP', 'MMT', 64, 8.32);

INSERT INTO SINHVIEN
VALUES ('SV21003567', 'Mohanlal Lall', 'N?', to_date('1948-11-01', 'YYYY-MM-DD'), 'H.No. 75 Tara Path Vijayawada', '+914179932430', 'CLC', 'CNTT', 35, 4.06);

INSERT INTO SINHVIEN
VALUES ('SV21003568', 'Nirvaan Chakraborty', 'N?', to_date('1956-11-26', 'YYYY-MM-DD'), '48 Ben Path Ahmedabad', '01677829669', 'VP', 'MMT', 86, 5.27);

INSERT INTO SINHVIEN
VALUES ('SV21003569', 'Rhea Brar', 'N?', to_date('1980-03-11', 'YYYY-MM-DD'), '676 Luthra Circle Ghaziabad', '7297427583', 'VP', 'MMT', 83, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21003570', 'Tushar Anand', 'N?', to_date('1925-03-06', 'YYYY-MM-DD'), '22/934 Sachdev Chowk Bhiwandi', '02057679930', 'VP', 'CNPM', 107, 7.28);

INSERT INTO SINHVIEN
VALUES ('SV21003571', 'Riya Randhawa', 'Nam', to_date('1941-04-27', 'YYYY-MM-DD'), 'H.No. 902 Sama Zila Barasat', '+912137232514', 'CQ', 'KHMT', 74, 8.27);

INSERT INTO SINHVIEN
VALUES ('SV21003572', 'Madhup Ganesh', 'N?', to_date('1970-08-16', 'YYYY-MM-DD'), '435 Sha Sirsa', '9202693024', 'CLC', 'MMT', 6, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21003573', 'Misha Thakur', 'Nam', to_date('1935-11-27', 'YYYY-MM-DD'), '78/801 Sharaf Road Sri Ganganagar', '+914387572352', 'VP', 'MMT', 101, 8.82);

INSERT INTO SINHVIEN
VALUES ('SV21003574', 'Diya Kashyap', 'N?', to_date('1989-11-21', 'YYYY-MM-DD'), '60 Choudhury Zila Cuttack', '06362502940', 'CQ', 'CNTT', 93, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21003575', 'Rati Sant', 'Nam', to_date('1917-07-17', 'YYYY-MM-DD'), 'H.No. 62 Sandal Road Saharsa', '02005144745', 'CTTT', 'HTTT', 64, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21003576', 'Aradhya Bhatnagar', 'N?', to_date('1953-03-16', 'YYYY-MM-DD'), '979 Ravel Ganj Kollam', '2864838484', 'VP', 'CNTT', 76, 4.54);

INSERT INTO SINHVIEN
VALUES ('SV21003577', 'Pihu Salvi', 'N?', to_date('1975-05-11', 'YYYY-MM-DD'), 'H.No. 144 Loyal Circle Kadapa', '+917490177716', 'VP', 'CNPM', 57, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21003578', 'Dishani Hegde', 'N?', to_date('2011-10-27', 'YYYY-MM-DD'), 'H.No. 501 D��Alia Zila Saharsa', '0993403276', 'VP', 'TGMT', 7, 6.74);

INSERT INTO SINHVIEN
VALUES ('SV21003579', 'Vivaan Desai', 'N?', to_date('1972-11-05', 'YYYY-MM-DD'), 'H.No. 76 Ravel Path Rampur', '+918802786970', 'CQ', 'CNTT', 51, 5.16);

INSERT INTO SINHVIEN
VALUES ('SV21003580', 'Kiara Cherian', 'N?', to_date('2003-08-16', 'YYYY-MM-DD'), '467 Keer Marg Meerut', '8278419130', 'CTTT', 'CNTT', 4, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21003581', 'Anya Banik', 'N?', to_date('2000-04-21', 'YYYY-MM-DD'), 'H.No. 766 Sangha Street Barasat', '08818381206', 'CTTT', 'TGMT', 32, 9.76);

INSERT INTO SINHVIEN
VALUES ('SV21003582', 'Anay Sachar', 'N?', to_date('1947-07-24', 'YYYY-MM-DD'), 'H.No. 612 Salvi Street Sambhal', '3495446643', 'CLC', 'TGMT', 34, 8.52);

INSERT INTO SINHVIEN
VALUES ('SV21003583', 'Miraya Bedi', 'Nam', to_date('1915-09-16', 'YYYY-MM-DD'), 'H.No. 99 Kapadia Path Udupi', '+918928312929', 'CTTT', 'TGMT', 28, 9.04);

INSERT INTO SINHVIEN
VALUES ('SV21003584', 'Vihaan Solanki', 'Nam', to_date('1931-08-26', 'YYYY-MM-DD'), 'H.No. 21 Goda Zila Raiganj', '1375224189', 'CLC', 'CNPM', 109, 9.59);

INSERT INTO SINHVIEN
VALUES ('SV21003585', 'Jivika Shan', 'N?', to_date('1969-11-02', 'YYYY-MM-DD'), 'H.No. 916 Ramakrishnan Path Cuttack', '08479090617', 'CLC', 'HTTT', 47, 8.16);

INSERT INTO SINHVIEN
VALUES ('SV21003586', 'Hansh Bandi', 'N?', to_date('1986-08-09', 'YYYY-MM-DD'), '93 Dara Delhi', '+913269570146', 'CLC', 'KHMT', 17, 8.53);

INSERT INTO SINHVIEN
VALUES ('SV21003587', 'Dishani Bhatia', 'N?', to_date('1970-12-19', 'YYYY-MM-DD'), '554 Vig Zila Bidar', '+916538259130', 'CQ', 'TGMT', 120, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21003588', 'Purab Brahmbhatt', 'N?', to_date('1981-07-29', 'YYYY-MM-DD'), '51 Bail Road Ranchi', '2614007837', 'CLC', 'CNTT', 120, 8.57);

INSERT INTO SINHVIEN
VALUES ('SV21003589', 'Zoya Mann', 'N?', to_date('1938-01-01', 'YYYY-MM-DD'), 'H.No. 015 Dalal Street Chandrapur', '07851872032', 'CQ', 'CNPM', 137, 8.85);

INSERT INTO SINHVIEN
VALUES ('SV21003590', 'Anahita Chander', 'Nam', to_date('2000-10-05', 'YYYY-MM-DD'), '12 Keer Warangal', '5511477642', 'CLC', 'KHMT', 134, 4.14);

INSERT INTO SINHVIEN
VALUES ('SV21003591', 'Taimur Dada', 'Nam', to_date('2013-08-31', 'YYYY-MM-DD'), '41 Gokhale Zila Tiruppur', '02129094886', 'CLC', 'TGMT', 0, 4.81);

INSERT INTO SINHVIEN
VALUES ('SV21003592', 'Indrajit Bali', 'N?', to_date('1929-12-20', 'YYYY-MM-DD'), '63/56 Bhasin Road Uluberia', '4379648944', 'CLC', 'CNPM', 75, 9.29);

INSERT INTO SINHVIEN
VALUES ('SV21003593', 'Divit Dhaliwal', 'N?', to_date('1962-10-02', 'YYYY-MM-DD'), 'H.No. 858 Ramakrishnan Chowk South Dumdum', '00891688768', 'CQ', 'KHMT', 28, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21003594', 'Aaina Dayal', 'N?', to_date('2019-06-28', 'YYYY-MM-DD'), 'H.No. 020 Arora Nagar Karaikudi', '+916405862163', 'CLC', 'TGMT', 124, 6.35);

INSERT INTO SINHVIEN
VALUES ('SV21003595', 'Sara Boase', 'Nam', to_date('1970-10-01', 'YYYY-MM-DD'), '45/654 Hora Circle Kavali', '2203161199', 'CQ', 'KHMT', 68, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21003596', 'Tejas Golla', 'N?', to_date('1994-02-14', 'YYYY-MM-DD'), '40/03 Chhabra Marg Barasat', '1837633839', 'CTTT', 'KHMT', 78, 8.35);

INSERT INTO SINHVIEN
VALUES ('SV21003597', 'Dishani Setty', 'Nam', to_date('1945-08-15', 'YYYY-MM-DD'), '51 Guha Chowk Chandigarh', '03300186432', 'CQ', 'KHMT', 7, 9.23);

INSERT INTO SINHVIEN
VALUES ('SV21003598', 'Vardaniya Korpal', 'N?', to_date('1990-09-21', 'YYYY-MM-DD'), '76/983 Bandi Zila Avadi', '06974250297', 'CQ', 'CNTT', 87, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21003599', 'Hridaan Dubey', 'N?', to_date('1939-11-06', 'YYYY-MM-DD'), 'H.No. 20 Uppal Street Jalandhar', '+917746152356', 'VP', 'CNPM', 47, 4.41);

INSERT INTO SINHVIEN
VALUES ('SV21003600', 'Saanvi Iyer', 'N?', to_date('1974-07-14', 'YYYY-MM-DD'), '07/458 Dyal Chowk Akola', '08162616057', 'CTTT', 'KHMT', 108, 9.16);

INSERT INTO SINHVIEN
VALUES ('SV21003601', 'Divit Borde', 'N?', to_date('1949-02-28', 'YYYY-MM-DD'), '45/62 Balan Road Sagar', '3774239443', 'CLC', 'TGMT', 85, 5.46);

INSERT INTO SINHVIEN
VALUES ('SV21003602', 'Miraya Cheema', 'N?', to_date('2008-05-25', 'YYYY-MM-DD'), '72/730 Sandal Bhiwani', '08048879832', 'CQ', 'CNPM', 6, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21003603', 'Vardaniya Ratti', 'N?', to_date('1942-02-08', 'YYYY-MM-DD'), '62 Sheth Chowk Kirari Suleman Nagar', '+919531273122', 'CTTT', 'TGMT', 92, 5.05);

INSERT INTO SINHVIEN
VALUES ('SV21003604', 'Alia Dey', 'Nam', to_date('1936-09-21', 'YYYY-MM-DD'), '86/867 Saha Road Dharmavaram', '+914750074420', 'CQ', 'CNPM', 15, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21003605', 'Oorja Ravel', 'Nam', to_date('2008-03-19', 'YYYY-MM-DD'), '89/67 Sunder Nagar Anantapur', '+915126572050', 'CLC', 'TGMT', 132, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21003606', 'Hridaan Chakraborty', 'N?', to_date('1926-05-18', 'YYYY-MM-DD'), '33/812 Gokhale Street Durgapur', '9163764114', 'CQ', 'CNPM', 22, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21003607', 'Taimur Sem', 'N?', to_date('1971-03-03', 'YYYY-MM-DD'), '72 Yohannan Street Muzaffarnagar', '+916500340067', 'CLC', 'MMT', 51, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21003608', 'Gokul Kalla', 'N?', to_date('1928-04-03', 'YYYY-MM-DD'), '224 Grewal Zila Tumkur', '+913818568260', 'VP', 'HTTT', 94, 4.85);

INSERT INTO SINHVIEN
VALUES ('SV21003609', 'Aayush Saini', 'Nam', to_date('1970-08-18', 'YYYY-MM-DD'), '57/404 Apte Chowk Gaya', '08419004303', 'CQ', 'TGMT', 116, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21003610', 'Miraan Soman', 'Nam', to_date('2022-12-12', 'YYYY-MM-DD'), '349 Basak Circle Jorhat', '+915074511237', 'CLC', 'MMT', 98, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21003611', 'Diya Dave', 'N?', to_date('1996-06-16', 'YYYY-MM-DD'), '821 Thakur Chowk Bulandshahr', '+917449370665', 'CLC', 'MMT', 30, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21003612', 'Inaaya  Rana', 'Nam', to_date('1992-10-10', 'YYYY-MM-DD'), '82/42 Arya Bhusawal', '9021977328', 'CLC', 'HTTT', 36, 7.33);

INSERT INTO SINHVIEN
VALUES ('SV21003613', 'Ojas Basak', 'Nam', to_date('1955-08-16', 'YYYY-MM-DD'), '38/57 Issac Street Kirari Suleman Nagar', '8545156587', 'CLC', 'HTTT', 68, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21003614', 'Miraya Baria', 'Nam', to_date('1992-07-07', 'YYYY-MM-DD'), '26 Bhalla Ongole', '01313523607', 'VP', 'KHMT', 94, 7.72);

INSERT INTO SINHVIEN
VALUES ('SV21003615', 'Aradhya Reddy', 'N?', to_date('1998-03-05', 'YYYY-MM-DD'), '957 Varghese Chowk Korba', '07069429059', 'CTTT', 'CNPM', 46, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21003616', 'Inaaya  Upadhyay', 'Nam', to_date('1942-07-22', 'YYYY-MM-DD'), '26 Goswami Path Serampore', '9082413210', 'CLC', 'TGMT', 85, 7.17);

INSERT INTO SINHVIEN
VALUES ('SV21003617', 'Stuvan Tailor', 'N?', to_date('1932-01-27', 'YYYY-MM-DD'), '19 Bobal Street Jorhat', '01637537622', 'CQ', 'TGMT', 123, 6.16);

INSERT INTO SINHVIEN
VALUES ('SV21003618', 'Jayan Bala', 'Nam', to_date('1915-10-24', 'YYYY-MM-DD'), '99/64 Sachdeva Marg Sirsa', '8991436476', 'CLC', 'HTTT', 132, 6.12);

INSERT INTO SINHVIEN
VALUES ('SV21003619', 'Sahil Sur', 'Nam', to_date('1950-04-10', 'YYYY-MM-DD'), 'H.No. 036 Keer Street Hajipur', '02400149177', 'CQ', 'HTTT', 11, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21003620', 'Ojas Thaman', 'N?', to_date('1986-10-23', 'YYYY-MM-DD'), '10/05 Shanker Path Bhalswa Jahangir Pur', '03473588328', 'VP', 'TGMT', 35, 6.08);

INSERT INTO SINHVIEN
VALUES ('SV21003621', 'Inaaya  Dewan', 'Nam', to_date('1962-05-05', 'YYYY-MM-DD'), '502 Sule Path Bangalore', '+918942989582', 'CQ', 'KHMT', 109, 6.12);

INSERT INTO SINHVIEN
VALUES ('SV21003622', 'Jayan Kanda', 'N?', to_date('1998-07-12', 'YYYY-MM-DD'), '29/82 Dixit Street Kulti', '08882124387', 'CQ', 'HTTT', 17, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21003623', 'Aaryahi Vohra', 'Nam', to_date('1995-06-27', 'YYYY-MM-DD'), 'H.No. 431 Shankar Zila Jalandhar', '8750150135', 'CTTT', 'MMT', 77, 9.96);

INSERT INTO SINHVIEN
VALUES ('SV21003624', 'Sumer Soni', 'Nam', to_date('1933-04-15', 'YYYY-MM-DD'), 'H.No. 524 Saxena Nagar Erode', '+919733878099', 'CLC', 'TGMT', 11, 7.92);

INSERT INTO SINHVIEN
VALUES ('SV21003625', 'Advik Gour', 'Nam', to_date('1985-06-28', 'YYYY-MM-DD'), '238 Baria Circle Bhilai', '+913050532368', 'CLC', 'KHMT', 39, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21003626', 'Tushar Varkey', 'Nam', to_date('1913-04-29', 'YYYY-MM-DD'), '71/390 Salvi Chowk Ghaziabad', '0307208774', 'VP', 'CNPM', 40, 4.15);

INSERT INTO SINHVIEN
VALUES ('SV21003627', 'Keya Tank', 'N?', to_date('1958-06-24', 'YYYY-MM-DD'), 'H.No. 47 Acharya Path Naihati', '+912050735580', 'CQ', 'CNPM', 8, 9.92);

INSERT INTO SINHVIEN
VALUES ('SV21003628', 'Indrans Dugar', 'N?', to_date('1994-12-07', 'YYYY-MM-DD'), 'H.No. 53 Karan Road Sikar', '09730023145', 'CQ', 'MMT', 9, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21003629', 'Shlok Sahni', 'N?', to_date('1932-10-01', 'YYYY-MM-DD'), '169 Issac Chowk Saharanpur', '3644235353', 'CQ', 'CNPM', 37, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21003630', 'Aarush Deol', 'Nam', to_date('2002-05-31', 'YYYY-MM-DD'), '59 Bhatti Path Dehri', '0023804223', 'CQ', 'CNPM', 115, 5.7);

INSERT INTO SINHVIEN
VALUES ('SV21003631', 'Gokul Tank', 'N?', to_date('1908-07-30', 'YYYY-MM-DD'), '66 Samra Ganj Medininagar', '+915117781454', 'CTTT', 'CNPM', 98, 4.22);

INSERT INTO SINHVIEN
VALUES ('SV21003632', 'Saanvi Sen', 'Nam', to_date('1976-08-12', 'YYYY-MM-DD'), '87/095 Tailor Karawal Nagar', '+916309617905', 'CQ', 'CNPM', 20, 8.29);

INSERT INTO SINHVIEN
VALUES ('SV21003633', 'Taran Kadakia', 'N?', to_date('1919-06-17', 'YYYY-MM-DD'), 'H.No. 91 Mand Chowk Bhubaneswar', '09382779880', 'CTTT', 'MMT', 53, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21003634', 'Sahil Chowdhury', 'N?', to_date('1928-02-25', 'YYYY-MM-DD'), '44 Shan Nagar Vijayanagaram', '7110336623', 'CLC', 'CNTT', 56, 8.91);

INSERT INTO SINHVIEN
VALUES ('SV21003635', 'Aaina Dey', 'Nam', to_date('1925-07-31', 'YYYY-MM-DD'), '168 Venkatesh Circle Chinsurah', '07592282449', 'VP', 'CNTT', 31, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21003636', 'Sumer Seshadri', 'Nam', to_date('1967-12-07', 'YYYY-MM-DD'), '43 Chowdhury Circle Bikaner', '2058066966', 'CLC', 'HTTT', 80, 4.49);

INSERT INTO SINHVIEN
VALUES ('SV21003637', 'Shray Chada', 'Nam', to_date('1923-03-30', 'YYYY-MM-DD'), '00/384 Thakkar Street Mau', '+918706828392', 'CLC', 'HTTT', 121, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21003638', 'Vedika Devi', 'N?', to_date('1954-11-01', 'YYYY-MM-DD'), '38/020 Varughese Nagar Yamunanagar', '02569416196', 'CTTT', 'HTTT', 136, 7.19);

INSERT INTO SINHVIEN
VALUES ('SV21003639', 'Alisha Brar', 'Nam', to_date('1971-02-08', 'YYYY-MM-DD'), '92/061 Ganesan Street Jhansi', '00152919517', 'CTTT', 'MMT', 87, 4.62);

INSERT INTO SINHVIEN
VALUES ('SV21003640', 'Rati Khosla', 'Nam', to_date('1922-12-31', 'YYYY-MM-DD'), '21/024 Dewan Circle Nashik', '0588648268', 'CTTT', 'HTTT', 128, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21003641', 'Oorja Chad', 'N?', to_date('1996-06-29', 'YYYY-MM-DD'), '47 Sinha Zila Karnal', '01560425862', 'CTTT', 'CNTT', 52, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003642', 'Vanya Srivastava', 'N?', to_date('2019-05-04', 'YYYY-MM-DD'), '48 Kadakia Marg Avadi', '08641752445', 'CLC', 'MMT', 12, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21003643', 'Neelofar Dada', 'Nam', to_date('2017-09-26', 'YYYY-MM-DD'), '95 Bath Ganj Anand', '08350173960', 'CTTT', 'CNPM', 38, 5.64);

INSERT INTO SINHVIEN
VALUES ('SV21003644', 'Ishaan Mander', 'N?', to_date('1953-11-28', 'YYYY-MM-DD'), '688 Sheth Ganj Jamalpur', '05764077612', 'CLC', 'CNPM', 60, 5.31);

INSERT INTO SINHVIEN
VALUES ('SV21003645', 'Chirag Hora', 'Nam', to_date('1951-07-28', 'YYYY-MM-DD'), '44/360 Hayer Proddatur', '2023720658', 'CQ', 'TGMT', 102, 4.95);

INSERT INTO SINHVIEN
VALUES ('SV21003646', 'Manjari Ramesh', 'N?', to_date('1920-12-08', 'YYYY-MM-DD'), 'H.No. 49 Shanker Marg Motihari', '06147801429', 'CQ', 'TGMT', 129, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21003647', 'Tanya Kashyap', 'N?', to_date('1992-01-02', 'YYYY-MM-DD'), 'H.No. 281 Kanda Ganj Deoghar', '+915711690145', 'VP', 'KHMT', 133, 5.93);

INSERT INTO SINHVIEN
VALUES ('SV21003648', 'Bhamini Gola', 'N?', to_date('1945-06-20', 'YYYY-MM-DD'), 'H.No. 96 Rajagopal Circle Rampur', '+919144560692', 'CQ', 'MMT', 22, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003649', 'Darshit Rattan', 'N?', to_date('1982-07-10', 'YYYY-MM-DD'), '24/00 Karnik Chowk Mirzapur', '01736028704', 'CLC', 'TGMT', 37, 5.33);

INSERT INTO SINHVIEN
VALUES ('SV21003650', 'Ojas Sharma', 'Nam', to_date('2001-11-05', 'YYYY-MM-DD'), '960 Chand Path Siwan', '6533435805', 'CTTT', 'TGMT', 8, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21003651', 'Dhruv Sachar', 'Nam', to_date('1971-07-03', 'YYYY-MM-DD'), '42/676 Mahajan Path Davanagere', '3108127130', 'CLC', 'MMT', 87, 5.94);

INSERT INTO SINHVIEN
VALUES ('SV21003652', 'Arnav Sharma', 'N?', to_date('1925-08-23', 'YYYY-MM-DD'), '240 Dara Nagar Akola', '+919764008636', 'CQ', 'KHMT', 48, 9.9);

INSERT INTO SINHVIEN
VALUES ('SV21003653', 'Dishani Contractor', 'N?', to_date('2020-08-30', 'YYYY-MM-DD'), '030 Saxena Street Navi Mumbai', '01989122312', 'VP', 'KHMT', 54, 9.62);

INSERT INTO SINHVIEN
VALUES ('SV21003654', 'Rati Chokshi', 'N?', to_date('1959-08-24', 'YYYY-MM-DD'), 'H.No. 462 Issac Street Moradabad', '+910823707904', 'CQ', 'KHMT', 132, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21003655', 'Pihu Dugal', 'Nam', to_date('1943-10-02', 'YYYY-MM-DD'), '50 Karnik Marg Srikakulam', '03406041497', 'CLC', 'HTTT', 57, 9.4);

INSERT INTO SINHVIEN
VALUES ('SV21003656', 'Veer Dyal', 'N?', to_date('2015-02-25', 'YYYY-MM-DD'), 'H.No. 10 Tata Nagar Parbhani', '01245852027', 'CQ', 'CNPM', 116, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21003657', 'Anika Sharaf', 'N?', to_date('1922-11-20', 'YYYY-MM-DD'), '563 Soman Nagar Ahmednagar', '+915528375929', 'CTTT', 'MMT', 17, 8.5);

INSERT INTO SINHVIEN
VALUES ('SV21003658', 'Anahita Acharya', 'Nam', to_date('2014-11-10', 'YYYY-MM-DD'), '68/20 Manda Circle Gopalpur', '6123681287', 'CTTT', 'CNPM', 107, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21003659', 'Saanvi Sama', 'Nam', to_date('1935-01-17', 'YYYY-MM-DD'), '594 Chakrabarti Marg Purnia', '05216836237', 'CTTT', 'KHMT', 34, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003660', 'Anaya Devi', 'N?', to_date('1971-05-06', 'YYYY-MM-DD'), '74/410 Gulati Road Medininagar', '0297293409', 'CTTT', 'CNPM', 82, 4.78);

INSERT INTO SINHVIEN
VALUES ('SV21003661', 'Mishti Dara', 'N?', to_date('1956-11-11', 'YYYY-MM-DD'), '894 Choudhury Thane', '07352662497', 'CLC', 'CNPM', 110, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21003662', 'Bhavin Goyal', 'N?', to_date('1917-11-22', 'YYYY-MM-DD'), '19 Rege Yamunanagar', '05388920941', 'CTTT', 'CNPM', 84, 5.44);

INSERT INTO SINHVIEN
VALUES ('SV21003663', 'Anaya Trivedi', 'Nam', to_date('1997-02-05', 'YYYY-MM-DD'), 'H.No. 15 Balakrishnan Ganj Jabalpur', '+912114369112', 'CLC', 'KHMT', 98, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21003664', 'Kaira Rajagopalan', 'Nam', to_date('1979-11-23', 'YYYY-MM-DD'), '170 Krish Madanapalle', '03499657508', 'CQ', 'TGMT', 10, 5.43);

INSERT INTO SINHVIEN
VALUES ('SV21003665', 'Prerak Shenoy', 'N?', to_date('1962-01-13', 'YYYY-MM-DD'), '92/12 Madan Ganj Warangal', '09258793911', 'CTTT', 'MMT', 98, 7.32);

INSERT INTO SINHVIEN
VALUES ('SV21003666', 'Vaibhav Kar', 'Nam', to_date('1957-10-07', 'YYYY-MM-DD'), '842 Goda Ganj Adoni', '4575771483', 'CQ', 'MMT', 118, 7.79);

INSERT INTO SINHVIEN
VALUES ('SV21003667', 'Farhan Dugar', 'N?', to_date('1949-08-13', 'YYYY-MM-DD'), 'H.No. 140 Barad Marg Munger', '04524052695', 'CLC', 'KHMT', 97, 9.98);

INSERT INTO SINHVIEN
VALUES ('SV21003668', 'Sumer Yohannan', 'N?', to_date('2018-07-23', 'YYYY-MM-DD'), '74/14 Agarwal Road Pudukkottai', '4256292253', 'VP', 'CNPM', 126, 9.31);

INSERT INTO SINHVIEN
VALUES ('SV21003669', 'Dhruv Comar', 'N?', to_date('1920-12-05', 'YYYY-MM-DD'), '279 Gopal Ganj Ghaziabad', '08055665373', 'CLC', 'TGMT', 108, 4.66);

INSERT INTO SINHVIEN
VALUES ('SV21003670', 'Diya Raj', 'Nam', to_date('2005-06-13', 'YYYY-MM-DD'), 'H.No. 249 Trivedi Ganj Khammam', '+910383008246', 'CQ', 'CNTT', 80, 5.51);

INSERT INTO SINHVIEN
VALUES ('SV21003671', 'Urvi Basu', 'Nam', to_date('1945-03-18', 'YYYY-MM-DD'), '02 Dora Zila Munger', '04824606852', 'CLC', 'CNPM', 36, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21003672', 'Divyansh Dutt', 'N?', to_date('1967-07-24', 'YYYY-MM-DD'), '58 Ben Marg Katni', '5294880949', 'CLC', 'KHMT', 81, 6.53);

INSERT INTO SINHVIEN
VALUES ('SV21003673', 'Indranil Bora', 'N?', to_date('1941-02-16', 'YYYY-MM-DD'), '69/742 Dayal Ganj Machilipatnam', '5047308142', 'CTTT', 'HTTT', 21, 7.42);

INSERT INTO SINHVIEN
VALUES ('SV21003674', 'Divij Dutta', 'N?', to_date('2001-09-03', 'YYYY-MM-DD'), '093 Ratti Nagar Arrah', '07485002163', 'CTTT', 'CNPM', 46, 5.75);

INSERT INTO SINHVIEN
VALUES ('SV21003675', 'Damini Banerjee', 'N?', to_date('2022-11-16', 'YYYY-MM-DD'), 'H.No. 37 Mannan Bhimavaram', '09019269648', 'CLC', 'CNTT', 34, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21003676', 'Aaina Bhakta', 'N?', to_date('2009-08-07', 'YYYY-MM-DD'), 'H.No. 09 Korpal Marg Shivpuri', '07120313856', 'VP', 'CNTT', 58, 4.23);

INSERT INTO SINHVIEN
VALUES ('SV21003677', 'Eva Dewan', 'Nam', to_date('1928-11-10', 'YYYY-MM-DD'), '71 Rana Nagar Srikakulam', '01393636219', 'CTTT', 'CNPM', 85, 6.37);

INSERT INTO SINHVIEN
VALUES ('SV21003678', 'Vardaniya Joshi', 'N?', to_date('1940-10-26', 'YYYY-MM-DD'), '00 Dada Ganj Visakhapatnam', '+914434880133', 'CTTT', 'HTTT', 82, 8.89);

INSERT INTO SINHVIEN
VALUES ('SV21003679', 'Adah Shere', 'N?', to_date('2015-06-22', 'YYYY-MM-DD'), '78/86 Grover Marg Rajpur Sonarpur', '6702925121', 'CTTT', 'MMT', 0, 4.05);

INSERT INTO SINHVIEN
VALUES ('SV21003680', 'Riaan Hegde', 'N?', to_date('2003-07-28', 'YYYY-MM-DD'), '53/35 Varughese Zila Raichur', '03742568472', 'CLC', 'TGMT', 79, 9.43);

INSERT INTO SINHVIEN
VALUES ('SV21003681', 'Lagan Sarin', 'Nam', to_date('1971-03-04', 'YYYY-MM-DD'), 'H.No. 52 Yadav Circle Gopalpur', '09324214654', 'CTTT', 'KHMT', 66, 4.48);

INSERT INTO SINHVIEN
VALUES ('SV21003682', 'Hridaan Biswas', 'Nam', to_date('1996-12-03', 'YYYY-MM-DD'), '74/822 Datta Circle Kollam', '6496040571', 'CQ', 'CNTT', 129, 5.27);

INSERT INTO SINHVIEN
VALUES ('SV21003683', 'Romil Wagle', 'N?', to_date('1973-03-13', 'YYYY-MM-DD'), '493 D��Alia Zila Dharmavaram', '+915147895840', 'VP', 'MMT', 10, 5.09);

INSERT INTO SINHVIEN
VALUES ('SV21003684', 'Ehsaan Wali', 'Nam', to_date('1917-11-13', 'YYYY-MM-DD'), 'H.No. 748 Jha Kamarhati', '08074319105', 'CTTT', 'CNPM', 131, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21003685', 'Riya Batra', 'Nam', to_date('2011-01-20', 'YYYY-MM-DD'), '115 Srinivasan Ganj Bhatpara', '3947947501', 'CTTT', 'CNPM', 29, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21003686', 'Sahil Comar', 'N?', to_date('1909-12-30', 'YYYY-MM-DD'), '63/06 Kuruvilla Road Parbhani', '1174562722', 'CLC', 'MMT', 123, 4.32);

INSERT INTO SINHVIEN
VALUES ('SV21003687', 'Siya Bath', 'N?', to_date('1918-07-16', 'YYYY-MM-DD'), 'H.No. 71 Raman Street Dhanbad', '7910599495', 'CLC', 'TGMT', 23, 4.96);

INSERT INTO SINHVIEN
VALUES ('SV21003688', 'Diya Sarna', 'N?', to_date('1992-12-23', 'YYYY-MM-DD'), '33/74 Srinivas Ganj Ozhukarai', '+918827384388', 'CQ', 'CNTT', 39, 6.66);

INSERT INTO SINHVIEN
VALUES ('SV21003689', 'Arnav Sangha', 'N?', to_date('1926-02-12', 'YYYY-MM-DD'), '15 Karnik Road Bangalore', '05553865091', 'CQ', 'CNTT', 99, 4.69);

INSERT INTO SINHVIEN
VALUES ('SV21003690', 'Samaira Rajan', 'Nam', to_date('1941-03-06', 'YYYY-MM-DD'), '455 Dave Road Rourkela', '+915287201302', 'CLC', 'HTTT', 39, 5.46);

INSERT INTO SINHVIEN
VALUES ('SV21003691', 'Anika Sawhney', 'Nam', to_date('1970-04-24', 'YYYY-MM-DD'), 'H.No. 50 Hans Zila Jamshedpur', '+913189137211', 'CQ', 'CNTT', 1, 6.11);

INSERT INTO SINHVIEN
VALUES ('SV21003692', 'Ishaan Kapur', 'N?', to_date('1952-07-31', 'YYYY-MM-DD'), 'H.No. 547 Banik Zila Nagercoil', '+915813994576', 'CQ', 'TGMT', 100, 4.37);

INSERT INTO SINHVIEN
VALUES ('SV21003693', 'Badal Krishnamurthy', 'Nam', to_date('1947-04-21', 'YYYY-MM-DD'), '380 Boase Ganj Kanpur', '09195334807', 'CTTT', 'MMT', 116, 8.08);

INSERT INTO SINHVIEN
VALUES ('SV21003694', 'Nitya Raja', 'Nam', to_date('1935-12-04', 'YYYY-MM-DD'), '65 Bhatti Ganj Gaya', '4516143729', 'CQ', 'CNPM', 111, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21003695', 'Indranil Sodhi', 'Nam', to_date('1911-04-20', 'YYYY-MM-DD'), 'H.No. 737 Sheth Road Khandwa', '0279528994', 'CTTT', 'TGMT', 75, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21003696', 'Samaira Mall', 'N?', to_date('2023-02-10', 'YYYY-MM-DD'), '017 Chatterjee Street Nagpur', '7508628437', 'VP', 'CNTT', 2, 9.97);

INSERT INTO SINHVIEN
VALUES ('SV21003697', 'Neysa Tella', 'Nam', to_date('2004-07-11', 'YYYY-MM-DD'), '61 Borah Zila Salem', '7767672018', 'VP', 'CNPM', 132, 8.47);

INSERT INTO SINHVIEN
VALUES ('SV21003698', 'Onkar Kakar', 'Nam', to_date('1922-11-04', 'YYYY-MM-DD'), '50/25 Khare Marg Ulhasnagar', '6057960376', 'CTTT', 'KHMT', 33, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21003699', 'Nayantara Bala', 'N?', to_date('1988-10-10', 'YYYY-MM-DD'), '25/06 Sankaran Nagar Nadiad', '+911732403643', 'CLC', 'HTTT', 107, 5.36);

INSERT INTO SINHVIEN
VALUES ('SV21003700', 'Rania Rastogi', 'Nam', to_date('2011-07-10', 'YYYY-MM-DD'), '44/849 Krishna Path Gulbarga', '02521066432', 'CQ', 'KHMT', 92, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21003701', 'Onkar Sridhar', 'N?', to_date('1916-09-14', 'YYYY-MM-DD'), '18 Lanka Ganj Bidar', '0755500111', 'CQ', 'CNTT', 111, 8.68);

INSERT INTO SINHVIEN
VALUES ('SV21003702', 'Lagan Upadhyay', 'Nam', to_date('1935-12-06', 'YYYY-MM-DD'), '64/09 Sarna Zila Avadi', '03110831827', 'CQ', 'HTTT', 48, 8.93);

INSERT INTO SINHVIEN
VALUES ('SV21003703', 'Arnav Bora', 'N?', to_date('1958-02-01', 'YYYY-MM-DD'), '762 Goswami Road Latur', '+912469485623', 'CLC', 'HTTT', 138, 5.2);

INSERT INTO SINHVIEN
VALUES ('SV21003704', 'Damini Kapoor', 'Nam', to_date('2008-04-26', 'YYYY-MM-DD'), '180 Seth Path Bally', '+910481784442', 'VP', 'TGMT', 29, 5.87);

INSERT INTO SINHVIEN
VALUES ('SV21003705', 'Charvi Dasgupta', 'Nam', to_date('1909-02-01', 'YYYY-MM-DD'), '294 Bahri Ganj Singrauli', '8059321689', 'CLC', 'KHMT', 122, 8.2);

INSERT INTO SINHVIEN
VALUES ('SV21003706', 'Neysa Dora', 'Nam', to_date('1959-03-30', 'YYYY-MM-DD'), '34/693 Sood Path Katihar', '08456634606', 'VP', 'CNTT', 135, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21003707', 'Nirvaan Sandal', 'N?', to_date('1979-12-09', 'YYYY-MM-DD'), 'H.No. 038 Choudhary Bhiwandi', '8152962162', 'CQ', 'MMT', 32, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21003708', 'Ivana Sant', 'N?', to_date('2018-03-11', 'YYYY-MM-DD'), '41 Khanna Ganj Delhi', '+918389248597', 'VP', 'KHMT', 65, 6.21);

INSERT INTO SINHVIEN
VALUES ('SV21003709', 'Biju Baria', 'Nam', to_date('1964-06-07', 'YYYY-MM-DD'), 'H.No. 67 Dara Chowk Medininagar', '01012186775', 'CQ', 'HTTT', 3, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21003710', 'Aaryahi De', 'Nam', to_date('1960-09-01', 'YYYY-MM-DD'), 'H.No. 693 Kapadia Chowk Bhilai', '+911284119400', 'CLC', 'CNPM', 53, 4.5);

INSERT INTO SINHVIEN
VALUES ('SV21003711', 'Divij Baria', 'N?', to_date('1912-12-31', 'YYYY-MM-DD'), '09 Chanda Road Cuttack', '6719571409', 'CLC', 'HTTT', 46, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21003712', 'Purab Chad', 'Nam', to_date('1987-09-16', 'YYYY-MM-DD'), 'H.No. 89 Dey Circle Gandhinagar', '+919066117734', 'VP', 'HTTT', 11, 6.05);

INSERT INTO SINHVIEN
VALUES ('SV21003713', 'Gatik Wason', 'Nam', to_date('1917-07-30', 'YYYY-MM-DD'), '046 Saraf Nagar Kulti', '07387033973', 'CTTT', 'MMT', 73, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003714', 'Jiya Bhargava', 'Nam', to_date('1938-08-29', 'YYYY-MM-DD'), '78/73 Kuruvilla Street Danapur', '7567925608', 'CQ', 'CNTT', 29, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21003715', 'Yashvi Bhagat', 'Nam', to_date('1964-02-12', 'YYYY-MM-DD'), '85/40 Dixit Street Dehradun', '04353389585', 'VP', 'CNTT', 2, 5.66);

INSERT INTO SINHVIEN
VALUES ('SV21003716', 'Nirvaan Chatterjee', 'N?', to_date('1916-11-06', 'YYYY-MM-DD'), '71/953 Dhillon Road Ulhasnagar', '+911708857289', 'CQ', 'TGMT', 129, 4.71);

INSERT INTO SINHVIEN
VALUES ('SV21003717', 'Miraya Goel', 'Nam', to_date('1924-05-27', 'YYYY-MM-DD'), '255 Brar Circle Nellore', '+912004630313', 'CQ', 'KHMT', 5, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21003718', 'Neysa Anand', 'N?', to_date('1956-01-28', 'YYYY-MM-DD'), '16/120 Bhatnagar Circle Naihati', '+918921901733', 'CQ', 'HTTT', 134, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21003719', 'Anaya Raja', 'N?', to_date('1987-08-26', 'YYYY-MM-DD'), '11/182 Chanda Ganj Guwahati', '05438260525', 'CTTT', 'MMT', 22, 6.09);

INSERT INTO SINHVIEN
VALUES ('SV21003720', 'Gatik Chhabra', 'Nam', to_date('1916-11-18', 'YYYY-MM-DD'), '218 Goswami Ganj Mirzapur', '5608153136', 'CTTT', 'HTTT', 101, 6.73);

INSERT INTO SINHVIEN
VALUES ('SV21003721', 'Sumer Luthra', 'N?', to_date('1927-07-11', 'YYYY-MM-DD'), '87/46 Borra Chowk Aizawl', '02054441180', 'VP', 'MMT', 49, 8.67);

INSERT INTO SINHVIEN
VALUES ('SV21003722', 'Heer Chanda', 'Nam', to_date('2005-11-29', 'YYYY-MM-DD'), '16/905 Dash Marg Kota', '1541158383', 'CLC', 'MMT', 89, 6.52);

INSERT INTO SINHVIEN
VALUES ('SV21003723', 'Kiara Sethi', 'Nam', to_date('1947-07-04', 'YYYY-MM-DD'), 'H.No. 52 Kapur Alwar', '01387711092', 'CQ', 'CNPM', 81, 8.94);

INSERT INTO SINHVIEN
VALUES ('SV21003724', 'Tarini Shukla', 'Nam', to_date('2007-12-07', 'YYYY-MM-DD'), '096 Sagar Zila Saharanpur', '01707165219', 'CTTT', 'CNTT', 111, 9.27);

INSERT INTO SINHVIEN
VALUES ('SV21003725', 'Indrans Boase', 'Nam', to_date('2020-10-30', 'YYYY-MM-DD'), '296 Chanda Ganj Kollam', '5846312808', 'CQ', 'MMT', 5, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21003726', 'Hridaan Wagle', 'N?', to_date('1922-11-05', 'YYYY-MM-DD'), 'H.No. 34 Sekhon Marg Silchar', '+917079588841', 'CQ', 'CNPM', 119, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21003727', 'Fateh Manda', 'N?', to_date('1912-07-21', 'YYYY-MM-DD'), '13 Kohli Jaunpur', '+918265739063', 'CQ', 'TGMT', 67, 4.24);

INSERT INTO SINHVIEN
VALUES ('SV21003728', 'Biju Ranganathan', 'Nam', to_date('1981-11-01', 'YYYY-MM-DD'), '82 Randhawa Street Thane', '+918768262991', 'CQ', 'MMT', 17, 9.44);

INSERT INTO SINHVIEN
VALUES ('SV21003729', 'Urvi Dhaliwal', 'Nam', to_date('1987-01-08', 'YYYY-MM-DD'), '851 Guha Chowk Howrah', '+918923276360', 'CTTT', 'TGMT', 32, 9.49);

INSERT INTO SINHVIEN
VALUES ('SV21003730', 'Piya Banik', 'Nam', to_date('1990-11-15', 'YYYY-MM-DD'), '26/762 Sodhi Nagar Dehradun', '+913872799223', 'CLC', 'HTTT', 4, 8.18);

INSERT INTO SINHVIEN
VALUES ('SV21003731', 'Abram Shan', 'N?', to_date('1968-09-05', 'YYYY-MM-DD'), '10 Dasgupta Ganj Shimla', '+913311374473', 'VP', 'MMT', 14, 4.01);

INSERT INTO SINHVIEN
VALUES ('SV21003732', 'Mehul Shroff', 'Nam', to_date('1951-10-06', 'YYYY-MM-DD'), '91/81 Balasubramanian Circle Kavali', '09218280689', 'CQ', 'TGMT', 18, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003733', 'Samarth Rau', 'N?', to_date('1960-03-15', 'YYYY-MM-DD'), '560 Deo Circle Haridwar', '8185275187', 'CTTT', 'CNTT', 127, 4.56);

INSERT INTO SINHVIEN
VALUES ('SV21003734', 'Shayak Bhakta', 'N?', to_date('1975-01-30', 'YYYY-MM-DD'), 'H.No. 363 Mane Zila Tezpur', '+915070535831', 'CTTT', 'KHMT', 22, 7.26);

INSERT INTO SINHVIEN
VALUES ('SV21003735', 'Jayesh Krishnamurthy', 'N?', to_date('1999-11-21', 'YYYY-MM-DD'), '556 Kashyap Zila Begusarai', '+914729935618', 'CLC', 'CNTT', 102, 6.28);

INSERT INTO SINHVIEN
VALUES ('SV21003736', 'Shamik Dhaliwal', 'N?', to_date('1964-02-11', 'YYYY-MM-DD'), '660 Seshadri Road Dhanbad', '3349467527', 'CLC', 'HTTT', 1, 7.87);

INSERT INTO SINHVIEN
VALUES ('SV21003737', 'Vihaan Vasa', 'Nam', to_date('2005-07-30', 'YYYY-MM-DD'), 'H.No. 52 Ratti Street Malegaon', '3852595498', 'CTTT', 'MMT', 33, 4.88);

INSERT INTO SINHVIEN
VALUES ('SV21003738', 'Hunar Bera', 'N?', to_date('1965-02-04', 'YYYY-MM-DD'), 'H.No. 594 Bail Path Malegaon', '8041861617', 'CLC', 'TGMT', 23, 4.61);

INSERT INTO SINHVIEN
VALUES ('SV21003739', 'Tushar Hayer', 'N?', to_date('1947-04-30', 'YYYY-MM-DD'), 'H.No. 052 Lal Ganj Adoni', '+913831041246', 'VP', 'MMT', 73, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21003740', 'Yuvaan Wable', 'Nam', to_date('1966-11-30', 'YYYY-MM-DD'), 'H.No. 473 Bhat Ganj Guna', '7889644856', 'CQ', 'CNTT', 109, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21003741', 'Elakshi Yohannan', 'Nam', to_date('1992-05-12', 'YYYY-MM-DD'), '802 Lalla Street Darbhanga', '05439700368', 'CLC', 'HTTT', 5, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21003742', 'Ojas Krishnamurthy', 'N?', to_date('1940-11-28', 'YYYY-MM-DD'), 'H.No. 01 Khalsa Ganj Varanasi', '8781703422', 'CTTT', 'MMT', 38, 6.82);

INSERT INTO SINHVIEN
VALUES ('SV21003743', 'Ela Sheth', 'Nam', to_date('1952-12-08', 'YYYY-MM-DD'), '73/75 Arya Nagar Karimnagar', '00538995678', 'CLC', 'MMT', 32, 4.87);

INSERT INTO SINHVIEN
VALUES ('SV21003744', 'Vritika Chadha', 'Nam', to_date('2006-01-17', 'YYYY-MM-DD'), '02/768 Bahl Road Bardhaman', '+913705289632', 'CTTT', 'MMT', 64, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21003745', 'Ojas Sachdeva', 'Nam', to_date('1999-04-11', 'YYYY-MM-DD'), 'H.No. 68 Dua Street Sri Ganganagar', '00059325712', 'CQ', 'CNPM', 23, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21003746', 'Ranbir Issac', 'N?', to_date('1928-08-07', 'YYYY-MM-DD'), '03/51 Suri Street Amaravati', '08392540728', 'CQ', 'MMT', 65, 4.28);

INSERT INTO SINHVIEN
VALUES ('SV21003747', 'Misha Ahluwalia', 'Nam', to_date('1984-11-03', 'YYYY-MM-DD'), '92/943 Thakkar Path Kharagpur', '+917567989152', 'CLC', 'KHMT', 19, 8.76);

INSERT INTO SINHVIEN
VALUES ('SV21003748', 'Adah Mandal', 'Nam', to_date('1974-09-07', 'YYYY-MM-DD'), '51/67 Dubey Road Jalandhar', '04758682003', 'CQ', 'CNTT', 92, 4.73);

INSERT INTO SINHVIEN
VALUES ('SV21003749', 'Amira Manne', 'N?', to_date('1993-01-07', 'YYYY-MM-DD'), '28/92 Kakar Nagar Agra', '08112380143', 'CLC', 'KHMT', 69, 8.15);

INSERT INTO SINHVIEN
VALUES ('SV21003750', 'Anvi Sachdev', 'N?', to_date('1993-03-19', 'YYYY-MM-DD'), '91/200 Biswas Marg Siliguri', '+913439062016', 'CQ', 'MMT', 105, 8.81);

INSERT INTO SINHVIEN
VALUES ('SV21003751', 'Arnav Divan', 'Nam', to_date('1918-08-10', 'YYYY-MM-DD'), '72 Chanda Road Fatehpur', '5342354796', 'VP', 'KHMT', 26, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21003752', 'Trisha Dugal', 'Nam', to_date('1962-03-18', 'YYYY-MM-DD'), 'H.No. 481 Dhawan Nagar Kulti', '+914061341074', 'CQ', 'TGMT', 78, 5.15);

INSERT INTO SINHVIEN
VALUES ('SV21003753', 'Shray Andra', 'N?', to_date('1956-11-10', 'YYYY-MM-DD'), '10/03 Kamdar Path Kolhapur', '+914719696714', 'CTTT', 'MMT', 126, 5.18);

INSERT INTO SINHVIEN
VALUES ('SV21003754', 'Inaaya  Bava', 'N?', to_date('1936-07-28', 'YYYY-MM-DD'), '45/96 Baral Zila Udupi', '+913588226443', 'VP', 'CNPM', 15, 8.77);

INSERT INTO SINHVIEN
VALUES ('SV21003755', 'Jayesh Mannan', 'Nam', to_date('1932-04-02', 'YYYY-MM-DD'), 'H.No. 03 Sane Path Bhubaneswar', '06811763670', 'VP', 'CNTT', 117, 8.14);

INSERT INTO SINHVIEN
VALUES ('SV21003756', 'Zoya Chaudhry', 'N?', to_date('1952-12-31', 'YYYY-MM-DD'), '79 Singhal Guntakal', '0033117540', 'CTTT', 'CNPM', 77, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21003757', 'Lagan Tiwari', 'N?', to_date('1981-11-11', 'YYYY-MM-DD'), '605 Saini Chowk Panihati', '07041925645', 'CTTT', 'MMT', 26, 7.6);

INSERT INTO SINHVIEN
VALUES ('SV21003758', 'Sahil Grover', 'Nam', to_date('1959-04-01', 'YYYY-MM-DD'), '52 Dani Road Khammam', '1911716719', 'VP', 'CNPM', 115, 8.19);

INSERT INTO SINHVIEN
VALUES ('SV21003759', 'Devansh Buch', 'N?', to_date('1954-05-08', 'YYYY-MM-DD'), '53 Savant Zila Morbi', '02409078738', 'CQ', 'KHMT', 67, 5.65);

INSERT INTO SINHVIEN
VALUES ('SV21003760', 'Farhan Swamy', 'N?', to_date('1998-01-06', 'YYYY-MM-DD'), '552 Soman Chowk Sultan Pur Majra', '02867086512', 'CQ', 'CNTT', 60, 8.99);

INSERT INTO SINHVIEN
VALUES ('SV21003761', 'Rasha Kaul', 'N?', to_date('1952-10-06', 'YYYY-MM-DD'), '69 Yohannan Path Tumkur', '8578664555', 'VP', 'MMT', 8, 5.37);

INSERT INTO SINHVIEN
VALUES ('SV21003762', 'Anahita Jha', 'Nam', to_date('1964-02-23', 'YYYY-MM-DD'), '25 Rajagopalan Circle Sri Ganganagar', '+914104032305', 'CTTT', 'HTTT', 6, 9.25);

INSERT INTO SINHVIEN
VALUES ('SV21003763', 'Indrajit Sama', 'N?', to_date('1952-12-09', 'YYYY-MM-DD'), 'H.No. 79 Kannan Path Gandhinagar', '04197639539', 'CTTT', 'MMT', 40, 9.54);

INSERT INTO SINHVIEN
VALUES ('SV21003764', 'Ivan Saini', 'Nam', to_date('1910-09-30', 'YYYY-MM-DD'), 'H.No. 974 Lad Road Bongaigaon', '2205176283', 'VP', 'CNTT', 97, 8.29);

INSERT INTO SINHVIEN
VALUES ('SV21003765', 'Nayantara Kunda', 'Nam', to_date('1977-10-22', 'YYYY-MM-DD'), '91/11 Kala Chowk Dibrugarh', '5218068651', 'VP', 'MMT', 0, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21003766', 'Ehsaan Sha', 'Nam', to_date('1945-08-22', 'YYYY-MM-DD'), 'H.No. 51 Chaudhary Circle Morbi', '8225104335', 'CLC', 'KHMT', 84, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21003767', 'Lagan Sachdev', 'Nam', to_date('1962-04-15', 'YYYY-MM-DD'), '23/553 Saxena Zila Ghaziabad', '03653932986', 'CQ', 'KHMT', 101, 8.72);

INSERT INTO SINHVIEN
VALUES ('SV21003768', 'Gatik Chander', 'N?', to_date('2018-08-30', 'YYYY-MM-DD'), '39/847 Apte Marg Hazaribagh', '8872723640', 'CTTT', 'CNPM', 8, 7.57);

INSERT INTO SINHVIEN
VALUES ('SV21003769', 'Jayan Kanda', 'Nam', to_date('1950-02-22', 'YYYY-MM-DD'), '231 Sahota Circle Rewa', '+910054949263', 'CTTT', 'CNPM', 123, 5.96);

INSERT INTO SINHVIEN
VALUES ('SV21003770', 'Eshani Ram', 'Nam', to_date('1914-06-03', 'YYYY-MM-DD'), '69/50 Ganesan Ganj Noida', '2969652460', 'CQ', 'MMT', 91, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21003771', 'Anahita Kale', 'N?', to_date('1996-10-02', 'YYYY-MM-DD'), '28/594 Lad Road Shimoga', '00491734084', 'CQ', 'TGMT', 60, 5.72);

INSERT INTO SINHVIEN
VALUES ('SV21003772', 'Oorja Sathe', 'Nam', to_date('1980-09-23', 'YYYY-MM-DD'), 'H.No. 53 Bhasin Miryalaguda', '+915693552478', 'VP', 'KHMT', 0, 5.59);

INSERT INTO SINHVIEN
VALUES ('SV21003773', 'Prisha Sridhar', 'Nam', to_date('2006-10-26', 'YYYY-MM-DD'), '415 Balakrishnan Road Jammu', '5833452513', 'CTTT', 'KHMT', 107, 9.81);

INSERT INTO SINHVIEN
VALUES ('SV21003774', 'Baiju Jaggi', 'N?', to_date('1980-06-06', 'YYYY-MM-DD'), '56/762 Dass Nagar Siliguri', '2703501780', 'CQ', 'KHMT', 86, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21003775', 'Mamooty Setty', 'N?', to_date('2008-01-27', 'YYYY-MM-DD'), 'H.No. 638 Kar Road Tiruchirappalli', '09280313917', 'CQ', 'TGMT', 72, 7.06);

INSERT INTO SINHVIEN
VALUES ('SV21003776', 'Miraya Walia', 'N?', to_date('1931-08-06', 'YYYY-MM-DD'), '67/124 Dube Marg Anand', '5064295289', 'CLC', 'MMT', 101, 6.06);

INSERT INTO SINHVIEN
VALUES ('SV21003777', 'Baiju Deshmukh', 'Nam', to_date('1977-09-19', 'YYYY-MM-DD'), 'H.No. 355 Dugar Circle Bhusawal', '1383800030', 'CLC', 'KHMT', 126, 7.47);

INSERT INTO SINHVIEN
VALUES ('SV21003778', 'Abram Tripathi', 'Nam', to_date('1932-06-03', 'YYYY-MM-DD'), '02 Batra Chowk Meerut', '+916142898156', 'CLC', 'CNTT', 63, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21003779', 'Jayant Lal', 'Nam', to_date('1957-09-13', 'YYYY-MM-DD'), '189 Kamdar Chowk Munger', '5644125566', 'VP', 'TGMT', 2, 6.26);

INSERT INTO SINHVIEN
VALUES ('SV21003780', 'Arnav Golla', 'Nam', to_date('1918-06-18', 'YYYY-MM-DD'), '68/430 Bansal Deoghar', '06046995405', 'CQ', 'TGMT', 82, 5.54);

INSERT INTO SINHVIEN
VALUES ('SV21003781', 'Sumer Gera', 'N?', to_date('1925-02-04', 'YYYY-MM-DD'), 'H.No. 94 Bansal Marg Morbi', '06450036542', 'CQ', 'HTTT', 21, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003782', 'Jivika Kanda', 'N?', to_date('2011-06-08', 'YYYY-MM-DD'), '214 Sarma Circle Hapur', '06914016821', 'VP', 'CNPM', 90, 4.63);

INSERT INTO SINHVIEN
VALUES ('SV21003783', 'Rasha Borah', 'N?', to_date('1983-12-04', 'YYYY-MM-DD'), 'H.No. 57 Loyal Malegaon', '3673605348', 'CQ', 'TGMT', 14, 9.97);

INSERT INTO SINHVIEN
VALUES ('SV21003784', 'Pihu Bobal', 'N?', to_date('1987-03-22', 'YYYY-MM-DD'), 'H.No. 611 Ganguly Sikar', '6373201052', 'CLC', 'KHMT', 102, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21003785', 'Tarini Choudhry', 'N?', to_date('1968-05-12', 'YYYY-MM-DD'), '55 Bhatia Street Jehanabad', '5876359676', 'VP', 'CNPM', 31, 8.83);

INSERT INTO SINHVIEN
VALUES ('SV21003786', 'Anaya Zachariah', 'Nam', to_date('2013-05-04', 'YYYY-MM-DD'), '759 Gulati Street Jamshedpur', '+919703875240', 'CLC', 'TGMT', 103, 6.57);

INSERT INTO SINHVIEN
VALUES ('SV21003787', 'Sana Tripathi', 'Nam', to_date('1978-04-19', 'YYYY-MM-DD'), 'H.No. 88 Mann Circle Darbhanga', '09599397099', 'CLC', 'CNTT', 36, 8.54);

INSERT INTO SINHVIEN
VALUES ('SV21003788', 'Shray Ray', 'N?', to_date('1965-12-02', 'YYYY-MM-DD'), '93/50 Dua Nagar Malegaon', '09324484805', 'CLC', 'HTTT', 106, 6.92);

INSERT INTO SINHVIEN
VALUES ('SV21003789', 'Vedika Setty', 'Nam', to_date('2005-05-30', 'YYYY-MM-DD'), 'H.No. 30 Desai Road Jalandhar', '+911880182503', 'CTTT', 'KHMT', 79, 5.17);

INSERT INTO SINHVIEN
VALUES ('SV21003790', 'Advika Jaggi', 'Nam', to_date('1944-04-11', 'YYYY-MM-DD'), 'H.No. 42 Cherian Zila Chinsurah', '+913617735500', 'VP', 'HTTT', 102, 9.2);

INSERT INTO SINHVIEN
VALUES ('SV21003791', 'Armaan Bumb', 'N?', to_date('1971-04-01', 'YYYY-MM-DD'), '727 Dhillon Marg Serampore', '5308591937', 'CTTT', 'CNTT', 71, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003792', 'Nakul Sethi', 'N?', to_date('1937-10-13', 'YYYY-MM-DD'), 'H.No. 993 Divan Path Gopalpur', '+910677913836', 'CTTT', 'CNPM', 13, 5.17);

INSERT INTO SINHVIEN
VALUES ('SV21003793', 'Riya Singh', 'N?', to_date('1995-11-22', 'YYYY-MM-DD'), '094 Jha Chowk Eluru', '04343872221', 'CQ', 'TGMT', 83, 9.38);

INSERT INTO SINHVIEN
VALUES ('SV21003794', 'Riya Sant', 'N?', to_date('1926-06-04', 'YYYY-MM-DD'), '219 Kibe Path Kottayam', '+919014980581', 'VP', 'HTTT', 116, 4.99);

INSERT INTO SINHVIEN
VALUES ('SV21003795', 'Romil Bhatnagar', 'Nam', to_date('1935-08-28', 'YYYY-MM-DD'), '89/94 Cherian Chowk Gaya', '08683062251', 'CLC', 'HTTT', 90, 7.45);

INSERT INTO SINHVIEN
VALUES ('SV21003796', 'Myra Singhal', 'N?', to_date('2021-07-28', 'YYYY-MM-DD'), 'H.No. 66 Kothari Ganj Latur', '7554870983', 'CLC', 'CNTT', 37, 5.12);

INSERT INTO SINHVIEN
VALUES ('SV21003797', 'Shray Thakur', 'Nam', to_date('1937-08-26', 'YYYY-MM-DD'), '33/810 Deep Street Surendranagar Dudhrej', '08174954378', 'CTTT', 'KHMT', 101, 5.29);

INSERT INTO SINHVIEN
VALUES ('SV21003798', 'Aaina Kale', 'Nam', to_date('2001-04-24', 'YYYY-MM-DD'), '34/36 Kohli Road Jabalpur', '9618712666', 'CQ', 'CNTT', 96, 9.99);

INSERT INTO SINHVIEN
VALUES ('SV21003799', 'Yasmin Hans', 'N?', to_date('2019-03-04', 'YYYY-MM-DD'), '15 Chacko Nagar Bokaro', '+917506959983', 'CQ', 'TGMT', 20, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21003800', 'Ira Korpal', 'N?', to_date('1968-11-16', 'YYYY-MM-DD'), '446 Tripathi Circle Jaipur', '+912404009327', 'VP', 'KHMT', 109, 6.78);

INSERT INTO SINHVIEN
VALUES ('SV21003801', 'Bhamini Bumb', 'Nam', to_date('1972-02-18', 'YYYY-MM-DD'), '96 Lal Shahjahanpur', '09721079062', 'CQ', 'CNTT', 91, 8.88);

INSERT INTO SINHVIEN
VALUES ('SV21003802', 'Devansh Bhatnagar', 'N?', to_date('1928-08-22', 'YYYY-MM-DD'), '01/64 Kale Varanasi', '+912645955460', 'CTTT', 'CNTT', 59, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21003803', 'Darshit Hans', 'Nam', to_date('1933-03-19', 'YYYY-MM-DD'), '990 Lala Bhalswa Jahangir Pur', '04412706205', 'VP', 'MMT', 56, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21003804', 'Aniruddh Mangal', 'Nam', to_date('1932-06-02', 'YYYY-MM-DD'), '81 Lal Zila Kirari Suleman Nagar', '8603850456', 'VP', 'CNPM', 111, 9.36);

INSERT INTO SINHVIEN
VALUES ('SV21003805', 'Nakul Kaur', 'Nam', to_date('1951-08-09', 'YYYY-MM-DD'), '278 Sridhar Road Navi Mumbai', '7170157931', 'VP', 'CNPM', 136, 5.69);

INSERT INTO SINHVIEN
VALUES ('SV21003806', 'Siya Shankar', 'N?', to_date('1960-07-26', 'YYYY-MM-DD'), '194 Sengupta Street Hazaribagh', '1460042976', 'CQ', 'HTTT', 20, 7.38);

INSERT INTO SINHVIEN
VALUES ('SV21003807', 'Azad Sathe', 'N?', to_date('2018-08-06', 'YYYY-MM-DD'), '12 Sodhi Path Hindupur', '8407923461', 'VP', 'MMT', 110, 8.21);

INSERT INTO SINHVIEN
VALUES ('SV21003808', 'Piya Barman', 'N?', to_date('1944-04-21', 'YYYY-MM-DD'), 'H.No. 402 Hayre Path Kishanganj', '+912328823388', 'VP', 'CNTT', 100, 7.39);

INSERT INTO SINHVIEN
VALUES ('SV21003809', 'Parinaaz Shere', 'N?', to_date('2017-10-23', 'YYYY-MM-DD'), '16 Dugal Ganj Saharanpur', '9446468322', 'CLC', 'HTTT', 104, 5.79);

INSERT INTO SINHVIEN
VALUES ('SV21003810', 'Vaibhav Banerjee', 'N?', to_date('1983-01-09', 'YYYY-MM-DD'), '78/43 Lalla Nagar Giridih', '+910407188121', 'VP', 'CNTT', 59, 8.45);

INSERT INTO SINHVIEN
VALUES ('SV21003811', 'Faiyaz Karpe', 'Nam', to_date('1916-06-09', 'YYYY-MM-DD'), '43/18 Dubey Circle Mangalore', '+910877482461', 'CLC', 'CNPM', 8, 8.7);

INSERT INTO SINHVIEN
VALUES ('SV21003812', 'Alisha Kata', 'N?', to_date('1996-10-04', 'YYYY-MM-DD'), '00/00 Gaba Circle Buxar', '+912421455068', 'CLC', 'TGMT', 25, 8.9);

INSERT INTO SINHVIEN
VALUES ('SV21003813', 'Aniruddh Sibal', 'Nam', to_date('1986-06-25', 'YYYY-MM-DD'), '998 Gokhale Road Tirupati', '5323957783', 'VP', 'CNPM', 48, 6.15);

INSERT INTO SINHVIEN
VALUES ('SV21003814', 'Manikya Bajwa', 'N?', to_date('2014-12-04', 'YYYY-MM-DD'), 'H.No. 427 Samra Nagar Haldia', '02429303109', 'VP', 'CNTT', 98, 6.59);

INSERT INTO SINHVIEN
VALUES ('SV21003815', 'Bhamini Ranganathan', 'Nam', to_date('2014-12-25', 'YYYY-MM-DD'), '35 Karnik Ganj Kochi', '0322362467', 'CTTT', 'TGMT', 110, 6.91);

INSERT INTO SINHVIEN
VALUES ('SV21003816', 'Anya Gera', 'Nam', to_date('1971-06-17', 'YYYY-MM-DD'), '93 Brar Circle Avadi', '+912747933339', 'VP', 'HTTT', 11, 6.85);

INSERT INTO SINHVIEN
VALUES ('SV21003817', 'Ryan Dhingra', 'N?', to_date('1998-10-01', 'YYYY-MM-DD'), '46/366 Dada Marg Jalgaon', '8236026720', 'VP', 'TGMT', 82, 9.25);

INSERT INTO SINHVIEN
VALUES ('SV21003818', 'Anahita Yadav', 'Nam', to_date('1925-10-23', 'YYYY-MM-DD'), '53 Ganguly Road Gorakhpur', '4530890394', 'CLC', 'CNPM', 89, 8.94);

INSERT INTO SINHVIEN
VALUES ('SV21003819', 'Samaira Sibal', 'N?', to_date('2005-12-21', 'YYYY-MM-DD'), '89 Atwal Zila Ujjain', '03062416116', 'CQ', 'MMT', 117, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21003820', 'Shray Vig', 'N?', to_date('1989-12-02', 'YYYY-MM-DD'), '14/695 Sur Path Rampur', '01239289661', 'CTTT', 'CNPM', 128, 4.42);

INSERT INTO SINHVIEN
VALUES ('SV21003821', 'Raunak Issac', 'Nam', to_date('1965-10-19', 'YYYY-MM-DD'), 'H.No. 682 Agrawal Ganj Davanagere', '+913663931231', 'CQ', 'TGMT', 107, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21003822', 'Samiha Sharaf', 'N?', to_date('1964-01-07', 'YYYY-MM-DD'), '43/44 Tata Marg Jorhat', '+919542549203', 'CTTT', 'CNPM', 68, 4.07);

INSERT INTO SINHVIEN
VALUES ('SV21003823', 'Zeeshan Krishnan', 'N?', to_date('1979-03-20', 'YYYY-MM-DD'), 'H.No. 24 Choudhary Zila Ramgarh', '02714692474', 'CLC', 'TGMT', 124, 4.55);

INSERT INTO SINHVIEN
VALUES ('SV21003824', 'Devansh Karan', 'N?', to_date('1938-05-26', 'YYYY-MM-DD'), 'H.No. 495 Dugar Road Gangtok', '8892418849', 'VP', 'CNTT', 130, 4.1);

INSERT INTO SINHVIEN
VALUES ('SV21003825', 'Kartik Gade', 'Nam', to_date('1984-10-05', 'YYYY-MM-DD'), '91/33 Amble Road Uluberia', '00269000308', 'CLC', 'HTTT', 77, 6.56);

INSERT INTO SINHVIEN
VALUES ('SV21003826', 'Taran Dugal', 'N?', to_date('1968-05-07', 'YYYY-MM-DD'), 'H.No. 38 Raman Chowk Ulhasnagar', '+917830155981', 'CTTT', 'MMT', 15, 5.57);

INSERT INTO SINHVIEN
VALUES ('SV21003827', 'Tara Bedi', 'N?', to_date('1911-01-02', 'YYYY-MM-DD'), '62/842 Som Path Bilaspur', '+917939232468', 'VP', 'TGMT', 11, 7.03);

INSERT INTO SINHVIEN
VALUES ('SV21003828', 'Akarsh Mane', 'N?', to_date('2012-06-22', 'YYYY-MM-DD'), '19 Krishnamurthy Marg Nanded', '+918861835072', 'VP', 'CNPM', 70, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003829', 'Riya Koshy', 'N?', to_date('1996-09-03', 'YYYY-MM-DD'), 'H.No. 65 Venkataraman Circle Akola', '+919597199418', 'CQ', 'CNTT', 97, 9.86);

INSERT INTO SINHVIEN
VALUES ('SV21003830', 'Shanaya Roy', 'N?', to_date('1932-02-01', 'YYYY-MM-DD'), 'H.No. 912 Mane Zila Bhimavaram', '06823473398', 'VP', 'TGMT', 114, 5.73);

INSERT INTO SINHVIEN
VALUES ('SV21003831', 'Zoya Sandal', 'Nam', to_date('2002-09-22', 'YYYY-MM-DD'), '64/15 Bora Chowk Dehradun', '09906352501', 'CLC', 'HTTT', 99, 6.23);

INSERT INTO SINHVIEN
VALUES ('SV21003832', 'Madhup Dhillon', 'Nam', to_date('1957-02-27', 'YYYY-MM-DD'), 'H.No. 714 Dara Marg Mysore', '07096631908', 'CQ', 'MMT', 9, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21003833', 'Abram Tandon', 'Nam', to_date('1910-05-10', 'YYYY-MM-DD'), '824 Tata Nagar Kumbakonam', '0295468191', 'CLC', 'KHMT', 32, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21003834', 'Ranbir Basu', 'N?', to_date('1942-05-25', 'YYYY-MM-DD'), 'H.No. 325 Ravel Marg Buxar', '07086046667', 'VP', 'MMT', 35, 4.0);

INSERT INTO SINHVIEN
VALUES ('SV21003835', 'Alisha Cherian', 'N?', to_date('1913-01-22', 'YYYY-MM-DD'), 'H.No. 477 Srinivasan Circle Bellary', '+918731447633', 'VP', 'HTTT', 26, 9.88);

INSERT INTO SINHVIEN
VALUES ('SV21003836', 'Zeeshan Barad', 'Nam', to_date('1957-11-09', 'YYYY-MM-DD'), 'H.No. 55 Wason Circle Bijapur', '+911801190364', 'CQ', 'CNTT', 65, 5.6);

INSERT INTO SINHVIEN
VALUES ('SV21003837', 'Jayant Grover', 'N?', to_date('1959-03-02', 'YYYY-MM-DD'), 'H.No. 410 Goswami Jaipur', '3147447417', 'CTTT', 'HTTT', 102, 8.15);

INSERT INTO SINHVIEN
VALUES ('SV21003838', 'Mahika Lall', 'Nam', to_date('2016-01-04', 'YYYY-MM-DD'), '21 Soman Marg Gorakhpur', '+916101462400', 'CTTT', 'KHMT', 133, 6.7);

INSERT INTO SINHVIEN
VALUES ('SV21003839', 'Dhanush Wadhwa', 'Nam', to_date('1976-10-20', 'YYYY-MM-DD'), 'H.No. 60 Salvi Circle Morena', '01992118100', 'CQ', 'CNPM', 78, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21003840', 'Mishti Sahota', 'N?', to_date('1972-02-14', 'YYYY-MM-DD'), '35/839 Sachdeva Road Parbhani', '+916933866869', 'VP', 'CNTT', 100, 7.75);

INSERT INTO SINHVIEN
VALUES ('SV21003841', 'Krish Dara', 'Nam', to_date('1932-11-19', 'YYYY-MM-DD'), 'H.No. 26 Dar Circle Kavali', '+917912667112', 'CQ', 'KHMT', 31, 9.11);

INSERT INTO SINHVIEN
VALUES ('SV21003842', 'Myra Ray', 'N?', to_date('1986-09-09', 'YYYY-MM-DD'), 'H.No. 07 Bajwa Road Malda', '09105840090', 'CQ', 'TGMT', 125, 6.91);

INSERT INTO SINHVIEN
VALUES ('SV21003843', 'Ayesha Amble', 'N?', to_date('1980-01-25', 'YYYY-MM-DD'), 'H.No. 81 Chanda Marg Jalgaon', '6788712861', 'CTTT', 'HTTT', 81, 8.3);

INSERT INTO SINHVIEN
VALUES ('SV21003844', 'Arhaan Hora', 'Nam', to_date('1936-02-19', 'YYYY-MM-DD'), '24/92 Virk Zila Mangalore', '+912145459455', 'CTTT', 'TGMT', 29, 7.0);

INSERT INTO SINHVIEN
VALUES ('SV21003845', 'Damini Barad', 'Nam', to_date('1994-09-21', 'YYYY-MM-DD'), '84/324 Balan Nagar Mahbubnagar', '+918421511440', 'VP', 'HTTT', 123, 4.94);

INSERT INTO SINHVIEN
VALUES ('SV21003846', 'Suhana Swaminathan', 'Nam', to_date('1964-02-01', 'YYYY-MM-DD'), 'H.No. 53 Vora Chowk Kharagpur', '6832478093', 'CLC', 'CNTT', 1, 4.47);

INSERT INTO SINHVIEN
VALUES ('SV21003847', 'Rania Venkataraman', 'Nam', to_date('1988-10-13', 'YYYY-MM-DD'), '98/11 Sura Ganj North Dumdum', '8844699438', 'VP', 'HTTT', 134, 9.03);

INSERT INTO SINHVIEN
VALUES ('SV21003848', 'Vihaan Gara', 'Nam', to_date('2022-10-05', 'YYYY-MM-DD'), '82/05 Subramaniam Marg Karawal Nagar', '+915790000754', 'CLC', 'CNTT', 69, 9.88);

INSERT INTO SINHVIEN
VALUES ('SV21003849', 'Ryan Golla', 'Nam', to_date('1972-11-27', 'YYYY-MM-DD'), '04/34 Andra Chowk Raipur', '02684794914', 'CQ', 'CNPM', 69, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21003850', 'Bhavin Subramanian', 'Nam', to_date('1980-05-29', 'YYYY-MM-DD'), '671 Magar Street Raebareli', '+918935615089', 'VP', 'MMT', 113, 6.42);

INSERT INTO SINHVIEN
VALUES ('SV21003851', 'Mahika Banerjee', 'Nam', to_date('2001-04-05', 'YYYY-MM-DD'), '16/35 Johal Marg Sonipat', '7932169363', 'VP', 'KHMT', 80, 7.56);

INSERT INTO SINHVIEN
VALUES ('SV21003852', 'Priyansh Balasubramanian', 'Nam', to_date('1929-07-17', 'YYYY-MM-DD'), '96/56 Bhatia Nagar Rajkot', '00171766118', 'VP', 'HTTT', 22, 6.93);

INSERT INTO SINHVIEN
VALUES ('SV21003853', 'Elakshi Sen', 'N?', to_date('1953-05-27', 'YYYY-MM-DD'), 'H.No. 091 D��Alia Ganj Gopalpur', '05412085887', 'CLC', 'KHMT', 97, 8.06);

INSERT INTO SINHVIEN
VALUES ('SV21003854', 'Amani Hora', 'N?', to_date('1940-09-23', 'YYYY-MM-DD'), '21 Vyas Jammu', '+910733665466', 'VP', 'CNTT', 12, 6.5);

INSERT INTO SINHVIEN
VALUES ('SV21003855', 'Riaan Datta', 'Nam', to_date('1940-08-14', 'YYYY-MM-DD'), 'H.No. 753 Ramakrishnan Zila Mira-Bhayandar', '09763420456', 'VP', 'KHMT', 83, 5.07);

INSERT INTO SINHVIEN
VALUES ('SV21003856', 'Lakshay Gara', 'N?', to_date('2009-01-20', 'YYYY-MM-DD'), '37/100 Yadav Road Kurnool', '+915220355847', 'CTTT', 'CNTT', 68, 6.28);

INSERT INTO SINHVIEN
VALUES ('SV21003857', 'Suhana Arora', 'Nam', to_date('2013-05-15', 'YYYY-MM-DD'), 'H.No. 893 Uppal Path Sonipat', '8440905110', 'CLC', 'TGMT', 88, 8.26);

INSERT INTO SINHVIEN
VALUES ('SV21003858', 'Rhea Magar', 'Nam', to_date('1931-09-07', 'YYYY-MM-DD'), '08/368 Datta Chandigarh', '1973348469', 'VP', 'HTTT', 117, 8.12);

INSERT INTO SINHVIEN
VALUES ('SV21003859', 'Charvi Sandal', 'Nam', to_date('1934-06-25', 'YYYY-MM-DD'), '77/661 Koshy Ganj Howrah', '3257598035', 'CQ', 'KHMT', 16, 6.22);

INSERT INTO SINHVIEN
VALUES ('SV21003860', 'Vritika Sundaram', 'N?', to_date('1961-04-02', 'YYYY-MM-DD'), '84 Tata Marg Agartala', '3803060702', 'CQ', 'KHMT', 125, 5.23);

INSERT INTO SINHVIEN
VALUES ('SV21003861', 'Jivika Solanki', 'Nam', to_date('1989-01-19', 'YYYY-MM-DD'), '40/977 Agate Circle Raipur', '+913466231076', 'VP', 'MMT', 4, 5.41);

INSERT INTO SINHVIEN
VALUES ('SV21003862', 'Kanav Tiwari', 'N?', to_date('1912-06-01', 'YYYY-MM-DD'), 'H.No. 857 Bains Circle Agartala', '02713684299', 'CLC', 'MMT', 91, 7.91);

INSERT INTO SINHVIEN
VALUES ('SV21003863', 'Kismat Saha', 'Nam', to_date('1928-09-03', 'YYYY-MM-DD'), '09 Grewal Hapur', '+916488321079', 'VP', 'TGMT', 9, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21003864', 'Kaira Tella', 'N?', to_date('2020-07-25', 'YYYY-MM-DD'), '66/21 Baria Nagar Mumbai', '8477120554', 'CTTT', 'CNPM', 19, 9.77);

INSERT INTO SINHVIEN
VALUES ('SV21003865', 'Ira Arora', 'Nam', to_date('2013-08-27', 'YYYY-MM-DD'), 'H.No. 343 Madan Circle Bijapur', '01677471653', 'CQ', 'HTTT', 30, 9.53);

INSERT INTO SINHVIEN
VALUES ('SV21003866', 'Vihaan Golla', 'N?', to_date('1948-05-31', 'YYYY-MM-DD'), '67/943 Chaudry Nagar Bhilai', '+916095479019', 'CQ', 'KHMT', 59, 7.67);

INSERT INTO SINHVIEN
VALUES ('SV21003867', 'Veer Acharya', 'N?', to_date('2009-03-18', 'YYYY-MM-DD'), 'H.No. 734 Issac Marg Arrah', '5215010838', 'CTTT', 'MMT', 6, 6.04);

INSERT INTO SINHVIEN
VALUES ('SV21003868', 'Ivan Shah', 'Nam', to_date('1928-06-20', 'YYYY-MM-DD'), '29/144 Sandhu Tumkur', '0970121612', 'VP', 'HTTT', 50, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003869', 'Aayush Dave', 'Nam', to_date('1962-04-11', 'YYYY-MM-DD'), '86/33 Shere Zila Bhubaneswar', '+919609111340', 'VP', 'HTTT', 41, 9.18);

INSERT INTO SINHVIEN
VALUES ('SV21003870', 'Raunak Gera', 'N?', to_date('1971-08-22', 'YYYY-MM-DD'), 'H.No. 847 Suri Street Thrissur', '09105019704', 'VP', 'TGMT', 18, 6.29);

INSERT INTO SINHVIEN
VALUES ('SV21003871', 'Sara Kashyap', 'Nam', to_date('1943-11-17', 'YYYY-MM-DD'), 'H.No. 03 Jayaraman Marg Aurangabad', '04906761224', 'VP', 'HTTT', 79, 9.71);

INSERT INTO SINHVIEN
VALUES ('SV21003872', 'Keya Sachdev', 'Nam', to_date('1965-03-27', 'YYYY-MM-DD'), '56/917 Sodhi Circle Katihar', '+911197015491', 'CLC', 'MMT', 120, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21003873', 'Ryan Atwal', 'N?', to_date('1935-01-26', 'YYYY-MM-DD'), 'H.No. 86 Rastogi Ganj Ranchi', '+913922188591', 'CLC', 'CNTT', 40, 4.16);

INSERT INTO SINHVIEN
VALUES ('SV21003874', 'Ayesha Bala', 'Nam', to_date('1950-04-14', 'YYYY-MM-DD'), '73/970 Rajagopalan Shimla', '08717655772', 'CQ', 'CNTT', 48, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21003875', 'Prisha Buch', 'N?', to_date('1994-07-21', 'YYYY-MM-DD'), '02/64 Andra Marg Giridih', '01612031531', 'CTTT', 'MMT', 48, 9.84);

INSERT INTO SINHVIEN
VALUES ('SV21003876', 'Lakshay Gopal', 'N?', to_date('1982-12-20', 'YYYY-MM-DD'), '12 D��Alia Zila Singrauli', '+914482107564', 'CTTT', 'HTTT', 32, 7.63);

INSERT INTO SINHVIEN
VALUES ('SV21003877', 'Dharmajan Sharaf', 'Nam', to_date('1994-09-19', 'YYYY-MM-DD'), 'H.No. 102 Ravel Nagar Dindigul', '+919404637539', 'CQ', 'CNTT', 69, 6.61);

INSERT INTO SINHVIEN
VALUES ('SV21003878', 'Pihu Lad', 'N?', to_date('1917-12-27', 'YYYY-MM-DD'), '50/511 Lall Circle Aurangabad', '9318020531', 'VP', 'TGMT', 55, 9.56);

INSERT INTO SINHVIEN
VALUES ('SV21003879', 'Aarna Chaudhry', 'N?', to_date('1955-11-26', 'YYYY-MM-DD'), '01/72 Manda Street Jamalpur', '07279764282', 'VP', 'MMT', 41, 8.87);

INSERT INTO SINHVIEN
VALUES ('SV21003880', 'Saanvi Mane', 'Nam', to_date('2003-06-14', 'YYYY-MM-DD'), '88 Kara Nagar Miryalaguda', '08689359072', 'CTTT', 'MMT', 10, 6.01);

INSERT INTO SINHVIEN
VALUES ('SV21003881', 'Lagan Arya', 'Nam', to_date('1935-10-18', 'YYYY-MM-DD'), 'H.No. 08 Tailor Street Bhusawal', '+912631792266', 'CLC', 'MMT', 46, 5.04);

INSERT INTO SINHVIEN
VALUES ('SV21003882', 'Rati Soni', 'N?', to_date('1989-05-03', 'YYYY-MM-DD'), '53/16 Goyal Ganj Bhilai', '8392204490', 'VP', 'KHMT', 2, 5.99);

INSERT INTO SINHVIEN
VALUES ('SV21003883', 'Alisha Barman', 'Nam', to_date('1978-06-22', 'YYYY-MM-DD'), '32/40 Kumar Zila Begusarai', '8677419515', 'CLC', 'HTTT', 99, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21003884', 'Renee Kakar', 'Nam', to_date('1996-03-24', 'YYYY-MM-DD'), '64/287 Kaul Satara', '8357659965', 'CLC', 'MMT', 75, 4.43);

INSERT INTO SINHVIEN
VALUES ('SV21003885', 'Ryan Luthra', 'Nam', to_date('1978-04-20', 'YYYY-MM-DD'), '306 Vaidya Path Patiala', '03680869163', 'CQ', 'HTTT', 73, 8.19);

INSERT INTO SINHVIEN
VALUES ('SV21003886', 'Nirvaan Chopra', 'Nam', to_date('1921-02-23', 'YYYY-MM-DD'), 'H.No. 51 Rau Nagar Panvel', '04481620867', 'CTTT', 'CNTT', 86, 9.08);

INSERT INTO SINHVIEN
VALUES ('SV21003887', 'Eva Subramaniam', 'N?', to_date('1927-03-06', 'YYYY-MM-DD'), '95/15 Kalita Street Latur', '+919611318816', 'CLC', 'CNPM', 77, 7.05);

INSERT INTO SINHVIEN
VALUES ('SV21003888', 'Myra Kanda', 'Nam', to_date('1989-02-06', 'YYYY-MM-DD'), 'H.No. 192 Kanda Nagar Ranchi', '07444089720', 'CTTT', 'HTTT', 64, 7.71);

INSERT INTO SINHVIEN
VALUES ('SV21003889', 'Gatik Sridhar', 'Nam', to_date('1949-07-18', 'YYYY-MM-DD'), '33/14 Chawla Road Gaya', '+913524349766', 'CQ', 'TGMT', 127, 8.4);

INSERT INTO SINHVIEN
VALUES ('SV21003890', 'Aarush Sant', 'Nam', to_date('1931-12-13', 'YYYY-MM-DD'), 'H.No. 88 Upadhyay Street Barasat', '01957003162', 'CLC', 'CNTT', 53, 4.59);

INSERT INTO SINHVIEN
VALUES ('SV21003891', 'Miraya Agate', 'N?', to_date('1982-10-27', 'YYYY-MM-DD'), '80 Kale Marg Malegaon', '02541329287', 'VP', 'CNTT', 112, 4.55);

INSERT INTO SINHVIEN
VALUES ('SV21003892', 'Biju Joshi', 'N?', to_date('2002-02-19', 'YYYY-MM-DD'), '777 Kohli Ganj Ichalkaranji', '+918895915940', 'CTTT', 'HTTT', 93, 6.39);

INSERT INTO SINHVIEN
VALUES ('SV21003893', 'Kaira Amble', 'Nam', to_date('1999-10-16', 'YYYY-MM-DD'), '81 Gill Ganj Silchar', '4779044137', 'CTTT', 'CNPM', 41, 6.03);

INSERT INTO SINHVIEN
VALUES ('SV21003894', 'Hridaan Kata', 'Nam', to_date('1967-12-06', 'YYYY-MM-DD'), '23 Shan Zila Ujjain', '05719486194', 'CLC', 'KHMT', 55, 9.42);

INSERT INTO SINHVIEN
VALUES ('SV21003895', 'Alia Kari', 'Nam', to_date('1932-03-27', 'YYYY-MM-DD'), '86/480 Kamdar Street Tirupati', '9197807482', 'CQ', 'CNPM', 44, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21003896', 'Tanya Shukla', 'Nam', to_date('1991-06-24', 'YYYY-MM-DD'), '66/318 Bhalla Path Junagadh', '+911619809463', 'CLC', 'CNPM', 21, 9.87);

INSERT INTO SINHVIEN
VALUES ('SV21003897', 'Yasmin Hayer', 'Nam', to_date('2015-04-19', 'YYYY-MM-DD'), 'H.No. 90 Balasubramanian Path Barasat', '+912251318490', 'CTTT', 'KHMT', 5, 5.39);

INSERT INTO SINHVIEN
VALUES ('SV21003898', 'Kimaya Dayal', 'N?', to_date('1986-11-08', 'YYYY-MM-DD'), '94/85 Malhotra Zila Durg', '+914784208991', 'CLC', 'CNPM', 93, 6.86);

INSERT INTO SINHVIEN
VALUES ('SV21003899', 'Siya Bath', 'N?', to_date('1979-04-06', 'YYYY-MM-DD'), 'H.No. 21 Ganesan Zila Ballia', '+915488475584', 'CTTT', 'TGMT', 124, 5.45);

INSERT INTO SINHVIEN
VALUES ('SV21003900', 'Mahika Bhatti', 'Nam', to_date('1942-01-18', 'YYYY-MM-DD'), '15/411 Basak Marg Gulbarga', '9999036498', 'VP', 'CNTT', 126, 7.93);

INSERT INTO SINHVIEN
VALUES ('SV21003901', 'Abram Biswas', 'Nam', to_date('1988-12-29', 'YYYY-MM-DD'), '325 Gole Zila Ambarnath', '5584758254', 'CQ', 'KHMT', 133, 7.54);

INSERT INTO SINHVIEN
VALUES ('SV21003902', 'Chirag Kakar', 'Nam', to_date('2000-03-10', 'YYYY-MM-DD'), '26 Jain Nagar Mira-Bhayandar', '01104070513', 'CTTT', 'CNTT', 31, 8.48);

INSERT INTO SINHVIEN
VALUES ('SV21003903', 'Chirag Talwar', 'Nam', to_date('2018-08-18', 'YYYY-MM-DD'), '43/338 Raman Path Tirunelveli', '9757574714', 'CQ', 'CNPM', 25, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21003904', 'Ehsaan Basu', 'N?', to_date('1937-12-25', 'YYYY-MM-DD'), 'H.No. 862 Comar Circle Bihar Sharif', '00801088476', 'CTTT', 'CNPM', 69, 6.94);

INSERT INTO SINHVIEN
VALUES ('SV21003905', 'Samarth Salvi', 'N?', to_date('1957-06-09', 'YYYY-MM-DD'), '37/35 Ganesh Path Agartala', '0662942880', 'VP', 'KHMT', 62, 8.09);

INSERT INTO SINHVIEN
VALUES ('SV21003906', 'Myra Soni', 'Nam', to_date('1935-12-12', 'YYYY-MM-DD'), 'H.No. 144 Samra Circle Alappuzha', '4106360806', 'CTTT', 'CNPM', 49, 5.08);

INSERT INTO SINHVIEN
VALUES ('SV21003907', 'Nakul Varty', 'Nam', to_date('1915-11-08', 'YYYY-MM-DD'), '84 Kota Path Ozhukarai', '7585324689', 'CTTT', 'CNTT', 30, 6.76);

INSERT INTO SINHVIEN
VALUES ('SV21003908', 'Anahita Rajagopal', 'Nam', to_date('1947-02-08', 'YYYY-MM-DD'), '695 Kapadia Marg Dharmavaram', '05074718795', 'VP', 'CNPM', 88, 9.07);

INSERT INTO SINHVIEN
VALUES ('SV21003909', 'Aniruddh Bhandari', 'N?', to_date('1989-03-28', 'YYYY-MM-DD'), 'H.No. 577 Goel Circle Nagpur', '4718680010', 'CQ', 'CNTT', 133, 5.78);

INSERT INTO SINHVIEN
VALUES ('SV21003910', 'Adah Bali', 'N?', to_date('1976-11-07', 'YYYY-MM-DD'), '90 Mann Marg Tiruppur', '05526636635', 'CLC', 'CNTT', 37, 7.98);

INSERT INTO SINHVIEN
VALUES ('SV21003911', 'Nayantara Borde', 'N?', to_date('1941-09-21', 'YYYY-MM-DD'), '81 Kale Anand', '+910124395239', 'CLC', 'TGMT', 129, 4.86);

INSERT INTO SINHVIEN
VALUES ('SV21003912', 'Vedika Sahni', 'N?', to_date('1939-11-04', 'YYYY-MM-DD'), 'H.No. 984 Chandra Street Kharagpur', '+919726766036', 'CTTT', 'HTTT', 2, 8.8);

INSERT INTO SINHVIEN
VALUES ('SV21003913', 'Tara Choudhary', 'N?', to_date('1981-05-08', 'YYYY-MM-DD'), '35 Dugal Marg Jodhpur', '01442595927', 'CTTT', 'CNPM', 72, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21003914', 'Anay Ramachandran', 'N?', to_date('1969-05-09', 'YYYY-MM-DD'), 'H.No. 784 Bassi Nagar Bhiwandi', '9443054537', 'VP', 'MMT', 11, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21003915', 'Indrajit Sachar', 'N?', to_date('1972-12-04', 'YYYY-MM-DD'), '86 Bhalla Nagar Aurangabad', '4327957360', 'CLC', 'HTTT', 17, 5.89);

INSERT INTO SINHVIEN
VALUES ('SV21003916', 'Amani Varma', 'N?', to_date('1930-03-31', 'YYYY-MM-DD'), '93 Vyas Nagar Yamunanagar', '7013214014', 'VP', 'HTTT', 0, 4.89);

INSERT INTO SINHVIEN
VALUES ('SV21003917', 'Fateh Kade', 'N?', to_date('1962-02-09', 'YYYY-MM-DD'), '47/61 Tailor Chennai', '01076256046', 'CLC', 'CNPM', 6, 8.13);

INSERT INTO SINHVIEN
VALUES ('SV21003918', 'Jayan Bath', 'N?', to_date('1950-05-21', 'YYYY-MM-DD'), '38/82 Zachariah Zila Ujjain', '+917981758953', 'VP', 'KHMT', 36, 8.51);

INSERT INTO SINHVIEN
VALUES ('SV21003919', 'Indrans Bajaj', 'N?', to_date('1911-10-01', 'YYYY-MM-DD'), '16/66 Grewal Path Nanded', '00568224494', 'CLC', 'CNPM', 132, 7.27);

INSERT INTO SINHVIEN
VALUES ('SV21003920', 'Hiran Deo', 'N?', to_date('1908-05-19', 'YYYY-MM-DD'), 'H.No. 90 Master Street Bangalore', '5014087313', 'CQ', 'CNPM', 37, 7.58);

INSERT INTO SINHVIEN
VALUES ('SV21003921', 'Ehsaan Agarwal', 'Nam', to_date('1963-02-11', 'YYYY-MM-DD'), 'H.No. 08 Bir Chowk Ulhasnagar', '7303871143', 'CTTT', 'MMT', 5, 9.22);

INSERT INTO SINHVIEN
VALUES ('SV21003922', 'Rhea Srivastava', 'N?', to_date('1962-02-20', 'YYYY-MM-DD'), 'H.No. 954 Din Marg Sirsa', '07158211454', 'CQ', 'TGMT', 138, 7.43);

INSERT INTO SINHVIEN
VALUES ('SV21003923', 'Alisha Ravel', 'N?', to_date('2019-06-17', 'YYYY-MM-DD'), '25/35 Sathe Chowk Rourkela', '08847017945', 'CLC', 'MMT', 58, 9.57);

INSERT INTO SINHVIEN
VALUES ('SV21003924', 'Aaina Mall', 'Nam', to_date('2008-06-13', 'YYYY-MM-DD'), 'H.No. 425 Deol Street Suryapet', '+910720459891', 'CLC', 'KHMT', 55, 9.58);

INSERT INTO SINHVIEN
VALUES ('SV21003925', 'Yuvaan Date', 'N?', to_date('1989-05-30', 'YYYY-MM-DD'), 'H.No. 55 Ahuja Marg Jhansi', '4162300042', 'CQ', 'CNPM', 63, 7.61);

INSERT INTO SINHVIEN
VALUES ('SV21003926', 'Rasha Bhagat', 'N?', to_date('1977-09-27', 'YYYY-MM-DD'), 'H.No. 31 Sarna Tadepalligudem', '04931588173', 'CLC', 'HTTT', 58, 8.84);

INSERT INTO SINHVIEN
VALUES ('SV21003927', 'Aarush Suri', 'N?', to_date('1943-02-22', 'YYYY-MM-DD'), 'H.No. 27 Subramaniam Nagar Mira-Bhayandar', '+917662604879', 'CQ', 'TGMT', 36, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21003928', 'Anahita Batta', 'N?', to_date('1966-05-26', 'YYYY-MM-DD'), '65/474 Bera Chowk Ghaziabad', '09480225508', 'CTTT', 'CNPM', 106, 9.84);

INSERT INTO SINHVIEN
VALUES ('SV21003929', 'Bhavin Bahl', 'N?', to_date('1931-03-17', 'YYYY-MM-DD'), 'H.No. 429 Basu Ganj Nashik', '06708016970', 'CLC', 'KHMT', 110, 6.68);

INSERT INTO SINHVIEN
VALUES ('SV21003930', 'Ivana Dasgupta', 'Nam', to_date('1977-09-27', 'YYYY-MM-DD'), 'H.No. 694 Dugar Road Tadepalligudem', '7589744268', 'CLC', 'KHMT', 130, 7.41);

INSERT INTO SINHVIEN
VALUES ('SV21003931', 'Riya Srivastava', 'N?', to_date('1971-03-12', 'YYYY-MM-DD'), 'H.No. 82 Bajwa Road Mahbubnagar', '00604006772', 'VP', 'TGMT', 20, 4.7);

INSERT INTO SINHVIEN
VALUES ('SV21003932', 'Romil Mand', 'Nam', to_date('2022-07-24', 'YYYY-MM-DD'), '42/067 Kata Ganj Cuttack', '05249081047', 'CTTT', 'TGMT', 91, 9.6);

INSERT INTO SINHVIEN
VALUES ('SV21003933', 'Taimur Jani', 'Nam', to_date('1947-03-30', 'YYYY-MM-DD'), 'H.No. 586 Lal Chowk Jabalpur', '1340131716', 'VP', 'CNTT', 101, 9.02);

INSERT INTO SINHVIEN
VALUES ('SV21003934', 'Hunar Bansal', 'N?', to_date('1930-01-12', 'YYYY-MM-DD'), 'H.No. 606 Sanghvi Nagar Dindigul', '06541196359', 'CQ', 'KHMT', 137, 5.86);

INSERT INTO SINHVIEN
VALUES ('SV21003935', 'Mishti Rajagopalan', 'N?', to_date('1987-06-11', 'YYYY-MM-DD'), 'H.No. 442 Chacko Circle Satara', '00736418324', 'CTTT', 'MMT', 60, 4.08);

INSERT INTO SINHVIEN
VALUES ('SV21003936', 'Alisha Bhavsar', 'Nam', to_date('1921-09-22', 'YYYY-MM-DD'), '13 Krish Path Darbhanga', '+910811429972', 'CLC', 'CNTT', 135, 5.62);

INSERT INTO SINHVIEN
VALUES ('SV21003937', 'Mamooty Gupta', 'Nam', to_date('1991-05-29', 'YYYY-MM-DD'), '03/27 Gole Nagar Bahraich', '+913015054182', 'VP', 'HTTT', 78, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21003938', 'Riya Raja', 'N?', to_date('2005-11-26', 'YYYY-MM-DD'), '43/58 Dada Path Bareilly', '08725140671', 'CLC', 'MMT', 53, 8.38);

INSERT INTO SINHVIEN
VALUES ('SV21003939', 'Darshit Sankaran', 'Nam', to_date('1909-06-21', 'YYYY-MM-DD'), '978 Srinivas Marg Phagwara', '+912216890287', 'CLC', 'CNTT', 13, 7.37);

INSERT INTO SINHVIEN
VALUES ('SV21003940', 'Parinaaz Arya', 'Nam', to_date('1971-04-26', 'YYYY-MM-DD'), '240 Goel Ganj Phusro', '+917329092229', 'VP', 'MMT', 56, 7.62);

INSERT INTO SINHVIEN
VALUES ('SV21003941', 'Vaibhav Suri', 'Nam', to_date('1929-10-17', 'YYYY-MM-DD'), '40/75 Golla Rewa', '2093260050', 'CQ', 'HTTT', 80, 8.97);

INSERT INTO SINHVIEN
VALUES ('SV21003942', 'Oorja Dara', 'N?', to_date('1943-03-09', 'YYYY-MM-DD'), '331 Maharaj Marg Moradabad', '+915188254457', 'CTTT', 'KHMT', 128, 9.5);

INSERT INTO SINHVIEN
VALUES ('SV21003943', 'Aarush Ramanathan', 'Nam', to_date('2000-09-15', 'YYYY-MM-DD'), 'H.No. 568 Rout Circle Aurangabad', '07844253779', 'CLC', 'CNTT', 130, 5.56);

INSERT INTO SINHVIEN
VALUES ('SV21003944', 'Samiha Dugar', 'Nam', to_date('1957-12-01', 'YYYY-MM-DD'), '91 Dhillon Nagar Jehanabad', '7089950943', 'CTTT', 'TGMT', 64, 6.54);

INSERT INTO SINHVIEN
VALUES ('SV21003945', 'Vritika Buch', 'Nam', to_date('2010-12-28', 'YYYY-MM-DD'), '77/09 Chakraborty Circle Madanapalle', '04821070322', 'CLC', 'TGMT', 63, 4.83);

INSERT INTO SINHVIEN
VALUES ('SV21003946', 'Mohanlal Yohannan', 'N?', to_date('1967-10-28', 'YYYY-MM-DD'), '81/96 Gara Circle Latur', '+915730766779', 'CLC', 'MMT', 44, 5.26);

INSERT INTO SINHVIEN
VALUES ('SV21003947', 'Madhav Yohannan', 'Nam', to_date('1965-07-19', 'YYYY-MM-DD'), '84 Shah Street Belgaum', '3447813900', 'CTTT', 'CNPM', 33, 8.78);

INSERT INTO SINHVIEN
VALUES ('SV21003948', 'Parinaaz Majumdar', 'Nam', to_date('1955-03-15', 'YYYY-MM-DD'), '87/655 Rau Chowk Shimla', '6516953523', 'CQ', 'CNPM', 69, 7.23);

INSERT INTO SINHVIEN
VALUES ('SV21003949', 'Ishita Sehgal', 'N?', to_date('1956-03-07', 'YYYY-MM-DD'), '81/539 Kunda Street Naihati', '2225996580', 'CLC', 'TGMT', 15, 5.28);

INSERT INTO SINHVIEN
VALUES ('SV21003950', 'Vaibhav Verma', 'Nam', to_date('1980-07-26', 'YYYY-MM-DD'), '96/51 Kala Street Pali', '9311399499', 'CLC', 'KHMT', 101, 9.72);

INSERT INTO SINHVIEN
VALUES ('SV21003951', 'Ishita Bhavsar', 'N?', to_date('1948-06-07', 'YYYY-MM-DD'), '98/407 Agrawal Ganj Dindigul', '05529751513', 'VP', 'CNTT', 3, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21003952', 'Samarth Chakrabarti', 'N?', to_date('1945-06-22', 'YYYY-MM-DD'), 'H.No. 61 Wagle Street Singrauli', '07656261197', 'CTTT', 'CNPM', 112, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21003953', 'Aarna Bal', 'Nam', to_date('1944-10-06', 'YYYY-MM-DD'), 'H.No. 156 Batra Path Tiruchirappalli', '5283541208', 'VP', 'KHMT', 22, 6.06);

INSERT INTO SINHVIEN
VALUES ('SV21003954', 'Yasmin Bath', 'N?', to_date('1974-07-29', 'YYYY-MM-DD'), '284 Chaudhry Street Hosur', '+917837413488', 'CQ', 'MMT', 131, 7.21);

INSERT INTO SINHVIEN
VALUES ('SV21003955', 'Anika Sundaram', 'Nam', to_date('1948-04-24', 'YYYY-MM-DD'), 'H.No. 753 Raman Circle Hajipur', '05014959006', 'CTTT', 'KHMT', 97, 9.8);

INSERT INTO SINHVIEN
VALUES ('SV21003956', 'Ayesha Bora', 'Nam', to_date('1962-11-24', 'YYYY-MM-DD'), '185 Hayer Street Burhanpur', '+911552612515', 'CQ', 'MMT', 99, 8.44);

INSERT INTO SINHVIEN
VALUES ('SV21003957', 'Khushi Srinivasan', 'Nam', to_date('2023-07-02', 'YYYY-MM-DD'), '690 Randhawa Nagar Jabalpur', '07812542284', 'CTTT', 'CNTT', 34, 9.22);

INSERT INTO SINHVIEN
VALUES ('SV21003958', 'Keya Ratti', 'Nam', to_date('1917-07-15', 'YYYY-MM-DD'), '46/898 Mander Road Ramgarh', '9974484276', 'CLC', 'KHMT', 53, 9.79);

INSERT INTO SINHVIEN
VALUES ('SV21003959', 'Eva Bahri', 'N?', to_date('1965-02-13', 'YYYY-MM-DD'), '49/792 Kadakia Hajipur', '00730809428', 'VP', 'CNTT', 110, 9.7);

INSERT INTO SINHVIEN
VALUES ('SV21003960', 'Stuvan Dalal', 'Nam', to_date('1960-12-03', 'YYYY-MM-DD'), 'H.No. 625 Bora Ganj Rajkot', '+910468299323', 'VP', 'MMT', 26, 8.0);

INSERT INTO SINHVIEN
VALUES ('SV21003961', 'Bhamini Saha', 'N?', to_date('1951-04-27', 'YYYY-MM-DD'), '46/21 Lala Ganj New Delhi', '+915977844040', 'CQ', 'HTTT', 78, 9.35);

INSERT INTO SINHVIEN
VALUES ('SV21003962', 'Rhea Anne', 'N?', to_date('2012-07-25', 'YYYY-MM-DD'), '812 Devan Chowk Muzaffarnagar', '4205026248', 'CQ', 'HTTT', 43, 7.15);

INSERT INTO SINHVIEN
VALUES ('SV21003963', 'Aarav Khosla', 'Nam', to_date('1934-08-26', 'YYYY-MM-DD'), '802 Kumar Raurkela Industrial Township', '01075996747', 'CLC', 'KHMT', 102, 7.25);

INSERT INTO SINHVIEN
VALUES ('SV21003964', 'Baiju Sastry', 'Nam', to_date('1996-07-11', 'YYYY-MM-DD'), 'H.No. 43 Vyas Zila Ambala', '+916098917755', 'VP', 'MMT', 87, 9.0);

INSERT INTO SINHVIEN
VALUES ('SV21003965', 'Romil Kulkarni', 'N?', to_date('1970-12-18', 'YYYY-MM-DD'), '16/34 Trivedi Nagar Nagaon', '+914600005039', 'CTTT', 'MMT', 100, 7.65);

INSERT INTO SINHVIEN
VALUES ('SV21003966', 'Devansh Chowdhury', 'Nam', to_date('1984-11-16', 'YYYY-MM-DD'), '05 Kumar Circle Bhagalpur', '+911529189885', 'CTTT', 'CNTT', 32, 6.25);

INSERT INTO SINHVIEN
VALUES ('SV21003967', 'Aarav Ram', 'Nam', to_date('1928-06-09', 'YYYY-MM-DD'), '85/666 Shah Road Satara', '0312795644', 'CQ', 'CNPM', 45, 9.51);

INSERT INTO SINHVIEN
VALUES ('SV21003968', 'Kismat Varughese', 'Nam', to_date('1942-12-22', 'YYYY-MM-DD'), '050 Dave Zila Moradabad', '06296353018', 'CQ', 'CNTT', 136, 7.18);

INSERT INTO SINHVIEN
VALUES ('SV21003969', 'Anay Devan', 'Nam', to_date('1926-10-08', 'YYYY-MM-DD'), 'H.No. 021 Balay Ganj Imphal', '4922371214', 'CQ', 'TGMT', 97, 4.57);

INSERT INTO SINHVIEN
VALUES ('SV21003970', 'Rania Sridhar', 'N?', to_date('1947-09-15', 'YYYY-MM-DD'), '00/12 Raj Marg Surat', '+913457996047', 'CTTT', 'KHMT', 118, 8.96);

INSERT INTO SINHVIEN
VALUES ('SV21003971', 'Kiaan Saraf', 'N?', to_date('1976-10-29', 'YYYY-MM-DD'), '933 Deol Street Kharagpur', '08707920075', 'CQ', 'MMT', 66, 9.21);

INSERT INTO SINHVIEN
VALUES ('SV21003972', 'Jivin Sandhu', 'N?', to_date('1996-04-08', 'YYYY-MM-DD'), 'H.No. 842 Buch Nagar Panchkula', '02856032637', 'CQ', 'CNPM', 68, 4.6);

INSERT INTO SINHVIEN
VALUES ('SV21003973', 'Nitara Grover', 'N?', to_date('1911-04-29', 'YYYY-MM-DD'), '80/193 Dey Nagar Hubli�CDharwad', '2013517341', 'VP', 'TGMT', 97, 9.94);

INSERT INTO SINHVIEN
VALUES ('SV21003974', 'Emir Bhatnagar', 'N?', to_date('1911-10-06', 'YYYY-MM-DD'), 'H.No. 901 Gopal Yamunanagar', '07742222405', 'CTTT', 'CNTT', 137, 9.39);

INSERT INTO SINHVIEN
VALUES ('SV21003975', 'Vardaniya Iyengar', 'N?', to_date('1946-02-06', 'YYYY-MM-DD'), 'H.No. 20 Boase Road Panihati', '6056369419', 'CLC', 'TGMT', 48, 8.33);

INSERT INTO SINHVIEN
VALUES ('SV21003976', 'Purab Bhavsar', 'N?', to_date('1933-05-29', 'YYYY-MM-DD'), 'H.No. 94 Venkatesh Circle Rourkela', '4945639905', 'CLC', 'CNPM', 82, 8.29);

INSERT INTO SINHVIEN
VALUES ('SV21003977', 'Jivin Chakrabarti', 'Nam', to_date('2001-10-18', 'YYYY-MM-DD'), 'H.No. 610 Shah Ganj Morbi', '+910817786811', 'VP', 'HTTT', 56, 7.73);

INSERT INTO SINHVIEN
VALUES ('SV21003978', 'Akarsh Raval', 'N?', to_date('1921-06-22', 'YYYY-MM-DD'), '95/971 Baral Junagadh', '+910763034648', 'CQ', 'KHMT', 15, 8.64);

INSERT INTO SINHVIEN
VALUES ('SV21003979', 'Emir Saini', 'Nam', to_date('1937-11-07', 'YYYY-MM-DD'), 'H.No. 060 Borde Nagar Dharmavaram', '+917685257107', 'CTTT', 'KHMT', 31, 5.55);

INSERT INTO SINHVIEN
VALUES ('SV21003980', 'Onkar Trivedi', 'Nam', to_date('2003-01-28', 'YYYY-MM-DD'), '61 Kaur Chowk Medininagar', '03800275067', 'VP', 'MMT', 7, 9.66);

INSERT INTO SINHVIEN
VALUES ('SV21003981', 'Akarsh Hans', 'Nam', to_date('1981-08-04', 'YYYY-MM-DD'), '87/693 Choudhary Path Amravati', '4352621521', 'CLC', 'HTTT', 98, 8.69);

INSERT INTO SINHVIEN
VALUES ('SV21003982', 'Gokul Zachariah', 'Nam', to_date('1944-08-23', 'YYYY-MM-DD'), 'H.No. 439 Dara Circle Saharsa', '+916165083110', 'CQ', 'MMT', 22, 7.96);

INSERT INTO SINHVIEN
VALUES ('SV21003983', 'Tara Keer', 'Nam', to_date('1986-10-02', 'YYYY-MM-DD'), 'H.No. 688 Vala Zila Aurangabad', '04099897440', 'CQ', 'TGMT', 120, 5.47);

INSERT INTO SINHVIEN
VALUES ('SV21003984', 'Piya Jani', 'Nam', to_date('1910-08-24', 'YYYY-MM-DD'), '441 Mane Chowk Dharmavaram', '2513362072', 'CTTT', 'CNTT', 48, 5.98);

INSERT INTO SINHVIEN
VALUES ('SV21003985', 'Emir Kapoor', 'Nam', to_date('1959-03-15', 'YYYY-MM-DD'), 'H.No. 317 Brahmbhatt Road Kirari Suleman Nagar', '02733793389', 'CTTT', 'CNTT', 127, 7.49);

INSERT INTO SINHVIEN
VALUES ('SV21003986', 'Pranay Ghosh', 'Nam', to_date('1919-03-30', 'YYYY-MM-DD'), '381 Rattan Howrah', '08362015092', 'VP', 'HTTT', 9, 5.27);

INSERT INTO SINHVIEN
VALUES ('SV21003987', 'Veer Kohli', 'N?', to_date('1973-07-03', 'YYYY-MM-DD'), '01 Sachdeva Circle Giridih', '04314236135', 'VP', 'HTTT', 67, 5.74);

INSERT INTO SINHVIEN
VALUES ('SV21003988', 'Eva Singh', 'Nam', to_date('1992-01-10', 'YYYY-MM-DD'), '15 Bir Marg Loni', '5716200186', 'VP', 'HTTT', 113, 5.55);

INSERT INTO SINHVIEN
VALUES ('SV21003989', 'Azad Basu', 'N?', to_date('2002-02-18', 'YYYY-MM-DD'), '60 Garde Ganj Ludhiana', '7193004471', 'CTTT', 'CNPM', 97, 6.99);

INSERT INTO SINHVIEN
VALUES ('SV21003990', 'Nishith Wable', 'N?', to_date('1949-11-13', 'YYYY-MM-DD'), 'H.No. 553 Korpal Chowk Mirzapur', '00254131931', 'CQ', 'KHMT', 35, 4.79);

INSERT INTO SINHVIEN
VALUES ('SV21003991', 'Indranil Bhagat', 'N?', to_date('2023-05-21', 'YYYY-MM-DD'), 'H.No. 796 Khalsa Chowk Muzaffarpur', '7564047770', 'CQ', 'CNPM', 47, 5.52);

INSERT INTO SINHVIEN
VALUES ('SV21003992', 'Misha Rajan', 'Nam', to_date('1947-12-07', 'YYYY-MM-DD'), 'H.No. 810 Deo Street Hapur', '1083013841', 'VP', 'KHMT', 124, 5.67);

INSERT INTO SINHVIEN
VALUES ('SV21003993', 'Armaan Rao', 'Nam', to_date('1971-07-31', 'YYYY-MM-DD'), '00/873 Bansal Circle Howrah', '+912824004008', 'CTTT', 'MMT', 66, 9.95);

INSERT INTO SINHVIEN
VALUES ('SV21003994', 'Azad Shanker', 'Nam', to_date('1942-12-11', 'YYYY-MM-DD'), 'H.No. 59 Dayal Street Malda', '9585496903', 'CQ', 'CNPM', 62, 7.8);

INSERT INTO SINHVIEN
VALUES ('SV21003995', 'Hiran Din', 'Nam', to_date('1975-02-06', 'YYYY-MM-DD'), '88/049 Bhatia Road Dewas', '8687433547', 'CQ', 'KHMT', 129, 8.07);

INSERT INTO SINHVIEN
VALUES ('SV21003996', 'Ishaan Taneja', 'N?', to_date('1918-10-24', 'YYYY-MM-DD'), '96 Bora Ganj Dehradun', '2835459467', 'CTTT', 'CNTT', 123, 9.47);

INSERT INTO SINHVIEN
VALUES ('SV21003997', 'Kismat Gandhi', 'Nam', to_date('2006-03-25', 'YYYY-MM-DD'), 'H.No. 235 Bera Path Bhiwandi', '+919674979421', 'CQ', 'MMT', 127, 4.04);

INSERT INTO SINHVIEN
VALUES ('SV21003998', 'Shalv Chana', 'Nam', to_date('2012-04-02', 'YYYY-MM-DD'), 'H.No. 33 Gandhi Street Nagpur', '5494111455', 'CLC', 'CNPM', 89, 9.52);

INSERT INTO SINHVIEN
VALUES ('SV21003999', 'Priyansh Banerjee', 'Nam', to_date('1918-01-29', 'YYYY-MM-DD'), '75/227 Bakshi Chowk Kanpur', '2563600228', 'CTTT', 'HTTT', 42, 8.37);

INSERT INTO SINHVIEN
VALUES ('SV21004000', 'Biju Bava', 'Nam', to_date('1938-12-12', 'YYYY-MM-DD'), 'H.No. 952 Saxena Ganj Avadi', '2855749365', 'CLC', 'CNPM', 119, 5.44);
-- update TRGDV to DONVI
update DONVI set TRGDV = 'NS05000001' where MADV = 'DV0001';
update DONVI set TRGDV = 'NS04000001' where MADV = 'DV0002';
update DONVI set TRGDV = 'NS04000002' where MADV = 'DV0003';
update DONVI set TRGDV = 'NS04000003' where MADV = 'DV0004';
update DONVI set TRGDV = 'NS04000004' where MADV = 'DV0005';
update DONVI set TRGDV = 'NS04000005' where MADV = 'DV0006';
update DONVI set TRGDV = 'NS04000006' where MADV = 'DV0007';

connect ns05000001/NS05000001;
select* from ADMINLC.DANGKY;
insert into ADMINLC.DANGKY values ('SV21000001','NS02000002','HP002',1,2023,'CLC',7,8,7.5,7.5); 
INSERT INTO HOCPHAN
VALUES ('HP001', 'To�n cao c?p', 3, 30, 15, 50, 'DV0001');
INSERT INTO HOCPHAN
VALUES ('HP002', 'L?p tr�nh Java', 4, 40, 20, 60, 'DV0002');
INSERT INTO HOCPHAN
VALUES ('HP003', 'C?u tr�c d? li?u v? gi?i thu?t', 3, 30, 15, 50, 'DV0003');
INSERT INTO HOCPHAN
VALUES ('HP004', 'H? qu?n tr? c? s? d? li?u', 4, 40, 20, 60, 'DV0004');
INSERT INTO HOCPHAN
VALUES ('HP005', 'M?ng m�y t�nh', 3, 30, 15, 50, 'DV0005');
/
INSERT INTO KHMO
VALUES ('HP001', 1, 2023, 'CQ');
INSERT INTO KHMO
VALUES ('HP002', 1, 2023, 'CLC');
INSERT INTO KHMO
VALUES ('HP003', 1, 2024, 'CTTT');
INSERT INTO KHMO
VALUES ('HP004', 2, 2024, 'CQ');
INSERT INTO KHMO
VALUES ('HP005', 2, 2024, 'CLC');
INSERT INTO KHMO
VALUES ('HP005', 1, 2024, 'VP');
/
INSERT INTO ADMINLC.PHANCONG
VALUES ('NS02000001', 'HP001', 1, 2023, 'CQ');
INSERT INTO ADMINLC.PHANCONG
VALUES ('NS02000002', 'HP002', 1, 2023, 'CLC');
INSERT INTO ADMINLC.PHANCONG
VALUES ('NS02000003', 'HP003', 1, 2024, 'CTTT');
INSERT INTO ADMINLC.PHANCONG
VALUES ('NS02000004', 'HP004', 2, 2024, 'CQ');
INSERT INTO ADMINLC.PHANCONG
VALUES ('NS02000005', 'HP005', 2, 2024, 'CLC');
/
INSERT INTO ADMINLC.DANGKY
VALUES ('SV21000001', 'NS02000001', 'HP001', 1, 2023, 'CQ', 8.5, 7.5, 9.0, 8.0);
INSERT INTO ADMINLC.DANGKY
VALUES ('SV21000002', 'NS02000002', 'HP002', 1, 2023, 'CLC', 7.0, 8.0, 7.5, 7.5);
INSERT INTO ADMINLC.DANGKY
VALUES ('SV21000003', 'NS02000003', 'HP003', 1, 2024, 'CTTT', 9.0, 8.5, 8.0, 8.5);
INSERT INTO ADMINLC.DANGKY
VALUES ('SV21000004', 'NS02000004', 'HP004', 2, 2024, 'CQ', 8.0, 9.0, 8.5, 8.5);
INSERT INTO ADMINLC.DANGKY
VALUES ('SV21000005', 'NS02000005', 'HP005', 2, 2024, 'CLC', 7.5, 7.0, 7.0, 7.0);
---------------------------------------------- create user----------------------------
CREATE OR REPLACE PROCEDURE USP_CREATEUSER_NS
AS
    CURSOR CUR IS (SELECT ns.manv
                    FROM ADMINLC.nhansu ns
                    WHERE ns.manv NOT IN (SELECT USERNAME
                                            FROM ALL_USERS)
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
    OPEN CUR;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ;
--        EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER  '||USR||' IDENTIFIED BY '||USR;
        EXECUTE IMMEDIATE (STRSQL);
        STRSQL := 'GRANT CONNECT TO '||USR;
        EXECUTE IMMEDIATE (STRSQL);
    END LOOP;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
--        EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/
CREATE OR REPLACE PROCEDURE USP_CREATEUSER_SV
AS
    CURSOR CUR IS (SELECT sv.masv
                    FROM ADMINLC.sinhvien sv
                    WHERE sv.masv NOT IN (SELECT USERNAME
                                            FROM ALL_USERS)
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
    OPEN CUR;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ;
--        EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'CREATE USER  '||USR||' IDENTIFIED BY '||USR;
        EXECUTE IMMEDIATE (STRSQL);
        STRSQL := 'GRANT CONNECT TO '||USR;
        EXECUTE IMMEDIATE (STRSQL);
    END LOOP;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
--        EXECUTE IMMEDIATE(STRSQL);
    CLOSE CUR;
END;
/
CREATE OR REPLACE PROCEDURE USP_DROPUSER_NS
AS
    CURSOR CUR IS (SELECT ns.manv
                    FROM ADMINLC.nhansu ns
                    WHERE ns.manv IN (SELECT USERNAME
                                        FROM ALL_USERS)
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
    OPEN CUR;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ;
--        EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'DROP USER '||USR|| ' cASCADE';
        EXECUTE IMMEDIATE STRSQL;
    END LOOP;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
--        EXECUTE IMMEDIATE STRSQL;
    CLOSE CUR;
END;
/
CREATE OR REPLACE PROCEDURE USP_DROPUSER_SV
AS
    CURSOR CUR IS (SELECT sv.masv
                    FROM ADMINLC.sinhvien sv
                    WHERE sv.masv IN (SELECT USERNAME
                                        FROM ALL_USERS)
                );
    STRSQL VARCHAR(2000);
    USR VARCHAR2(10);
BEGIN
    OPEN CUR;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE' ;
--        EXECUTE IMMEDIATE(STRSQL);
    LOOP
        FETCH CUR INTO USR;
        EXIT WHEN CUR%NOTFOUND;
        STRSQL := 'DROP USER '||USR|| ' cASCADE';
        EXECUTE IMMEDIATE STRSQL;
    END LOOP;
--        STRSQL := 'ALTER SESSION SET "_ORACLE_SCRIPT" = FALSE';
--        EXECUTE IMMEDIATE STRSQL;
    CLOSE CUR;
END;
/
exec USP_DROPUSER_NS;
exec USP_DROPUSER_SV;
/
exec USP_CREATEUSER_NS;
exec USP_CREATEUSER_SV;
