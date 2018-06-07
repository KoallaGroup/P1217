#Include "Rwmake.ch"
#Include "TOPCONN.CH"
#Include "Protheus.ch"
#Include "Tbiconn.ch"
#Include "Tbicode.ch"

User Function BuscaNome()

dbSelectArea("SC5")
dbSetOrder(1)

dbseek(xFilial("SC5")+SC5->C5_NUM)

ExecuteFilter()
GetdRefresh()

Return Nil