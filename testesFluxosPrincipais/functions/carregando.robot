*** Settings ***
Documentation    Carregar

*** Keywords ***
Carregando
    Wait Until Element Is Not Visible       carregando          timeout=60

Esperar carregar
    Wait Until Element Is Visible           carregando          timeout=10

zz
    Wait Until Element Is Not Visible       carregando          timeout=60