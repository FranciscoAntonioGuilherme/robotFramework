*** Settings ***
Documentation                           SUBCATEGORIA
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page

${nome_tipoDeParceiro}                  SubCategoria

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***

Clicar em configurações
    ${Configuracoes}=                   Execute JavaScript
    ...                                 return document.querySelectorAll(".label-sidebar")[6]
    Click Element                       ${Configuracoes}

Clicar em tipo de parceiro

    ${element_subItem}                  Execute JavaScript
    ...                                 return document.querySelectorAll('.subItem')

    ${subItem_present}=                 Run Keyword And Return Status
    ...                                 Element Should Be Visible           ${element_subItem}

    Run Keyword Unless                  ${subItem_present}                  tipoDeParceiro.Clicar em configurações
    Click Link                          TIPO DE PARCEIROS
    Carregando

Tentar salvar sem dados preenchidos
    CLick Button                        ${btn_Adicionar}
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
