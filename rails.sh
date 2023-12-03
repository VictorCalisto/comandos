#!/bin/bash

# Rails Console: Console interativo Ruby (IRB) para interagir com sua aplicação Rails.
rails console

# Rails Server: Inicia o servidor de desenvolvimento do Rails em uma porta específica:
rails server -p 3001

# Rails Test: Executa testes para sua aplicação Rails.
rails test

# RSpec: Executa testes RSpec para desenvolvimento orientado a comportamento (BDD) no Rails.
bundle exec rspec

# Rails Generate: Utilizado para gerar vários componentes como modelos, controladores, etc.
rails generate migration CreateProdutos localizacao:string nome:string quantidade:integer fornecedor:references
rails generate migration RemoveLocalizacaoFromProdutos localizacao:string
rails generate migration AddFuncionarioToProdutos funcionario:references
rails generate migration DropProdutos
# -- com --skip-views para pular as view.
rails generate scaffold Produto nome:string quantidade:integer fornecedor:references funcionario:references --skip-views

# Rails DB Migrate: Executa migrações de banco de dados pendentes.
rails db:migrate

# Rails DB Create: Cria o banco de dados.
rails db:create

# Rails DB Drop: Exclui o banco de dados.
rails db:drop

# Rails DB Seed: Preenche o banco de dados com dados iniciais.
rails db:seed

# Rails DB Console: Abre um console para interagir com o banco de dados usando SQL.
rails dbconsole

# Rails Routes: Exibe uma lista de todas as rotas definidas em sua aplicação.
rails routes

# Rails New: Cria uma nova aplicação Rails com o nome especificado.
rails new $NOME_DA_APLICACAO # Na pasta com nome da aplicacao.
rails new . # Na pasta atual.

# Rails Destroy: Utilizado para destruir componentes gerados como modelos, controladores, etc.
rails destroy

# Mostrar a lista de tarefas rake disponíveis:
rails -T
