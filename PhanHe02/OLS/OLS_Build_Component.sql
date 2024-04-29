Connected.

1 row updated.


1 row updated.


1 row updated.


1 row updated.

Connection created by CONNECT script command disconnected
Connected.

PL/SQL procedure successfully completed.

Connection created by CONNECT script command disconnected
Connected.
>>Query Run In:Query Result 15
>>Query Run In:Query Result 16
>>Query Run In:Query Result 17
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
4/10      PLS-00103: Encountered the symbol "=" when expecting one of the following:     constant exception <an identifier>    <a double-quoted delimited-identifier> table columns long    double ref char standard time timestamp interval date binary    national character nchar The symbol "<an identifier>" was substituted for "=" to continue. 
5/8       PLS-00103: Encountered the symbol "=" when expecting one of the following:     constant exception <an identifier>    <a double-quoted delimited-identifier> table columns long    double ref char standard time timestamp interval date binary    national character nchar The symbol "<an identifier>" was substituted for "=" to continue. 
9/26      PLS-00103: Encountered the symbol ";" when expecting one of the following:     % 
12/0      PLS-00103: Encountered the symbol "end-of-file" when expecting one of the following:     end not pragma final instantiable persistable order    overriding static member constructor map 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
10/26     PLS-00103: Encountered the symbol ";" when expecting one of the following:     % 
12/26     PLS-00103: Encountered the symbol ";" when expecting one of the following:     % 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
10/26     PLS-00103: Encountered the symbol ";" when expecting one of the following:     % 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
10/26     PLS-00103: Encountered the symbol ";" when expecting one of the following:     % 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Error starting at line : 145 in command -
select*ADMIN_OLS.THONGBAO
Error at Command Line : 145 Column : 8
Error report -
SQL Error: ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
Connection created by CONNECT script command disconnected
Connected.

Error starting at line : 145 in command -
select* from ADMIN_OLS.THONGBAO
Error at Command Line : 145 Column : 24
Error report -
SQL Error: ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

LINE/COL  ERROR
--------- -------------------------------------------------------------
1/49      PLS-00103: Encountered the symbol "(" when expecting one of the following:     := . ) , @ % default character The symbol ":=" was substituted for "(" to continue. 
Errors: check compiler log
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

Connection created by CONNECT script command disconnected
Connected.

Error starting at line : 150 in command -
select* from ADMIN_OLS.THONGBAO
Error at Command Line : 150 Column : 24
Error report -
SQL Error: ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
Connection created by CONNECT script command disconnected
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled

Connection created by CONNECT script command disconnected

Error starting at line : 149 in command -
BEGIN GRANT_OLS_TRUONGKHOA('NS05000001'); END;
Error report -
ORA-06550: line 1, column 7:
PLS-00201: identifier 'GRANT_OLS_TRUONGKHOA' must be declared
ORA-06550: line 1, column 7:
PL/SQL: Statement ignored
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action:

Procedure GRANT_OLS_TRUONGKHOA compiled


Error starting at line : 149 in command -
BEGIN GRANT_OLS_TRUONGKHOA('NS05000001'); END;
Error report -
ORA-06598: insufficient INHERIT PRIVILEGES privilege
ORA-06512: at "LBACSYS.SA_USER_ADMIN", line 1
ORA-06512: at line 1
ORA-06512: at "SYS.GRANT_OLS_TRUONGKHOA", line 16
ORA-06512: at line 1
06598. 00000 -  "insufficient INHERIT PRIVILEGES privilege"
*Cause:    An attempt was made to run an AUTHID CURRENT_USER function or
           procedure, or to reference a BEQUEATH CURRENT_USER view, and the
           owner of that function, procedure, or view lacks INHERIT PRIVILEGES
           privilege on the calling user.
*Action:   Either do not call the function or procedure or reference the view,
           or grant the owner of the function, procedure, or view
           INHERIT PRIVILEGES privilege on the calling user.
Connected.

Procedure GRANT_OLS_TRUONGKHOA compiled


Error starting at line : 150 in command -
BEGIN GRANT_OLS_TRUONGKHOA('NS05000001'); END;
Error report -
ORA-42903: Cannot assign OLS authorizations to common or application users.
ORA-06512: at "LBACSYS.SA_USER_ADMIN_INT", line 825
ORA-06512: at "LBACSYS.SA_USER_ADMIN_INT", line 125
ORA-06512: at "LBACSYS.SA_USER_ADMIN_INT", line 761
ORA-06512: at "LBACSYS.SA_USER_ADMIN", line 224
ORA-06512: at line 1
ORA-06512: at "ADMIN_OLS.GRANT_OLS_TRUONGKHOA", line 16
ORA-06512: at line 1
42903. 00000 -  "Cannot assign OLS authorizations to common or application users."
*Cause:    An attempt was made to assign Oracle Label Security (OLS)
           authorizations to common or application users.
*Action:   Assign OLS authorizations to local users only.
Connection created by CONNECT script command disconnected
