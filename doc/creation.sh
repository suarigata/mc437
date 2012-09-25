#!/bin/bash

rails new auth

cd auth

rails g scaffold sistema nome:string key:string
rails g scaffold usertype nome:string
rails g scaffold status nome:string
rails g scaffold user cpf:string senha:string nome:string rg:string dica_senha:string resposta_dica_senha:string email_1:string email_2:string usertype:integer status:integer sistema:integer
rails g scaffold tipolog nome:string
rails g scaffold log_geral data:timestamp sistema:integer user:integer tipolog:integer desc:text

# rake db:create
rake db:migrate

cd ..

cp -r template/images/ template/style.css auth/app/assets/stylesheets/
cp application.html.erb auth/app/views/layouts/
