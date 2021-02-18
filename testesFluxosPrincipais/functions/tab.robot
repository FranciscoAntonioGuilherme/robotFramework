*** Settings ***
Documentation    TAB

*** Keywords ***
TAB
    [Arguments]                         ${id_campo}

    Press Keys                          ${id_campo}                       \ue004
