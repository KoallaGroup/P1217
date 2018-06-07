#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'

#Define CPOSCABEC "|ZSI_FILIAL|ZSI_CLIENT|ZSI_LOJA|ZSI_NOMCLI|"

//-------------------------------------------------------------------
/*/{Protheus.doc} ZZCadZSI

Cadastro de Sites (Locais de Atendimento)

@author 	Augusto Krejci Bem-Haja
@since 		13/01/2017
@return		nil
/*/
//-------------------------------------------------------------------
User Function ZZCadZSI()
	Local oBrowse       
	
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias('ZSI')
	oBrowse:SetDescription('Cadastro de Sites')  

	oBrowse:AddLegend( "ZSI_SITUAC=='A'", "GREEN", "Ativo" )
	oBrowse:AddLegend( "ZSI_SITUAC=='I'", "RED"  , "Inativo" )

	oBrowse:SetLocate()
	oBrowse:Activate()
Return NIL

//-------------------------------------------------------------------
Static Function MenuDef()
	Local aRotina := {}
	
	ADD OPTION aRotina TITLE 'Pesquisar'  ACTION 'PesqBrw'        OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.ZZCadZSI' OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.ZZCadZSI' OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.ZZCadZSI' OPERATION 4 ACCESS 0
	//ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.ZZCadZSI' OPERATION 5 ACCESS 0
	ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.ZZCadZSI' OPERATION 8 ACCESS 0
	ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.ZZCadZSI' OPERATION 9 ACCESS 0
Return aRotina


//-------------------------------------------------------------------
Static Function ModelDef()
	Local oStruZSIM := FWFormStruct( 1,'ZSI', {|cCampo| AllTrim(cCampo)	+ "|" $ CPOSCABEC})
	Local oStruZSID := FWFormStruct( 1,'ZSI', {|cCampo| !AllTrim(cCampo)+ "|" $ CPOSCABEC})
	Local oModel
	Local bPreDetail := {|oFieldModel, cAction, cIDField, xValue| validPre(oFieldModel, cAction, cIDField, xValue)}
	Local aTrigger := {}
	
	oStruZSIM:SetProperty("ZSI_CLIENT"	,	MODEL_FIELD_WHEN,{|| oModel:GetOperation() == 3 })
	oStruZSIM:SetProperty("ZSI_LOJA"	,	MODEL_FIELD_WHEN,{|| oModel:GetOperation() == 3 })

	oStruZSID:setProperty("ZSI_END"		,	MODEL_FIELD_VALID,{|| cleanKT()})
	oStruZSID:setProperty("ZSI_MUNIC"   ,	MODEL_FIELD_VALID,{|| loadKT() })

	oModel := MPFormModel():New('ZSIMod',{ || verifUser()},{ || verifReg(oModel)})

	oModel:AddFields('ZSIMASTER',NIL, oStruZSIM,, )
	oModel:AddGrid('ZSIDETAIL', 'ZSIMASTER', oStruZSID, bPreDetail)
    
	oModel:SetRelation ('ZSIDETAIL',;
							{ {'ZSI_FILIAL',"xFilial('ZSI')"},;
							  {'ZSI_CLIENT','ZSI_CLIENT'},;
							  {'ZSI_LOJA','ZSI_LOJA'}}, ZSI->(IndexKey(1)) )
							  
	oModel:GetModel( 'ZSIDETAIL' ):SetUniqueLine( { 'ZSI_COD' } )

	oModel:SetDescription('Modelo de Dados de Sites')
	oModel:GetModel('ZSIMASTER'):SetDescription( 'Dados do Cliente')
	oModel:GetModel('ZSIDETAIL'):SetDescription( 'Sites')
	
	oModel:SetPrimaryKey({ })
Return oModel


//-------------------------------------------------------------------
Static Function ViewDef()
	Local oModel   := FWLoadModel('ZZCadZSI')
	Local oStruZSIM := FWFormStruct(2,'ZSI',{|cCampo| AllTrim(cCampo)	+ "|" $ CPOSCABEC})
	Local oStruZSID := FWFormStruct(2,'ZSI',{|cCampo| !AllTrim(cCampo)	+ "|" $ CPOSCABEC})
	Local oView  
	
	oView := FWFormView():New()
	oView:SetModel(oModel)

	oView:AddField('VIEW_ZSIM', oStruZSIM, 'ZSIMASTER')
	oView:AddGrid ('VIEW_ZSID', oStruZSID, 'ZSIDETAIL')
	
	oView:AddIncrementField('VIEW_ZSID','ZSI_COD')
	
	oView:CreateHorizontalBox('MASTER',15)
	oView:CreateHorizontalBox('DETAIL1',55)
	
    oView:SetCloseOnOk({||.T.})
	
	oView:SetOwnerView('VIEW_ZSIM', 'MASTER')
	oView:SetOwnerView('VIEW_ZSID', 'DETAIL1')
Return oView

User Function ZZrMod(cSecao,cCampo)
	local oMdl     	:= FwModelActive()
	local oMdlGrid 	:= oMdl:getModel(cSecao)
	local cDado		:= oMdlGrid:getValue(cCampo)
return cDado

Static Function loadKT()
	Local oMdl     	:= FwModelActive()
	Local oMdlMaster:= oMdl:getModel("ZSIMASTER")
	Local oMdlDetail:= oMdl:getModel("ZSIDETAIL")

	Local aRetCAM				:= {}
	Local aRetJUN				:= {}
	Local aRetLIM				:= {}
	Local aRetRIB				:= {}
	Local aRetSOR				:= {}
	Local aArea				:= GetArea()

	Local cTitulo			:= "Atualização do Traslado e KM"     
	Local cCustomerCode	:= oMdlMaster:getValue('ZSI_CLIENT')
	Local cCustomerName	:= oMdlMaster:getValue('ZSI_NOMCLI')
	Local cToStreet		:= FisGetEnd(oMdlDetail:getValue('ZSI_END'))[1] 
	Local cToNumber		:= FisGetEnd(oMdlDetail:getValue('ZSI_END'))[3]
	Local cToCity		:= oMdlDetail:getValue('ZSI_MUNIC')
	Local cToState		:= oMdlDetail:getValue('ZSI_UF')
	Local oGM			:= NIL

	oGM				:= TIPGoogleMaps():New()
	oGM:SetToAddress(cCustomerCode, cToStreet, cToNumber, cToCity, cToState)
		
	aRetCAM := oGM:GetTraslado("IPC")
	aRetJUN := oGM:GetTraslado("IPJ")
	aRetLIM := oGM:GetTraslado("IPL")
	aRetRIB := oGM:GetTraslado("IPR")
	aRetSOR := oGM:GetTraslado("IPS")
	
	If oGM:GetStatus() == "OK"
		oMdlDetail:setValue("ZSI_KMCAM"  , aRetCAM[1])
		oMdlDetail:setValue("ZSI_KMJUN"  , aRetJUN[1])
		oMdlDetail:setValue("ZSI_KMLIM"  , aRetLIM[1])
		oMdlDetail:setValue("ZSI_KMRIB"  , aRetRIB[1])
		oMdlDetail:setValue("ZSI_KMSOR"  , aRetSOR[1])
		oMdlDetail:setValue("ZSI_TRACAM" , aRetCAM[2])
		oMdlDetail:setValue("ZSI_TRAJUN" , aRetJUN[2])
		oMdlDetail:setValue("ZSI_TRALIM" , aRetLIM[2])
		oMdlDetail:setValue("ZSI_TRARIB" , aRetRIB[2])
		oMdlDetail:setValue("ZSI_TRASOR" , aRetSOR[2])	
	Else
		Aviso(cTitulo, "Os dados do cliente (Traslado e KM) não foram encontrados pelo Google Maps!!!", {"OK"})
	EndIf
	
	RestArea(aArea)
Return (.T.)

Static Function cleanKT()
	local oView
	local oModel   	:= FWModelActive()
	local oStructGrid := oModel:getModel("ZSIDETAIL")
	
	oStructGrid:setValue("ZSI_MUNIC"  , "")
	oStructGrid:setValue("ZSI_UF"	  , "")
	oStructGrid:setValue("ZSI_KMCAM"  , 0)
	oStructGrid:setValue("ZSI_KMJUN"  , 0)
	oStructGrid:setValue("ZSI_KMLIM"  , 0)
	oStructGrid:setValue("ZSI_KMRIB"  , 0)
	oStructGrid:setValue("ZSI_KMSOR"  , 0)
	oStructGrid:setValue("ZSI_TRACAM" , "  :  ")
	oStructGrid:setValue("ZSI_TRAJUN" , "  :  ")
	oStructGrid:setValue("ZSI_TRALIM" , "  :  ")
	oStructGrid:setValue("ZSI_TRARIB" , "  :  ")
	oStructGrid:setValue("ZSI_TRASOR" , "  :  ")
	
	oView := FWViewActive()
	oView:Refresh()	
Return (.T.)

Static Function verifReg(oModel)
	Local lRet			:= .T.
	Local aArea			:= GetArea()
	Local aAreaZSI		:= GetArea("ZSI")
	Local aAreaSA1		:= GetArea("SA1")
	
	Local cCliente		:= oModel:GetValue("ZSIMASTER","ZSI_CLIENT")
	Local cLoja			:= oModel:GetValue("ZSIMASTER","ZSI_LOJA")
	Local nOperacao		:= oModel:GetOperation()
	
	If nOperacao == 3
		ZSI->(DbSetOrder(1))
		If ZSI->(DbSeek(xFilial("ZSI") + cCliente + cLoja))
			Help( ,, 'Help',, "Já existe registro do Cliente: " + AllTrim(cCliente) + " e Loja: " + AllTrim(cLoja), 1, 0 )
			lRet := .F.
		EndIf
		SA1->(DbSetOrder(1))
		If !(SA1->(DbSeek(xFilial("SA1")+cCliente + cLoja)))
			Help( ,, 'Help',, "Cliente: " + AllTrim(cCliente) + " e Loja: " + AllTrim(cLoja) + " inválido.", 1, 0 )
			lRet := .F.
		Endif                                                               
	EndIf
	RestArea(aAreaZSI)
	RestArea(aAreaSA1)
	RestArea(aArea)	
Return (lRet)

Static Function validPre(oFieldModel, cAction, cIDField, xValue)
	Local lRet := .T.
	Local cMunic := oFieldModel:GetValue("ZSI_MUNIC")
	
	If (cIDField == "DELETE" .OR. cIDField == "UNDELETE") .AND. !(Empty(cMunic))
   		lRet := .F.   
	   	Help( ,, 'HELP',, 'Não possível excluir, se necessário desative o Site.', 1, 0)   
	Endif
Return lRet

Static Function verifUser()
	Local lRet			:= .T.
	Local cCurrentUser	:= Upper(AllTrim( cUserName))
	Local cPermissao	:= Upper(AllTrim( SuperGetMV("MV_ZZFAT48",.F.,"")))  
	
	If !(cCurrentUser $ cPermissao)  
  		lRet := .F.
	Endif  	
Return (lRet)
