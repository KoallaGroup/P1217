#include 'protheus.ch'
#include 'parmtype.ch'

user function myftp()


Local cDirL  :="\ftp\"
Local cDirR  :="AdvPL/gil/"
Local cServer  :="ftp.totvs.com.br"
Local cUser  := "ftpacr"
Local cPass  := "ftp4785"
Local cFile  :="*.txt"
Local lCompacta := .T.

Local aRetDir := {}
//Tenta se conectar ao servidor ftp em localhost na porta 21
//com usuario e senha anonimos
if ! FTPCONNECT ( cServer , 21 ,cUser, cPass )
 conout( "Nao foi possivel se conectar!!" )
 Return NIL
EndIf
//Tenta mudar do diretorio corrente ftp, para o diretorio
//especificado como parametro
if ! FTPDIRCHANGE ( cDirR )
 conout( "Nao foi possivel modificar diretório!!" )
 Return NIL
EndIf
//Retorna apenas os arquivos contidos no local
aRetDir := FTPDIRECTORY ( "*.txt" , )

//Verifica se o array esta vazio
If Empty( aRetDir )
 conout( "Array Vazio!!" )
 Return NIL
EndIf
//Tenta realizar o download de um item qualquer no array
//Armazena no local indicado pela constante PATH
if ! FTPDOWNLOAD( cDirL + aRetDir[1][1], aRetDir[1][1])
 conout( "Nao foi possivel realizar o download!!" )
 Return NIL
EndIf
//CpyS2T( cDirL+'sgv.txt', "C:\testeFTP\", lCompacta )// Copia para diretório local
//Tenta renomear um arquivo ou diretorio
if ! FTPRENAMEFILE ( aRetDir[1][1] , "novo" )
 conout( "Nao foi possivel renomear o arquivo!!" )
 Return NIL
EndIf

//Tenta desconectar do servidor ftp
FTPDISCONNECT ()

Return