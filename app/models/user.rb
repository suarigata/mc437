class User < ActiveRecord::Base
  
  validates_presence_of :cpf, :senha, :rg, :nome, :email_1, :dica_senha, :resposta_dica_senha
  validates_uniqueness_of :cpf, :rg, :email_1, :email_2
   
  validates_length_of :cpf, :is => 11
  
  validates_length_of :senha, :minimum => 6
  
  validates_length_of :rg, :in => 8..9

  
  attr_accessible :cpf, :dica_senha, :email_1, :email_2, :nome, :resposta_dica_senha, :rg, :senha, :sistema, :status, :usertype
end
