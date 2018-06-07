#Include 'RwMake.ch'
#Include 'Protheus.ch'
#Include 'TopConn.ch'

/*
+------------------------------------------------------------------------+
¦Programa  ¦M460MARK   ¦ Autor ¦ Henrique (Allianca)  ¦ Data ¦28/05/2015 ¦
+----------+-------------------------------------------------------------+
¦Descriçào ¦P.E. Validacao Selecao / Marcacao Ped Venda p/ Ger. NF Saida.¦
+----------+-------------------------------------------------------------+
¦ Uso      ¦Especifico Allianca Consultoria / FAT - Faturamento.         ¦
+------------------------------------------------------------------------+
|                  Documentacao Eletronica Totvs - Protheus Doc          |
+------------------------------------------------------------------------+
|{Protheus.doc} M460MARK (MATA460A)                                      | 
| P.E. Validacao Selecao / Marcacao Pedidos de Vendas p/ Geracao das     |
| Notas Fiscais Saida, mediante disponibilidade de Saldo em Estoque dos  |
| Produtos destes respectivos Pedidos do Cliente Nova Allianca / Modulo  |
| Embalagens.                                                            |
|                                                                        |
|Pasta - \Novos Projetos\Faturamento\P. Entradas\M460MARK.prw            |
|                                                                        |
| @Author	Henrique (Nova Allianca)                                     |
| @Since	28/05/2015                                                   |
| @Version	11.1.1.1.3                                                   |
| @Return Nil                                                            |
+------------------------------------------------------------------------+
¦           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL             ¦
+------------------------------------------------------------------------¦
¦ANALISTA    ¦ DATA   ¦ ALTERAÇÃO                                        ¦
+------------+--------+--------------------------------------------------¦
¦Maurilio    ¦10/04/16|Melhoria Interna P.E. M460MARK sob Orientacao do  ¦
¦Reis        ¦        ¦Claudio Athayde (Nova Allianca).                  ¦
+------------+--------+--------------------------------------------------+
|Maurilio    |18/04/16|Implementar Leitura Saldos Fisicos e Financeiros  |
|Reis        |        | do Produto, via Tab SB2 / Campo: B2_QATU.        |
+------------+--------+--------------------------------------------------+
|Maurilio    |25/04/16|Tentativa Correcao Posicionamento Tabela SC9 e Ve-|
|Reis        |        |rificao Saldo Itens de TODOS os Pedidos Selecionad|
+------------+--------+--------------------------------------------------+
|Maurilio    |25/04/16|Mudanca Regra Calculo Saldo Atual/Real em Estoque |
|Reis        |        |do Produto em Pedido Venda mesmo que Lib. Est/Cred|
+------------+--------+--------------------------------------------------+
|Maurilio    |26/04/16|Agrupado Qtdes Produtos Por: Pedido + Produto +   |
|Reis        |        |Almox. Alteracao Query Principal Campos SC9.      |
+------------+--------+--------------------------------------------------+
|            |        |                                                  |
|            |        |                                                  |
+------------+--------+--------------------------------------------------+
*/

User Function M460MARK()   
 
//Declaracao Variaveis.
Local aArea       := GetArea()
Private cIteMark  := ThisMark()
Private lRetMark  := .T.

//Se P.E. 'M460MARK' Nao Ativado --> Abortar !!! 
If AllTrim(SuperGetMv( "MA_M460MAR" , .F. , "2")) == "2" //Inativo ...

   //Restaura Ambiente Origem.
   RestArea(aArea)
   Return(lRetMark)
EndIf

//Somente Verificar Saldos em Estoque para a Empresa: '01' ...
If AllTrim(SM0->M0_CODIGO) $ '99'
   
   //Funcao Buscar Status Estoques ...
   lRetMark := FVerEst(cIteMark)
EndIf

//Restaura Ambiente Origem.
RestArea(aArea)

Return(lRetMark)

/****************************************************************************************************************************************************
* Static Function Funcao Verificar / Buscar Informacoes de Saldo em Estoque de Itens Pedidos de Venda - Especifico Cliente Allianca Consultoria.
* Maurilio Reis - 10/04/16 - 22:14 h
****************************************************************************************************************************************************/
Static Function FVerEst(cIteMark)

//Declaracao Variaveis.
Local aArea    := GetArea()
Local aAreaSC9 := SC9->(GetArea())
Local cAliSC9  := GetNextAlias()
Local cQrySC9  := ''
Local lRetSC9  := .T.
Local nRetSC9  := 0
Local cDscSC9  := ''
Local nRecSB2  := SB2->(RecNo())
Local nRecSC9  := SC9->(RecNo())

//Montagem Query SQL Buscar Dados Tabelas: SC9, SC6 e SF4 ...
cQrySC9 := "SELECT SC9.C9_OK, SC9.C9_FILIAL, SC9.C9_PEDIDO, SC9.C9_PRODUTO, SC9.C9_LOCAL, SC9.C9_CLIENTE, SC9.C9_LOJA, SC6.C6_TES, SF4.F4_CODIGO,    "
cQrySC9 += "       SF4.F4_ESTOQUE, SUM(SC9.C9_QTDLIB) C9_QTDLIB                                                                                      "
cQrySC9 += "FROM "+RetSqlName('SC9')+" SC9 INNER JOIN "+RetSqlName('SC6')+" SC6 ON (SC9.C9_FILIAL = SC6.C6_FILIAL AND SC9.C9_PEDIDO = SC6.C6_NUM AND "
cQrySC9 += "SC9.C9_ITEM = SC6.C6_ITEM AND SC9.C9_PRODUTO = SC6.C6_PRODUTO AND SC9.C9_CLIENTE = SC6.C6_CLI AND SC9.C9_LOJA = SC6.C6_LOJA)             "
cQrySC9 += "INNER JOIN "+RetSqlName('SF4')+" SF4 ON (SC6.C6_TES = SF4.F4_CODIGO)                                                                     "
cQrySC9 += "WHERE SC9.D_E_L_E_T_ <> '*' AND SC6.D_E_L_E_T_ <> '*' AND SF4.D_E_L_E_T_ <> '*' AND SF4.F4_FILIAL = '"+AllTrim(xFilial("SF4"))+"'    AND "
cQrySC9 += "      SC9.C9_FILIAL = '"+AllTrim(xFilial('SC9'))+"' AND SC9.C9_OK = '"+AllTrim(cIteMark)+"' AND SC9.C9_NFISCAL = ' '                     "
cQrySC9 += "GROUP BY SC9.C9_OK, SC9.C9_FILIAL, SC9.C9_PEDIDO, SC9.C9_PRODUTO, SC9.C9_LOCAL, SC9.C9_CLIENTE, SC9.C9_LOJA, SC6.C6_TES, SF4.F4_CODIGO,  "
cQrySC9 += "         SF4.F4_ESTOQUE                                                                                                                  "
cQrySC9 += "ORDER BY SC9.C9_OK, SC9.C9_FILIAL, SC9.C9_PEDIDO, SC9.C9_PRODUTO, SC9.C9_LOCAL, SC9.C9_CLIENTE, SC9.C9_LOJA, SC6.C6_TES, SF4.F4_CODIGO,  "
cQrySC9 += "         SF4.F4_ESTOQUE                                                                                                                  "

//Formatar Query SQL p/ SGBD utilizado: MSSQL ...
cQrySC9 := ChangeQuery(cQrySC9)

//Se Alias Tabela Temporaria Alias 'cAliSC9' ainda Aberto --> Fechar !!!
If (Select(cAliSC9) > 0)
   DbSelectArea(cAliSC9)
   (cAliSC9)->(DbCloseArea())
EndIf

//Re-Abrindo Area Arquivo Trabalho Temporario Alias 'cAliSC9' ...
DbUseArea( .T., 'TOPCONN', TcGenQry(,, cQrySC9), cAliSC9, .T., .T. )

//Ajustando Campos do Tipo: Numero ...
TCSetField(cAliSC9, 'C9_QTDLIB'  , 'N', TamSX3('C9_QTDLIB')[1] , TamSX3('C9_QTDLIB')[2])

//Reposicionando Area Arquivo Trabalho Temporario Alias 'cAliSC9' ...
DbSelectArea(cAliSC9)
(cAliSC9)->(DbGoTop())

//Se Final Arquivo No Arquivo Trabalho Temporario Alias 'cAliSC9' ...
If (cAliSC9)->(Eof())

   //Mensagem ao Usuario ...
   Aviso(OemToAnsi('Atenção ...'),OemToAnsi('Saldo(s) do(s) Produto(s) NÃO Encontrado(s) em Estoque ! Gentileza Acionar TI !!!'),{'Ok'}) 
   lRetSC9 := .F.
   
   //Restaura Ambiente Origem.
   If (Select('SC9') > 0)
      DbSelectArea('SC9')
      SC9->(MsGoTo(nRecSC9))
   EndIf
   
   If (Select(cAliSC9) > 0)
      DbSelectArea(cAliSC9)
      (cAliSC9)->(DbCloseArea())
   EndIf 
   
   RestArea(aAreaSC9)
   RestArea(aArea)
   Return(lRetSC9)
EndIf

//Reposicionando Novamente Area Arquivo Trabalho Temporario Alias 'cAliSC9' ...
DbSelectArea(cAliSC9)
(cAliSC9)->(DbGoTop())

//Setando Regua Processamento ...
ProcRegua(RecCount(cAliSC9))

//Varrendo Arquivo Trabalho Temporario Alias 'cAliSC9' ...
While (cAliSC9)->(!Eof())

      //Se Codigo TES Atualiza Estoque p/ Item Pedido Venda ...
      If AllTrim((cAliSC9)->F4_ESTOQUE) $ 'S' //S - Sim ...      
         
         //Abrindo Area Arquivo Trabalho Temporario SB2 - Saldos Fisicos e Financeiros ...
         DbSelectArea('SB2')
         SB2->(DbSetOrder(1)) //Filial+CodigoProduto+LocalPadrao.
         SB2->(MsSeek(xFilial('SB2')+(cAliSC9)->C9_PRODUTO+(cAliSC9)->C9_LOCAL))
         
         //Funcao Padrao Calculo Saldos em Estoques ...
         //Comentado Por Maurilio Reis - 25/04/16 - 00:22 h - Pos-Orientacoes Marcos Vinicius - Via E-mail & Video - 25/04/16 - 09:16 h.
         //nRetSC9 := IIF(SB2->B2_QATU > 0,SB2->B2_QATU,CalcEst((cAliSC9)->C9_PRODUTO,(cAliSC9)->C9_LOCAL,dDataBase + 1,(cAliSC9)->C9_FILIAL)[1])
         //----------------------------------------------------------------------------------------------------------------------------------------
         nRetSC9 := SB2->B2_QATU - (cAliSC9)->C9_QTDLIB
      
         //Se Saldo Negativo ... Envia Mensagem ao Usuario ...
         If (nRetSC9 < 0)
            //Montagem Mensagem ao Usuario ...
            cDscSC9 += OemToAnsi('Sld Produto: ' + AllTrim((cAliSC9)->C9_PRODUTO) + ' Referente ao Pedido N.: ' +; 
                       AllTrim((cAliSC9)->C9_PEDIDO) + ' é Insuficiente: ' + AllTrim(TRANSFORM(nRetSC9,PesqPict('SB2','B2_QATU')))) + '.' + Chr(13) + Chr(10)
            lRetSC9 := .F.
         EndIf
      EndIf
      
      DbSelectArea(cAliSC9)
      (cAliSC9)->(DbSkip())
EndDo

//Caso Retorno Impeditivo ... Mensagem ao Usuario ...
If !(lRetSC9)
   Aviso(OemToAnsi('Atenção ...'),AllTrim(cDscSC9),{'Ok'},2)
EndIf

//Restaura Ambiente Origem.

//Reposicionando Area Arquivo Trabalho SC9 ...
If (Select('SC9') > 0)
   DbSelectArea('SC9')
   SC9->(MsGoTo(nRecSC9))
EndIf

If (Select('SB2') > 0)
   DbSelectArea('SB2')
   SB2->(MsGoTo(nRecSB2))
EndIf

If (Select(cAliSC9) > 0)
   DbSelectArea(cAliSC9)
   (cAliSC9)->(DbCloseArea())
EndIf

RestArea(aAreaSC9)
RestArea(aArea)

Return(lRetSC9)


/*
1 - Criacao Novo Parametro Sistema (SX6).

Filial Nome Variavel Tipo Conteudo                                     Descricao
 N/A    MA_M460MAR    C     "1"     Ativa ou Desativa P.E. M460MARK no Ambiente Cliente Nova Allianca. (1 = Ativa ou 2 = Inativa).
 N/A    MV_TPSALDO    C     "Q"     Tipo de Saldo a ser considerado nos movimentos internos: (S) Utiliza a funcao SaldoSB2(), 
                                    (Q) Utiliza o valor B2_QATU-B2_QACLASS-B2_RESERVA, (C) Utiliza o saldo proveniente da função CalcEst()
 N/A    MV_ESTNEG     C     "N"     Identifica se o sistema permitira que os saldos em estoque dos produtos fique negativo atraves de
                                    movimentacao. Conteudo deve ser (S)im ou (N)ao.
*/