class CreateLogGerals < ActiveRecord::Migration
  def change
    create_table :log_gerals do |t|
      t.timestamp :data
      t.integer :sistema
      t.integer :user
      t.integer :tipolog
      t.text :desc

      t.timestamps
    end
  end
end
