#include 'protheus.ch'
#include 'parmtype.ch'

user function TstRecLock()

dbSelectArea("SA1")
 
RECLOCK("SA1", .T.)
 
SA1->A1_FILIAL     := xFilial("SA1")   // Retorna a filial de acordo com as configurações do ERP Protheus
SA1->A1_COD        := "900002"
SA1->A1_LOJA       := "01"
SA1->A1_NOME     := "MARCOS AURELIUS TERCEIRUS 3"
SA1->A1_NREDUZ := "MARCOS AURELIUS"

RECLOCK("SA1", .T.) // Forçando o erro.


 
MSUNLOCK()     // Destrava o registro
 

	
return

user function TstaRecLock()

connout("Entrou na função tsta")
dbSelectArea("SA1")
dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
dbSeek(xFilial("SA1") + "900001" + "01")     // Busca exata
 
IF FOUND()    // Avalia o retorno da pesquisa realizada
          RECLOCK("SA1", .F.)
 
          SA1->A1_NOME := "MARCOS AURELIUS TERCEIRUS 3"
          SA1->A1_NREDUZ := "MARCOS AURELIUS"
 
          MSUNLOCK()     // Destrava o registro
ENDIF
 

	
return



