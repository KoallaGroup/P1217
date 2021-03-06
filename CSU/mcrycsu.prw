#INCLUDE "Rwmake.ch"
#INCLUDE "Protheus.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � Rcrycsu � Autor � Equipe - BI         � Data �  20/07/06   ���
�������������������������������������������������������������������������͹��
���Descricao � Integracao com Crystal acesso via Browser                  ���
�������������������������������������������������������������������������͹��
�������������������������������������������������������������������������͹��
���Objetivo  � Apresentar as informacoes dos relatorios feitos em         ���
���          � Crystal via WEB por meio do Remote                         ���
�������������������������������������������������������������������������͹��
���Uso       �  ASP - Cliente CSU / Parametrizado                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION RCryCSU(_cRel)  //Recebo o nome do rpt

Local oDlg, o, oBtnNav, oBtnPrint, oBtnHome,cQrycod
Local _cPar := ''
Local cTitle := "Relat�rio Crystal - Via WEB"
Local nWidth:= 300
Local nHeight:=300

// Busca parametros do sistema
//Local _cUrl:="http://csu-crystal.microsiga.com.br/"+_cRel
Local _cUrl:= alltrim("http://csucrystal.microsiga.com.br/") + "/" + _cRel+".rpt"
//Local _cUsuario:= "&user0=aluahtop"
Local _cUsuario:= "&user0=" + alltrim("sigacrys")
//Local _cSenha:= "&password0=topsql"
Local _cSenha:= "&password0=" + alltrim("AGL3eVFJ494Eg2bP")


If Pergunte(upper(_cRel),.T.)
	
	if valtype(mv_par01) = 'D'
		//Data(2006,4,12)  ano,mes,dia
		_cPar += "?prompt0=("+alltrim(substr(dtos(mv_par01),1,4))+","+substr(dtos(mv_par01),5,2)+","+substr(dtos(mv_par01),7,2)+")"
	elseIf valtype(mv_par01) = 'C'
		If mv_par01 <> ''
			_cPar += "?prompt0="
			_cPar += mv_par01
		Endif
	endif
	
	if valtype(mv_par02) = 'D'
		_cPar += "&prompt1=("+substr(dtos(mv_par02),1,4)+","+substr(dtos(mv_par02),5,2)+","+substr(dtos(mv_par02),7,2)+")"
	elseIf valtype(mv_par02) = 'C'
		If mv_par02 <> ''
			_cPar += "&prompt1="
			_cPar += mv_par02
		Endif
	endif
	
	if valtype(mv_par03) = 'D'
		_cPar += "&prompt2=("+substr(dtos(mv_par03),1,4)+","+substr(dtos(mv_par03),5,2)+","+substr(dtos(mv_par03),7,2)+")"
	elseIf valtype(mv_par03) = 'C'
		If mv_par03 <> ''
			_cPar += "&prompt2="
			_cPar += mv_par03
		Endif
	endif
	
	if valtype(mv_par04) = 'D'
		_cPar += "&prompt3=("+substr(dtos(mv_par04),1,4)+","+substr(dtos(mv_par04),5,2)+","+substr(dtos(mv_par04),7,2)+")"
	elseIf valtype(mv_par04) = 'C'
		If mv_par04 <> ''
			_cPar += "&prompt3="
			_cPar += mv_par04
		Endif
	endif
	
	if valtype(mv_par05) = 'D'
		_cPar += "&prompt4=("+substr(dtos(mv_par05),1,4)+","+substr(dtos(mv_par05),5,2)+","+substr(dtos(mv_par05),7,2)+")"
	elseIf valtype(mv_par05) = 'C'
		If mv_par05 <> ''
			_cPar += "&prompt4="
			_cPar += mv_par05
		Endif
	endif
	
	if valtype(mv_par06) = 'D'
		_cPar += "&prompt5=("+substr(dtos(mv_par06),1,4)+","+substr(dtos(mv_par06),5,2)+","+substr(dtos(mv_par06),7,2)+")"
	elseIf valtype(mv_par06) = 'C'
		If mv_par06 <> ''
			_cPar += "&prompt5="
			_cPar += mv_par06
		Endif
	endif
	
	if valtype(mv_par07) = 'D'
		_cPar += "&prompt6=("+substr(dtos(mv_par07),1,4)+","+substr(dtos(mv_par07),5,2)+","+substr(dtos(mv_par07),7,2)+")"
	elseIf valtype(mv_par07) = 'C'
		If mv_par07 <> ''
			_cPar += "&prompt6="
			_cPar += mv_par07
		Endif
	endif
	
	if valtype(mv_par08) = 'D'
		_cPar += "&prompt7=("+substr(dtos(mv_par08),1,4)+","+substr(dtos(mv_par08),5,2)+","+substr(dtos(mv_par08),7,2)+")"
	elseIf valtype(mv_par08) = 'C'
		If mv_par08 <> ''
			_cPar += "&prompt7="
			_cPar += mv_par08
		Endif
	endif
	
	if valtype(mv_par09) = 'D'
		_cPar += "&prompt8=("+substr(dtos(mv_par09),1,4)+","+substr(dtos(mv_par09),5,2)+","+substr(dtos(mv_par09),7,2)+")"
	elseIf valtype(mv_par09) = 'C'
		If mv_par09 <> ''
			_cPar += "&prompt8="
			_cPar += mv_par09
		Endif
	endif
	//	If mv_par10 <> ''
	//		_cPar += "&prompt9="
	//		_cPar += mv_par10
	//	Endif
	
	if valtype(mv_par10) = 'D'
		_cPar += "&prompt9=("+substr(dtos(mv_par10),1,4)+","+substr(dtos(mv_par10),5,2)+","+substr(dtos(mv_par10),7,2)+")"
	elseIf valtype(mv_par10) = 'C'
		If mv_par10 <> ''
			_cPar += "&prompt9="
			_cPar += mv_par10
		Endif
	endif
	
	if valtype(mv_par11) = 'D'
		_cPar += "&prompt10=("+substr(dtos(mv_par11),1,4)+","+substr(dtos(mv_par11),5,2)+","+substr(dtos(mv_par11),7,2)+")"
	elseIf valtype(mv_par11) = 'C'
		If mv_par11 <> ''
			_cPar += "&prompt10="
			_cPar += mv_par11
		Endif
	endif
	
	if valtype(mv_par12) = 'D'
		_cPar += "&prompt11=("+substr(dtos(mv_par12),1,4)+","+substr(dtos(mv_par12),5,2)+","+substr(dtos(mv_par12),7,2)+")"
	elseIf valtype(mv_par12) = 'C'
		If mv_par12 <> ''
			_cPar += "&prompt11="
			_cPar += mv_par12
		Endif
	endif
	
	if valtype(mv_par13) = 'D'
		_cPar += "&prompt12=("+substr(dtos(mv_par13),1,4)+","+substr(dtos(mv_par13),5,2)+","+substr(dtos(mv_par13),7,2)+")"
	elseIf valtype(mv_par13) = 'C'
		If mv_par13 <> ''
			_cPar += "&prompt12="
			_cPar += mv_par13
		Endif
	endif
	
	if valtype(mv_par14) = 'D'
		_cPar += "&prompt13=("+substr(dtos(mv_par14),1,4)+","+substr(dtos(mv_par14),5,2)+","+substr(dtos(mv_par14),7,2)+")"
	elseIf valtype(mv_par14) = 'C'
		If mv_par14 <> ''
			_cPar += "&prompt13="
			_cPar += mv_par14
		Endif
	endif
	
	if valtype(mv_par15) = 'D'
		_cPar += "&prompt14=("+substr(dtos(mv_par15),1,4)+","+substr(dtos(mv_par15),5,2)+","+substr(dtos(mv_par15),7,2)+")"
	elseIf valtype(mv_par15) = 'C'
		If mv_par15 <> ''
			_cPar += "&prompt14="
			_cPar += mv_par15
		Endif
	endif
	
	if valtype(mv_par16) = 'D'
		_cPar += "&prompt15=("+substr(dtos(mv_par16),1,4)+","+substr(dtos(mv_par16),5,2)+","+substr(dtos(mv_par16),7,2)+")"
	elseIf valtype(mv_par16) = 'C'
		If mv_par16 <> ''
			_cPar += "&prompt15="
			_cPar += mv_par16
		Endif
	endif
	
	if valtype(mv_par17) = 'D'
		_cPar += "&prompt16=("+substr(dtos(mv_par17),1,4)+","+substr(dtos(mv_par17),5,2)+","+substr(dtos(mv_par17),7,2)+")"
	elseIf valtype(mv_par17) = 'C'
		If mv_par17 <> ''
			_cPar += "&prompt16="
			_cPar += mv_par17
		Endif
	endif
	
	if valtype(mv_par18) = 'D'
		_cPar += "&prompt17=("+substr(dtos(mv_par18),1,4)+","+substr(dtos(mv_par18),5,2)+","+substr(dtos(mv_par18),7,2)+")"
	elseIf valtype(mv_par18) = 'C'
		If mv_par18 <> ''
			_cPar += "&prompt17="
			_cPar += mv_par18
		Endif
	endif
	
 	if valtype(mv_par19) = 'D'
		_cPar += "&prompt18=("+substr(dtos(mv_par19),1,4)+","+substr(dtos(mv_par19),5,2)+","+substr(dtos(mv_par19),7,2)+")"
	elseIf valtype(mv_par19) = 'C'
		If mv_par19 <> ''
			_cPar += "&prompt18="
			_cPar += mv_par19
		Endif
	endif
	
	
		
else
	Return()
Endif

_cUrl += _cPar
_cUrl += _cUsuario
_curl += _cSenha

DEFINE MSDIALOG oDlg FROM 0, 0 TO 600, 800 TITLE cTitle PIXEL
oDlg:lMaximized := .T.
o:=TiBrowser():New(0,0,oDlg:nWidth / 2,oDlg:nHeight / 2, _cUrl,oDlg)

o:Align := CONTROL_ALIGN_ALLCLIENT
o:Navigate(_cURL)
ACTIVATE MSDIALOG oDlg CENTERED ON INIT ( EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()}) )

Return()
