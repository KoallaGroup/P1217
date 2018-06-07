#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103FIM()

Local nOpcao := PARAMIXB[1]   // Opção Escolhida pelo usuario no aRotina 

Local nConfirma := PARAMIXB[2]   // Se o usuario confirmou a operação de gravação da NFECODIGO DE APLICAÇÃO DO USUARIO.....

dbSelectArea("SF1")
dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA

dbSeek(xFilial("SF1") + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA + SF1->F1_tIPO)     // Busca exata

 

IF FOUND()    // Avalia o retorno da pesquisa realizada

RECLOCK("SF1", .F.)

SF1->F1_ESTDES  := 'SP' 

MSUNLOCK() 

 
ENDIF

Return	
