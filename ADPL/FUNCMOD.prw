#include 'protheus.ch'
#include 'parmtype.ch'
	
#DEFINE CRLF Chr(13)+Chr(10)
User Function Exemplo()
Local cMensagem := ""
//+----------------------------------------------------------------------------+
//|Exemplifica o uso da função Mod                                             |
//+----------------------------------------------------------------------------+
  cMensagem += "Mod(-3, -2) = "   + cValToChar(Mod(-3, -2))  + CRLF
  cMensagem += "Mod(-6, -3) = "   + cValToChar(Mod(-6, -3))  + CRLF
  cMensagem += "Mod(-9, -4) = "   + cValToChar(Mod(-9, -4))  + CRLF
  cMensagem += "Mod(-12, -5) = "  + cValToChar(Mod(-12, -5)) + CRLF
  cMensagem += "Mod(-16, -6) = "  + cValToChar(Mod(-16, -6)) + CRLF
  cMensagem += "Mod(-20, -7) = "  + cValToChar(Mod(-20, -7)) + CRLF
  cMensagem += "Mod(0, -1) = "    + cValToChar(Mod(0, -1))   + CRLF
  cMensagem += "Mod(3, -2) = "    + cValToChar(Mod(3, -2))   + CRLF
  cMensagem += "Mod(6, -3) = "    + cValToChar(Mod(6, -3))   + CRLF
  cMensagem += "Mod(9, -4) = "    + cValToChar(Mod(9, -4))   + CRLF
  cMensagem += "Mod(12, -5) = "   + cValToChar(Mod(12, -5))  + CRLF
  cMensagem += "Mod(16, -6) = "   + cValToChar(Mod(16, -6))  + CRLF
  cMensagem += "Mod(20, -7) = "   + cValToChar(Mod(20, -7))  + CRLF
  cMensagem += "Mod(0, 1) = "     + cValToChar(Mod(0, 1))    + CRLF
  cMensagem += "Mod(3, 2) = "     + cValToChar(Mod(3, 2))    + CRLF
  cMensagem += "Mod(6, 3) = "     + cValToChar(Mod(6, 3))    + CRLF
  cMensagem += "Mod(9, 4) = "     + cValToChar(Mod(9, 4))    + CRLF
  cMensagem += "Mod(12, 5) = "    + cValToChar(Mod(12, 5))   + CRLF
  cMensagem += "Mod(16, 6) = "    + cValToChar(Mod(16, 6))   + CRLF
  cMensagem += "Mod(20, 7) = "    + cValToChar(Mod(20, 7))
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
Return MsgInfo(cMensagem, "Mod - Exemplo")