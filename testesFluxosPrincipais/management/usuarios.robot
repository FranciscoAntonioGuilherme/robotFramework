*** Settings ***
Documentation                           USUARIOS
Resource                                ../funcoes/carregando.robot
Library                                 DateTime

*** Variables ***
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
    Should Contain                      ${mensagem_vazio_email.text}       ${erro_campo_email}
    Should Contain                      ${mensagem_vazio_senha.text}        ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_repetir_senha.text}    ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_telefone.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_funcao.text}       ${erro_campo_com_spaco}
    Should Contain                      ${mensagem_vazio_tipo_contrato.text}    ${erro_campo_vazio}

Salvar com dados preenchidos
    # ${date}=                            Get Current Date                    result_format=%d-%m-%Y-%S
    ${date}=                            Get Current Date                    result_format=%d-%m-%Y
    Input Text                          id = name                           ${nome_usuario}
    Input Text                          id = family_name                    ${date}

    Press Keys                          id = birthday                       01
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       0
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       1
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       2
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       0
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       0
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = birthday                       1

    Input Text                          id = cpf                            12345678901
    Input Text                          id = email                          asdf@gmail.com
    Input Text                          id = password                       12345678
    Input Text                          id = same_password                  12345678
    Press Keys                          id = phone_number                   12
    Press Keys                          id = birthday                       \ue004
    Press Keys                          id = phone_number                   345
