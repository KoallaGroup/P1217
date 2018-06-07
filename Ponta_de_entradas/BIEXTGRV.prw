#Include 'Protheus.ch'
#include 'parmtype.ch'


User Function BIEXTGRV
    Local cAlias        := PARAMIXB[1]
    Local aRecord       := PARAMIXB[2]
    Local lDimension    := PARAMIXB[3]
    Local aSaveAlias    := SD1->(GetArea())
    Local nLivre0       := 0
  
    //Verifica a tabela que está sendo processada.
    If ( cAlias == "HL6" )
      //varinfo("aRecord",aRecord) 
       //Localiza a posição dos campos desejados no conteúdo recebido no parâmetro PARAMIXB[2].
        nLivre0 := aScan( aRecord, {|x| AllTrim( x[1] ) == cAlias + "_LIVRE0" } )
        varinfo("nLivre0",nLivre0)
        nCod    := aScan( aRecord, {|x| AllTrim( x[1] ) == "HL6_NUMDEV" } )
        varinfo("nCod",nCod)
        SD1->(DBSetOrder(1))
        //Localiza o conteúdo desejado na tabela SA1 e grava no campo livre desejado.
        If ( SD1->( DBSeek( xFilial("SD1") + Padr( aRecord[nCod][2], TamSX3( "D1_DOC")[1] )  ) ) )
            aRecord[nLivre0][2] := SD1->D1_CF
            varinfo("aRecord[nLivre0][2]",aRecord[nLivre0][2])
        EndIf
        RestArea(aSaveAlias)
    EndIf
Return aRecord

