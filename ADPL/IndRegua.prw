#include "protheus.ch"

User Function Exemplo()

Local cArquivo
Local cChave
Local cFor
Local nIndex



DbSelectArea("SE1")
cArquivo := CriaTrab(,.F.)
cChave := "E1_FILIAL+DESCEND(DTOS(E1_EMISSAO))"
cFor := "!Empty(E1_VALOR)"
//IndRegua("SE1",cArquivo,cChave,,cFor)

IndRegua("SE1",cArquivo,cChave,,cFor)

DbSelectArea("SE1")

nIndex := RetIndex("SE1")
#IFNDEF TOP  
DbSetIndex(cArquivo+OrdBagExt())
#ENDIF

DbSetOrder(nIndex+1)
DbSelectArea("SE1")
RetIndex("SE1")
FErase(cArquivo+OrdBagExt())

Return