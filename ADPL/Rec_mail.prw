#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "Ap5Mail.ch"
#INCLUDE "XMLXFUN.CH"


user function Rec_Mail()
  Local oServer
  Local oMessage
  Local nAttach := 0, nI := 0
  Local nMessages := 0, nM := 0
  Local cAttach := "", cName := ""
  Local aAttInfo := {}
  Local xRet
   
  oServer := tMailManager():New()
  writePProString( "Mail", "Protocol", "POP3", getsrvininame() )
   
  oServer:SetUseSSL( .T. )
  xRet := oServer:Init( "pop.gmail.com", "", "rodrigoguimaraessoares@gmail.com", "*****", 995, 0)
  if xRet <> 0
    conout( "Could not initialize mail server: " + oServer:GetErrorString( xRet ) )
    return
  endif
   
  xRet := oServer:POPConnect()
  if xRet <> 0
    conout( "Could not connect on POP3 server: " + oServer:GetErrorString( xRet ) )
    return
  endif
   
  oServer:GetNumMsgs( @nMessages )
  conout( "Number of messages: " + cValToChar( nMessages ) )
   
  oMessage := TMailMessage():New()
  oMessage:Clear()
/*   
  conout( "Receiving newest message" )
  xRet := oMessage:Receive( oServer, nMessages )
  if xRet <> 0
    conout( "Could not get message " + cValToChar( nMessages ) + ": " + oServer:GetErrorString( xRet ) )
    return
  endif
 FOR nM := 1 to nMessages
   nAttach := oMessage:GetAttachCount()
   for nI := 1 to nAttach
    aAttInfo := oMessage:GetAttachInfo( nI )
    cName := "C:\emails\"
     
    if aAttInfo[1] == ""
      cName += "message"+cvaltochar(nM)+"." + SubStr( aAttInfo[2], At( "/", aAttInfo[2] ) + 1, Len( aAttInfo[2] ) )
    else
      cName += aAttInfo[1]
    endif
     
    conout( "Saving attachment " + cValToChar( nI ) + ": " + cName )
     
    cAttach := oMessage:GetAttach( nI )
    xRet := MemoWrite( cName, cAttach )
    if !xRet
      conout( "Could not save attachment " + cValToChar( nI ) )
    endif
  next nI
  
 next nM */

for ny := 1 to nMessages

	conout( "Receiving newest message" )
	xRet := oMessage:Receive( oServer, ny )
	if xRet <> 0
		conout( "Could not get message " + cValToChar( nMessages ) + ": " + oServer:GetErrorString( xRet ) )
		return
	endif
   
/*	cBaseName := GetSrvProfString( "RootPath", "" )
	if Right( cBaseName, 1 ) <> '\'
		cBaseName += '\'
	endif

	cBaseName += "mail\" */
    cFile := "C:\EML\" + cValToChar( ny ) + ".eml"
    conout( "Saving message " + cValToChar( ny ) + " to " + cFile )
    oMessage:Save( cFile )
	nAttach := oMessage:GetAttachCount()
	for nI := 1 to nAttach
		cAttach := oMessage:GetAttach( nI )
		aAttInfo := oMessage:GetAttachInfo( nI )
		varinfo( "", aAttInfo )
     
		cName := "C:\emails\"    
     
     	 
     	
			if aAttInfo[1] == ""
				cName += "message"+cvaltochar(ny)+"."+ SubStr( aAttInfo[2], At( "/", aAttInfo[2] ) + 1, Len( aAttInfo[2] ) )
			else
      			cName += aAttInfo[1]
			endif
     
			conout( "Saving attachment " + cValToChar( nI ) + ": " + cName )		
		    
			xRet := oMessage:SaveAttach( nI, cName )
			if xRet == .F.
				conout( "Could not save attachment " + cName  )
				loop
			endif

			/*cfile := StrTran(AllTrim(aAttInfo[4]), '"', '',,)
			cStrAtch := Memoread( cBaseName +'\'+ cfile)
    
			CREATE oXML XMLSTRING cStrAtch*/
    	
	next nI  
next ny


   
  xRet := oServer:POPDisconnect()
  if xRet <> 0
    conout( "Could not disconnect from POP3 server: " + oServer:GetErrorString( xRet ) )
  endif
return


