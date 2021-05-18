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
${erro_campo_invalido}                     Campo inválido
${erro_campo_email}                     Formatação de e-mail incorreta

*** Keywords ***
Clicar em parceiros
    Click Link                          Parceiros
    Carregando
    Wait Until Element Is Visible       class = title-container             timeout=10
    Element Text Should Be              class = title-container             PARCEIROS

Clicar em novo
    CLick Button                       ${btn_Adicionar}
    Carregando

Tentar salvar sem dados preenchidos
    # Botão SALVAR
    Click Button                        class = btn-primario
    # Wait Until Element Is Visible       class = alert-agro
    # Wait Until Element Is Not Visible   class = alert-agro
    Execute JavaScript                  window.scrollTo(0, 0);
    ${mensagem_vazio_razao_social}=     Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_cpf_cnpj}=         Get webElement                      name = invalid-feedback-cpf_cnpj
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-partner_type_id
    ${mensagem_vazio_categoria}=        Get webElement                      name = invalid-feedback-category_id
    ${mensagem_vazio_email}=            Get webElement                      name = invalid-feedback-email
    ${mensagem_vazio_CEP}=              Get webElement                      name = invalid-feedback-zipcode
    Should Contain                      ${mensagem_vazio_razao_social.text}     ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_cpf_cnpj.text}     ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_categoria.text}    ${erro_campo_invalido}
    Should Contain                      ${mensagem_vazio_email.text}        ${erro_campo_email}
    Should Contain                      ${mensagem_vazio_CEP.text}          ${erro_campo_vazio}

Salvar parceiro com preenchimento correto
    Input Text                          id = name                           ${razao_social}${date}
    Input Text                          id = fantasy_name                   ${date}
    Press Keys                          id = cpf_cnpj                       ${CNPJ_CPF}
    Input Text                          id = state_registration             ${insc.estadual}
    Select From List By Label           id = partner_type_id                Veterinário
    Select From List By Label           id = category_id                    Animais Vivos
    Input Text                          id = email                          ${date}@gmail.com
    Press Keys                          id = cell_phone                     ${celular}
    Press Keys                          id = residential_phone              ${telefone_residencial}
    Press Keys                          id = commercial_phone               ${telefone_comercial}
    Press Keys                          id = zipcode                        ${cep}
    Press Keys                          id = number                         123
    Press Keys                          id = observation                    ${observacao}
    # Botão SALVAR
    Click Button                        class = btn-primario
    Carregando
    # Wait Until Page Does Not Contain Element                                class = form-row
    # Carregando
    # Element Text Should Be              class = title-container-location    PARCEIROS


Buscar parceiro criado
    Click Element                       class = head-table-action-icon
    Input Text                          ${field_Search}                     ${date}
    Click Button                        ${btn_Buscar}
    Carregando

Editar parceiro criado
    Carregando
    ${element_editar}=                  Execute JavaScript
    ...                                 return document.querySelector('button.action-button-table-primary')
    Click Element                       ${element_editar}
    Carregando
    Clear Element Text                  id = name
    Press Keys                          id = name                           ${razao_social}${date}Editado
    Press Keys                          id = observation                    Observação editada.
    # Click Button                        Salvar
    Click Button                        class = btn-primario
    Carregando
    Wait Until Element Is Visible       class = top-bar-titulo              timeout=10
    Element Text Should Be              class = title-container-location    PARCEIROS

Excluir parceiro criado
    parceiros.Buscar parceiro criado
    ${element_exluir}=                  Execute JavaScript
    ...                                 return document.getElementsByClassName('action-button-table-primary')[1]
    Click Element                       ${element_exluir}
    # Click Button                        Sim
    Click Button                        class = btn-primario.ml-3
    Carregando
