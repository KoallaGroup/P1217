#include 'protheus.ch'
#include 'parmtype.ch'
#include "TBICONN.CH"

user function myFINA050()

LOCAL aArray := {}

	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" 
 
PRIVATE lMsErroAuto := .F.
 
aArray := { { "E2_PREFIXO"  , "PAG"             , NIL },;
            { "E2_NUM"      , "000011"            , NIL },;
            { "E2_TIPO"     , "RPA"              , NIL },;
            { "E2_NATUREZ"  , "1         "             , NIL },;
            { "E2_FILORIG "  , "03"             , NIL },;
            { "E2_FORNECE"  , "001   "            , NIL },;
            { "E2_EMISSAO"  , dDataBase, NIL },;
            { "E2_VENCTO"   , CtoD("30/04/2018"), NIL },;
            { "E2_VENCREA"  , CtoD("30/04/2018"), NIL },;
            { "E2_VALOR"    , 5000              , NIL },;
            { "E2_EMIS1"    , CtoD("01/03/2018")  , NIL }}
 
MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
 
 
If lMsErroAuto
    MostraErro()
Else
    Alert("Título incluído com sucesso!")
Endif
 

return