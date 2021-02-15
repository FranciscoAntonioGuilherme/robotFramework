*** Settings ***
Documentation   UNIDADES
Resource        ../funcoes/carregando.robot

*** Variables ***
${nome_nova_und}                        metro quadrado
${nome_nova_und_editada}                Metro Quadrado

${erro_campo_vazio}                     Campo obrigatório
${erro_campo_com_spaco}                 Não pode ser vazio

*** Keywords ***
Clicar em unidades
    Click Link          Unidades
    Carregando

Adicionar uma nova unidade com o campo vazio
    Click Button        NOVA
    Carregando
    Click Button        Salvar
    ${mensagem_vazio_nome}=             Get webElement                      name = invalid-feedback-name
    ${mensagem_vazio_tipo}=             Get webElement                      name = invalid-feedback-production_type
    Should Contain                      ${mensagem_vazio_nome.text}         ${erro_campo_vazio}
    Should Contain                      ${mensagem_vazio_tipo.text}         ${erro_campo_vazio}
