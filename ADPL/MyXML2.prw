#include 'protheus.ch'
#include 'parmtype.ch'

user function MyXML2()

  Local cXML := "", cNewXML := ""
  Local oXML
   
  oXML := TXMLManager():New()
   
  cXML := '<?xml version="1.0"?>' + Chr( 10 )
  cXML += '<book isNew="true">' + Chr( 10 )
  cXML += '  <title>A Clash of Kings</title>' + Chr( 10 )
  cXML += '  <author>George R. R. Martin</author>' + Chr( 10 )
  cXML += '  <price>9.99</price>' + Chr( 10 )
  cXML += '  <origin>US</origin>' + Chr( 10 )
  cXML += '</book>' + Chr( 10 )
   
  if !oXML:Parse( cXML )
    conout( "Errors on Parse!" )
    return
  endif
   
  cNewXML := oXML:Save2String()
   
  // Vai exibir ".T."
  conout( cNewXML == cXML )
   
  oXML:XPathAddNode( "/book", "hardcover", "no" )
   
  cNewXML := oXML:Save2String()
   
  // Vai exibir ".F."
  conout( cNewXML == cXML )
   
  // Vai exibir
  // <?xml version="1.0"?>
  // <book isNew="true">
  //   <title >A Clash of Kings</title>
  //   <author>George R. R. Martin</author>
  //   <price>9.99</price>
  //   <origin>US</origin>
  // <hardcover>no</hardcover></book>
  conout( cNewXML )
return	
