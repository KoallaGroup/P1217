#include 'protheus.ch'
#include 'parmtype.ch'
#include "KPIDefs.ch"
#include "BIDefs.ch"
#include "KPICore.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


user function TESTECARQUIVO()

    Local cFile		:= 'sgi_teste.jnlp'
	Local oFileJNPL := TBIFileIO():New(cFile)     
	Local cHost 	:= 'E:\Temp\Protheus 12\protheus_data_17\web\sgi_'                  
    
    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
    	
    	
	/*Cria o arquivo JNLP*/
	If (!oFileJNPL:lCreate(FO_READWRITE + FO_EXCLUSIVE, .t.))
		/*Erro na criação do arquivo.*/
		conout("Error")
	
	Else
	    /*Escreve o corpo do arquivo.*/
		oFileJNPL:nWriteLn('<?xml version="1.0" encoding="utf-8"?>')		
		oFileJNPL:nWriteLn('<jnlp spec="1.0+" codebase="' + cHost + '" href="sgi.jnlp">')
			   			
		oFileJNPL:nWriteLn('<information>')
				
		/*Define as informações gerais da aplicação.*/
		oFileJNPL:nWriteLn('<title>SGI Desktop</title>')
		oFileJNPL:nWriteLn('<vendor>TOTVS SA</vendor>')
		oFileJNPL:nWriteLn('<homepage href="www.totvs.com.br"/>')
		oFileJNPL:nWriteLn('<description>SGI WebStart</description>')
	ENDIF
	
	aAdd(aFields,{"",x[3],x[4],x[5],x[1],""})	}
	
	
	
return