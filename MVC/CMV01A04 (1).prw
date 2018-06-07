#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWMVCDEF.CH'

user function ATFA012()
	Local aParam 	:= PARAMIXB
	Local xRet 		:= .T.
	Local cIdPonto 	:= ''
	Local cIdModel 	:= ''
	Local cMsg 		:= ''
	Local oModel 	:= ''

	If aParam <> NIL
		oModel		:= FwModelActive()
		cIdPonto	:= aParam[2]
		cIdModel	:= aParam[3]
		oObj := aParam[1]

		If cIdPonto == 'FORMPOS'
			If aParam[5] == 'DELETE' .AND. oObj:GetValue(cIdModel,"N1_STATUS") == "0"
				Help(,,"ATFA012(MVC)",,"Ativo fixo não pode ser excluido, pois foi gerado pelas rotinas de Cota Capital.",1,0)
				xRet := .F.
			EndIF
		EndIF
	EndIf
	
Return xRet
