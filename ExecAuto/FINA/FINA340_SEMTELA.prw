#include 'protheus.ch'
#include 'parmtype.ch'

user function FINA340_SEMTELA()

 Local aRecPA := {}			
Local aRecSE2 := {SE2->(Recno())}

 SE2->(dbSetOrder(1)) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA

 aRecAux := {}

 aRecAux := XGetTitAd(SE2->E2_FORNECE,SE2->E2_LOJA )

 For nX := 1 To Len(aRecAux)

     aADD(aRecPA,aRecAux[nX])

 Next nX			
			
			
			
			
			IF	!MaIntBxCP(2,aRecSE2,,aRecPA,,{.f.,.F.,.t.,.F.,.F.,.F.},,,,dDatabase)    

                  Help("XAFCMPAD",1,"HELP","XAFCMPAD","Não foi possível a compensação"+CRLF+" do titulo do adiantamento",1,0)    

          	 Else     

                 MsgInfo("Compensação Automática Concluida","Atencao")   

             EndIf

	
return