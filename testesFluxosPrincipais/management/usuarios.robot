*** Settings ***
Documentation                           USUARIOS
Resource                                ../functions/carregando.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page
${btn_Buscar}                           id = btn-ghost table-head-action-button-btn

${field_Search}                         id = headers-search-name

${nascimento}                           11012000
${telefone}                             85912345678
${funcao_usuario}                       Supervisor
${tipo_de_contrato}                     Contrato Temporário

${nome_usuario}                         Usuário
${erro_campo_vazio}                     Campo obrigatório
${erro_campo_invalido}                  Campo inválido
${erro_campo_com_spaco}                 Não pode ser vazio
${erro_campo_email}                     Formatação de e-mail incorreta
${erro_campo_senha}                     Sua senha deve conter oito caracteres

*** Keywords ***
Clicar em usuarios
    Click Link                          Usuários
    Carregando

Clicar em novo
    CLick Button                       ${btn_Adicionar}
    Carregando

Tentar salvar sem dados preenchidos
    # Botão SALVAR
    Click Button                        class = btn-primario
    ${mensagem_vazio_nascimento}=       Get webElement                      name = invalid-feedback-birthday
    ${mensagem_vazio_CPF}=              Get webElement                      name = invalid-feedback-cpf
    ${mensagem_vazio_email}=            Get webElement                      name = invalid-feedback-email
    ${mensagem_vazio_senha}=            Get webElement                      name = invalid-feedback-password
    ${mensagem_vazio_repetir_senha}=    Get webElement                      name = invalid-feedback-confirm_password
    ${mensagem_vazio_telefone}=         Get webElement                      name = invalid-feedback-phone_number
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-permission
    ${mensagem_vazio_funcao}=           Get webElement                      name = invalid-feedback-role
    ${mensagem_vazio_tipo_contrato}=    Get webElement                      name = invalid-feedback-contract_type
    Should Contain                      ${mensagem_vazio_nascimento.text}   ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_CPF.text}          ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_email.text}        ${erro_campo_email}
    Should Contain                      ${mensagem_vazio_senha.text}        ${erro_campo_senha}
    Should Contain                      ${mensagem_vazio_repetir_senha.text}    ${erro_campo_senha}
    Should Contain                      ${mensagem_vazio_telefone.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_funcao.text}       ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_tipo_contrato.text}    ${erro_campo_invalido}

Salvar usuario com preenchimento correto
    Input Text                          id = name                           ${nome_usuario}
    Input Text                          id = family_name                    ${date}
    Press Keys                          id = birthday                       ${nascimento}
    Click Element                       id = cpf
    Input Text                          id = cpf                            12345678901
    Press Keys                          id = phone_number                   ${telefone}
    Input Text                          id = email                          User${date}@gmail.com
    Input Text                          id = password                       12345678
    Input Text                          id = confirm_password               12345678
    Select From List By Index           id = permission                     1
    Select From List By Value           id = role                           ${funcao_usuario}
    Select From List By Value           id = contract_type                  ${tipo_de_contrato}
    Click Element                       id = projects
    Click Element                       id = form-basic-checkbox-check_0
    Click Element                       class = generic-template-form
    # Botão SALVAR
    Click Button                        class = btn-primario
    Carregando
    Carregando
    Wait Until Element Is Visible       class = title-container             timeout=10
    Element Text Should Be              class = title-container             USUÁRIOS

    # FOR     ${i}    IN RANGE    ${nascimento}
    #     Exit For Loop If    ${i} == 8
    #     Press Keys                      id = birthday                       ${nascimento[${i}]}
    #     Press Keys                      id = birthday                       \ue004
    # END

Buscar usuario criado
    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
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
    # Botão SALVAR
    Click Button                        class = btn-primario
    Carregando
    Wait Until Element Is Visible       class = title-container             timeout=10
    Element Text Should Be              class = title-container             USUÁRIOS

Excluir usuario criado
    usuarios.Buscar usuario criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.querySelectorAll('button:nth-child(2)')[0]
    Click Element                       ${element_exluir}
    Click Button                        Sim
    Carregando
