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

${erro_campo_vazio2}                     Campo Obrigatório

*** Keywords ***
Clicar em produtos
    Click Link                          Produtos
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = title-container-location    PRODUTOS

Clicar em novo
    CLick Button                        ${btn_Adicionar}
    Carregando

Tentar adicionar intem sem dados preenchidos
    Click Button                        class = btn-primario.btn-multiple-stocks
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_marca}=            Get webElement                      name = invalid-feedback-brand
    ${mensagem_vazio_categoria}=        Get webElement                      name = invalid-feedback-category
    ${mensagem_vazio_embalagem}=        Get webElement                      name = invalid-feedback-package_id
    ${mensagem_vazio_vlr_medida}=       Get webElement                      name = invalid-feedback-weight
    ${mensagem_vazio_und}=              Get webElement                      name = invalid-feedback-unit_measure_id
    ${mensagem_vazio_estq_minimo}=      Get webElement                      name = invalid-feedback-qtd_min
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_marca.text}        ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_categoria.text}    ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_embalagem.text}    ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_vlr_medida.text}   ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_und.text}          ${erro_campo_vazio2}
    Should Contain                      ${mensagem_vazio_estq_minimo.text}  ${erro_campo_vazio2}

Salvar produto com preenchimento correto
    Input Text                          id = name                           ${nome_produto}${date}
    Input Text                          id = brand                          ${marca}
    Select From List By Label           id = category                       ${categoria}
    Wait Until Element Is Enabled       id = category_id
    ${element_novo}=                    Execute JavaScript
    ...                                 return document.getElementsByClassName('buttom-new-in-label')[1]
    Click Element                       ${element_novo}
    Wait Until Element Is Enabled       id = entity_name
    Input Text                          id = entity_name                    ${subCategoria}
    ### Botão salvar subcategoria
    ${element_salvarSubCat}=            Execute JavaScript
    ...                                 return document.querySelectorAll('.btn-primario')[2]
    Click Element                       ${element_salvarSubCat}
    Carregando
    Select From List By Label           id = package_id                     ${embalagem}
    Input Text                          id = weight                         ${valor_medida}
    Select From List By Value           id = unit_measure_id                ${unidade}
    Input Text                          id = qtd_min                        ${estoque_min}
    ### Botão adicionar item
    Click Button                        class = btn-primario.btn-multiple-stocks
    ### Botão salvar
    Click Button                        class = btn-primario.btn-form-generic
    Carregando

Buscar produto criado
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
    Click Button                        class = btn-primario
    # Esperar carregar
    # Carregando
    # Wait Until Element Is Not Visible   class = modal-content               error=None
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
    produtos.Buscar produto criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.getElementsByClassName('action-button-table-primary')[1]
    Click Element                       ${element_exluir}
    ### Botão SIM
    Click Button                        class = btn-primario.ml-3.btn-form-generic
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

    ### Botão SIM
    Click Button                        class = btn-primario.ml-3.btn-form-generic
    Carregando
