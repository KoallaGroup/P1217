#include 'protheus.ch'
#include 'parmtype.ch'

User Function F241BTN()
Local aButtons:= paramixb

aAdd( aButtons ,{ "OBJETIVO",{|| alert("botão teste")},"Teste"," BR_VERMELHO"})


Return aButtons

User Function F240BTN()
Local aButtons:= paramixb

aAdd( aButtons ,{ "OBJETIVO2",{|| alert("botão teste")},"Teste","F240BTN"})


Return aButtons