#include 'protheus.ch'
#include 'parmtype.ch'

User Function F241BTN()
Local aButtons:= paramixb

aAdd( aButtons ,{ "OBJETIVO",{|| alert("bot�o teste")},"Teste"," BR_VERMELHO"})


Return aButtons

User Function F240BTN()
Local aButtons:= paramixb

aAdd( aButtons ,{ "OBJETIVO2",{|| alert("bot�o teste")},"Teste","F240BTN"})


Return aButtons