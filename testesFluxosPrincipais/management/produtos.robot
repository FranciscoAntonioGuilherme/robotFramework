*** Settings ***
Documentation                           PRODUTOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em produtos
    Click Link                          Produtos
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = top-bar-titulo              PRODUTOS

Clicar em novo
    CLick Button                        NOVO

Tentar salvar sem dados preenchidos
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_marca}=            Get webElement                      name = invalid-feedback-brand
    ${mensagem_vazio_categoria}=        Get webElement                      name = invalid-feedback-categories
    ${mensagem_vazio_embalagem}=        Get webElement                      name = invalid-feedback-package_id
    ${mensagem_vazio_estq_minimo}=      Get webElement                      name = invalid-feedback-qtd_min
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_marca.text}        ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_categoria.text}    ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_embalagem.text}    ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_estq_minimo.text}  ${erro_campo_vazio}

Salvar dados com preenchimento correto
    Input Text                          id = name                           ${razao_social}${date}
