*** Settings ***
Documentation                           Modulo Gestão
Resource                                ../funcoes/carregando.robot

*** Keywords ***
Clicar em gestao
    Carregando
    ${url}=   Get Location

    Run Keyword if      '${url}'=='${Home Page}'        Click Link                          Gestão
    ...                     ELSE        Click Element        class = gestao
