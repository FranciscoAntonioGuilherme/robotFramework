*** Settings ***
Documentation                           PRODUTOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${novoEstoque}                          Estoque
${fazenda}                              Todas as fazendas

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em estoques
    Click Link                          Estoques
    Carregando
    Wait Until Element Is Visible       class = title-container             timeout=10
    Element Text Should Be              class = title-container             ESTOQUES

Clicar em novo
    CLick Button                        ${btn_Adicionar}
    Carregando

Tentar salvar sem dados preenchidos
    ### Botão salvar
    Click Button                        class = btn-primario.ml-3.btn-form-generic

    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_fazenda}=          Get webElement                      name = invalid-feedback-project_id
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_fazenda.text}      ${erro_campo_vazio}


Salvar estoque com preenchimento correto
    Input Text                          id = name                           ${novoEstoque}${SPACE}${date}
    Select From List By Label           id = project_id                     ${fazenda}
    ### Botão salvar
    Click Button                        class = btn-primario
    Carregando

    # Wait Until Element Is Not Visible   class = modal-content               error=None
    # Element Text Should Be              class = top-bar-titulo              ESTOQUES
    # # Reload Page
    # Carregando
    # Page Should Contain                 ${novoEstoque}

Buscar estoque criado
    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar descrição do estoque
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelectorAll('.button-generic-table')[1]
    Click Element                       ${element_editar}
    Carregando

    Clear Element Text                  id = name
    Press Keys                          id = name                           ${novoEstoque}${SPACE}${date}Editado
    ### Botão salvar
    Click Button                        class = btn-primario
    Carregando

Visualizar estoque
    ${element_visualizar}=              Execute JavaScript
    ...                                 return Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\\n/)[2] === '${EstoqueEditado}').children[0].lastChild.children[2]
    Click Element                       ${element_visualizar}

Adicionar produto no estoque
    Click Button                        Adicionar

# Editar descrição do estoque
#     ${element_editar}=                  Execute JavaScript
#     ...                                 return Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\\n/)[2] === '${novoEstoque}').children[0].lastChild.children[1]
#     Click Element                       ${element_editar}
#     # Execute Javascript      Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\\n/)[2] === '${novoEstoque}').children[0].lastChild.children[1].click()
#     # 0 = EXCLLUIR >> 1 = EDITAR >> 2 = VISUALIZAR
#     # Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\n/)[2] === 'Estoque 19022021').children[0].lastChild.children[1]
#     # --> ↵ = \n