*** Settings ***
Documentation                           Modulo Pecuária
Resource                                ../functions/carregando.robot

*** Keywords ***

Clicar em pecuaria
    Carregando
    ${url}=   Get Location

    Run Keyword if      '${url}'=='${Home Page}'        Click Link                          Pecuária
    ...                     ELSE        Click Element        class = pecuaria

    Carregando
