#Include 'Protheus.ch'

User Function BIUSRTAB()
    Local aTable   := {}
    Local cTable := PARAMIXB[1] // Alias da tabela fato ou dimensão que está sendo processada.
 
    If ( cTable == "HL6")
    	 Conout("Pasosu pelo HL6")
        aTable := {"SD1","SF1","SA1"}
    EndIf
Return aTable