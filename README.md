##  Instalação

###  De preferência execute os comandos abaixo como root no terminal
###  Ultilize o python 3

    Para acessar o root, digite:
    >  sudo su
    após colocar a senha, estará como root.

> Robot Insatalação

```
pip3 install robotframework
pip3 install --upgrade robotframework-selenium2library
pip3 install --upgrade --pre robotframework-selenium2library
pip3 install webdrivermanager
pip3 install -U robotframework-JSONLibrary
webdrivermanager firefox chrome --linkpath /usr/local/bin
```

> Instalação da biblioteca RequestsLibrary

```
pip3 install -U requests
pip3 install -U robotframework-requests
```

##  Rodando os testes de API

> OBS: as *Keywords* dos arquivos precisam ter a url com seus respectivos endpoints

Para rodar todos os testes de API da pasta **API**, deve rodar o comando:

```
    robot -d ./results/ ./API/
```

Para rodar testes isolados, de um determinado arquivo, deve rodar o comando:

``` 
    robot -d ./results/ ./API/Nome_da_pasta/nome_do_arquivo.robot

    EX: robot -d ./results/ ./API/Broadband/sensores_req.robot
```

> OBS: o comando *-d ./nome_da_pasta* serve para armazenar os resultados dos testes dentro de uma pasta específica 


##  Rodando os testes de UI 

Para rodar os teste de fluxos, deve rodar o comando na seguinte pasta, pois ela irá rodar todo o fluxo da aplicação.

``` 
    robot -d ./results/ ./test_de_fluxos_front/fluxosPrinciais.robot 
```

##  Gerando o relatório

Dentro da pasta **results** há um arquivo *log.html* que gera um relatório no browser, ao clicar no teste ele irá informar os dados, a resposta do teste estará dentro do Log Resposta.

####  Para gerar o relatório .xlsx

Deve executar o comando dentro da pasta results:

``` 
    python result_extractor_excel.py
```

Ele irá gerar um arquivo xlsx com as informações de sucesso

## Explicando arquivos

O arquivo **teste.robot** na raíz do projeto, possui as informações que você precisa para executar os testes de fluxos, como a url desejada. Nesse arquivo encontram-se as *Keywords*  "globas", usadas na maioria dos fluxos.

##  Dicas e links das bibliotecas usadas no projeto

1.  Selenium2Library(Biblioteca principal)

> https://robotframework.org/Selenium2Library/Selenium2Library.html

2.  RequestsLibrary

> https://bulkan.github.io/robotframework-requests/doc/RequestsLibrary.html

3.  JSONLibrary

> https://robotframework-thailand.github.io/robotframework-jsonlibrary/JSONLibrary.html

4.  Collections

> https://robotframework.org/robotframework/latest/libraries/Collections.html

5.  BuiltIn

> https://robotframework.org/robotframework/latest/libraries/BuiltIn.html

6. String

> https://robotframework.org/robotframework/latest/libraries/String.html

