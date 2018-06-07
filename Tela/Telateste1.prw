#include 'protheus.ch'
#include 'parmtype.ch'

user function Telateste1()
	
Private arotina:={}
Private aRotina := { {"Teste de Hello","U_Rd",0,3} ,;
             {"Teste2","U_Rd",0,3} ,;
             {"teste3","U_Geratela",0,3} ,;
             {"teste4","U_Rd",0,3} ,;
             {"teste5","U_Rd",0,3} }
                           
mBrowse( 6,1,22,75,"SE1")  
return
                        
User function Geratela()
Local i
Local oDlg
Local oMsMGet
Local lInit
Local cCampo                            
Local aSizeAut  := MsAdvSize()
local aCpoEnchoice:={} 
Private oGetDados
Private oGetDados2
Private acols:={}
Private aPosObj   := {}
Private aHeader := {}

DbSelectArea("SE1")
regtomemory("SE1",.T.)

_cAliasEnch := "SE1"

cCposEnch := "E1_NUM#E1_PREFIXO#E1_CLIENTE#E1_VALOR"                 
//  Campos para Detalhe
cCposGetD := "E1_CLIENTE#E1_EMISSAO" 
 
_nUsado:=0  
aObjects := {}                                                       
AAdd( aObjects, { 350,  100,,,} )
AAdd( aObjects, { 350,  100,,,} )
aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }   
aPosObj := MsObjSize( aInfo, aObjects, .T. )
dbSelectArea("SX3")
dbSeek(_cAliasEnch)
While !Eof().And.(x3_arquivo==_cAliasEnch) 

// Prenchendo matriz aHeader - cabecalho Do browse
      IF    (X3USO(x3_usado)) .AND. (cNivel >= x3_nivel) .AND. (ALLTRIM(x3_campo)$ cCposGetD )
            _nUsado++
            AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
            x3_tamanho, x3_decimal, x3_vlduser,;
            x3_usado, x3_tipo, x3_arquivo, x3_context } )
      EndIf
                  
      dbSkip()
Enddo
aCols:={Array(Len(aHeader)+1)}
aCols[1,Len(aHeader)+1]:=.F.

DEFINE MSDIALOG oDlg TITLE "Exemplo" FROM 00,00 TO 35,100 
oGetDados := MsGetDados():New(aPosObj[1][1],aPosObj[1][2],aPosObj[1][3],aPosObj[1][4],3,"U_xxx","U_xxx","+E1_CLIENTE",.F.,{E1_CLIENTE},/*reservado*/,.F.,99,"U_xxx","U_xxx",/*reservado*/,"U_xxx", oDlg)
oGetDados2 := MsGetDados():New(aPosObj[2][1],aPosObj[2][2],aPosObj[2][3],aPosObj[2][4],3,"U_xxx","U_xxx","+E1_CLIENTE",.F.,{E1_CLIENTE},/*reservado*/,.F.,99,"U_xxx","U_xxx",/*reservado*/,"U_xxx", oDlg)
ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()})
Return

USER FUNCTION CRIAX() 
ALERT("TESTE") 
eVal(oGetDados:obrowse:badd )

RETURN()

user function xxx()
alert("teste2")
return




