*** Settings ***
Documentation                           LOTES
Resource                                ../functions/carregando.robot

*** Variables ***
&{LOTE}                                 novoLote=LOTE
...                                     novoTipo=Cria
...                                     indicePiquete=1
...                                     novoPeso=50
...                                     novoPreco=20000
...                                     novaDescricao=Nova descrição criada...
${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em lotes
    ${element_rebanho}=                 Execute JavaScript                  return document.querySelectorAll('.label-sidebar')[3]
    Wait Until Element Is Enabled       ${element_rebanho}
    Click Element                       ${element_rebanho}

    Click Link                          LOTES
    Carregando

Criar novo lote com campo vazio
    CLick Button                        ${btn_Adicionar}
    Carregando

    # Click Button                        Salvar
    ${element_salvar}=                  Execute JavaScript                  return document.querySelectorAll('.btn-primario')
    Click Element                       ${element_salvar}

    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-type
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}

Criar novo lote com nome e tipo
    Input text                          id = name                           ${LOTE.novoLote}${SPACE}${date}
    Select From List By Value           id = type                           ${LOTE.novoTipo}
    # Click Button                        Salvar
    ${element_salvar}=                  Execute JavaScript                  return document.querySelectorAll('.btn-primario')
    Click Element                       ${element_salvar}
    Carregando

Bucar por nome do lote
    Click Element                       class = head-table-action-icon
    # Input Text                          ${field_Search}                     ${date}
    Input Text                          ${field_Search}                     ${LOTE.novoLote}${SPACE}${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar adicionando informações dos outros campos
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelectorAll('button.action-button-table-primary')[1]
    Click Element                       ${element_editar}
    Carregando

    Select From List By Index           id = module_id                      ${LOTE.indicePiquete}
    Input text                          id = estimated_avg_weight_sale      ${LOTE.novoPeso}
    Input text                          id = estimated_avg_price_sale       ${LOTE.novoPreco}
    Input text                          id = description                    ${LOTE.novaDescricao}

    ${element_salvar}=                  Execute JavaScript                  return document.querySelectorAll('.btn-primario')
    Click Element                       ${element_salvar}
    Carregando

Excluir lote criado
    Bucar por nome do lote
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.getElementsByClassName('action-button-table-primary')[2]
    Click Element                       ${element_exluir}
    Click button                        Sim
    Carregando
