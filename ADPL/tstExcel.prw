#include 'protheus.ch'
#include 'parmtype.ch'

user function tstExcel()

Local _nDir 
Local _nArq 
Local oExcel := FWMSEXCEL():New()
oExcel:AddworkSheet("Teste - 1")
oExcel:AddTable ("Teste - 1","Titulo de teste 1")
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col1",1,1)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col2",2,2)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col3",3,3)
oExcel:AddColumn("Teste - 1","Titulo de teste 1","Col4",1,1)
oExcel:AddRow("Teste - 1","Titulo de teste 1",{11,12,13,14})
oExcel:AddRow("Teste - 1","Titulo de teste 1",{21,22.12123,23,24})
oExcel:AddRow("Teste - 1","Titulo de teste 1",{31,NoRound(32.12123,3),33,34})
oExcel:AddRow("Teste - 1","Titulo de teste 1",{41,42,43,44})
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
//oExcel:Activate()
//oExcel:GetXMLFile("TESTE.xml")


conout("teste Excel")


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
	
	//chamada para abrir a planilha gerada no Excel
	/*_oExcelApp := MsExcel():New()
	_oExcelApp:WorkBooks:Open( _nDir + _nArq )
	_oExcelApp:SetVisible(.T.)	*/ 

return