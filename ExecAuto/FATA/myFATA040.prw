#include 'protheus.ch'
#include 'parmtype.ch'

user function myFATA040()

LOCAL aArray := {}
 
PRIVATE lMsErroAuto := .F.



 
aArray := { { "E1_PREFIXO"  , "AUT"             , NIL },;
            { "E1_NUM"      , "7"            , NIL },;
            { "E1_TIPO"     , "BOL"              , NIL },;
            { "E1_PARCELA"     , "1"              , NIL },;
            { "E1_NATUREZ"  , "1"             , NIL },;
            { "E1_CLIENTE"  , "2"          , NIL },;
            { "E1_EMISSAO"  , CtoD("14/09/2017"), NIL },;
            { "E1_VENCTO"   , CtoD("30/11/2017"), NIL },;
            { "E1_VENCREA"  , CtoD("30/11/2017"), NIL },;
            { "E1_VALOR"    , 5000              , NIL } }
 
MsExecAuto( { |x,y| FINA040(x,y)} , aArray, 3, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
 

If lMsErroAuto
    MostraErro()
Else
    Alert("Título incluído com sucesso!")
Endif
 
Return	
