class User < ActiveRecord::Base
  attr_accessible :cpf, :dica_senha, :email_1, :email_2, :nome, :resposta_dica_senha, :rg, :senha, :sistema, :status, :usertype
end
