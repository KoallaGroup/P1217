#Include 'Protheus.ch'
#include 'parmtype.ch'

User Function SRVCRYS()
/*
local cRel := 'REL'
local bT := .T.
local cOptions := "1;0;1;Pedido de Compras"


Local cRootPath		:= GetPvProfString( GetEnvServer(), "ROOTPATH", "", GetADV97() )
Local cSystem			:= GetPvProfString( GetEnvServer(), "STARTPATH", "", GetADV97() )  
Local cStartPath 		:= cBIFixPath( cRootPath, "\") + cSystem   
Local cLogPath 		:= cBIFixPath( cRootPath, "\") + SuperGetMV("MV_CRYSTAL") + "\LOG\
Local cPathCli  	:= GetClientDir()
local cInstallPath	:= cBIFixPath( GetPvProfString( GetEnvServer(), "CRWINSTALLPATH", "" , GetADV97() ), "\" )		



ConOut(cRootPath)
ConOut(cSystem)
ConOut(cStartPath)
ConOut(cLogPath)
ConOut(cPathCli) 
ConOut(cInstallPath)

// TODO 

CallCrys(cRel,'', cOptions, .t.,.t. ,.t.,.f.) */

local cRel := 'REL'
local cOptions := "1;0;1;Pedido de Compras"

CallCrys(cRel,'', cOptions, .t.,.t.,.t.,.f.)



	
Return .T.