-- Quản lý dữ liệu nội bộ
drop table DANGKY;
drop table PHANCONG;
drop table KHMO;
drop table HOCPHAN;
drop table NHANSU;
drop table DONVI;
drop table SINHVIEN;
create table NHANSU(
    MANV char(10) primary key,
    HOTEN varchar(50),
    PHAI char(5) check (PHAI = 'Nam' or PHAI = 'Nữ'),
    NGSINH DATE,
    PHUCAP INT, 
    DT char(11),
    VAITRO varchar(50),
    MADV char(10) -- khoa ngoai toi DONVI
);
/
create table SINHVIEN(
    MASV char(10) primary key,
    HOTEN varchar(50),
    PHAI char(5) check (PHAI = 'Nam' or PHAI = 'Nữ'),
    NGSINH DATE,
    DCHI varchar(100),
    DT char(11),
    MACT char(10), -- khoa ngoai toi CHUONGTRINH
    MANGANH char(10),
    SOTCTL int,
    DTBTL int
);
/
create table DONVI (
    MADV char(10) primary key,
    TENDV varchar(50),
    TRGDV varchar(50) --chưa chắc , khóa ngoại tới NHANSU
);
/
create table HOCPHAN(
    MAHP char(10) primary key,
    TENHP varchar(50),
    SOTC int,
    STLT int,
    STTH int,
    SOSVTD int,
    MADV char(10) -- tơi bảng đơn vị
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
alter table NHANSU add foreign key (MADV) references DONVI(MADV);
-- HOCPHAN, MADV -- DONVI MADV
alter table HOCPHAN add foreign key (MADV) references DONVI(MADV);
-- KHMO
alter table KHMO add FOREIGN key (MAHP) references HOCPHAN(MAHP);
--PHANCONG
alter table PHANCONG add foreign key (MAGV) references NHANSU(MANV);
alter table PHANCONG add foreign key (MAHP,HK,NAM,MACT) references KHMO(MAHP,HK,NAM,MACT);
-- DANG KY
alter table DANGKY add foreign key (MASV) references SINHVIEN(MASV);
alter table DANGKY add foreign key (MAGV,MAHP,HK,NAM,MACT) references PHANCONG(MAGV,MAHP,HK,NAM,MACT);