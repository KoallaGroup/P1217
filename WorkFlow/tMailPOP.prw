#Include 'Protheus.ch'

User Function tMailPOP()
Local cAttach := "", cName := ""
Local aAttInfo := {}
Local nAttach := 0, nI := 0
Local oServer
Local oMessage
Local nMessages := 0
Local xRet
  
lIsPop := .T. // define as .T. if POP protocol, instead of IMAP
  
oServer := TMailManager():New()
oServer:SetUseSSL( .T. )
  
If lIsPop
	writePProString( "Mail", "Protocol", "POP3", getsrvininame() )	
	xRet := oServer:Init( "pop.gmail.com", "", "rodrigoguimaraessoares@gmail.com", "Rodrigo9606", 995, 0 ) 
    
	if xRet <> 0
		conout( "Could not initialize mail server: " + oServer:GetErrorString( xRet ) )
		return
	endif

	xRet := oServer:POPConnect()
	if xRet <> 0
		conout( "Could not connect on POP3 server: " + oServer:GetErrorString( xRet ) )
		return
	endif
Else
	writePProString( "Mail", "Protocol", "IMAP", getsrvininame() )
	xRet := oServer:Init( "imap.gmail.com", "", "rodrigoguimaraessoares@gmail.com", "Rodrigo9606", 993, 0 )
 
	if xRet <> 0
		conout( "Could not initialize mail server: " + oServer:GetErrorString( xRet ) )
		return
	endif
 
	xRet := oServer:IMAPConnect()
	if xRet <> 0
		conout( "Could not connect on IMAP server: " + oServer:GetErrorString( xRet ) )
		return
	endif       
EndIf




	oServer:GetNumMsgs( @nMessages )
	conout( "Number of messages: " + cValToChar( nMessages ) )
	
   oMessage := TMailMessage():New()
   oMessage:Clear()
   
   conout( "Receiving newest message" )

	nAttach := oMessage:GetAttachCount()
	for nI := 1 to nAttach
    aAttInfo := oMessage:GetAttachInfo( nI )
    cName := "\emails\"
     
    if aAttInfo[1] == ""
      cName += "message." + SubStr( aAttInfo[2], At( "/", aAttInfo[2] ) + 1, Len( aAttInfo[2] ) )
    else
      cName += aAttInfo[1]
    endif
     
    conout( "Saving attachment " + cValToChar( nI ) + ": " + cName )
     
    cAttach := oMessage:GetAttach( nI )
    xRet := MemoWrite( cName, cAttach )
    if !xRet
      conout( "Could not save attachment " + cValToChar( nI ) )
    endif
    conout(cvaltochar(nI))
  next nI
   

If lIsPop
	xRet := oServer:POPDisconnect()
	if xRet <> 0
		conout( "Could not disconnect from POP3 server: " + oServer:GetErrorString( xRet ) )
	Endif
Else 
	xRet := oServer:IMAPDisconnect
	if xRet <> 0
		conout( "Could not disconnect from IMAP server: " + oServer:GetErrorString( xRet ) )
	Endif
EndIf

return