#DEFINE ODBC_ADD_DSN 1
#DEFINE ODBC_CONFIG_DSN 2
#DEFINE ODBC_REMOVE_DSN 3
#DEFINE ODBC_ADD_SYS_DSN 4
#DEFINE ODBC_CONFIG_SYS_DSN 5
#DEFINE ODBC_REMOVE_SYS_DSN 6
#DEFINE ODBC_REMOVE_DEFAULT_DSN 7
 
DECLARE INTEGER SQLConfigDataSource in odbccp32.DLL ;
         INTEGER hwndParent, INTEGER fRequest, ;
         STRING @lpszDriver, STRING @lpszAttributes
 
lcAttributes = "DSN=Richard" + CHR(0) + ;
       "Description=nomina2" + CHR(0) + ;
       "Server=localhost" + CHR(0) + ;
       "Database=nomina" + CHR(0) + ;
       "User=root" + CHR(0) + ;
       "port=3306" + CHR(0) + ;
       "PWD=693693123456"
 
lnReturn = SQLConfigDataSource( 0, ODBC_ADD_SYS_DSN,;
             "MySQL ODBC 5.1 Driver" + CHR(0),;
             lcAttributes )
 
IF lnReturn>0
   WAIT WINDOW "Dado de Alta"
ELSE
   WAIT WINDOW "Falló la Alta"
ENDIF