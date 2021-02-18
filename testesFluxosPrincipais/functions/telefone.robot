*** Settings ***
Documentation   TELEFONE
Resource        tab.robot

*** Keywords ***

Inserir Telefone
    [Arguments]                         ${id_campo}                     ${arguments}

    FOR     ${i}    IN RANGE    10

        Exit For Loop If                ${i} == 10
        Press Keys                      ${id_campo}                         ${arguments[${i}]}
        TAB                             ${id_campo}

    END
