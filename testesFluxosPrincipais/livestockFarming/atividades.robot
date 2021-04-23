*** Settings ***
Documentation   Suite ATIVIDADE

Resource        ../functions/carregando.robot

*** Variables ***
&{ANIMAL}                               tipo=""
...                                     numero=asdf28102020
...                                     racas=Nelore
...                                     nascimento=26092020
...                                     sexo=M
...                                     castrado=false
...                                     ecc=100
...                                     primeiraPesagem=01112020
...                                     primeiroPeso=9089
...                                     ecc=390
...                                     numeroPai=asdf pai
...                                     numeroMae=asdf mae

*** Keywords ***
Clicar em atividades
    Click Link                          Atividades

Clicar em nova atividade
    # Click Button                        class = btn-primario
    Click Button                        Nova Atividade
