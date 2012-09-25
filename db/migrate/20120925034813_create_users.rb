class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :cpf
      t.string :senha
      t.string :nome
      t.string :rg
      t.string :dica_senha
      t.string :resposta_dica_senha
      t.string :email_1
      t.string :email_2
      t.integer :usertype
      t.integer :status
      t.integer :sistema

      t.timestamps
    end
  end
end
