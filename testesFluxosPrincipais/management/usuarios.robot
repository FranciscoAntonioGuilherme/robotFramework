*** Settings ***
Documentation                           USUARIOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${nascimento}                           11012000
${telefone}                             85912345678
${funcao_usuario}                       Supervisor
${tipo_de_contrato}                     Contrato Temporário

${nome_usuario}                         Usuário
${erro_campo_vazio}                     Campo obrigatório
${erro_campo_com_spaco}                 Não pode ser vazio
${erro_campo_email}                     Formatação de e-mail incorreta

*** Keywords ***
Clicar em usuarios
    Click Link                          Usuários
    Carregando

Clicar em novo
    CLick Button                        NOVO
    Carregando

Tentar salvar sem dados preenchidos
    Click Button                        Salvar
    ${mensagem_vazio_nascimento}=       Get webElement                      name = invalid-feedback-birthday
    ${mensagem_vazio_CPF}=              Get webElement                      name = invalid-feedback-cpf
    ${mensagem_vazio_email}=            Get webElement                      name = invalid-feedback-email
    ${mensagem_vazio_senha}=            Get webElement                      name = invalid-feedback-password
    ${mensagem_vazio_repetir_senha}=    Get webElement                      name = invalid-feedback-same_password
    ${mensagem_vazio_telefone}=         Get webElement                      name = invalid-feedback-phone_number
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-permission
    ${mensagem_vazio_funcao}=           Get webElement                      name = invalid-feedback-role
    ${mensagem_vazio_tipo_contrato}=    Get webElement                      name = invalid-feedback-contract_type
    Should Contain                      ${mensagem_vazio_nascimento.text}   ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_CPF.text}          ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_email.text}        ${erro_campo_email}
    Should Contain                      ${mensagem_vazio_senha.text}        ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_repetir_senha.text}    ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_telefone.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_funcao.text}       ${erro_campo_com_spaco}
    Should Contain                      ${mensagem_vazio_tipo_contrato.text}    ${erro_campo_vazio}

Salvar usuario com preenchimento correto
    ${date}=                            Get Current Date                    result_format=%d-%m-%Y-%S
    Input Text                          id = name                           ${nome_usuario}
    Input Text                          id = family_name                    ${date}

    FOR     ${i}    IN RANGE    ${nascimento}

        Exit For Loop If    ${i} == 8
        Press Keys                      id = birthday                       ${nascimento[${i}]}
        Press Keys                      id = birthday                       \ue004

    END

    Input Text                          id = cpf                            12345678901
    Input Text                          id = email                          User${date}@gmail.com
    Input Text                          id = password                       12345678
    Input Text                          id = same_password                  12345678

    FOR     ${i}    IN RANGE    11
        Exit For Loop If    ${i} == 11
        Press Keys                      id = phone_number                   ${telefone[${i}]}
        Press Keys                      id = phone_number                   \ue004
    END

    Select From List By Index           id = permission                     2
    Select From List By Value           id = role                           ${funcao_usuario}
    Select From List By Value           id = contract_type                  ${tipo_de_contrato}

    # Selecionando a úlitma opção do array
    ${fazendas}=                        Execute JavaScript
    ...                                 return document.querySelectorAll('div.cardChecks-item').length
    ${element_fazenda}=                 Execute JavaScript
    ...                                 return document.querySelectorAll('div.cardChecks-item')[${fazendas} - 1]
    Click Element                       ${element_fazenda}

    Click Button                        Salvar
    Carregando
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = top-bar-titulo              USUÁRIOS

Buscar usuario criado
    ${date}=                            Get Current Date                    result_format=%d-%m-%Y
    Input Text                          id = headers-search-name            ${date}
    ${element_buscar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.btn-ghost')
    Click Element                       ${element_buscar}
    Carregando

Editar usuario criado
    Carregando
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}
    Carregando
    Press Keys                          id = name                           Editado
    Select From List By Value           id = role                           Tratorista
    Select From List By Value           id = contract_type                  Contrato CLT
    Click Button                        Salvar
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = top-bar-titulo              USUÁRIOS

Excluir usuario criado
    usuarios.Buscar usuario criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll('button:nth-child(2)')[0]
    Click Element                       ${element_exluir}
    Click Button                        Sim
    Carregando
