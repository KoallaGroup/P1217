#include "rwmake.ch"
#include "topconn.ch"
#Include "PROTHEUS.CH"
#Include 'ap5Mail.ch'
#DEFINE cCRLF CHR(13)+CHR(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA030TOK  �Autor  �Antonio Carlos L F  � Data �  14/07/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada executado na confirma��o de altera��o do   ���
���          �cliente                                                     ���
�������������������������������������������������������������������������͹��
���Uso       �Utilizado para startar re-processamento de cliente quando   ���
���          �este sofrer altra��es.                                      ���
�������������������������������������������������������������������������͹��     
���          �            Contribuinte, pois existe essa situacao         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MA030TOK()

Local cMsg := "teste de erro"
Local lRet := .T.

If ! Empty( cMsg )
   Aviso('Makita', cMsg,{'OK'},2,'Aten��o !!! ') 
   alert ("Erro")
   conout( "Erro Console")
   lRet := .F.
EndIf 


Return lRet
