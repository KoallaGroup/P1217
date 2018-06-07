#Include "PROTHEUS.CH"
#include "TBICONN.CH"
#include "totvs.CH"

User Function MT410a()

	Private aCabec := {}
	Private aItens := {}
	Private aLinha1 := {}
	Private aLinha2 := {}
	Private lMsErroAuto := .F.
	private cPrePed := "9999B"//GETSXENUM("SC5","C5_NUM")

	PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

	dbselectarea("SC5")
	SC5->(dbSetOrder(1))
	SC5->(dbgotop())
	
	For nx:= 1 to 9
		
		cPed := cPrePed + cvaltochar(nx)
		
		SC5->(dbSeek(xFilial("SC5")+ cPed ))

		aCabec := {}
		aItens := {}
		aadd(aCabec,{"C5_NUM"		,cPed			,Nil})
		aadd(aCabec,{"C5_TIPO"		,SC5->C5_TIPO		,Nil})
		aadd(aCabec,{"C5_CLIENTE"	,SC5->C5_CLIENTE	,Nil})
		aadd(aCabec,{"C5_LOJACLI"	,SC5->C5_LOJACLI	,Nil})
		aadd(aCabec,{"C5_CONDPAG"	,SC5->C5_CONDPAG	,Nil})
		Aadd(aCabec,{"C5_TRANSP"  , SC5->C5_TRANSP   , Nil})
		Aadd(aCabec,{"C5_TABELA"  , SC5->C5_TABELA   , Nil})
		Aadd(aCabec,{"C5_VEND1"   , SC5->C5_VEND1    , Nil})
		Aadd(aCabec,{"C5_NATUREZ" , SC5->C5_NATUREZ  , Nil})
		Aadd(aCabec,{"C5_EMISSAO" , SC5->C5_EMISSAO , Nil})

		dbselectarea("SC6")
		SC6->(dbSetOrder(1))
		SC6->(dbgotop())
		SC6->(dbSeek(xFilial("SC6")+ cPed + '01' + "6              "))
		
		nval:=Randomize(610,670) 

		aLinha := {}
		dbselectarea("SC6")
		aadd(aLinha,{"C6_ITEM"		,SC6->C6_ITEM		,Nil})
		aadd(aLinha,{"C6_PRODUTO"	,SC6->C6_PRODUTO	,Nil})
		aadd(aLinha,{"C6_UM"      , SC6->C6_UM					, Nil})
		aadd(aLinha,{"C6_QTDVEN"		,1				,Nil})
		aadd(aLinha,{"C6_PRCVEN"		,nval  			,Nil})
		aadd(aLinha,{"C6_VALOR"		,nval				,Nil})
		aadd(aLinha,{"C6_TES"		,SC6->C6_TES		,Nil})
		aadd(aLinha,{"C6_LOCAL"   , SC6->C6_LOCAL 	 				, Nil})
		aadd(aLinha,{"C6_LOTECTL" , SC6->C6_LOTECTL					, Nil})//depois do itemori
		aadd(aLinha,{"C6_NUM"     , SC6->C6_NUM	    				, Nil})
		aadd(aLinha,{"C6_NFORI"   , SC6->C6_NFORI					, Nil})
		aadd(aLinha,{"C6_ITEMORI" , SC6->C6_ITEMORI					, Nil})
		aadd(aLinha,{"C6_SERIORI" , SC6->C6_SERIORI				, Nil})
		aadd(aLinha,{"C6_IDENTB6" , SC6->C6_IDENTB6					, Nil})
		aadd(aLinha,{"C6_NUMSERI" , SC6->C6_NUMSERI			, Nil})
		aadd(aLinha,{"LINPOS","C6_ITEM",StrZero(nX,2)})
		aadd(aLinha,{"AUTDELETA","N",Nil})
	
		//varinfo("Array",aitens)

		aadd(aItens,aLinha1)
		

		aadd(aLinha,{"C6_ITEM",'03',Nil})
	    aadd(aLinha,{"C6_PRODUTO","6              ",Nil})
	    aadd(aLinha,{"C6_QTDVEN",2,Nil})
	    aadd(aLinha,{"C6_PRCVEN",100,Nil})
	    aadd(aLinha,{"C6_PRUNIT",100,Nil})
	    aadd(aLinha,{"C6_VALOR",200,Nil})
	    aadd(aLinha,{"C6_LOCAL",'1 ',Nil})
	    aadd(aLinha,{"C6_TES","520",Nil})
	    aadd(aLinha,{"C6_QTDLIB",2,Nil})
		
		
		aadd(aItens,aLinha2)
		
		
		
		
		ConOut("Inicio  : "+Time())
		//varinfo("Array",aitens)
		MSExecAuto({|x,y,z| mata410(x,y,z)},aCabec,aItens,4)// Altera o pedido
		If !lMsErroAuto
			ConOut("Sucesso! " + cPed)
		Else
			ConOut("Erro!")
			MostraErro()
		EndIf
		
		
	NEXT nx
	
	ConOut("Fim  : "+Time())
	
	RESET ENVIRONMENT
Return


