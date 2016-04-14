Set Century On
SET DATE BRITISH 

Set Decimals To 2

*_Screen.Visible = .F.
PUBLIC odbcnombre,odbcclave,odbcusuario,odbcdatabase,npath,frmmain,frmmenu,elgue
PUBLIC gnx
PUBLIC esteform
PUBLIC IDT AS Integer 
PUBLIC rfecha1,rfecha2 as date
odbcnombre=""
odbcclave=""
odbcusuario=""
odbcdatabase=""
initf=FILETOSTR('firstini.cfg')

ALINES(initarray,initf)

iniciovar=VAL(ALLTRIM(SUBSTR(initarray(1),1,29)))
npath=ALLTRIM(SUBSTR(initarray(2),1,29))
SET DEFAULT TO (npath)
SET PROCEDURE TO procedures.prg
IF iniciovar=1 then







odbcnombre=ALLTRIM(SUBSTR(initarray(4),1,29))
odbcclave=ALLTRIM(SUBSTR(initarray(6),1,29))
odbcusuario=ALLTRIM(SUBSTR(initarray(5),1,29))
odbcdatabase=ALLTRIM(SUBSTR(initarray(3),1,29))

Store SQLConnect(odbcnombre, odbcusuario, odbcclave) To gnx




IF gnx<=0 then
MESSAGEBOX("No se pudo conectar a la base de datos")
quit
ENDIF
DO FORM frmfirstini
ELSE
odbcnombre=ALLTRIM(SUBSTR(initarray(4),1,29))
odbcclave=ALLTRIM(SUBSTR(initarray(6),1,29))
odbcusuario=ALLTRIM(SUBSTR(initarray(5),1,29))
odbcdatabase=ALLTRIM(SUBSTR(initarray(3),1,29))

Store SQLConnect(odbcnombre, odbcusuario, odbcclave) To gnx
SQLEXEC(gnx,"select * from empresa","empresa")
PUBLIC empicture,emrazon
empicture=empresa.logo

*DO FORM "frmmain.Scx" NAME frmmain
DO FORM "frmloging.Scx"
*_Screen.Visible= .F.
Read Events

Close All
Clear All
ENDIF



