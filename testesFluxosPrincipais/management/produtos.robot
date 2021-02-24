*** Settings ***
Documentation                           PRODUTOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${nome_produto}                         Produto
${marca}                                RAV
${categoria}                            Limpeza
${subCategoria}                         Cozinha
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

Salvar produto com preenchimento correto
    ${date}=                            Get Current Date                    result_format=%d-%m-%Y-%S
    ${nome_produto}=                    Set Variable                        ${nome_produto}${date}

    Input Text                          id = name                           ${nome_produto}
    Input Text                          id = brand                          ${marca}
    Input Text                          id = categories-mirror              ${categoria}
    Press Keys                          id = categories-mirror              DOWN
    Press Keys                          id = categories-mirror              ENTER

    Carregando
    Select From List By Label           id = category_id                    ${subCategoria}

    Input Text                          id = package_id-mirror              ${embalagem}
    Press Keys                          id = package_id-mirror              DOWN
    Press Keys                          id = package_id-mirror              ENTER
    Input Text                          id = weight                         ${valor_medida}
    Select From List By Value           id = unit_measure_id                ${unidade}
    Input Text                          id = qtd_min                        ${estoque_min}
    Click Button                        Salvar
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = top-bar-titulo              PRODUTOS

Buscar produto criado
    ${date}=                            Get Current Date                    result_format=%d-%m
    Input Text                          id = headers-search-name            ${date}
    ${element_buscar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.btn-ghost')
    Click Element                       ${element_buscar}
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
    Carregando
    Wait Until Element Is Not Visible   class = modal-content               error=None

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
    Click Button                        Sim
    Carregando
