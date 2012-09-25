class CreateSistemas < ActiveRecord::Migration
  def change
    create_table :sistemas do |t|
      t.string :nome
      t.string :key

      t.timestamps
    end
  end
end
