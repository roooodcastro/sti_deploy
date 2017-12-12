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

> Não é recomendado adicionar esta gem ao Gemfile do projeto, pois apenas líderes
técnicos podem fazer deploy, um desenvolvedor sem acesso de líder técnico não
irá conseguir utilizar a gem corretamente.
    
Execute o instalador:

    rails g sti_deploy:install
    
O instalador irá pedir o idioma desejado, o nome do usuário no Git. Com isso,
será criado um arquivo `sti_deploy.yml` no root do projeto, e esse arquivo será
adicionado ao `.gitignore`, pois ele **não deve ser commitado**.
 
## Utilização

Para utilizar esta gem, basta executar o comando `sti_deploy` no terminal, no
diretório root do projeto. O script irá pedir os dados necessários para fazer
os commits, merges e tags necessárias para dar início ao deploy. A gem **não**
realiza o deploy em si.

## Licensa, Créditos, Contribuição

Esta gem utiliza a licensa MIT:

> Copyright 2017 Rodrigo Castro Azevedo
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Esta gem foi desenvolvida por:

[@roooodcastro](https://github.com/roooodcastro/sti_deploy)

Os seguintes desenvolvedores colaboraram no desenvolvimento da gem:

> Ninguém

Para contribuir, siga os seguintes passos:

- Abra uma Issue explicando as alterações propostas
- Crie um fork do repositório
- Crie uma branch para as alterações
- Abra um Pull Request das suas alterações
