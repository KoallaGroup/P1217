#Include 'Protheus.ch'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH" // BIBLIOTECA
 
User Function Auto_160()
Local aAutoCab := {} // Array do cabecalho: 1-SC8->C8_NUM 2-comprador
Local aAutoItm := {} // Array dos itens da cotacao
Local nIndItem := 1
Local lOk := .T.
Local cNumCotacao := ""
PRIVATE lMSErroAuto := .F.
PRIVATE lAutoErrNoFile:= .T.
 
//------------------------
//| Abertura do ambiente|
//------------------------
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" //informe o codigo da empresa e da filial
 
conout("Inicio") // exibe no console do servidor
cNumCotacao := "000002" // informe aqui o numero da cotacao a ser analisada
 
dbSelectArea("SC8")
dbSetOrder(1)
If !DbSeek(xFilial("SC8")+cNumCotacao) // FILIAL + NUM. COTACAO
    conout("Falha! Gerar e atualizar cotacao " +cNumCotacao+" ! ")
    conout("Fim")
    lOk := .F.
Endif
 
If lOk
 
    conout("Iniciando exemplo de 5 propostas para a cotacao "+ cNumCotacao+".")
    aAdd(aAutoCab,{"C8_NUM",cNumCotacao,NIL}) // numero da solicitatacao de compras que gerou a(s) cotacao(oes)
    aAdd(aAutoCab,{"COMPACC","Administrador",NIL}) // nome do comprador
 
 
    // Deve-se fornecer os dados completos APENAS DO FORNECEDOR VENCEDOR!
    // No caso especifico desse ExecAuto, o fornecedor vencedor das cotacoes eh o "004 ".
    // Os tamanhos dos campos da tabela SCE devem ser respeitados.
    // O array de itens (aAutoItn) deve ter comprimento igual a quantidade de cotacoes existentes para a solicitacao de compras (nesse caso, 5)
    // Os dados do fornecedor vencedor devem ser declarados na primeira posicao do vetor aAutoItm
 
    aadd(aAutoitm,{})
    aAdd(aAutoItm[nIndItem],{})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_ITEMCOT","0001",NIL}) //item da cotacao
    aAdd(atail(aAutoItm[nIndItem]),{"CE_FORNECE","1",NIL}) //informe o codigo do fornecedor, respeitando o tamanho exato do campo
    aAdd(atail(aAutoItm[nIndItem]),{"CE_LOJA","1",NIL}) // loja do fornecedor
    aAdd(atail(aAutoItm[nIndItem]),{"CE_NUMPRO","01",NIL}) // numero da proposta
    aAdd(atail(aAutoItm[nIndItem]),{"CE_QUANT",500,NIL}) // quantidade
 /*
  conout( "Passou 1")
    nIndItem++
    aadd(aAutoitm,{})
    aAdd(aAutoItm[nIndItem],{})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_ITEMCOT","0001",NIL}) //item da cotacao (OBRIGATORIO)
    aAdd(atail(aAutoItm[nIndItem]),{"CE_FORNECE","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_LOJA","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_NUMPRO","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_QUANT",,NIL})
 conout( "Passou 2")
    nIndItem++
    aadd(aAutoitm,{})
    aAdd(aAutoItm[nIndItem],{})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_ITEMCOT","0001",NIL}) //item da cotacao (OBRIGATORIO)
    aAdd(atail(aAutoItm[nIndItem]),{"CE_FORNECE","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_LOJA","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_NUMPRO","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_QUANT",,NIL})
  conout( "Passou 3")
    nIndItem++
    aadd(aAutoitm,{})
    aAdd(aAutoItm[nIndItem],{})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_ITEMCOT","0001",NIL}) //item da cotacao (OBRIGATORIO)
    aAdd(atail(aAutoItm[nIndItem]),{"CE_FORNECE","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_LOJA","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_NUMPRO","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_QUANT",,NIL})
 conout( "Passou 4") 
    nIndItem++
    aadd(aAutoitm,{})
    aAdd(aAutoItm[nIndItem],{})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_ITEMCOT","0001",NIL}) //item da cotacao (OBRIGATORIO)
    aAdd(atail(aAutoItm[nIndItem]),{"CE_FORNECE","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_LOJA","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_NUMPRO","",NIL})
    aAdd(atail(aAutoItm[nIndItem]),{"CE_QUANT",,NIL}) */
 conout( "Passou 5") 
    //ExecAuto
    MSExecAuto({|x,y,z| MATA160(,x,,y,z)},6,aAutoCab,aAutoItm)
 
    If lMsErroAuto
        conout("Erro na analise da cotacao " + cNumCotacao +" !")
        Mostraerro()
    Else
        Alert("SUCESSO!") 
        conout("Cotacao " + cNumCotacao + " analisada com sucesso!")
    Endif
Endif
 
RESET ENVIRONMENT
Return