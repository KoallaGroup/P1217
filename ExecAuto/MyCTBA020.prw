#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

Static __oModelAut := NIL //variavel oModel para substituir msexecauto em MVC


//Exemplo de rotina automática para inclusão de contas contábeis no ambiente Contabilidade Gerencial (SigaCTB).
/// ROTINA AUTOMATICA - INCLUSAO DE CONTA CONTABIL CTB
User Function ModelCT1()
Local nOpcAuto :=0
Local nX
Local oCT1
Local aLog
Local cLog :=""
Local lRet := .T.

If __oModelAut == Nil //somente uma unica vez carrega o modelo CTBA020-Plano de Contas CT1
__oModelAut := FWLoadModel('CTBA020')
EndIf


nOpcAuto:=3


__oModelAut:SetOperation(nOpcAuto) // 3 - Inclusão | 4 - Alteração | 5 - Exclusão
__oModelAut:Activate() //ativa modelo

//---------------------------------------------------------
// Preencho os valores da CT1
//---------------------------------------------------------


oCT1 := __oModelAut:GetModel('CT1MASTER') //Objeto similar enchoice CT1 
oCT1:SETVALUE('CT1_CONTA','17')
oCT1:SETVALUE('CT1_DESC01','Okdok')
oCT1:SETVALUE('CT1_CLASSE','2')
oCT1:SETVALUE('CT1_CLASSE','2')
oCT1:SETVALUE('CT1_NORMAL' ,'1')

//---------------------------------------------------------
// Preencho os valores da CVD
//---------------------------------------------------------
/*
oCVD := __oModelAut:GetModel('CVDDETAIL') //Objeto similar getdados CVD
oCVD:SETVALUE('CVD_FILIAL' ,CVD->(xFilial('CVD'))) 
oCVD:SETVALUE('CVD_ENTREF','10')
oCVD:SETVALUE('CVD_CODPLA',PadR('2016',Len(CVD->CVD_CODPLA))) 
oCVD:SETVALUE('CVD_CTAREF',PadR('1.01.01.01.01', Len(CVD->CVD_CTAREF)))
oCVD:SETVALUE('CVD_TPUTIL','A')
oCVD:SETVALUE('CVD_CLASSE','2') 
oCVD:SETVALUE('CVD_VERSAO',PadR('0001',Len(CVD->CVD_VERSAO)))
oCVD:SETVALUE('CVD_CUSTO' ,PadR('001',Len(CVD->CVD_CUSTO)))

//---------------------------------------------------------
// Preencho os valores da CTS
//---------------------------------------------------------


oCTS := __oModelAut:GetModel('CTSDETAIL') //Objeto similar getdados CTS
oCTS:SETVALUE('CTS_FILIAL' ,CTS->(xFilial('CTS'))) 
oCTS:SETVALUE('CTS_CODPLA' ,'001')
oCTS:SETVALUE('CTS_CONTAG' ,'0000021')
*/

If __oModelAut:VldData() //validacao dos dados pelo modelo

__oModelAut:CommitData() //gravacao dos dados

conout("Gravação feita com Sucesso")
Else

aLog := __oModelAut:GetErrorMessage() //Recupera o erro do model quando nao passou no VldData

//laco para gravar em string cLog conteudo do array aLog
For nX := 1 to Len(aLog)
If !Empty(aLog[nX])
cLog += Alltrim(aLog[nX]) + CRLF
EndIf
Next nX

lMsErroAuto := .T. //seta variavel private como erro
AutoGRLog(cLog) //grava log para exibir com funcao mostraerro
mostraerro()
lRet := .F. //retorna false

EndIf

__oModelAut:DeActivate() //desativa modelo

Return( lRet )

Return