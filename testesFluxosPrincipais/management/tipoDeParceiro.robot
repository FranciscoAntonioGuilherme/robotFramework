*** Settings ***
Documentation                           SUBCATEGORIA
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page

${nome_tipoDeParceiro}                  Freelancer 

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***

Clicar em configurações
    ${Configuracoes}=                   Execute JavaScript
    ...                                 return document.querySelectorAll(".label-sidebar")[6]
    Click Element                       ${Configuracoes}

Clicar em tipo de parceiro

    ${element_subItem}                  Execute JavaScript
    ...                                 return document.querySelectorAll('.item-subItem')[2]

    ${subItem_present}=                 Run Keyword And Return Status
    ...                                 Element Should Be Visible           ${element_subItem}

    Run Keyword Unless                  ${subItem_present}                  tipoDeParceiro.Clicar em configurações
    Click Link                          TIPO DE PARCEIROS
    Carregando

Tentar salvar sem dados preenchidos
    CLick Button                        ${btn_Adicionar}
    Wait Until Element Is Visible       id = name
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}

Adicionar novo tipo de parceiro
    Input Text                          id = name                           ${nome_tipoDeParceiro}${SPACE}${date}
    Click Button                        Salvar
    Carregando

Buscar tipo de parceiro
    Carregando
    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar tipo de parceiro
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}

    Wait Until Element Is Visible       id = name
    Press Keys                          id = name                           ${SPACE}Editado
    Click Button                        Salvar
    Carregando

Excluir tipo de parceiro criado
    Click Button                        ${btn_Buscar}
    Carregando

    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll(".button-generic-table")[1]
    Click Element                       ${element_exluir}   

    Click Button                        Sim
    Carregando
