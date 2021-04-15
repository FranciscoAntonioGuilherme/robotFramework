*** Settings ***
Documentation                           CATEGORIA
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page
#${btn_Buscar}                           id = btn-ghost table-head-action-button-btn

${nome_categoria}                       Categoria
${marca}                                RAV
${categoria}                            Limpeza
${subCategoria}                         TesteSubCategoria
${embalagem}                            Lata
${valor_medida}                         1
${unidade}                              mL
${estoque_min}                          12

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***

Clicar em configurações
    ${Configuracoes}=                   Execute JavaScript
    ...                                 return document.querySelectorAll(".label-sidebar")[6]
    Click Element                       ${Configuracoes}

Clicar em categoria
    Clicar em configurações
    Click Link                          CATEGORIA
    Carregando

Tentar salvar sem dados preenchidos
    CLick Button                        ${btn_Adicionar}    
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}

Adicionar nova categoria
    Input Text                          id = name                           ${nome_categoria}${SPACE}${date}
    Click Button                        Salvar
    Carregando

Buscar categoria criada
    ${btn_Lupa}                         Execute JavaScript
    ...                                 return document.querySelectorAll('.head-table-action-icon')
    Click Element                       ${btn_Lupa}

    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar categoria
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}
    Wait Until Element Is Visible       id = name
    Press Keys                          id = name                           ${SPACE}Editado
    Click Button                        Salvar
    Carregando

Excluir categoria criada
    Click Button                        ${btn_Buscar}
    Carregando

    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll(".button-generic-table")[1]
    Click Element                       ${element_exluir}   

    Click Button                        Sim
    Carregando
