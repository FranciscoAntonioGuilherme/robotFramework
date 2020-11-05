*** Settings ***
Documentation                           LOTES
Resource                                ../funcoes/carregando.robot

*** Variables ***
&{LOTE}                                 novoLote=LOTE 27102020
...                                     novoTipo=Cria
...                                     indicePiquete=1
...                                     novoPeso=50
...                                     novoPreco=20000
...                                     novaDescricao=Nova descrição criada...
${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em lotes
    Click Element                       class = iconeSubMenu
    Click Link                          LOTES
    Carregando

Criar novo lote com campo vazio
    ${element_novo}=                    Execute JavaScript                  return document.getElementsByClassName('new btn-outline-segundario')[0]
    Click Element                       ${element_novo}

    Carregando
    Click Button                        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-type
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}

Criar novo lote com nome e tipo
    Input text                          id = name                           ${LOTE.novoLote}
    Select From List By Value           id = type                           ${LOTE.novoTipo}
    Click Button                        Salvar
    Carregando

Bucar por nome do lote
    Click Element                       class = head-table-action-icon
    Input text                          class = filter-field                 ${LOTE.novoLote}
    Wait Until Element Is Visible       carregando
    Carregando

Editar adicionando informações dos outros campos
    ${element_editar}=                  Execute JavaScript                  return document.getElementsByClassName('icon-item')[0]
    Click Element                       ${element_editar}
    Carregando
    Select From List By Index           id = module_id                      ${LOTE.indicePiquete}
    Input text                          id = estimated_avg_weight_sale      ${LOTE.novoPeso}
    Input text                          id = estimated_avg_price_sale       ${LOTE.novoPreco}
    Input text                          id = description                    ${LOTE.novaDescricao}
    Click Button                        Salvar
    Carregando

Excluir lote criado
    Bucar por nome do lote
    ${element_exluir}=                  Execute JavaScript                  return document.getElementsByClassName('icon-item')[1]
    Click Element                       ${element_exluir}
    Click button                        Sim
    Carregando
