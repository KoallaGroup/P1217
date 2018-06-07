#include 'protheus.ch'
#include 'parmtype.ch'
#include "tbiconn.ch"

user function MATA430()
	
/*Local aCabec := {}


local aOPERACAO := {1,"PD","KA020H","CL0001","01",""}
Local cNUMERO   := "99G6QJ"
Local cPRODUTO := "000000000000001"
Local cLOCAL    := "1 "
Local nQUANT    := 10
Local aLOTE     := {"","","",""}



PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"


dbSelectArea("SB2")
SET ORDER TO 1

DbSeek(xFilial("SB2")+"2              ",.T.)

Alert("Filial: "+B2_FILIAL+"   Prod: "+B2_COD+"   QTD: "+ALLTRIM(STR(B2_QATU)))


A430Reserv(aOPERACAO,cNUMERO,cPRODUTO,cLOCAL,nQUANT,aLOTE) */
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"


a430Reserv({1,'VD','         ','Administrador       ','01'},;
			  '000002',;
             'PA01           ',;
             '1 ',;
             10,;
             {    '      ',;
             '          ',;
             '               ',;
             '                    '})
             

Return nil