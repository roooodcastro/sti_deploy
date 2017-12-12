# STI Deploy

[![Gem Version](https://badge.fury.io/rb/sti_deploy.svg)](https://badge.fury.io/rb/sti_deploy)

Um programa automatizado para acelerar o processo de fazer o release de uma
versão para deploy. Foi desenvolvido para funcionar com um processo de deploy
específico.

## Funcionamento

Esse programa disponibiliza um executável `sti_deploy` que realiza as seguintes
ações:

1. Detecta o arquivo que contém o número de versão do projeto e o lê
2. Pergunta o tipo de deploy (staging, hotfix)
3. Faz um bump na versão de acordo com o tipo escolhido
4. Pergunta por uma mensagem contendo as notas de release
5. Faz o commit e push para o branch atual
6. Se necessário, faz o merge e push para o branch de release configurado
7. Faz checkout de volta ao branch de trabalho
8. Cria e dá push em uma nova tag para o release

## Instalação

Instale a gem usando:

    gem install sti_deploy
    
Execute o instalador:

    rails g sti_deploy:install
    
O instalador irá pedir o idioma desejado, o nome do usuário no Git. Com isso,
será criado um arquivo `sti_deploy.yml` no root do projeto, e esse arquivo será
adicionado ao `.gitignore`, pois ele **não deve ser commitado**.
 
## Utilização

Para utilizar, basta executar o comando `sti_deploy` no terminal, no diretório
root do projeto. O script irá pedir os dados necessários para fazer os commits,
merges e tags necessárias para dar início ao deploy. A gem **não** realiza o
deploy em si.
