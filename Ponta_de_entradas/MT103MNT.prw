#include 'protheus.ch'
#include 'parmtype.ch'

user function MT103MNT()


Local aHeadSev := PARAMIXB[1]

Local aColsSev := PARAMIXB[2]///  carga do aColsSev ///

conout("Passou pelo PE MT103MNT")

Return aColsSev
