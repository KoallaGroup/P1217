#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function mFIN040()

LOCAL aArray := {}
Local cDoc := '900000005' 


PRIVATE lMsErroAuto := .F.



PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" 
 
 
 cDoc := GetSX8Num("SE1","E1_NUM")



aArray := { { "E1_PREFIXO"  , "AUT"             , NIL },;
            { "E1_NUM"      , '000002002'            , NIL },;
            { "E1_TIPO"     , "BOL"              , NIL },;
            { "E1_NATUREZ"  , "1"             , NIL },;
            { "E1_CLIENTE"  , "2"          , NIL },;
            { "E1_PARCELA"  , "01"          , NIL },;
            { "E1_EMISSAO"  , CtoD("22/05/2018"), NIL },;
            { "E1_VENCTO"   , CtoD("31/05/2018"), NIL },;
            { "E1_VENCREA"  , CtoD("31/05/2018"), NIL },;
            { "E1_VALOR"    , 5000              , NIL }}/*,;
            { "E1_PORTADO"    , "001"             , NIL },;
            { "E1_AGEDEP"    , "155  "              , NIL },;
            { "E1_CONTA"    , "95919     "              , NIL }*/ 
 
MsExecAuto( { |x,y| FINA040(x,y)} , aArray, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão

// Desta maneira dará o mesmo erro, é necessário que os dados estão exatamente iguais ao da SA6. Agora não dara erro.
 
If lMsErroAuto
    MostraErro()
Else
    Alert("Título incluído com sucesso!  " +cvaltochar(cDoc))
Endif


Return	

//