#Include 'Protheus.ch'
#Include "RPTDEF.CH"
#include "tbiconn.ch" 


user function MyCODE3_9()



Local oPrinter   

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

Private cCodigo := '123456789' //Numero do teste

oPrinter      := FWMSPrinter():New('teste',6,.F.,,.T.,,,,,.F.)
oPrinter:Setup()
oPrinter:setDevice(IMP_PDF)
//oPrinter:cPathPDF :="C:\"
oPrinter:Say(10,0,"Teste para Code128")    
oPrinter:FWMSBAR('CODE128'    ,50      ,1    ,cCodigo      ,oPrinter      ,.F.  ,    ,.T.  , 0.03  , 1  ,.T.  ,'Arial'    ,''      ,.F.)
//oPrinter:FWMSBAR("CODE3_9" /*cTypeBar*/,50/*nRow*/ ,1/*nCol*/ ,cCodigo  /*cCode*/,oPrinter/*oPrint*/,/*lCheck*/,/*Color*/,/*lHorz*/, /*nWidth*/,/*nHeigth*/,/*lBanner*/,/*cFont*/,/*cMode*/,.F./*lPrint*/,/*nPFWidth*/,/*nPFHeigth*/,/*lCmtr2Pix*/)      
//oPrinter:Code128c(100, 10, '111990000410013', 50) //Numero do teste
//oPrinter:Code128c(100, 10, '11111990000410013', 50) //Numero impar
//oPrinter:Code128c(100, 10, '1111990000410013', 50) //Numero par
oPrinter:EndPage()
oPrinter:Preview()                                                                   

FreeObj(oPrinter)
oPrinter := Nil

RESET ENVIRONMENT  

Return	
