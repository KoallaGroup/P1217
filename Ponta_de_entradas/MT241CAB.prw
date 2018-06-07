#include 'protheus.ch'
#include 'parmtype.ch'

user function MT241CAB()

Local oNewDialog  := PARAMIXB[1]      
Local aCp:=Array(2,2)  
    aCp[1][1]="D3_CP1"  
    aCp[2][1]="D3_CP2"
IF PARAMIXB[2]==3   
    aCp[1][2]=SPAC(10)   
    aCp[2][2]=SPAC(10)   
    @2.9,49.5 SAY "Cpo1" OF oNewDialog 
    @2.8,51.5 MSGET aCp[1][2] SIZE 40,08 OF oNewDialog   
    @2.9,60.5 SAY "Cpo2" OF oNewDialog   
    @2.8,62.5 MSGET aCp[2][2] SIZE 40,08 OF oNewDialog
EndIf
return (aCp)  
