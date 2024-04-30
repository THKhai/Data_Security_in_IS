alter session set container = XEPDB1;
alter pluggable database open;
conn sys/258789258789 as sysdba
select name, flashback_on, log_mode from v$database;
shutdown immediate;
startup mount;
alter system set db_recovery_file_dest_size=50g scope=both sid='*';
alter system set db_recovery_file_dest='C:\backup' scope=both sid='*';

alter database flashback on;
alter database open;

create restore point rp1;
select scn,time,name from v$restore_point;
drop restore point rp1;

 rman target /
shutdown immediate;
startup mount;
flashback database to restore point rp1;
alter database open resetlogs;
alter database open;