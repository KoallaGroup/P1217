#include 'protheus.ch'
#include 'parmtype.ch'
#include "Fileio.ch"
#INCLUDE "XMLXFUN.CH"
#define F_BLOCK  512


user function MyXML()
	
Local cError   := ""
Local cWarning := ""
Local oXml := NIL


//Gera o Objeto XML
oXml := XmlParser( GeraXML(), "_", @cError, @cWarning )
If (oXml == NIL )
	MsgStop("Falha ao gerar Objeto XML : "+cError+" / "+cWarning)
	Return
Endif

// Mostrando a informação do Node
MsgInfo(oXml:_PEDIDO:_NOME_CLIENTE:Text,"Cliente")

SAVE oXml XMLFILE "\teste1.xml"


Return oXml

// função para gerar uma string contendo um xml
Static Function GeraXML()
Local cScript
cScript := '<?xml version="1.0" encoding="ISO-8859-1"?>'
cScript += "<pedido>"
cScript += "    <Nome_Cliente>Microsiga Software</Nome_Cliente>"
cScript += "    <Endereco>Av. Braz Leme</Endereco>"
cScript += "    <Numero>1361</Numero>"
cScript += "    <Data>22-03-2005</Data>"
cScript += "    <Itens>"
cScript += "        <Item>"
cScript += "            <Produto>Protheus</Produto>"
cScript += "            <Quantidade>1</Quantidade>"
cScript += "            <Preco>100.00</Preco>"
cScript += "        </Item>"
cScript += "    </Itens>"
cScript += "</pedido>"
Return cScript

/*No exemplo abaixo, usamos um conteudo com caracteres acentuados e caracteres especiais para ser colocado dentro
de um node XML. Utilizamos as funcoes EncodeUTF8() para gerar um conteudo adequado à codificação do XML, e uma
função de framework _NoTags() para transformar eventuais tags interpretaveis que possam existir dentro do conteúdo
para serem representadas como conteudo do node XML*/

User Function XMLEnc()
Local cNome    := 'A&B-ZÃO LTDA'
Local cXml     := ""
Local cErro    := ""
Local cAviso   := ""
cXml += '<?xml version="1.0" encoding="UTF-8"?>'
cXml += "<Teste>"
cXml += EncodeUTF8( _NoTags( cNome ) )
cXml += "</Teste>"
conout("XML Original....:")
conout(cXml)
oXml := XmlParser(cXml,"_",@cErro,@cAviso)
MsgInfo(oXml:_TESTE:TEXT , "Conteudo" )
Return

 

RETURN NIL