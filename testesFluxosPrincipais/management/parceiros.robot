*** Setting ***
Documentation                           PARCEIROS
Resource                                ../functions/carregando.robot
Resource                                ../functions/celular.robot
Resource                                ../functions/telefone.robot
Library                                 DateTime

*** Variables ***
${btn_Adicionar}                        class = btn-create-page
${btn_Buscar}                           id = btn-ghost table-head-action-button-btn

${field_Search}                         id = headers-search-name

${razao_social}                         Teste Parceiro
${CNPJ_CPF}                             12345678901234
${insc.estadual}                        1234
${celular}                              85912345678
${telefone_residencial}                 8512345678
${telefone_comercial}                   8587654321
${cep}                                  01001000
${observacao}                           lorem ipsum adipiscing vitae proin sagittis nisl

${erro_campo_vazio}                     Campo obrigatório
${erro_campo_email}                     Formatação de e-mail incorreta

*** Keywords ***
Clicar em parceiros
    Click Link                          Parceiros
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    # Element Text Should Be              class = top-bar-titulo              PARCEIROS
    Element Text Should Be              class = title-container-location    PARCEIROS

Clicar em novo
    CLick Button                       ${btn_Adicionar}
    Carregando

Tentar salvar sem dados preenchidos
    Click Button                        Salvar
    ${mensagem_vazio_razao_social}=     Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-partner_type_id
    ${mensagem_vazio_cpf_cnpj}=         Get webElement                      name = invalid-feedback-cpf_cnpj
    ${mensagem_vazio_categoria}=        Get webElement                      name = invalid-feedback-category_id
    ${mensagem_vazio_email}=            Get webElement                      name = invalid-feedback-email
    ${mensagem_vazio_cell_phone}=       Get webElement                      name = invalid-feedback-cell_phone
    Should Contain                      ${mensagem_vazio_razao_social.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_cpf_cnpj.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_categoria.text}    ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_cell_phone.text}   ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_email.text}        ${erro_campo_email}
    Should Contain                      ${mensagem_vazio_cell_phone.text}   ${erro_campo_vazio}
    Click Button                        Cancelar
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = title-container-location    PARCEIROS

Salvar parceiro com preenchimento correto
    parceiros.Clicar em novo
    # ${date}=                            Get Current Date                    result_format=%d-%m-%Y-%S
    Input Text                          id = name                           ${razao_social}${date}
    Input Text                          id = fantasy_name                   ${date}
    
    Press Keys                          id = partner_type_id-mirror         DOWN
    Press Keys                          id = partner_type_id-mirror         ENTER
    Input Text                          id = cpf_cnpj                       ${CNPJ_CPF}
    Input Text                          id = state_registration             ${insc.estadual}
    
    Click Element                       id = category_id-mirror
    Press Keys                          id = category_id-mirror             DOWN
    Press Keys                          id = category_id-mirror             ENTER

    Input Text                          id = email                          ${date}@gmail.com
    Inserir Celular                     id = cell_phone                     ${celular}
    Inserir Telefone                    id = residential_phone              ${telefone_residencial}

    FOR     ${i}    IN RANGE    8

        Exit For Loop If                ${i} == 8
        Press Keys                      id = zipcode                        ${cep[${i}]}
        Press Keys                      id = zipcode                        \ue004

    END

    # Inserir Telefone                    id = commercial_phone               ${telefone_comercial}
    Wait Until Element Is Enabled       id = number
    Input Text                          id = number                         123
    Input Text                          id = observation                    ${observacao}

    Click Button                        Salvar
    Carregando
    Wait Until Page Does Not Contain Element                                class = form-row
    Carregando
    Element Text Should Be              class = title-container-location    PARCEIROS

Buscar parceiro criado
    # ${date}=                            Get Current Date                    result_format=%d-%m

    ${btn_Lupa}                         Execute JavaScript
    ...                                 return document.querySelectorAll('.head-table-action-icon')
    Click Element                       ${btn_Lupa}

    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar parceiro criado
    Carregando
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}
    Carregando
    Press Keys                          id = name                           Editado
    Press Keys                          id = observation                    Observação editada.
    Click Button                        Salvar
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = title-container-location    PARCEIROS

Excluir parceiro criado
    parceiros.Buscar parceiro criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.getElementsByClassName('action-button-table-primary')[1]
    Click Element                       ${element_exluir}
    Click Button                        Sim
    Carregando
