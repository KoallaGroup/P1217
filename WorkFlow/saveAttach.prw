#Include 'Protheus.ch'
#INCLUDE "XMLXFUN.CH"

User function saveAttach()
Local oServer
Local oMessage
Local nAttach := 0, nI := 0
Local nMessages := 0
Local aAttInfo := {}
Local cBaseName := "", cName := ""
Local xRet
Local cfile := ""
Local cStrAtch := ""
  
lIsPop := .F. // define as .T. if POP protocol, instead of IMAP
  
oXml			:= {}
   
oServer := TMailManager():New()
oServer:SetUseSSL( .T. )
  
If lIsPop
	writePProString( "Mail", "Protocol", "POP3", getsrvininame() )	
	xRet := oServer:Init( "pop.gmail.com", "", "carlos.des.totvs@gmail.com", "totvs1234", 995, 0 ) 
    
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
	xRet := oServer:Init( "imap.gmail.com", "", "carlos.des.totvs@gmail.com", "totvs1234", 993, 0 )
 
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
nTam := nMessages

oMessage := TMailMessage():New()
oMessage:Clear()

for ny := nTam to nTam

	conout( "Receiving newest message" )
	xRet := oMessage:Receive( oServer, ny )
	if xRet <> 0
		conout( "Could not get message " + cValToChar( nMessages ) + ": " + oServer:GetErrorString( xRet ) )
		return
	endif
   
	cBaseName := GetSrvProfString( "RootPath", "" )
	if Right( cBaseName, 1 ) <> '\'
		cBaseName += '\'
	endif

	cBaseName += "mail\"
 
	nAttach := oMessage:GetAttachCount()
	for nI := 1 to nAttach
		cAttach := oMessage:GetAttach( nI )
		aAttInfo := oMessage:GetAttachInfo( nI )
		varinfo( "", aAttInfo )
     
		cName := cBaseName     
     
     	If SUBSTR(aAttInfo[4], len(aAttInfo[4])-3,4) == ".eml" 
     	
			if aAttInfo[1] == ""
				cName += "message." + SubStr( aAttInfo[2], At( "/", aAttInfo[2] ) + 1, Len( aAttInfo[2] ) )
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
    	EndIf
	next nI  
next ny

xRet := oServer:POPDisconnect()

if xRet <> 0
	conout( "Could not disconnect from POP3 server: " + oServer:GetErrorString( xRet ) )
endif

return