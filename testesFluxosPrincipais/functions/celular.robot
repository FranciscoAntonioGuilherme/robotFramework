*** Settings ***
Documentation   CELULAR
Resource        tab.robot

*** Keywords ***

Inserir Celular
    [Arguments]                         ${id_campo}                     ${arguments}

    FOR     ${i}    IN RANGE    11

        Exit For Loop If                ${i} == 11
        Press Keys                      ${id_campo}                         ${arguments[${i}]}
        TAB                             ${id_campo}

    END
