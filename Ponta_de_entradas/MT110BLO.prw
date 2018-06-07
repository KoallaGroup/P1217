#Include 'Protheus.ch'

User Function MT110BLO()
//Local cUserNm := 'Administrador'
//Local cUserNm := SC1->C1_SOLICIT

Alert ( "Passou pelo ponto MT110BLO")
  


PswOrder(2)
//PswSeek(cUserId, .T.)

PswSeek(ALLTRIM(SC1->C1_SOLICIT), .T.)

aRetuser := PswRet(1)

Return




