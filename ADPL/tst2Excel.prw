#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TBICONN.CH"

user function tst2Excel()
Local _nDir
Local _nArq
Local oExcel := FWMsExcelEx():New()

PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

oExcel:AddworkSheet("Teste - 1")
oExcel:AddTable ("Teste - 1","Titulo de teste 1")
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col1",1,1)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col2",2,2)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col3",3,3)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col4",1,1)
oExcel:SetCelBold(.T.)
oExcel:SetCelFont('Arial')
oExcel:SetCelItalic(.T.)
oExcel:SetCelUnderLine(.T.)
oExcel:SetCelSizeFont(10)

oExcel:AddRow("Teste - 1","Titulo de teste 1",{11,12,13,14},{1,3})

oExcel:SetCelBold(.T.)
oExcel:SetCelFont('Arial')
oExcel:SetCelItalic(.T.)
oExcel:SetCelUnderLine(.T.)
oExcel:SetCelSizeFont(15)
oExcel:SetCelFrColor("#FFFFFF")
oExcel:SetCelBgColor("#000666")

oExcel:AddRow("Teste - 1","Titulo de teste 1",{21,22,23,24},{1})

oExcel:SetCelBold(.T.)
oExcel:SetCelFont('Courier New')
oExcel:SetCelItalic(.F.)
oExcel:SetCelUnderLine(.T.)
oExcel:SetCelSizeFont(10)
oExcel:SetCelFrColor("#FFFFFF")
oExcel:SetCelBgColor("#000333")

oExcel:AddRow("Teste - 1","Titulo de teste 1",{31,32,33,34},{2,4})

oExcel:SetCelBold(.T.)
oExcel:SetCelFont('Line Draw')
oExcel:SetCelItalic(.F.)
oExcel:SetCelUnderLine(.F.)
oExcel:SetCelSizeFont(12)
oExcel:SetCelFrColor("#FFFFFF")
oExcel:SetCelBgColor("#D7BCFB")


oExcel:AddRow("Teste - 1","Titulo de teste 1",{41,42,43,44},{3})

oExcel:AddworkSheet("Teste - 2")
oExcel:AddTable("Teste - 2","Titulo de teste 1")
oExcel:AddColumn("Teste - 2","Titulo de teste 1","Col1",1)
oExcel:AddColumn("Teste - 2","Titulo de teste 1","Col2",2)
oExcel:AddColumn("Teste - 2","Titulo de teste 1","Col3",3)
oExcel:AddColumn("Teste - 2","Titulo de teste 1","Col4",1)
oExcel:AddRow("Teste - 2","Titulo de teste 1",{11,12,13,stod("20121212")})
oExcel:AddRow("Teste - 2","Titulo de teste 1",{21,22,23,stod("20121212")})
oExcel:AddRow("Teste - 2","Titulo de teste 1",{31,32,33,stod("20121212")})
oExcel:AddRow("Teste - 2","Titulo de teste 1",{41,42,43,stod("20121212")})
oExcel:AddRow("Teste - 2","Titulo de teste 1",{51,52,53,stod("20121212")})
/*oExcel:Activate()
oExcel:GetXMLFile("TESTE.xml")
Return */

	//criação/edição do diretório para salvar o arquivo...
    _nDir:=cGetFile( '*.*' , 'Escolha diretório para salvar arquivo', 0, 'C:\', .F., ( GETF_LOCALHARD+GETF_RETDIRECTORY+GETF_OVERWRITEPROMPT ),.F., .F.)
    _nArq:="TESTE.XLS"

	if empty(_nDir)		 //o usuário cancelou...
	   	return
	else
        	if existdir(_nDir)                           //se o diretório já existe...
		  	if file(_nDir+_nArq)                     //confere se o arquivo também existe
				if (apmsgyesno("Este arquivo já existe, sobrescrever?","Arquivo encontrado"))
	  	   			oExcel:Activate()
  				 	oExcel:GetXMLFile(_nDir+_nArq)
	  			else
	  	   			return
	  	  		endif
	  	  	else                                        //se arquivo não existe, cria
				oExcel:Activate()
   				oExcel:GetXMLFile(_nDir+_nArq)
	  	  	endif
	  	else                     			  		//se o diretório não existe, cria
	  		ret:= makedir(_nArq)
	  		if ret != 0
	  			apmsginfo( "Não foi possível criar o diretório ","Erro!" )
	  			return
	  		endif
	  		oExcel:Activate()
   			oExcel:GetXMLFile(_nDir+_nArq)
	  	endif
	endif



return
