#include 'protheus.ch'
#include 'parmtype.ch'

user function MT120BRW()


//Define Array contendo as Rotinas a executar do programa     
// ----------- Elementos contidos por dimensao ------------    
// 1. Nome a aparecer no cabecalho                             
// 2. Nome da Rotina associada                                 
// 3. Usado pela rotina                                        
// 4. Tipo de Transa‡„o a ser efetuada                         
//    1 - Pesquisa e Posiciona em um Banco de Dados            
//    2 - Simplesmente Mostra os Campos                        
//    3 - Inclui registros no Bancos de Dados                  
//    4 - Altera o registro corrente                           
//    5 - Remove o registro corrente do Banco de Dados         
//    6 - Altera determinados campos sem incluir novos Regs     


alert("Passou pelo MT120BRW")

AAdd( aRotina, { 'TESTE', "U_TMT120", 0, 4 } )



return


user function TMT120()

alert ("Filial de Entrada Corrente "+SC7->C7_FILENT)


SC7->C7_FILENT := '02'


return



