class User < ActiveRecord::Base
   
  validates_presence_of :cpf, :senha, :rg, :nome, :email_1, :dica_senha, :resposta_dica_senha
  
  validates_length_of :senha, :minimum => 6
  validates_length_of :rg, :in => 8..9
  validates_length_of :cpf, :is => 11
  

  validates_format_of :rg, :with => /\A[0-9]+\Z/
  validates_format_of :cpf, :with => /\A[0-9]+\Z/
  validates_format_of :nome, :with => /\A[a-zA-Z ]+\z/
  validates_format_of :email_1, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates_format_of :email_2, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validate :cpf_digito
  
  validates_uniqueness_of :cpf, :rg, :email_1
  
  def cpf_digito
    s = cpf
    x = s.to_s
    puts ("CPF #{x.length}")
    if(x.length != 11)
      errors.add(:cpf, "invalido")
    end
    
    contador1 = 0
    contador2 = 0
    for i in 0..8
      c = x[i].to_i
      contador1 = contador1 + (c*(i+1))
      c = x[i+1].to_i
      contador2 = contador2 + (c*(i+1))
    end
    
    if(contador1 %11 == 10)
      contador1 = 0
    end
    
    if(contador2 %11 == 10)
      contador2 = 0
    end
    
    c = x[9].to_i
    if(contador1 % 11 != c)
      errors.add(:cpf, "invalido")
    end
    c = x[10].to_i
    if(contador2 % 11 != c)
      errors.add(:cpf, "invalido")
    end
  end  
   
  attr_accessible :cpf, :dica_senha, :email_1, :email_2, :nome, :resposta_dica_senha, :rg, :senha, :sistema, :status, :usertype
end
