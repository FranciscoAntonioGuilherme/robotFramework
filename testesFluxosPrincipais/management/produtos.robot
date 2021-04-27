*** Settings ***
Documentation                           PRODUTOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page
${btn_Buscar}                           id = btn-ghost table-head-action-button-btn

${nome_produto}                         Produto
${marca}                                RAV
${categoria}                            Limpeza
${subCategoria}                         TesteSubCategoria
${embalagem}                            Lata
${valor_medida}                         1
${unidade}                              mL
${estoque_min}                          12

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em produtos
    Click Link                          Produtos
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = title-container-location    PRODUTOS

Clicar em novo
    CLick Button                        ${btn_Adicionar}
    Wait Until Element Is Visible       class = modal-content

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
    Click Button                        Cancelar
    Carregando
    Wait Until Element Is Not Visible   class = modal-content               error=None
    Element Text Should Be              class = title-container-location    PRODUTOS

Salvar produto com preenchimento correto
    produtos.Clicar em novo

    ${nome_produto}=                    Set Variable                        ${nome_produto}${date}

    Wait Until Element Is Visible       class = modal-content               error=None
    Input Text                          id = name                           ${nome_produto}
    Input Text                          id = brand                          ${marca}
    Click Element                       id = categories-mirror
    ${categoria_produtos}=              Execute JavaScript
    ...                                 return document.querySelectorAll('#div-options > ul')[0].children[3]
    Click Element                       ${categoria_produtos}
    Carregando

    ${element_novo}=                    Execute JavaScript
    ...                                 return document.getElementsByClassName('buttom-new-in-label')[1]
    Click Element                       ${element_novo}

    Wait Until Element Is Visible       id = entity_name
    Input Text                          id = entity_name                    ${subCategoria}

    ${element_salvar}=                  Execute JavaScript
    ...                                 return document.querySelectorAll('button.ml-3')[1]
    Click Element                       ${element_salvar}
    Carregando

    Click Element                       id = package_id-mirror
    ${categoria_embalagem}=             Execute JavaScript
    ...                                 return document.querySelectorAll('#div-options > ul')[1].children[3]
    Click Element                       ${categoria_embalagem}

    Input Text                          id = weight                         ${valor_medida}
    Select From List By Value           id = unit_measure_id                ${unidade}
    Input Text                          id = qtd_min                        ${estoque_min}
    Click Button                        Salvar
    Carregando
    Wait Until Element Is Not Visible   class = modal-content               error=None
    Element Text Should Be              class = title-container-location    PRODUTOS

Buscar produto criado
    # ${date}=                            Get Current Date                    result_format=%d-%m

    # ${btn_Lupa}                         Execute JavaScript
    # ...                                 return document.querySelectorAll('.head-table-action-icon')
    # Click Element                       ${btn_Lupa}

    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar produto criado
    Carregando
    # Testar o Get WebElement em vez de JavaScript
    # Documentação: https://robotframework.org/Selenium2Library/Selenium2Library.html#Locating%20elements
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}
    Carregando
    Press Keys                          id = name                           Editado
    Press Keys                          id = brand                          Editado
    Click Button                        Salvar
    # Esperar carregar
    Carregando
    Wait Until Element Is Not Visible   class = modal-content               error=None
    Carregando

    # produtos.Buscar produto criado

    # ${nome}=                              Get Table Cell                    id = table-products-list  2   1
    # ${marca}=                             Get Table Cell                    id = table-products-list  2   2
    # ${valor_medida}=                      Get Table Cell                    id = table-products-list  2   3
    # ${unidade}=                           Get Table Cell                    id = table-products-list  2   4
    # ${estoque_min}=                       Get Table Cell                    id = table-products-list  2   5
    # ${categoria}=                         Get Table Cell                    id = table-products-list  2   6
    # ${subCategoria}=                      Get Table Cell                    id = table-products-list  2   7

    # Log To Console      ${nome}
    # Log To Console      ${marca}
    # Log To Console      ${valor_medida}
    # Log To Console      ${unidade}
    # Log To Console      ${estoque_min}
    # Log To Console      ${categoria}
    # Log To Console      ${subCategoria}

Excluir produto criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.getElementsByClassName('action-button-table-primary')[1]
    Click Element                       ${element_exluir}
    Click Button                        Sim
    Carregando

Excluir subCategoria criado em produto
    ${Configuracoes}=                  Execute JavaScript
    ...                                 return document.querySelectorAll(".label-sidebar")[6]
    Click Element                       ${Configuracoes}

    Click Link                          SUBCATEGORIA
    Carregando

    Click Element                       class = head-table-action-icon
    Input Text                          id = headers-search-name            ${subCategoria}
    Click Button                        ${btn_Buscar}
    Carregando

    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll(".button-generic-table")[1]
    Click Element                       ${element_exluir}   

    Click Button                        Sim
    Carregando
