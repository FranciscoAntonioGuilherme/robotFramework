*** Settings ***
Documentation                           SUBCATEGORIA
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page

${nome_subcategoria}                    SubCategoria

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***

Clicar em configurações
    ${Configuracoes}=                   Execute JavaScript
    ...                                 return document.querySelectorAll(".label-sidebar")[6]
    Click Element                       ${Configuracoes}

Clicar em subcategoria

    ${element_subItem}                  Execute JavaScript
    ...                                 return document.querySelectorAll('.item-subItem')[1]

    ${subItem_present}=                 Run Keyword And Return Status
    ...                                 Element Should Be Visible           ${element_subItem}

    Run Keyword Unless                  ${subItem_present}                  subcategoria.Clicar em configurações
    Click Link                          SUBCATEGORIA
    Carregando

Tentar salvar sem dados preenchidos
    CLick Button                        ${btn_Adicionar}    
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_categoria}=        Get webElement                      name = invalid-feedback-category_id
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_categoria.text}    ${erro_campo_vazio}

Adicionar nova subcategoria
    Input Text                          id = name                           ${nome_subcategoria}${SPACE}${date}

    Click Element                       id = category_id-mirror
    Press Keys                          id = category_id-mirror             DOWN
    Press Keys                          id = category_id-mirror             ENTER

    Click Button                        Salvar
    Carregando

Buscar subcategoria criada
    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar subcategoria
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}

    Wait Until Element Is Visible       id = name
    Press Keys                          id = name                           ${SPACE}Editado

    Click Element                       id = category_id-mirror
    Press Keys                          id = category_id-mirror             DOWN
    Press Keys                          id = category_id-mirror             ENTER

    Click Button                        Salvar
    Carregando

Excluir subcategoria criada
    Click Button                        ${btn_Buscar}
    Carregando

    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll(".button-generic-table")[1]
    Click Element                       ${element_exluir}   

    Click Button                        Sim
    Carregando
