#Include 'Protheus.ch'

static function RestoreConf( conf, iniFile )
  Local xRet
  Local cMsg := ""
   
  if conf == ""
    xRet := DeleteKeyINI( "MAIL", "Protocol", iniFile )
  else
    xRet := WritePProString( "MAIL", "Protocol", conf, iniFile )
  endif
   
  if xRet == .F.
    cMsg := "Could not restore configuration. Initial configuration: " + conf + CRLF
    conout( cMsg )
  endif
return
 
user function GetEmails()
  Local cUser := "", cPass := "", cRecvSrv := ""
  Local cIniFile := "", cIniConf := "", cMsg := "", cProtocol := ""
  Local nMessages := 0, nI := 0, nRecv := 0, nTimeout := 0
  Local lConnected := .F., lIsPop := .F., lRecvSec := .F.
  Local xRet
  Local oServer, oMessage
   
  cUser := "rodrigoguimaressoares@gmail.com" //define the e-mail account username
  cPass := "souomelhor9606" //define the e-mail account password
  cRecvSrv := "pop.gmail.com" // define the receive server
  lIsPop := .F. // define as .T. if POP protocol, instead of IMAP
  lRecvSec := .T. // define as .T. if the server uses secure connection
  nTimeout := 60 // define the timout to 60 seconds
   
  if lIsPop == .T.
    cProtocol := "POP3"
     
    if lRecvSec == .T.
      nRecv := 995 //default port for POPS protocol
    else
      nRecv := 110 //default port for POP protocol
    endif
  else
    cProtocol := "IMAP"
     
    if lRecvSec == .F.
      nRecv := 993 //default port for IMAPS protocol
    else
      nRecv := 143 //default port for IMAP protocol
    endif
  endif
   
  cIniFile := GetSrvIniName()
  cIniConf := GetPvProfString( "MAIL", "Protocol", "", cIniFile )
   
  xRet := WritePProString( "MAIL", "Protocol", cProtocol, cIniFile )
  if xRet == .F.
    cMsg := "Could not set " + cProtocol + " on " + cIniFile + CRLF
    conout( cMsg )
    return
  endif
   
  oServer := TMailManager():New()
   
  oServer:SetUseSSL( .F. )
  oServer:SetUseTLS( .F. )
   
  if lRecvSec == .T.
    oServer:SetUseSSL( .T. )
  endif
   
  // once it will only receives messages, the SMTP server will be passed as ""
  // and the SMTP port number won't be passed, once it is optional
  xRet := oServer:Init( cRecvSrv, "", cUser, cPass, nRecv )
  if xRet != 0
    cMsg := "Could not initialize mail server: " + oServer:GetErrorString( xRet )
    conout( cMsg )
    RestoreConf( cIniConf, cIniFile )
    return .F.
  endif
   
  // the method works for POP and IMAP, depending on the INI configuration
  xRet := oServer:SetPOPTimeout( nTimeout )
  if xRet != 0
    cMsg := "Could not set " + cProtocol + " timeout to " + cValToChar( nTimeout )
    conout( cMsg )
  endif
   
  if lIsPop == .T.
    xRet := oServer:POPConnect()
  else
    xRet := oServer:IMAPConnect()
  endif
   
  if xRet <> 0
    cMsg := "Could not connect on " + cProtocol + " server: " + oServer:GetErrorString( xRet )
    conout( cMsg )
  else
    lConnected := .T.
  endif
   
  if lConnected == .T.
    oServer:GetNumMsgs( @nMessages )
     
    cMsg := "Number of messages: " + cValToChar( nMessages )
    conout( cMsg )
     
    if nMessages > 0
      oMessage := TMailMessage():New()
       
      for nI := 1 to nMessages
        cMsg := "Receiving message " + cValToChar( nI )
        conout( cMsg )
         
        oMessage:Clear()
        xRet := oMessage:Receive( oServer, nI )
        if xRet <> 0
          cMsg := "Could not get message " + cValToChar( nI ) + ": " + oServer:GetErrorString( xRet )
          conout( cMsg )
           
          if xRet == 6 // error code for "No Connection"
            RestoreConf( cIniConf, cIniFile )
            return
          endif
        endif
      next nI
    endif
     
    if lIsPop == .T.
      xRet := oServer:POPDisconnect()
    else
      xRet := oServer:IMAPDisconnect()
    endif
     
    if xRet <> 0
      cMsg := "Could not disconnect from " + cProtocol + " server: " + oServer:GetErrorString( xRet )
      conout( cMsg )
    endif
  endif
   
  RestoreConf( cIniConf, cIniFile )
return