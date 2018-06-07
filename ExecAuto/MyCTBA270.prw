#Include 'Protheus.ch'
#Include 'TBICONN.ch'

User Function MyCTBA270()
Local nOpcA 

Local _lOk := .T. 
Local aAutoItens := {} 
Local xCab := {}

PRIVATE lMsErroAuto := .F. 

PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01'

cCtq_Rateio := CriaVar("CTQ_RATEIO") 
cCtq_Desc := CriaVar("CTQ_DESC") 
cCtq_Tipo := CriaVar("CTQ_TIPO") 
cCtq_CtPar := CriaVar("CTQ_CTPAR") 
cCtq_CCPar := CriaVar("CTQ_CCPAR") 
cCtq_ItPar := CriaVar("CTQ_ITPAR") 
cCtq_ClPar := CriaVar("CTQ_CLPAR") 
cCtq_CtOri := CriaVar("CTQ_CTORI") 
cCtq_CCOri := CriaVar("CTQ_CCORI") 
cCtq_ItOri := CriaVar("CTQ_ITORI") 
cCtq_ClOri := CriaVar("CTQ_CLORI") 
nCtq_PerBas := CriaVar("CTQ_PERBAS") 
cCtq_MSBLQL := '0' 

aAdd(xCab,{{cCtq_Rateio ,'000002' ,NIL},; 
      {cCtq_Desc ,'EXECAUTO            ' ,NIL},; 
      {cCtq_Tipo ,'1' ,NIL},; 
      {cCtq_CtPar ,'000002              ' ,NIL},; 
      {cCtq_CcPar ,'CC02     ' ,NIL},; 
      {cCtq_ItPar ,'         ' ,NIL},; 
      {cCtq_ClPar ,'         ' ,NIL},; 
      {cCtq_CtOri ,'000001              ' ,NIL},; 
      {cCtq_CCOri ,'CC01     ' ,NIL},; 
      {cCtq_ItOri ,'         ' ,NIL},; 
      {cCtq_ClOri ,'         ' ,NIL},; 
      {nCtq_PerBas ,100 ,NIL},; 
      {cCtq_MSBLQL ,'2' ,NIL} }) 
 
aAdd(aAutoItens,{    {'CTQ_FILIAL' ,'01' , NIL},; 
        {'CTQ_CTORI' ,'000001              ' , NIL},; 
        {'CTQ_CCORI' , 'CC01     ' , NIL},; 
        {'CTQ_ITORI' ,'         ', NIL},; 
        {'CTQ_CLORI' ,'         ' , NIL},; 
        {'CTQ_CTPAR' ,'000002              ' , NIL},; 
        {'CTQ_CCPAR' ,'CC01     ' , NIL},; 
        {'CTQ_ITPAR' ,'         ' , NIL},; 
        {'CTQ_CLPAR' ,'         ' , NIL},; 
        {'CTQ_SEQUEN' ,'001' , NIL},; 
        {'CTQ_CTCPAR' ,'000001              ' , NIL},; 
        {'CTQ_CCCPAR' ,'         ' , NIL},; 
        {'CTQ_ITCPAR' ,'         ' , NIL},; 
        {'CTQ_CLCPAR' ,'         ' , NIL},; 
        {'CTQ_UM' ,'UM' , NIL},; 
        {'CTQ_VALOR' ,0 , NIL},; 
        {'CTQ_PERCEN' ,100 , NIL},; 
        {'CTQ_FORMUL' ,'1' , NIL},; 
        {'CTQ_INTERC' ,'1', NIL} } ) 

MSExecAuto( {|X,Y,Z| CTBA270(X,Y,Z)} ,xCab ,aAutoItens, 3) 

If lMsErroAuto <> Nil 
 If !lMsErroAuto 
  _lOk := .T. 
  If !IsBlind() 
      MsgInfo('Inclusão com sucesso!') 
  EndIf 
 Else 
  _lOk := .F. 
  If !IsBlind() 
      MostraErro() 
      MsgAlert('Erro na inclusao!') 
  Endif 
 EndIf 
EndIf 

Return