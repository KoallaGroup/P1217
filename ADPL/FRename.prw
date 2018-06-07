#include 'protheus.ch'
#include 'parmtype.ch'
#include 'fileio.ch'

user function tstFRename()
	
// Neste exemplo, a função é utilizada para 3 finalidades diferentes, observe:

  // Renomeando um arquivo no Client de origem.txt para destino.txt , na pasta c:\Temp
 /* nStatus1 := frename('c:\Temp\Origem.txt' , 'c:\Temp\Destino.txt' )
  IF nStatus1 == -1
   MsgStop('Falha na operação 1 : FError '+str(ferror(),4))
  Endif*/
  // Renomeando um arquivo no servidor, na pasta sigaadv, de error.log para error.old
  nStatus2 := frename('\system\error.log' , '\system\error_antigo.log' )
  IF nStatus2 == -1
   MsgStop('Falha na operação 2 : FError '+str(ferror(),4))
  Endif
  // Movendo um arquivo no estação, da pasta Raiz para a pasta c:\Temp , alterando também o nome do arquivo.
  /*nStatus3 := frename('c:\Lista.txt','c:\Temp\OldLista.txt')
  IF nStatus3 == -1
   MsgStop('Falha na operação 3 : FError '+str(ferror(),4))
  Endif*/
Return


