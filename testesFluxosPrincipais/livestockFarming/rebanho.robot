*** Settings ***
Documentation   Suite REBANHO

Resource        ../functions/carregando.robot
Resource        ../functions/data.robot
Resource        ../functions/telefone.robot

*** Variables ***
&{ANIMAL}                               tipo=""
...                                     numero=asdf28102020
...                                     racas=Nelore
...                                     nascimento=26092020
...                                     sexo=M
...                                     castrado=false
...                                     ecc=100
...                                     primeiraPesagem=01112020
...                                     primeiroPeso=9089
...                                     ecc=390
...                                     numeroPai=asdf pai
...                                     numeroMae=asdf mae

*** Keywords ***
Clicar em rebanho
    Mouse Over                          class = menu-closed
    Click Element                       class = iconeSubMenu
    Click Link                          ANIMAL
    Carregando

Criar novo animal
    ${element_novo}=                    Execute JavaScript              return document.getElementsByClassName("new btn-outline-segundario")[0]
    Click Element                       ${element_novo}
    Carregando

Selecionar tipo de origem propria

    Selecionar tipo origem terceiros

    ${element_proria}=                  Execute JavaScript              return document.getElementsByClassName('btn btn-primario-toggle')[0]
    Click Element                       ${element_proria}

Cadastrar Bezerro Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Bezerro
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Select From List By Value           gender                          ${ANIMAL.sexo}
    Run Keyword if                     '${sexo}'=='M'
    ...                                 Select From List By Value       castrated       ${ANIMAL.castrado}

    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Cadastrar Novilho Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Novilho
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Select From List By Value           gender                          ${ANIMAL.sexo}
    Run Keyword if                     '${sexo}'=='M'
    ...                                 Select From List By Value       castrated       ${ANIMAL.castrado}

    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
#    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Cadastrar Vaca Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Vaca
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER

    ${ANIMAL.nascimento}                Set Variable                    01012016
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
    Input Text                          id = ecc                        ${ANIMAL.ecc}
#    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Cadastrar Boi Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Boi
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER

    ${ANIMAL.nascimento}                Set Variable                    01012015
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Select From List By Value           id = castrated                  ${ANIMAL.castrado}
    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
    Input Text                          id = ecc                        ${ANIMAL.ecc}
#    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Cadastrar Touro Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Touro
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER

    ${ANIMAL.nascimento}                Set Variable                    01012015
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
    Input Text                          id = ecc                        ${ANIMAL.ecc}
#    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Cadastrar Rufiao Proprio ${brinco}
    Criar novo animal
    Selecionar tipo de origem propria

    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Input Text                          id = animal_type_id-mirror      Rufiao
    Click Element                       id = options
    Input Text                          id = earring                    ${ANIMAL.numero}
    Esperar carregar
    Carregando
    Input Text                          id = breed_id-mirror            ${ANIMAL.racas}
    Press Keys                          id = breed_id-mirror            DOWN
    Press Keys                          id = breed_id-mirror            ENTER

    ${ANIMAL.nascimento}                Set Variable                    01012015
    Input Text                          id = birthday                   ${ANIMAL.nascimento}

    Select From List By Value           gender                          ${ANIMAL.sexo}
    Run Keyword if                     '${sexo}'=='M'
    ...                                 Select From List By Value       castrated       ${ANIMAL.castrado}

    Inserir data                        first_weigh_in                  ${ANIMAL.primeiraPesagem}
    Input Text                          id = first_weight               ${ANIMAL.primeiroPeso}
    Input Text                          id = ecc                        ${ANIMAL.ecc}
#    Input Text                          id = father_earring             ${ANIMAL.numeroPai}
    Input Text                          id = mother_earring             ${ANIMAL.numeroMae}
    Click Button                        Salvar
    Carregando
    Wait Until Location Is              ${pecuaria}rebanho

Editar BEZERRO para terceiro ${brinco}
    ${ANIMAL.numero}                    Set Variable                    ${brinco}
    Buscar animal ${ANIMAL.numero}
    Clicar em editar2
    Selecionar tipo origem terceiros
    Criar um novo parceiro2
    Selecionar o parceiro criado2
    Click Button                        Salvar

# # #

Buscar animal ${campoBuscar}
    Carregando
    ${ANIMAL.numero}                    Set Variable                    ${campoBuscar}
    Click Element                       class = head-table-action-icon
    Input Text                          class = filter-field            ${ANIMAL.numero}
    esperar carregar
    Carregando

Clicar em editar2
    Carregando
    ${element_editar}=                  Execute JavaScript              return document.getElementsByClassName('icon-item')[1]
    Click Element                       ${element_editar}
    Carregando

Selecionar tipo origem terceiros
    ${element_terceiros}=               Execute JavaScript              return document.getElementsByClassName('btn btn-primario-toggle')[1]
    Click Element                       ${element_terceiros}

    ${element_proria}=                  Execute JavaScript              return document.getElementsByClassName('btn btn-primario-toggle')[0]
    Click Element                       ${element_proria}

    ${element_terceiros}=               Execute JavaScript              return document.getElementsByClassName('btn btn-primario-toggle')[1]
    Click Element                       ${element_terceiros}

Criar um novo parceiro2
    ${element_novo_perceiro}=           Execute JavaScript              return document.getElementsByClassName('buttom-new-in-label')[2]
    Click Element                       ${element_novo_perceiro}

    Input Text                          id = name                       New Parceiro 30102020
    Input Text                          id = cpf_cnpj                   12345678901234
    # Formato celular 85912345678
    Inserir Celular                     id = cell_phone                 85912345678
    Input Text                          id = partner_type_id-mirror     Fornecedor
    Press Keys                          id = partner_type_id-mirror     DOWN
    Press Keys                          id = partner_type_id-mirror     ENTER
    Select From List By Label           category_id                     Medicamento
    ${element_salvar}=                  Execute JavaScript              return document.getElementsByClassName('btn-primario undefined ml-3')[1]
    Click Element                       ${element_salvar}
    Carregando

Selecionar o parceiro criado2
    Input Text                          id = partner_id-mirror          New Parceiro 30102020
    Press Keys                          id = partner_id-mirror          DOWN
    Press Keys                          id = partner_id-mirror          ENTER
