*** Settings ***
Documentation                           PRODUTOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${novoEstoque}                          Estoque
${fazenda}                              The good place
${estranho}                             /\n/

${erro_campo_vazio}                     Campo obrigatório

*** Keywords ***
Clicar em estoques
    Click Link                          Estoques
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = top-bar-titulo              ESTOQUES

Clicar em novo
    CLick Button                        NOVO

Tentar salvar sem dados preenchidos
    Click Button                        Salvar

    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_fazenda}=          Get webElement                      name = invalid-feedback-project_id
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_fazenda.text}      ${erro_campo_vazio}

    Click Button                        Cancelar

    Wait Until Element Is Not Visible   class = modal-content               error=None
    Element Text Should Be              class = top-bar-titulo              ESTOQUES

Salvar estoque com preenchimento correto
    estoques.Clicar em novo

    ${date}=                            Get Current Date                    result_format=%d-%m-%Y-%S
    ${novoEstoque}=                     Set Variable                        ${novoEstoque}${SPACE}${date}
    Set Suite Variable                  ${novoEstoque}

    Input Text                          id = name                           ${novoEstoque}
    Select From List By Label           id = project_id                     ${fazenda}

    Click Button                        Salvar
    Carregando

    Wait Until Element Is Not Visible   class = modal-content               error=None
    Element Text Should Be              class = top-bar-titulo              ESTOQUES
    Reload Page
    Carregando
    Page Should Contain                 ${novoEstoque}

Editar descrição do estoque

    # Sleep       3s
    # # ${estranho}                         /\n/
    # Log             ${novoEstoque}
    # Log To Console             ${novoEstoque}

    # ${element_editar}=                  Execute JavaScript
    # ...                                 return Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(${\n})[2] === '${novoEstoque}').children[0].lastChild.children[1]
    # Click Element                       ${element_editar}

    Execute Javascript      Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\\n/)[2] === '${novoEstoque}').children[0].lastChild.children[1].click()
    Capture Page Screenshot
    # Array.from(document.querySelectorAll('p')).find(el => el.textContent === 'Estoque 19022021')
    # document.querySelectorAll('div.custom-card')[7].innerText.split(/\n/)  --> ↵ = \n

    # Aqui eu consigo chegar até a DIV que quero
    # Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\n/)[2] === 'Estoque 19022021')

    # Aqui acessa o EXCLUIR, EDITAR e VISUALIZAR
    # Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\n/)[2] === 'Estoque 19022021').children[0].lastChild

    # 0 = EXCLLUIR >> 1 = EDITAR >> 2 = VISUALIZAR
    # Array.from(document.querySelectorAll('div.table-card')[0].children).find(el => el.innerText.split(/\n/)[2] === 'Estoque 19022021').children[0].lastChild.children[1]

    # Testar o \n como %2Fn
