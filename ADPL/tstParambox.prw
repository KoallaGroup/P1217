#include 'protheus.ch'
#include 'parmtype.ch'

user function tstParambox()
	

Local aPergs := {}
Local aRet := {}
Local cCodRec := space(08)
Local cRecDest := space(08)   


aAdd( aPergs ,{1,"Recurso De: ",cCodRec,"@",'.F.',,'.F.',40,.F.})   
aAdd( aPergs ,{1,"Recurso Para: ",cRecDest,"@!",'!Empty(mv_par02)',,'.T.',40,.T.})   

aAdd( aRet ,{1,"Recurso De: ",cCodRec,"@",'.F.',,'.F.',40,.F.})   
aAdd( aRet ,{1,"Recurso Para: ",cRecDest,"@!",'!Empty(mv_par02)',,'.T.',40,.T.})  


If ParamBox(aPergs ,"Substitui recurso",aRet, , , .F., 500,3)      

alert("Recurso original:"+aRet[1]+ " substituido pelo recurso:" + aRet[2])   

Else     
 Aviso("Processo cancelado")   

EndIf 
Return .T.

User Function ExempParam()
Local aPergs := {}
Local cCodRec := space(08)
Local aCombo := {"Plano","Cemiterio","Funeraria"} 
Local aRet := {}
Local lRet    

aAdd( aPergs ,{1,"Recurso : ",cCodRec,"@!",'.T.',,'.T.',40,.F.})  
aAdd( aPergs ,{2,"Recurso Para",1, {"Projeto", "Tarefa"}, 50,'.T.',.T.})  
aAdd( aPergs ,{3,"Considera Sabado/Domingo",1, {"Sim", "Nao"}, 50,'.T.',.T.})  
aAdd( aPergs ,{4,"Enviar e-mail",.T., "usuario@totvs.com.br", 80,'.T.',.T.})  
aAdd( aPergs ,{5,"Recurso Bloqueado",.T., 90,'.T.',.T.})
aAdd( aPergs ,{11,"Obs. ","TESTE", ".T.",".T.",.T.})      

If ParamBox(aPergs ,"Parametros ",aRet)      
 Alert("Pressionado OK")      
 lRet := .T.  
Else      
 Alert("Pressionado Cancel")      
 lRet := .F.  
EndIf

Return lRet

