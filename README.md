# Sooap Api
**Ruby 2.5.1**

**Rails 5.2.2**

**MongoDB 4.0.4**

Essa API permite que o usuário se cadastre, faça login e possa listar, criar e apagar agendamentos. Para mais informações consultar Documentação no [Apiary](https://sooapapi.docs.apiary.io/).

# Development
## Como rodar
Após instalar as depêndencias citadas acima, rode

` bundle install `

Para instalar o resto das depêndencias. Recomendo usar o mongo no Docker, para não haver conflitos com outras versões locais, usando o comando:

`sudo docker run -d -p 27017:27017 -v ~/data:/data/db mongo:4.0.4`

Após isso, rode o servidor com

`rails s`

Após isso pode começar a usar. Um bom primeiro passo é o cadastro:

`curl -d '{"email":"exemplo@gmail.com", "name":"Nome da Pessoa", "password": "senha"}' -H "Content-Type: application/json" -X POST http://localhost:3000/sign_up`

Mais informações sobre uso da API na documentação no [Apiary](https://sooapapi.docs.apiary.io/).

## Testes

O projeto usa *Rspec* para implementar a suite de testes. Para rodar basta executar o comando a seguir enquanto estiver na raiz do projeto

` rspec `

# LICENSE

Sooap API roda sob a [MIT License](https://opensource.org/licenses/MIT)
