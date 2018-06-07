#include 'protheus.ch'
#include 'parmtype.ch'

user function PNA020GRV ()
	

Local aArea      := GetArea()
Local cFilial    := ParamIxb[1]
Local cDescricao := ParamIxb[3]
Local cX5Descr	 := ""
Local cData      := ""
Local dData      := ParamIxb[2]
Local nOpcao     := ParamIxb[4]
cX5Descr := DtoC(dData) + Space(4) + cDescricao
cData    := DtoC(dData)

/*nOpcao:1 - Inclusao2 - Alteracao3 - Exclusao*/
DbSelectArea("SX5")

If nOpcao == 1	
SX5->( RecLock( "SX5" , .T. ) )	
SX5->X5_FILIAL := xFilial("SX5")	
SX5->X5_TABELA := "63"	
SX5->X5_CHAVE  := "AAA" 

//Exemplo	
SX5->X5_DESCRI := cX5Descr	
SX5->( MsUnlock() )	

ElseIf nOpcao == 2	
If SX5->(Dbseek(xFilial("SX5")+"63") )		
While SX5->( !Eof() .and. X5_TABELA == "63" )			

If Left(SX5->X5_DESCRI,8) == cData				

SX5->( RecLock( "SX5" , .F. ) )				

SX5->X5_DESCRI := cX5Descr				
SX5->( MsUnlock() )				

Exit			
EndIF					      	

SX5->( dbSkip() )		

End While	

EndIf
ElseIf nOpcao == 3	
If SX5->(Dbseek(xFilial("SX5")+"63") )		
While SX5->( !Eof() .and. X5_TABELA == "63" )			
If Left(SX5->X5_DESCRI,8) == cData				
SX5->( RecLock( "SX5" , .F., .T. ) )
				dbDelete()				
				
				SX5->( MsUnlock() )
Exit							
EndIF					      	
SX5->( dbSkip() )		
End While	
EndIf
EndIf
RestArea(aArea)

alert("Passou pelo PNA020GRV")
Return(Nil)