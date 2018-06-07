#include 'protheus.ch'
#include 'parmtype.ch'

USER FUNCTION AxCad()

 

PRIVATE cCadastro  := "Autor/Interprete"

PRIVATE aRotina     := {}

 

AxCadastro("ZA0", OemToAnsi(cCadastro), 'U_A100VldExcl()')

 

Return Nil