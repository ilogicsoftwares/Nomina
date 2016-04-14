
procedure ejecutarsqls
LPARAMETERS sfile,db
Store SQLConnect('nomina', 'root', '693693123456') To gnx2
SQLEXEC(gnx2,'use ' + db)
sscript=FILETOSTR(sfile)

ALINES(marray,sscript)

FOR i=1 TO (ALEN(marray))

SQLEXEC(gnx2,marray(i))

ENDFOR

ENDPROC


PROCEDURE renobarinicio
LPARAMETERS bdnamex
SET SAFETY OFF

var1=FILETOSTR('firstini.cfg')
ALINES(mxarray,var1)
mxarray(1)="0"
mxarray(3)=bdnamex

STRTOFILE("","firstini.cfg",0)
FOR y=1 TO ALEN(mxarray)
STRTOFILE(mxarray(y) + Chr(13) + Chr(10),"firstini.cfg",1)

ENDFOR
SET SAFETY ON


ENDPROC

FUNCTION limpiardatosenform
LPARAMETERS nFormulario as Object 
FOR I=1 TO &nformulario..controlCount

IF UPPER(&nformulario->Controls(i).baseclass)='TEXTBOX' AND &nformulario->Controls(i).name <> "id" then
xtcontrol=&nformulario->Controls(i).value
IF TYPE('xtcontrol')='N' then
&nformulario->Controls(i).value=0
ENDIF
IF TYPE('xtcontrol')='C' then
&nformulario->Controls(i).value=""
ENDIF

IF TYPE('xtcontrol')='D' then
&nformulario->Controls(i).value={//}
ENDIF
ENDIF



IF UPPER(&nformulario->Controls(i).baseclass)='CHECKBOX' 
&nformulario->Controls(i).value=0
ENDIF
IF UPPER(&nformulario->Controls(i).baseclass)='OPTIONGROUP' 
&nformulario->Controls(i).value=1
ENDIF

IF UPPER(&nformulario->Controls(i).baseclass)='COMBOBOX' THEN
&nformulario->Controls(i).CLEAR
*&nformulario->Controls(i).rowsource=""
ENDif

ENDFOR
ENDFUNC 

FUNCTION Editardatosenform
*tabla a editar,nombre del campo indice,el valor del indice,el nombre del formulario
LPARAMETERS TABLA,NOMBREINDICE,VALORINDICE,nformulario
FOR i=1 TO &nformulario..ControlCount 
IF (UPPER(&nformulario..Controls(i).baseclass)='TEXTBOX' OR UPPER(&nformulario..Controls(i).baseclass)='CHECKBOX' OR UPPER(&nformulario..Controls(i).baseclass)='COMBOBOX' OR UPPER(&nformulario..Controls(i).baseclass)='OPTIONGROUP') AND &nformulario..Controls(i).tag<>"a" THEN
nombrecampo=&nformulario..Controls(i).name
valorcampo=&nformulario..Controls(i).value
valorbusqueda=VALORINDICE
*!*	MESSAGEBOX(&nformulario..Controls(i).name)
*!*	MESSAGEBOX(TYPE('valorcampo'))
*MESSAGEBOX(valorindice)

SQLL="UPDATE " + TABLA +" SET " + nombrecampo +"=" + "?valorcampo" + " where " + NOMBREINDICE + "=" + "?valorbusqueda"

sqlcx=SQLEXEC(GNX,sqll)
*!*	MESSAGEBOX(SQLCX)
IF sqlcx<=0 THEN
MESSAGEBOX("No se pudieron actualizar los datos",48+0)
RETURN .F.
endif
ENDIF


ENDFOR

MESSAGEBOX("Datos Actualizados",64+0)
RETURN .T.
ENDFUNC



FUNCTION guardardatosenform
LPARAMETERS tabla,nformulario,aviso
Store SQLConnect('nomina', 'root', '693693123456') To gnx2
loscampos=""
losvalores=""
separador=","
FOR l=1 TO &nformulario..ControlCount

IF (UPPER(&nformulario..Controls(l).baseclass)='TEXTBOX' OR UPPER(&nformulario..Controls(l).baseclass)='CHECKBOX' OR UPPER(&nformulario..Controls(l).baseclass)='COMBOBOX' OR UPPER(&nformulario..Controls(l).baseclass)='OPTIONGROUP') AND &nformulario..Controls(l).tag<>'a' THEN
loscampos=loscampos + &nformulario..Controls(l).name + separador
IF UPPER(&nformulario..Controls(l).baseclass)='COMBOBOX'
losvalores=losvalores + "?" + nformulario + "." + &nformulario..Controls(l).name + ".displayvalue"+ separador
ELSE
losvalores=losvalores + "?" + nformulario + "." + &nformulario..Controls(l).name + ".value"+ separador

ENDIF

endif
ENDFOR
t1=LEN(loscampos)
t2=LEN(losvalores)
loscampos=SUBSTR(loscampos,1,t1-1)
losvalores=SUBSTR(losvalores,1,t2-1)

*!*	MESSAGEBOX(LOSCAMPOS)
*!*	MESSAGEBOX(LOSVALORES)

sqll="insert into " + tabla + " (" +loscampos+ ") " + "values (" +losvalores +")" 

ll=SQLEXEC(gnx2,sqll)

IF ll>0 then
IF aviso=1 then
MSG("Datos guardados exitosamente","I")
endif
RETURN .T.

ELSE
IF aviso=1 then
MSG("Los dato no fueron guardados","E")
ENDIF
RETURN .F.
endif
ENDFUNC

FUNCTION validardatosenform
LPARAMETERS nformulario

FOR I=1 TO &nformulario..ControlCount
IF UPPER(&nformulario..Controls(i).baseclass)='TEXTBOX' AND (&nformulario..Controls(i).wHATStHIShELPid)=-1

IF EMPTY(&nformulario..Controls(i).value) then

MSG("Debe completar todos los datos","E")
RETURN .f.
ELSE
RETURN .T.
endif
ENDIF



IF UPPER(&nformulario..Controls(i).baseclass)='CHECKBOX' AND EMPTY(&nformulario..Controls(i).tag)
ENDIF

IF UPPER(&nformulario..Controls(i).baseclass)='COMBOBOX' AND EMPTY(&nformulario..Controls(i).tag) THEN 

ENDif

ENDFOR

ENDFUNC



**************************++

Procedure CARGATEXTBOXS
Lparameters Combo As String,TABLA As String, campo As String,condicion as String 
If Used('CPRIME') Then
	Use In cprime
	bbr="_screen.ActiveForm" + "." +  Combo+"." +"clear"
	&bbr
Endif
prime="select " + campo + " from " + TABLA + " " +condicion + " order by " + campo
AAA=SQLExec(gnx, prime,"CPRIME")

If AAA >0 Then
	datosx="cprime." + campo
	CANTIDADR=Reccount('CPRIME')
	Select cprime
	Go Top
	For k =1 To CANTIDADR
		bbb="_screen.ActiveForm" + "." +  Combo+"." +"AddITEM"
		bba="_screen.ActiveForm" + "." +  Combo+"." +"style"
		&bba=2
		&bbb(&datosx,k,1)
		Skip
	Endfor


Else
	Messagebox("no se pudieron cargar los datos en el Combo Box")
	Return
Endif




Endproc



procedure cargadatosenform
*tabla a consultar,campo de busqueda,dato del campo de busqueda,los campos a retornar en el sql,nombre del formulario
LPARAMETERS tabla,indice,dato,xcampos,formname

IF TYPE('dato')="N" then
datox=ALLTRIM(STR(dato))
ELSE
datox="'"+dato+"'"
*datox=VAL(dato)
endif
*SQLEXEC(gnx,"select "+ xcampos + " from " + tabla + " where " + indice + "=" + datox,"cursorp")

select  &xcampos  from  cursorpt  where   &indice  =  &datox INTO CURSOR cursorp
SELECT cursorp
DIMENSION campos(FCOUNT('cursorp'))
i=0
FOR each element IN campos
i=i+1
campos(i)=FIELD(i,'cursorp')
ENDFOR

FOR j=1 TO ALEN(campos)
temp=formname +"." +campos(j) + ".value"
temp1="cursorp." + campos(j)
&temp=&temp1
ENDFOR



ENDPROC

PROCEDURE abrirform()
LPARAMETERS nombreform

FOR EACH formulario as form IN _screen.Forms
IF UPPER(formulario.Name)=UPPER(nombreform)   then
EXIT
ELSE

DO FORM &nombreform
exit
ENDIF




ENDFOR


ENDPROC
FUNCTION cargadatosenform2
*tabla a consultar,campo de busqueda,dato del campo de busqueda,los campos a retornar en el sql,nombre del formulario
LPARAMETERS tabla,indice,dato,xcampos,formname

*!*	IF TYPE('dato')="N" then
*!*	datox=ALLTRIM(STR(dato))
*!*	ELSE
*!*	datox=VAL(dato)
*!*	endif
&xcampos
lecur=ALIAS()
*!*	SQLEXEC(gnx,"select "+ xcampos + " from " + tabla + " where " + indice + "=" + dato,"cursorp")
*select  &xcampos  from  cursorpt  where   &indice  =  &datox INTO CURSOR cursorp
SELECT * from &lecur WHERE &indice=dato INTO CURSOR cursorx readwrite
SELECT cursorx
IF RECCOUNT('CURSORX')=0 THEN
RETURN .F.
ENDIF
DIMENSION campos(FCOUNT('cursorx'))
i=0
FOR each element IN campos
i=i+1
campos(i)=FIELD(i,'cursorx')
ENDFOR

FOR j=1 TO ALEN(campos)
temp=formname +"." +campos(j) + ".value"
temp1="cursorx." + campos(j)
&temp=&temp1

ENDFOR


RETURN .T.

ENDFUNC


PROCEDURE cargarconceptos
LPARAMETERS cline as Character
CREATE CURSOR cargarconceptos (idconcepto n(11),nombre c(50))
counter=1

DO WHILE NOT EMPTY(GETWORDNUM(cline,counter,","))
bb=VAL(GETWORDNUM(cline,counter,","))
SQLEXEC(gnx,"select  idconcepto,nombre from conceptos  where idconcepto=?bb",'Consul1')

SELECT cargarconceptos
APPEND FROM dbf('consul1') 
counter=counter+1
GO TOP 
ENDDO


ENDPROC

PROCEDURE cargarconceptosext
LPARAMETERS cline as Character
CREATE CURSOR cargarconceptosext (idconcepto n(11),nombre c(50),valor c(100),variante c(50),tipo n(11))
counter=1

DO WHILE NOT EMPTY(GETWORDNUM(cline,counter,","))
bb=VAL(GETWORDNUM(cline,counter,","))
SQLEXEC(gnx,"select  idconcepto,nombre,valor,variante,tipo from conceptos  where idconcepto=?bb",'Consul1')

SELECT cargarconceptosext
APPEND FROM dbf('consul1') 
counter=counter+1
GO TOP 
ENDDO


ENDPROC


PROCEDURE generarprenomina()

PARAMETERS PIDNOMINTYPE AS INTEGER
varrt=""
a=0
IF USED('prenomina')
	USE IN prenomina
	
ENDIF

SQLEXEC(GNX,"SELECT idtrabajador,conceptos,CONCAT(TRIM(nombres), ' ' , TRIM(apellidos)) as nombrex from trabajador where idnomina=?pidnomintype","nomsel")
SQLEXEC(GNX,"SELECT * from prenomina","prenominat")
SELECT * FROM prenominat INTO CURSOR prenomina READWRITE 
SELECT nomsel
GO Top
FOR t=1 TO RECCOUNT('nomsel')
	idt=nomsel.idtrabajador
	iconc=nomsel.conceptos
	cargarconceptosext(iconc)
	SELECT cargarconceptosext
	GO Top
	FOR pr=1 TO RECCOUNT('cargarconceptosext')
       try
		valorx=cargarconceptosext.valor
		nomconx=cargarconceptosext.nombre
		idconx=cargarconceptosext.idconcepto
		valorxy=cargarconceptosext.variante

		tipoxy=cargarconceptosext.tipo 
		obtenervariables(idt)
     
        valorz=&valorx
		IF EMPTY(valorxy) then
		valorxyz=0
		ELSE
		valorxyz=(&valorxy)
		ENDIF
		

		INSERT INTO prenomina (idtrabajador,idconcepto,nombrecon,valorconcepto,valorvar,tipoconcepto) VALUES ;
			(idt,idconx,nomconx,valorz,valorxyz,tipoxy)
		valorz=0
		valorxyz=0

       CATCH 
       varrt=varrt +"Ocurrio un error en " +ALLTRIM(nomconx) +" con la(s) Variable(s) "+ ALLTRIM(valorx) +" del Trabajador " + ALLTRIM(transform(idt)) +CHR(13)
       a=a+1     
        
       
            
       
       
       ENDTRY
               
     
		SELECT cargarconceptosext
		SKIP
		
	
	ENDFOR

	SELECT nomsel
	Skip
ENDFOR
SELECT prenomina
IF a>0 then
WAIT (varrt) WINDOW TIMEOUT 10
ENDIF



ENDPROC

PROCEDURE obtenervariables()
PARAMETERS pidtrabajador as Integer 

SQLEXEC(gnx,"select * from varsys where idtrabajador=?pidtrabajador","varsix")
cant=FCOUNT('varsix')
PUBLIC ARRAY variantes (cant) as String 
FOR i = 1 TO cant 
variantes(i)=FIELD(i,'varsix')
tx=variantes(i)
campo="varsix."+tx
PUBLIC &tx
yt=tx+"="+campo
&yt
ENDFOR




ENDPROC


PROCEDURE mover_rECORD(posicion AS INTEGER,tabla AS Cursor)
rt=tabla
con=rt +".idconcepto"
nom=rt +".nombre"
IF posicion=1 AND RECNO()<> 1 then
	
	ex=RECNO(tabla)
	a1=&rt..idconcepto
	a2=&rt..nombre
	GO RECORD(ex-1)
	b1=&rt..idconcepto
	b2= &rt..nombre
	REPLACE  &con WITH a1
	REPLACE &nom WITH a2
	Skip
	REPLACE &con WITH b1
	REPLACE &nom WITH b2
	
ELSE
	IF posicion=2 AND RECNO()<>RECCOUNT(rt)
		ex=RECNO(tabla)
		a1=&rt..idconcepto
		a2=&rt..nombre
		GO RECORD(ex+1)
		b1=&rt..idconcepto
		b2= &rt..nombre

		REPLACE &con WITH a1
		REPLACE &nom WITH a2

		Skip-1
		REPLACE &con WITH b1
		REPLACE &nom WITH b2
	ENDIF
ENDIF

SELECT (rt)
GO Top
prt=""

FOR i=1 TO RECCOUNT(rt)
	IF i<>RECCOUNT(rt) then
		prt=prt+TRANSFORM(&rt..idconcepto)+","
	ELSE
		prt=prt+TRANSFORM(&rt..idconcepto)
	ENDIF

	Skip
ENDFOR
RETURN prt
ENDPROC


FUNCTION MSG
LPARAMETERS PRONT,PRTIPO

DO case
CASE UPPER(PRTIPO)="P"

tx=MESSAGEBOX(PRONT,4+32,"Ilogic Softwares")

CASE UPPER(PRTIPO)="I"
tx=MESSAGEBOX(PRONT,0+64,"Ilogic Softwares")

CASE UPPER(PRTIPO)="E"
tx=MESSAGEBOX(PRONT,0+16,"Ilogic Softwares")
ENDCASE
RETURN tx
ENDFUNC

PROCEDURE crearformulario()
LPARAMETERS tabla
yx=0
Store SQLConnect('nomina', 'root', '693693123456') To gnx3
SET DEFAULT TO c:\nomina
CREATE form ? as formn FROM clases NOWAIT save
IF NOT EMPTY(tabla) then
yx=SQLEXEC(gnx3,"select * from " + tabla,tabla)
ENDIF

IF yx>0 then
COPY TO "c:\nomina\" + tabla + ".dbf"
ELSE
MESSAGEBOX("No se pudieron crear los datos del form")
endif





ENDPROC

********************************PROCEDIMIENTOS INTERNOS*******************+
PROCEDURE SUELDOACTUAL()
SQLEXEC(GNX, "SELECT SUELDO FROM TRABAJADOR WHERE IDTRABAJADOR=?IDT","suelval")
xval=suelval.sueldo
USE IN suelval
RETURN xval


ENDPROC


PROCEDURE  LUNESDELINTERVALO()


fec=rfecha1
ccont=0
FOR z=DAY(rfecha1) TO DAY(rfecha2)
IF CDOW(fec)="Lunes" then
ccont=ccont+1
ENDIF
fec=fec+1

ENDFOR

RETURN ccont

ENDPROC 


PROCEDURE SUELDO_INTEGRAL()
SELECT SUM(valorconcepto)as sival FROM prenomina WHERE idtrabajador=?idt AND tipoconcepto=1 INTO CURSOR suelint 
RETURN suelint.sival

ENDPROC 





***************************************************************************

PROCEDURE CREARMENU()
PARAMETERS USUARIO
SQLEXEC(GNX,"SELECT * FROM USERMENU WHERE IDUSUARIO=?USUARIO AND SELECCIONADO>=1","MUSER")

CLEAR

SET SYSMENU SAVE

SET SYSMENU TO
ON KEY Label ESC KEYBOARD CHR(13)
SET COLOR OF SCHEME 1 TO RGB(54,54,54)
DEFINE MENU ejemplo BAR  AT LINE 0.1 IN WINDOW FRMMAIN COLOR , RGB(0,0,0,240,240,240)
SELECT * FROM muser WHERE tipo=0  INTO Cursor encabezados
SELECT encabezados
GO Top
ttr=""



FOR m =1 TO RECCOUNT('encabezados')
	t1=encabezados.ID

	t2=encabezados.nombre

	ttr="DEFINE PAD " + ALLTRIM(t1) + " OF ejemplo PROMPT '" + ALLTRIM(t2) + "' STYLE 'B' COLOR , RGB(0,0,0,240,240,240)"
	&ttr
	ON PAD &t1 OF ejemplo Activate POPUP &t2


	Skip

ENDFOR



SELECT DISTINCT(PARIENTE)AS PARIENTE FROM muser WHERE NOT ISNULL(PARIENTE) INTO Cursor POPUS1
SELECT * FROM muser WHERE NOT ISNULL(PARIENTE) INTO Cursor PARIENTES1

SELECT POPUS1.PARIENTE,muser.nombre FROM POPUS1 INNER JOIN muser ON muser.ID=POPUS1.PARIENTE INTO Cursor POPUS
SELECT POPUS
GO Top
FOR P=1 TO RECCOUNT('POPUS')
	P2=POPUS.nombre
	P1=POPUS.PARIENTE

	DEFINE POPUP &P2 Margin RELATIVE COLOR SCHEME 4

	SELECT * FROM PARIENTES1 WHERE PARIENTE=P1 ORDER BY ID INTO Cursor PARIENTE
	SELECT PARIENTE

	GO Top

	FOR PR=1 TO RECCOUNT('PARIENTE')
		X1="'"+ALLTRIM(PARIENTE.nombre)+"'"
		xx=ALLTRIM(TRANSFORM(PR))
		ty="DEFINE BAR "+ ALLTRIM(TRANSFORM(PR)) + " OF " + ALLTRIM(P2)+ " PROMPT " + ALLTRIM(X1) + " COLOR , RGB(0,0,0,240,240,240)"
		&ty
		onbar="ON BAR " + ALLTRIM(TRANSFORM(PR)) + " OF " + ALLTRIM(P2)+ " ACTIVATE POPUP " + ALLTRIM(X1)
		trp=""
		trp="ON SELECTION BAR " + ALLTRIM(TRANSFORM(PR)) + " OF " + ALLTRIM(P2) +" " + (PARIENTE.ACCION)

		IF PARIENTE.hijos=1 then
			&onbar
		ELSE
			IF NOT ISNULL(PARIENTE.ACCION)
				TRY
				
				&trp
				CATCH TO OEX

				FINALLY

				ENDTRY
			ENDIF

		ENDIF

		Skip
	ENDFOR
	SELECT POPUS


	Skip



ENDFOR



Activate MENU ejemplo NOWAIT

ENDPROC

procedure cargadatosenform3
*tabla a consultar,campo de busqueda,dato del campo de busqueda,los campos a retornar en el sql,nombre del formulario
LPARAMETERS tabla,indice,dato,xcampos,formname

IF TYPE('dato')="N" then
datox=ALLTRIM(STR(dato))
ELSE
datox="'"+dato+"'"
*datox=VAL(dato)
endif
SQLEXEC(gnx,"select "+ xcampos + " from " + tabla + " where " + indice + "=" + datox,"cursorp")

*select  &xcampos  from  cursorpt  where   &indice  =  &datox INTO CURSOR cursorp
SELECT cursorp
DIMENSION campos(FCOUNT('cursorp'))
i=0
FOR each element IN campos
i=i+1
campos(i)=FIELD(i,'cursorp')
ENDFOR

FOR j=1 TO ALEN(campos)
temp=formname +"." +campos(j) + ".value"
temp1="cursorp." + campos(j)
&temp=&temp1
ENDFOR



ENDPROC


PROCEDURE importartasas
LPARAMETERS aditive
xtr=GETFILE()
IF aditive=0 then
SQLEXEC(gnx,"delete from tasas")
ENDIF

CREATE CURSOR tasas (Fecha c(11), Tasa c(10))
APPEND from (xtr) TYPE DELIMITED WITH CHARACTER ";" 
UPDATE tasas SET tasa=STRTRAN(tasa,",",".")
CREATE CURSOR tasasfinal (Fecha d(11), Tasa n(10,2))
SELECT tasasfinal
APPEND FROM DBF("tasas")
GO top
FOR z=1 TO RECCOUNT('tasas')
xa1=tasasfinal.fecha
xa2=tasasfinal.tasa


SQLEXEC(gnx,"insert into tasas values (?xa1,?xa2)")


skip


ENDFOR 

ENDPROC


FUNCTION valor()
LPARAMETERS controlA
atx=esteform +"."+ controlA +".value"
RETURN &atx

ENDFUNC


FUNCTION valorstr()
LPARAMETERS controlA
atx=esteform +"."+ controlA +".value"
RETURN TRANSFORM(&atx)

ENDFUNC

FUNCTION botonabrir()
LPARAMETERS mnTipo,FormoReporte

DO CASE 
******Abrirform
CASE mntipo=1

SELECT * FROM muser WHERE accion like "%"+FormoReporte+"%" INTO CURSOR formsi



IF formsi.seleccionado=1 then

abrirform(formoreporte)


ELSE
msg("El usuario no tiene permisos suficientes, contacte al administrador","I")

ENDIF


CASE mntipo=2
 ********abrirreport


REPORT FORM  (formoreporte) PREVIEW  




 

ENDCASE
ENDFUNC


FUNCTION cargarenlinea()
LPARAMETERS catabla,cacampo
rvalor=""
SELECT (catabla)
GO top
FOR rz=1 TO RECCOUNT(catabla)
IF rz=RECCOUNT(catabla)
rvalor=rvalor+TRANSFORM(&cacampo)
ELSE
rvalor=rvalor+TRANSFORM(&cacampo)+ ","
ENDIF
SKIP
ENDFOR
RETURN RVALOR

ENDFUNC


FUNCTION verificarfechas()
LPARAMETERS vrfecha1,vrfecha2,vnominatype

SQLEXEC(GNX,"SELECT DESDE,HASTA from nominauni WHERE nominatype=?vnominatype and DESDE<=?vrfecha1 AND HASTA>=?vrfecha1","SQLR")

IF RECCOUNT('SQLR')>0 THEN

RETURN 1
USE IN sqlr 
ELSE
SQLEXEC(GNX,"SELECT DESDE,HASTA from nominauni WHERE nominatype=?vnominatype and DESDE<=?vrfecha2 AND HASTA>=?vrfecha2","SQLR2")
IF RECCOUNT('SQLR2')>0 THEN
RETURN 2
USE IN sqlr2
ELSE
RETURN 0
ENDIF

ENDIF




ENDFUNC


